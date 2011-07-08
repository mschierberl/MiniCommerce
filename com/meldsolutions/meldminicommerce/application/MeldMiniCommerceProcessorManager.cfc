<!---

This file is part of the Meld MiniCommerce application.

Meld MiniCommerce is licensed under the GPL 2.0 license
Copyright (C) 2010 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

--->
<cfcomponent displayname="MeldMiniCommerceProcessorManager" output="false" hint="Main Manager">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldMiniCommerceProcessorManager" access="public" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="processTransaction" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />
		<cfargument name="formData" type="struct" required="true" />
		
		<cfset var siteID				= $.event().getValue('siteID') />
		<cfset var merchantService		= getBeanFactory().getBean('merchantService') />
		<cfset var cartService			= getBeanFactory().getBean('cartService') />
		<cfset var transactionService	= getBeanFactory().getBean('transactionService') />

		<cfset var merchantBean			= merchantService.getBeanByAttributes( isCurrent=1 ) />
		<cfset var transactionBean		= transactionService.createTransaction( cartID=arguments.cartBean.getCartID(),siteID=siteID ) />
		<cfset var processorBean 		= "" />
		<cfset var mmError				= getBeanFactory().getBean('mmErrorManager') />

		<cfset var sArgs 				= StructNew() />

		<cfif cartBean.isEmpty()>
			<cfreturn transactionBean />
		<cfelseif cartBean.getIsPending()>
			<cfreturn transactionBean />
		</cfif>

		<cfset cartBean.setIsPending( 1 ) />
		<cfset cartService.updateCart( cartBean ) />

		<cfset transactionBean.setMerchantID( merchantBean.getMerchantID() ) />
		<cfset transactionBean.setPaymentTypeID( arguments.paymentTypeBean.getPaymentTypeID() ) />
		<cfset transactionBean.setTotal( arguments.cartBean.getTotal() ) />

		<cfset transactionService.saveTransaction( transactionBean ) />

		<cfset cartBean.setIsProcessed( 0 ) />

		<cfset sArgs.cartBean 			= arguments.cartBean />
		<cfset sArgs.userBean 			= arguments.userBean />
		<cfset sArgs.paymentTypeBean	= arguments.PaymentTypeBean />
		<cfset sArgs.merchantBean		= merchantBean />
		<cfset sArgs.billingAddress		= getMeldMiniCommerceManager().getAddress( $,"Billing" ) />

		<cfset processorBean			= createProcessorBean( argumentCollection=sArgs ) />

		<cftry>		
			<cfset transactionBean 			= processorBean.processTransaction( transactionBean,arguments.formData ) />
		<cfcatch>
			<cfset mmError.addError($.event(),cfcatch.message,"error",0000)>
			<cfset arguments.cartBean.setIsPending( 0 ) />
		</cfcatch>
		</cftry>

		<!--- reset the cartID --->
		<cfif transactionBean.getIsCompleted()>
			<cflock scope="Session" timeout="15">
				<cfset getPluginConfig().getSession().setValue( 'cartID',createUUID() ) />
			</cflock>  
		</cfif>
			
		<cfset sArgs					= StructNew() />
		<cfset sArgs.$		 			= $ />
		<cfset sArgs.cartBean 			= arguments.cartBean />
		<cfset sArgs.userBean 			= arguments.userBean />
		<cfset sArgs.transactionBean	= transactionBean />
		<cfset sArgs.paymentTypeBean	= arguments.paymentTypeBean />

		<cfset transactionBean = completeTransaction( argumentCollection=sArgs ) />
		<cfset cartBean.setIsPending( 0 ) />
		<cfset cartService.updateCart( cartBean ) />
		
		<cfreturn transactionBean />
	</cffunction>

	<cffunction name="processSnailMailTransaction" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />
		<cfargument name="formData" type="struct" required="true" />
		
		<cfset var siteID				= $.event().getValue('siteID') />
		<cfset var transactionService	= getBeanFactory().getBean('transactionService') />
		<cfset var transactionBean		= transactionService.createTransaction( cartID=arguments.cartBean.getCartID(),siteID=siteID ) />
		<cfset var sArgs 				= StructNew() />

		<cfif cartBean.isEmpty()>
			<cfreturn transactionBean />
		</cfif>

		<cfset transactionBean.setPaymentTypeID( arguments.paymentTypeBean.getPaymentTypeID() ) />
		<cfset transactionBean.setSubTotal( arguments.cartBean.getSubTotal() ) />
		<cfset transactionBean.setTotal( arguments.cartBean.getTotal() ) />

		<cfset transactionService.saveTransaction( transactionBean ) />

		<cfset sArgs.cartBean 			= arguments.cartBean />
		<cfset sArgs.userBean 			= arguments.userBean />
		<cfset sArgs.paymentTypeBean	= arguments.PaymentTypeBean />
		<cfset sArgs.billingAddress		= getMeldMiniCommerceManager().getAddress( $,"Billing" ) />

		<cfset transactionBean.setIsCompleted( 1 ) />
		
		<cfset sArgs					= StructNew() />
		<cfset sArgs.$		 			= $ />
		<cfset sArgs.cartBean 			= arguments.cartBean />
		<cfset sArgs.userBean 			= arguments.userBean />
		<cfset sArgs.transactionBean	= transactionBean />
		<cfset sArgs.paymentTypeBean	= arguments.paymentTypeBean />

		<cfset transactionBean = completeTransaction( argumentCollection=sArgs ) />
		
		<cfreturn transactionBean />
	</cffunction>

	<cffunction name="createProcessorBean" returntype="any" access="public" output="false">
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />
		<cfargument name="merchantBean" type="any" required="true" />
		<cfargument name="billingAddress" type="query" required="true" />
				
		<cfset var processorBean = createObject('component',"MeldMiniCommerce.com.meldsolutions.MeldMiniCommerce.processor.#arguments.merchantBean.getBean()#").init( argumentCollection=arguments ) />
		
		<cfreturn processorBean />
	</cffunction>

	<cffunction name="completeTransaction" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="transactionBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />

		<cfset var siteID				= $.event().getValue('siteID') />
		<cfset var pluginEvent 			= createObject("component","mura.MuraScope") />
		<cfset var pluginManager		= $.getBean('pluginManager') />
		<cfset var cartID				= cartBean.getCartID() />
		<cfset var cartService			= getBeanFactory().getBean('cartService') />
		<cfset var transactionService	= getBeanFactory().getBean('transactionService') />
		<cfset var orderIdent			= "" />

		<cfif transactionBean.getisCompleted()>
			<cfset orderIdent = transactionService.createOrderIdent() />
			<cfset transactionBean.setOrderIdent( orderIdent ) />
		</cfif>
		
		<cfset transactionBean.setDiscount( arguments.cartBean.getDiscount() ) />
		<cfset transactionBean.setTax( arguments.cartBean.getTax() ) />
		<cfset transactionBean.setShipping( arguments.cartBean.getShipping() ) />
		
		<cftransaction>
		<cfset transactionService.updateTransaction( transactionBean ) />
		
		<cfif transactionBean.getIsCompleted()>
			<cfset cartService.commitCart( arguments.cartBean ) />
		</cfif>	
		</cftransaction>

		<!--- announce separate 'product added' event --->
		<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
		<cfset pluginEvent.setValue('userID',$.currentUser().getUserID() ) />
		<cfset pluginEvent.setValue('siteID',siteID ) />
		<cfset pluginEvent.setValue('cartID',cartID ) />
		<cfset pluginEvent.setValue('CartBean',arguments.cartBean ) />
		<cfset pluginEvent.setValue('userBean',arguments.userBean ) />
		<cfset pluginEvent.setValue('paymentTypeBean',arguments.paymentTypeBean ) />
		<cfset pluginEvent.setValue('transactionBean',arguments.transactionBean ) />

		<cfif transactionBean.getIsCompleted()>
			<cfset pluginManager.announceEvent("onMeldMiniCommerceTransactionComplete",pluginEvent )>
		<cfelse>
			<cfset pluginManager.announceEvent("onMeldMiniCommerceTransactionFailed",pluginEvent )>
		</cfif>	
		
		<cfreturn transactionBean />
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn getMeldMiniCommerceManager().getBeanFactory()>
	</cffunction>

	<cffunction name="getPluginConfig" access="public" returntype="any" output="false">
		<cfreturn getMeldMiniCommerceManager().getPluginConfig()>
	</cffunction>

	<cffunction name="setMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfargument name="MeldMiniCommerceManager" type="any" required="true">
		<cfset variables.MeldMiniCommerceManager = arguments.MeldMiniCommerceManager>
	</cffunction>
	<cffunction name="getMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldMiniCommerceManager>
	</cffunction>
</cfcomponent>
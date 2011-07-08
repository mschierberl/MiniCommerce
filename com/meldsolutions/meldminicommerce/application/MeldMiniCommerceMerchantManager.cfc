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
<cfcomponent displayname="MeldMiniCommerceMerchantManager" output="false" hint="Main Manager">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldMiniCommerceMerchantManager" access="public" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="createMerchantBean" returntype="any" access="public" output="false">
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="billingAddress" type="query" required="true" />
		
		<cfset var merchantBean = createObject('component',"MeldMiniCommerce.com.meldsolutions.MeldMiniCommerce.merchant.paypalpaymentspro.PayPalBean").init( argumentCollection=arguments ) />
		
		<cfreturn merchantBean />
	</cffunction>

	<cffunction name="saveTransaction" returntype="void" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="transactionBean" type="any" required="true" />

		<cfset var pluginEvent 			= createObject("component","mura.MuraScope") />
		<cfset var pluginManager		= $.getBean('pluginManager') />
		<cfset var cartID				= cartBean.getCartID() />
		<cfset var cartService			= getBeanFactory().getBean('cartService') />
		<cfset var transactionService	= getBeanFactory().getBean('transactionService') />
		
		<cftransaction>
		<cfset transactionService.saveTransaction( arguments.transactionBean ) />
		
		<cfif transactionBean.getIsApproved()>
			<cfset cartService.commitCart( arguments.cartBean ) />
		</cfif>	
		</cftransaction>

		<cfif transactionBean.getIsApproved()>
			<!--- announce separate 'product added' event --->
			<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
			<cfset pluginEvent.setValue('userID',$.currentUser().getUserID() ) />
			<cfset pluginEvent.setValue('siteID',session.siteID ) />
			<cfset pluginEvent.setValue('cartID',cartID ) />
			<cfset pluginEvent.setValue('CartBean',arguments.cartBean ) />
			<cfset pluginEvent.setValue('userBean',arguments.userBean ) />
			<cfset pluginEvent.setValue('transactionBean',arguments.transactionBean ) />
			<cfset pluginManager.announceEvent("onMeldMiniCommerceTransactionComplete",pluginEvent)>
		</cfif>	
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
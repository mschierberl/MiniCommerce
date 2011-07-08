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
<cfcomponent extends="controller">

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	</cffunction>

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset super.before(rc) />

		<cfif StructCount(form)>
			<cfset processFormSubmission(rc) />
		</cfif>
	</cffunction>

	<cffunction name="widget" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var cartManager			= getBeanFactory().getBean('MeldMiniCommerceManager') />
		<cfset var cartProductService	= getBeanFactory().getBean('cartProductService') />
		<cfset var cartID				= cartManager.getCartID( rc.$ ) />
		<cfset var sCart				= StructNew() />
		<cfset var sArgs				= StructNew() />
		<cfset var criteria				= StructNew() />
		<cfset var pluginEvent			= rc.$.getBean("MuraScope") />
		<cfset var pluginManager		= rc.$.getBean('PluginManager') />
		<cfset var quantity				= 0 />
		<cfset var iiX					= "" />

		<cfset criteria.cartID = cartID />

		<cfset sCart = cartProductService.search( criteria,'cartProductID,productID,quantity' ) />
		
		<cfloop from="1" to="#ArrayLen(sCart.itemArray)#" index="iiX">
			<cfset quantity = quantity + sCart.itemArray[iiX].quantity />
		</cfloop>
		
		<cfset rc.quantity			= quantity />
		<cfset rc.count				= sCart.count />
		<cfset rc.productsArray		= sCart.itemArray />
		<cfset rc.cartURL			= cartManager.getCartURL( rc.$ ) />

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginEvent.setValue('quantity',rc.quantity ) />
		<cfset pluginEvent.setValue('count',rc.count ) />
		<cfset pluginEvent.setValue('productsArray',rc.productsArray ) />
		<cfset pluginEvent.setValue('cartURL',rc.cartURL ) />
		<cfset pluginEvent.setValue('cartID',cartID ) />

		<cfset rc.renderCartWidget	= pluginManager.renderEvent( "onMeldMiniCommerceRenderCartWidget",pluginEvent )>
	</cffunction>

	<cffunction name="cart" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var cartManager		= getBeanFactory().getBean('MeldMiniCommerceManager') />
		<cfset var cartEventManager	= getBeanFactory().getBean('MeldMiniCommerceEventManager') />
		<cfset var cartService		= getBeanFactory().getBean('cartService') />
		<cfset var cartProductService	= getBeanFactory().getBean('cartProductService') />
		<cfset var cartBean			= "" />
		<cfset var pluginEvent		= rc.$.getBean("MuraScope") />
		<cfset var pluginManager	= rc.$.getBean('PluginManager') />
		<cfset var cartID			= "" />
		<cfset var checkoutURL		= "" />
		<cfset var iiX				= "" />
		<cfset var sCart			= StructNew() />
		<cfset var sItem			= StructNew() />
		<cfset var criteria			= StructNew() />

		<cfset pluginEvent = pluginEvent.init( StructNew() ).getEvent() />

		<cfif StructKeyExists(form,"checkout")>
			<cfset checkoutURL		= cartManager.getCheckoutURL( rc.$ ) />
			<cfif len(checkoutURL)>
				<cflocation url="#checkoutURL#" addtoken="false" /> 
			</cfif>
		<cfelseif StructKeyExists(form,"clearcart") and form.mode eq 'clearcart'>
<!---
			<cfset cartID = cartManager.getCartID( rc.$ ) />
			<cfset cartService.emptyCart( cartID ) />
--->
			<cfset criteria.cartID = cartID />
			<cfset sCart = cartProductService.search( criteria,'cartProductID,quantity' ) />

			<cfset pluginEvent.setValue('siteID', session.siteID ) />
			<cfset pluginEvent.setValue('moduleID', rc.pluginConfig.getModuleID() ) />

			<cfloop from="1" to="#ArrayLen(sCart.itemArray)#" index="iiX">
				<cfset sItem = sCart.itemArray[iiX] />
				<cfset pluginEvent.setValue('cartProductID', sItem.cartPRoductID ) />
				<cfset pluginManager.announceEvent("onMeldMiniCommerceRemoveProduct",pluginEvent) />
			</cfloop>
		<cfelseif StructKeyExists(form,"updatecart")>
			<cfset updateCartQuantity( argumentCollection=arguments ) />
			<cflocation url="./" addtoken="false"> 
		</cfif>

		<cfset pluginEvent = rc.$.getBean("MuraScope") />
		<cfset pluginEvent = pluginEvent.init( StructNew() ).getEvent() />

		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginManager.announceEvent("onMeldMiniCommerceGetCart",pluginEvent) />

		<!--- via render event --->
		<cfset rc.renderCart = pluginManager.renderEvent( "onMeldMiniCommerceRenderCart",pluginEvent )>
		<cfset rc.cartBean	= pluginEvent.getValue('cartBean') />
	</cffunction>

	<cffunction name="checkout" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var CartManager			= getBeanFactory().getBean('MeldMiniCommerceManager') />
		<cfset var CartEventManager		= getBeanFactory().getBean('MeldMiniCommerceEventManager') />
		<cfset var cartBean				= "" />
		<cfset var pluginEvent			= rc.$.getBean("MuraScope") />
		<cfset var pluginManager		= rc.$.getBean('PluginManager') />
		<cfset var cartURL				= cartManager.getCartURL( rc.$ ) />

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginManager.announceEvent("onMeldMiniCommerceGetCart",pluginEvent) />

		<cfset rc.cartBean	= pluginEvent.getValue('cartBean') />

		<cfparam name="form.pagemode" default="" />

		<cfif StructKeyExists(url,"page")>
			<cfset form.pagemode = url.page />
		</cfif>

		<cfif not rc.$.currentUser().isLoggedIn()>
			<cflocation url="#cartURL#/?display=login" addtoken="false" >
		</cfif>

		<cfset getCheckoutInfo( argumentCollection=arguments ) />

		<cfif len(form.pagemode)>
			<cfswitch expression="#form.pagemode#">
				<cfcase value="user">
					<cfset saveUserInfo( argumentCollection=arguments ) />
					<cfset form.pagemode = "payment" />
				</cfcase>
				<cfcase value="process">
					<cfset processCart( argumentCollection=arguments ) />

					<cfif structKeyExists(rc,"transactionBean") and rc.transactionBean.getIsCompleted()>
						<cfset form.pagemode = "receipt" />
					<cfelse>
						<cfset form.pagemode = "payment" />
					</cfif>

				</cfcase>
			</cfswitch>
		</cfif>

		<cfset pluginEvent.setValue('pagemode',form.pagemode ) />
		<cfset pluginEvent.setValue('userBean',$.currentUser().getUserBean() ) />

		<cfswitch expression="#form.pagemode#">
			<cfcase value="payment">
				<cfset getPaymentInfo( argumentCollection=arguments ) />
				<!--- via render event --->
				<cfset pluginEvent.setValue('billingAddress',rc.billingAddress ) />
				<cfset pluginEvent.setValue('qStates',rc.qStates ) />
				<cfset pluginEvent.setValue('qCountries',rc.qCountries ) />
				<cfset pluginEvent.setValue('aPaymentTypes',rc.aPaymentTypes ) />
				<cfset rc.renderCheckout = pluginManager.renderEvent( "onMeldMiniCommerceRenderPaymentForm",pluginEvent )>
			</cfcase>
			<cfcase value="receipt">
				<cfset pluginEvent.setValue('billingAddress',rc.billingAddress ) />
				<cfset pluginEvent.setValue('qStates',rc.qStates ) />
				<cfset pluginEvent.setValue('qCountries',rc.qCountries ) />
				<cfset pluginEvent.setValue('aPaymentTypes',rc.aPaymentTypes ) />
				<cfset pluginEvent.setValue('transactionBean',rc.transactionBean ) />
				<cfset rc.renderCheckout = pluginManager.renderEvent( "onMeldMiniCommerceRenderPaymentReceipt",pluginEvent )>
				<cfset sendReceipt( rc,pluginEvent ) />
			</cfcase>
			<cfdefaultcase>
				<cfset pluginEvent.setValue('billingAddress',rc.billingAddress ) />
				<cfset pluginEvent.setValue('qStates',rc.qStates ) />
				<cfset pluginEvent.setValue('qCountries',rc.qCountries ) />
				<cfset pluginEvent.setValue('aPaymentTypes',rc.aPaymentTypes ) />
				<cfset rc.renderCheckout = pluginManager.renderEvent( "onMeldMiniCommerceRenderUserForm",pluginEvent )>
			</cfdefaultcase>
		</cfswitch>
	</cffunction>

	<cffunction name="processFormSubmission" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var CartEventManager	= getBeanFactory().getBean('MeldMiniCommerceEventManager') />
		<cfset var pluginEvent		= rc.$.getBean("MuraScope") />
		<cfset var pluginManager	= rc.$.getBean('PluginManager') />

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />

		<cfif StructKeyExists(form,"removeProduct")>
			<cfset pluginEvent.setValue('cartProductID',form.removeProduct ) />
			<cfset pluginManager.announceEvent("onMeldMiniCommerceRemoveProduct",pluginEvent) />
		</cfif>
	</cffunction>

	<cffunction name="updateCartQuantity" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var cartProductService	= getBeanFactory().getBean('cartProductService') />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var cartManager			= getBeanFactory().getBean('MeldMiniCommerceManager') />
		<cfset var formData				= mmFormTools.scopeFormSubmission(form,false,true) />
		<cfset var criteria				= StructNew() />
		<cfset var sCart				= StructNew() />
		<cfset var sItem				= StructNew() />
		<cfset var quantity				= 0 />
		<cfset var cartID 				= cartManager.getCartID( rc.$ ) />
		<cfset var pluginEvent			= rc.$.getBean("MuraScope") />
		<cfset var pluginManager		= rc.$.getBean('PluginManager') />

		<cfif not structKeyExists(formData,"quantity")>
			<cfreturn>
		</cfif>

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset criteria.cartID = cartID />

		<cfset sCart = cartProductService.search( criteria,'cartProductID,quantity' ) />
		
		<cfloop from="1" to="#ArrayLen(sCart.itemArray)#" index="iiX">
			<cfset sItem = sCart.itemArray[iiX] />
			<cfif StructKeyExists(formData.quantity,sItem.cartProductID)>
				<cfset quantity = formData.quantity[sItem.cartProductID] />
				<cfif quantity lte 0>
					<cfset pluginEvent.setValue('siteID', session.siteID ) />
					<cfset pluginEvent.setValue('moduleID', rc.pluginConfig.getModuleID() ) />
					<cfset pluginEvent.setValue('cartProductID', sItem.cartPRoductID ) />
			
					<cfset pluginManager.announceEvent("onMeldMiniCommerceRemoveProduct",pluginEvent) />
					<!---<cfset cartProductService.deleteCartproduct( sItem.cartPRoductID ) />--->
				<cfelse>
					<cfset cartProductService.setQuantity( sItem.cartPRoductID,quantity ) />
				</cfif>
			</cfif>
		</cfloop>
	</cffunction>


	<cffunction name="processCart" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var PaymentTypeService	= getBeanFactory().getBean('PaymentTypeService') />
		<cfset var PaymentTypeBean		= PaymentTypeService.getPaymentType( rc.paymenttype ) />

		<cfset rc.PaymentTypeBean = PaymentTypeBean />

		<cfif rc.cartBean.isEmpty()>
			<cfset getErrorManager().addError(rc.$.event(),"error-1202","custom",1202)>
			<cfreturn>
		</cfif>

		<cfif PaymentTypeBean.getPaymentType() eq "card">
			<cfset processCreditCard( argumentCollection=arguments ) />
		<cfelseif PaymentTypeBean.getPaymentType() eq "mail">
			<cfset processSnailMail( argumentCollection=arguments ) />
		</cfif>
	</cffunction>

	<cffunction name="processCreditCard" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var cartProcessorManager	= getBeanFactory().getBean('MeldMiniCommerceProcessorManager') />
		<cfset var transactionBean		= "" />
		<cfset var processorBean		= "" />
		<cfset var sArgs 				= StructNew() />

		<cfif rc.cartBean.getIsPending()>
			<cfreturn>
		</cfif>

		<cfset sArgs.$		 			= rc.$ />
		<cfset sArgs.cartBean 			= rc.cartBean />
		<cfset sArgs.userBean 			= rc.$.currentUser().getUserBean() />
		<cfset sArgs.paymentTypeBean	= rc.PaymentTypeBean />
		<cfset sArgs.formData			= form />
		
		<cfset transactionBean = cartProcessorManager.processTransaction( argumentCollection=sArgs ) />
		
		<cfif not transactionBean.getIsCompleted()>
			<cfset getErrorManager().addError(rc.$.event(),transactionBean.getResponseMessage(),"error",2200)>
		</cfif>
			
		<cfset rc.transactionBean = transactionBean />
	</cffunction>

	<cffunction name="processSnailMail" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var cartProcessorManager	= getBeanFactory().getBean('MeldMiniCommerceProcessorManager') />
		<cfset var transactionBean		= "" />
		<cfset var processorBean		= "" />
		<cfset var sArgs 				= StructNew() />

		<cfset sArgs.$		 			= rc.$ />
		<cfset sArgs.cartBean 			= rc.cartBean />
		<cfset sArgs.userBean 			= rc.$.currentUser().getUserBean() />
		<cfset sArgs.paymentTypeBean	= rc.PaymentTypeBean />
		<cfset sArgs.formData			= form />
		
		<cfset transactionBean = cartProcessorManager.processSnailMailTransaction( argumentCollection=sArgs ) />

		<cfif not transactionBean.getIsCompleted()>
			<cfset getErrorManager().addError(rc.$.event(),"error-2200","custom",2200)>
		</cfif>
				
		<cfset rc.transactionBean = transactionBean />
	</cffunction>

	<cffunction name="getCheckoutInfo" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var MiniCommerceManager	= getBeanFactory().getBean('MeldMiniCommerceManager') />
		<cfset var PaymentTypeService	= getBeanFactory().getBean('PaymentTypeService') />
		<cfset var aPaymentTypes		= PaymentTypeService.getPaymentTypes( isActive=1,orderby='paymenttype' ) />
		<cfset var userUtility			= rc.$.getBean('userUtility') />

		<cfset userUtility.loginByUserID( rc.$.currentUser().getUserID(),rc.siteid ) />

		<cfset rc.billingAddress	= MiniCommerceManager.getAddress( rc.$,"Billing" ) />
		<cfset rc.qStates			= MiniCommerceManager.getStates() />
		<cfset rc.qCountries		= MiniCommerceManager.getCountries() />
		<cfset rc.aPaymentTypes		= aPaymentTypes />
	</cffunction>

	<cffunction name="sendReceipt" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var cartManager	= getBeanFactory().getBean('MeldMiniCommerceManager') />

		<cfset sArgs.$		 			= rc.$ />
		<cfset sArgs.cartBean 			= rc.cartBean />
		<cfset sArgs.userBean 			= rc.$.currentUser().getUserBean()/>
		<cfset sArgs.transactionBean	= rc.transactionBean />
		<cfset sArgs.paymentTypeBean	= rc.PaymentTypeBean />

		<cfset rc.displayMessage = cartManager.sendReceipt( argumentCollection=sArgs ) />
	</cffunction>

	<cffunction name="getPaymentInfo" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

	</cffunction>

	<cffunction name="saveUserInfo" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var userManager		= rc.$.getBean('userManager') />
		<cfset var userUtility		= rc.$.getBean('userUtility') />
		<cfset var userBean			= rc.$.currentUser().getUserBean() />
		<cfset var sArgs			= form />
		<cfset var qUserAddress 	= userBean.getAddresses() />
		<cfset var qBillingAddress	= "" />
		<cfset var mmFormTools		= getBeanFactory().getBean("mmFormTools") />
		<cfset var formData			= mmFormTools.scopeFormSubmission(form,false,true) />
		<cfset var billingAddress	= formData['billing'] />
		
		<cfset rc.$.currentUser().setFname( form.fName ) />
		<cfset rc.$.currentUser().setLname( form.lName ) />
		<cfset rc.$.currentUser().setCompany( form.company ) />
		<cfset rc.$.currentUser().setEmail( form.email ) />

		<cfset rc.$.currentUser().save() />

		<cfset billingAddress.userID		= userBean.getUserID() />
		<cfset billingAddress.addressName	= "Billing" />

		<cfquery name="qBillingAddress" dbtype="query" maxrows="1">
			SELECT
				*
			FROM
				qUserAddress
			WHERE
				AddressName = 'Billing'
		</cfquery>
	
		<cfif qBillingAddress.recordcount>
			<cfset billingAddress.addressID = qBillingAddress.addressID />
			<cfset userManager.updateAddress( billingAddress ) />
		<cfelse>
			<cfset userManager.createAddress( billingAddress ) />
		</cfif>

		<cfset userUtility.loginByUserID( rc.$.currentUser().getUserID(),rc.siteid ) />
	</cffunction>
</cfcomponent>
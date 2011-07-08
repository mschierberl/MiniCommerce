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
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">
	<cffunction name="onApplicationLoad">
		<cfargument name="$">
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<!--- MiniCommerce does this listening on behalf of Mura Page/Product products --->
	<cffunction name="onMeldMiniCommerceRequestProductInfo" output="false" returntype="void">
		<cfargument name="$">

		<cfset var cartBean			= $.event().getValue('cartBean') />
		<!--- All Mura Page/Product-sourced products have the moduleID of '00000000-0000-0000-0000000000000000' --->
		<cfset var aCartProductIDs 	= cartBean.getModuleCartProductIDs( '00000000-0000-0000-0000000000000000' ) />
		<cfset var cartProductBean	= "" />
		<cfset var iiX				= "" />
		<cfset var contentBean		= "" />
		<cfset var productURL		= "" />
		<cfset var productTitle		= "" />

		<cfloop from="1" to="#arraylen(aCartProductIDs)#" index="iiX">
			<cfset cartProductBean	= cartBean.getCartProductBean( aCartProductIDs[iiX] )>
			<cfset contentBean		= $.getBean('contentManager').read( contentID=cartProductBean.getProductID(),siteID=$.event("siteID") ) />
			
			<!--- create links back to the product page so the cart item can be edited --->
			<cfset productURL		= $.getContentRenderer().getURLStem( contentBean.getSiteID(),contentBean.getFileName() ) />

			<cfif not cartBean.getIsCompleted()>
				<cfset productURL		= productURL & "?cartProductID=" & cartProductBean.getCartProductID() />
				<cfset cartProductBean.setUrl( productURL ) />
			<cfelse>
				<cfset cartProductBean.setUrl( productURL ) />
			</cfif>

			<cfset cartProductBean.setPrice( contentBean.getValue('price') ) />
			<cfset cartProductBean.setName( contentBean.getTitle() ) />
			<cfset cartProductBean.setSummary( contentBean.getSummary() ) />
			
			<cfif isNumeric( contentBean.getValue('shipping') )>
				<cfset cartProductBean.setShipping( contentBean.getValue('shipping') ) />
			</cfif>
			<cfif isNumeric( contentBean.getValue('Tax') )>
				<cfset cartProductBean.setTax( contentBean.getValue('Tax') ) />
			</cfif>
			<cfif isNumeric( contentBean.getValue('Discount') )>
				<cfset cartProductBean.setDiscount( contentBean.getValue('Discount') ) />
			</cfif>
		</cfloop>
	</cffunction>

<!---
	<cffunction name="onMeldMiniCommerceRenderProduct" output="false" returntype="string">
		<cfargument name="event">

		<cfset var contentBean	= event.getValue('contentBean') />
		<cfset var strOut		= "" />

<cfsavecontent variable="strOut">
<cfoutput>
<div class="meld-minicommerce-product-form clearfix">
	<form method="post" action="./" class="meld-form">
	<input type="hidden" name="productID" value="#contentBean.getContentID()#">
	<ul>
	<cfif contentBean.getValue('useQuantity') eq true>
		<li>
			<label>How Many</label>
			<input type="text" class="text small" value="1" name="quantity">
		</li>
	</cfif>
		<li class="price">
			<label>Cost</label>
			<span>#lsCurrencyFormat( contentBean.getValue('price') )#</span>
		</li>
		<li>
			<button class="submit" name="addProduct">Add</button>
		</li>
	</table>
	</form>
</div>
</cfoutput>
</cfsavecontent>

		<cfreturn strOut />
	</cffunction>

	<cffunction name="onMeldMiniCommerceRequestDiscountInfo" output="false" returntype="void">
		<cfargument name="$">

		<cfset var cartBean				= $.event().getValue('cartBean') />
		<cfset var aCartProductIDs 		= ArrayNew(1) />
		<cfset var iiX			 		= "" />
		<cfset var cartProductBean		= "" />

		<cfif not cartBean.isProductIDInCart( 'DD4E2D67-4AAE-4A90-92028AD082AD1642' )>
			<cfreturn>
		</cfif>
		
		<cfset aCartProductIDs 	= cartBean.getModuleCartProductIDs( '00000000-0000-0000-0000000000000000' ) />
		<cfloop from="1" to="#arraylen(aCartProductIDs)#" index="iiX">
			<cfset cartProductBean	= cartBean.getCartProductBean( aCartProductIDs[iiX] )>
			<cfif cartProductBean.getAttribute('color') eq 'black'>
				<cfset cartProductBean.setDiscount( 4 ) />
			</cfif>
			<cfif cartProductBean.getAttribute('size') eq 'xl'>
				<cfset cartProductBean.setDiscount( 4 ) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="onMeldMiniCommerceRenderCart" output="false" returntype="string">
		<cfargument name="event">
		<cfreturn "" />
	</cffunction>

	<cffunction name="onMeldMiniCommerceRenderCartInfo" output="false" returntype="string">
		<cfargument name="event">
		<cfreturn "" />
	</cffunction>

	<cffunction name="onMeldMiniCommerceRenderPaymentForm" output="false" returntype="string">
		<cfargument name="event">
		<cfreturn "" />
	</cffunction>

	<cffunction name="onMeldMiniCommerceRenderUserForm" output="false" returntype="string">
		<cfargument name="event">
		<cfreturn "" />
	</cffunction>

	<cffunction name="onMeldMiniCommerceRenderReceipt" output="false" returntype="string">
		<cfargument name="event">

		<cfset var sContent				= "" />
		<cfset var userBean				= event.getValue('userBean') />
		<cfset var transactionBean		= event.getValue('transactionBean') />
		
<cfsavecontent variable="sContent"><cfoutput>
	#userBean.getFname()# #userBean.getLname()#, your transaction is complete.<br />
	<cfif len( #userBean.getCompany()# ) >
		<span style="font-weight: bold;">Organization:</span> #userBean.getCompany()#<br />
	</cfif>
	<span style="font-weight: bold;">Total</span>:&nbsp; #lsCurrencyFormat(transactionBean.getTotal())#<br />
</cfoutput></cfsavecontent>

		<cfreturn sContent />
	</cffunction>

	<cffunction name="onMeldMiniCommerceRenderTransactionView" output="false" returntype="string">
		<cfargument name="event">
		<cfreturn "" />
	</cffunction>
--->
</cfcomponent>
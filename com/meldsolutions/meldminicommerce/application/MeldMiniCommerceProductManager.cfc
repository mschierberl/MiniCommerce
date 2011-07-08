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
<cfcomponent displayname="MeldMiniCommerceProductManager" output="false" hint="Main Manager">
	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldMiniCommerceProductManager" access="public" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="createProduct" returntype="any" access="public" output="false">
		<cfargument name="data" type="Struct" required="true" default="#StructNew()#" />
		
		<cfset var productBean		= getBeanFactory().getBean('productBean') />
		<cfset var generalUtility	= getBeanFactory().getBean('generalUtility') />
		
		<cfif StructKeyExists(data,"productBean")>
			<cfif validateProductBean( data.productBean )>
				<cfreturn data.productBean>
			<cfelse>
				<cfreturn productBean />		
			</cfif>
		<cfelse>						
			<cfif StructKeyExists(data,"attributes")>
				<cfif isStruct( data.attributes )>
					<cfset data.attributes 		= serializeJSON( data.attributes ) />
				</cfif>
				<cfif not StructKeyExists(data,"attributesID") or not len( data.attributesID )>
					<cfset data.attributesID	= generalUtility.createUUIDFromString( data.attributes ) />
				</cfif>
			</cfif>
			<cfset productBean.init( argumentCollection=arguments.data ) />
		</cfif>
			
		<cfset validateProductBean( productBean ) />
		
		<cfreturn productBean>
	</cffunction>

	<cffunction name="validateProductBean" returntype="any" access="public" output="false">
		<cfargument name="productBean" type="any" required="true" />
		<cfargument name="event" type="any" required="false" />

		<cfset var mmError		= getBeanFactory().getBean('mmErrorManager') />
		<cfset var success		= true>
		
		<cftry>
			<cfset data = productBean.getMemento()>
			<cfcatch>
				<cfif structKeyExists(arguments,"event")>
					<cfset mmError.addError(event,"invalidProductBean","custom",3000,"") />
				</cfif>
				<cfset success = false>
				<cfreturn success>
			</cfcatch>
		</cftry>
		
		<cfif not StructKeyExists(data,"moduleID") or len(data.moduleID) neq 35>
			<cfif structKeyExists(arguments,"event")>
				<cfset mmError.addError(event,"invalidModuleID","custom",3000) />
			</cfif>
			<cfset success = false>
		<!--- moduleID is Mura content page --->
		<cfelseif data.moduleID eq "00000000000000000000000000000000000">
			<cfset productBean.setModuleID('00000000-0000-0000-0000000000000000') />
		</cfif>
		<cfif not StructKeyExists(data,"productID") or len(data.productID) neq 35>
			<cfif structKeyExists(arguments,"event")>
				<cfset mmError.addError(event,"invalidProductID","custom",3000) />
			</cfif>
			<cfset success = false>
		</cfif>
		<cfif not StructKeyExists(data,"price") or not isNumeric(data.price) or data.price lte 0>
			<cfif structKeyExists(arguments,"event")>
				<cfset mmError.addError(event,"invalidProductPrice","custom",3000) />
			</cfif>
			<cfset success = false>
		</cfif>

		<cfset productBean.setIsValid( success ) />

		<cfreturn success>
	</cffunction>

	<cffunction name="addProduct" access="public" output="false" returntype="any">
		<cfargument name="CartID" type="uuid" required="true" />
		<cfargument name="ProductBean" type="any" required="true" />
		<cfargument name="UserBean" type="any" required="true" />
		<cfargument name="event" type="any" required="false" />

		<cfset var cartService			= getBeanFactory().getBean('cartService') />
		<cfset var cartProductService	= getBeanFactory().getBean('cartProductService') />
		<cfset var sessionCartID		= getMeldMiniCommerceManager().getPluginConfig().getSession().getValue( 'cartID' ) />
		<cfset var cartBean				= "" />
		<cfset var sArgs				= StructNew() />

		<cfif not arguments.productBean.getIsValid()>
			<cfset validateProductBean( productBean ) />
		</cfif>

		<cfif not arguments.productBean.getIsValid()>
			<cfif structKeyExists(arguments,"event")>
				<cfset variables.mmErrorManager.addError(event,"invalidProductBean","custom",3000,"") />
			</cfif>
			<cfreturn "" />
		</cfif>

		<cfif len(sessionCartID)>
			<cfset sArgs.cartID	= sessionCartID />
		</cfif>
		<cfif not UserBean.getIsNew()>
			<cfset sArgs.userID	= UserBean.getUserID() />
		</cfif>
		<cfset sArgs.siteID = event.getValue('siteID') />

		<cfset cartBean		= cartService.getActiveCart( argumentCollection=sArgs ) />

		<cfif not len( sessionCartID ) or cartBean.getCartID() neq sessionCartID>
			<cflock scope="Session" timeout="15">
				<cfset getMeldMiniCommerceManager().getPluginConfig().getSession().setValue( 'cartID',cartBean.getCartID() ) />
			</cflock>  
		</cfif>

		<cfset sArgs				= StructNew() />
		<cfset sArgs.cartBean		= cartBean />
		<cfset sArgs.ProductBean	= arguments.ProductBean />
		<cfset sArgs.UserBean		= arguments.UserBean />

		<cfreturn cartProductService.addProduct( argumentCollection=sArgs ) />
	</cffunction>

	<cffunction name="updateProduct" access="public" output="false" returntype="any">
		<cfargument name="CartID" type="uuid" required="true" />
		<cfargument name="ProductBean" type="any" required="true" />
		<cfargument name="CartProductID" type="any" required="true" />
		<cfargument name="UserBean" type="any" required="true" />
		<cfargument name="event" type="any" required="false" />

		<cfset var cartService			= getBeanFactory().getBean('cartService') />
		<cfset var cartProductService	= getBeanFactory().getBean('cartProductService') />
		<cfset var sessionCartID		= getMeldMiniCommerceManager().getPluginConfig().getSession().getValue( 'cartID' ) />
		<cfset var cartBean				= "" />
		<cfset var sArgs				= StructNew() />

		<cfif not arguments.productBean.getIsValid()>
			<cfset validateProductBean( productBean ) />
		</cfif>

		<cfif not arguments.productBean.getIsValid()>
			<cfif structKeyExists(arguments,"event")>
				<cfset variables.mmErrorManager.addError(event,"invalidProductBean","custom",3000,"") />
			</cfif>
			<cfreturn "" />
		</cfif>

		<cfif len(sessionCartID)>
			<cfset sArgs.cartID	= sessionCartID />
		</cfif>
		<cfif not UserBean.getIsNew()>
			<cfset sArgs.userID	= UserBean.getUserID() />
		</cfif>
		<cfset sArgs.siteID 	= event.getValue('siteID') />

		<cfset cartBean		= cartService.getActiveCart( argumentCollection=sArgs ) />

		<cfif not len( sessionCartID ) or cartBean.getCartID() neq sessionCartID>
			<cflock scope="Session" timeout="15">
				<cfset getMeldMiniCommerceManager().getPluginConfig().getSession().setValue( 'cartID',cartBean.getCartID() ) />
			</cflock>  
		</cfif>

		<cfset sArgs				= StructNew() />
		<cfset sArgs.cartBean		= cartBean />
		<cfset sArgs.ProductBean	= arguments.ProductBean />
		<cfset sArgs.cartProductID	= arguments.cartProductID />
		<cfset sArgs.UserBean		= arguments.UserBean />
		<cfreturn cartProductService.updateProduct( argumentCollection=sArgs ) />
	</cffunction>

	<cffunction name="updatePricing" access="public" output="false" returntype="any">
		<cfargument name="CartBean" type="any" required="true" />

		<cfset var cartService			= getBeanFactory().getBean('cartService') />
		<cfset var cartProductService	= getBeanFactory().getBean('cartProductService') />
		<cfset var sCartProducts		= cartProductService.getProductsInCart( cartBean.getCartID() ) />  
		<cfset var cartProductBean		= "" />  
		<cfset var newProductBean		= "" />  
		<cfset var iiX					= "" />  

		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean	= sCartProducts[iiX] /> 
			<cfset newProductBean	= cartBean.getCartProductBean( cartProductBean.getCartPRoductID() ) />
	
			<cfif not isSimpleValue( newProductBean  )
				and newProductBean.getPrice() neq cartProductBean.getPrice()>
				<cfset cartProductService.updateCartProduct( newProductBean ) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn getMeldMiniCommerceManager().getBeanFactory()>
	</cffunction>

	<cffunction name="setMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfargument name="MeldMiniCommerceManager" type="any" required="true">
		<cfset variables.MeldMiniCommerceManager = arguments.MeldMiniCommerceManager>
	</cffunction>
	<cffunction name="getMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldMiniCommerceManager>
	</cffunction>
</cfcomponent>
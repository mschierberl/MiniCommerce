<!---^^LICENSE-START^^--->

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

<!---^^LICENSE-END^^--->

<cfcomponent displayname="CartBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="CartID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="IsProcessed" type="boolean" default="0" required="true" />
	<cfproperty name="IsSaved" type="boolean" default="0" required="true" />
	<cfproperty name="IsCompleted" type="boolean" default="0" required="true" />
	<cfproperty name="IsPending" type="boolean" default="0" required="true" />
	<cfproperty name="IsActive" type="boolean" default="1" required="true" />
	<cfproperty name="DatePending" type="date" default="" />
	<cfproperty name="TempUserID" type="uuid" default="" maxlength="35" />
	<cfproperty name="UserID" type="uuid" default="" maxlength="35" />
	<cfproperty name="RemoteID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Attributes" type="string" default="" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="Discount" type="numeric" default="0.00" required="true" />
	<cfproperty name="Tax" type="numeric" default="0.00" required="true" />
	<cfproperty name="Shipping" type="numeric" default="0.00" required="true" />
	<cfproperty name="Products" type="struct" default="" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="CartBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="IsProcessed" type="boolean" required="false" default="0" />
		<cfargument name="IsSaved" type="boolean" required="false" default="0" />
		<cfargument name="IsCompleted" type="boolean" required="false" default="0" />
		<cfargument name="IsPending" type="boolean" required="false" default="0" />
		<cfargument name="IsActive" type="boolean" required="false" default="1" />
		<cfargument name="DatePending" type="string" required="false" default="" />
		<cfargument name="TempUserID" type="string" required="false" default="" />
		<cfargument name="UserID" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="Attributes" type="string" required="false" default="" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="Discount" type="numeric" required="false" default="0.00" />
		<cfargument name="Tax" type="numeric" required="false" default="0.00" />
		<cfargument name="Shipping" type="numeric" required="false" default="0.00" />
		<cfargument name="Products" type="struct" required="false" default="#structNew()#" />

		<!---^^SETTERS-START^^--->
		<cfset setCartID( arguments.CartID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setIsProcessed( arguments.IsProcessed ) />
		<cfset setIsSaved( arguments.IsSaved ) />
		<cfset setIsCompleted( arguments.IsCompleted ) />
		<cfset setIsPending( arguments.IsPending ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setDatePending( arguments.DatePending ) />
		<cfset setTempUserID( arguments.TempUserID ) />
		<cfset setUserID( arguments.UserID ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setAttributes( arguments.Attributes ) />
		<cfset setSiteID( arguments.SiteID ) />
		<!---^^SETTERS-END^^--->
		<cfset setDiscount( arguments.Discount ) />
		<cfset setTax( arguments.Tax ) />
		<cfset setShipping( arguments.Shipping ) />
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setProducts( arguments.Products ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="CartBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setCartID" access="public" returntype="void" output="false">
		<cfargument name="CartID" type="uuid" required="true" />
		<cfset variables.instance['cartid'] = arguments.CartID />
	</cffunction>
	<cffunction name="getCartID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.CartID />
	</cffunction>
	
	<cffunction name="setDateCreate" access="public" returntype="void" output="false">
		<cfargument name="DateCreate" type="string" required="true" />
		<cfset variables.instance['datecreate'] = arguments.DateCreate />
	</cffunction>
	<cffunction name="getDateCreate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateCreate />
	</cffunction>
	
	<cffunction name="setDateLastUpdate" access="public" returntype="void" output="false">
		<cfargument name="DateLastUpdate" type="string" required="true" />
		<cfset variables.instance['datelastupdate'] = arguments.DateLastUpdate />
	</cffunction>
	<cffunction name="getDateLastUpdate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastUpdate />
	</cffunction>
	
	<cffunction name="setIsProcessed" access="public" returntype="void" output="false">
		<cfargument name="IsProcessed" type="boolean" required="true" />
		<cfset variables.instance['isprocessed'] = arguments.IsProcessed />
	</cffunction>
	<cffunction name="getIsProcessed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsProcessed />
	</cffunction>
	
	<cffunction name="setIsSaved" access="public" returntype="void" output="false">
		<cfargument name="IsSaved" type="boolean" required="true" />
		<cfset variables.instance['issaved'] = arguments.IsSaved />
	</cffunction>
	<cffunction name="getIsSaved" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsSaved />
	</cffunction>
	
	<cffunction name="setIsCompleted" access="public" returntype="void" output="false">
		<cfargument name="IsCompleted" type="boolean" required="true" />
		<cfset variables.instance['iscompleted'] = arguments.IsCompleted />
	</cffunction>
	<cffunction name="getIsCompleted" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsCompleted />
	</cffunction>
	
	<cffunction name="setIsPending" access="public" returntype="void" output="false">
		<cfargument name="IsPending" type="boolean" required="true" />
		<cfset variables.instance['ispending'] = arguments.IsPending />
	</cffunction>
	<cffunction name="getIsPending" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsPending />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setDatePending" access="public" returntype="void" output="false">
		<cfargument name="DatePending" type="string" required="true" />
		<cfset variables.instance['datepending'] = arguments.DatePending />
	</cffunction>
	<cffunction name="getDatePending" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DatePending />
	</cffunction>
	
	<cffunction name="setTempUserID" access="public" returntype="void" output="false">
		<cfargument name="TempUserID" type="string" required="true" />
		<cfset variables.instance['tempuserid'] = arguments.TempUserID />
	</cffunction>
	<cffunction name="getTempUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TempUserID />
	</cffunction>
	
	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="UserID" type="string" required="true" />
		<cfset variables.instance['userid'] = arguments.UserID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserID />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- BeanExists --->
	<cffunction name="setBeanExists" access="public" output="false" returntype="void">
		<cfargument name="BeanExists" type="boolean" required="true" />
		<cfset variables.BeanExists = arguments.BeanExists >
	</cffunction>
	<cffunction name="BeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>

	<!--- DUMP --->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="setAttributes" access="public" returntype="void" output="false">
		<cfargument name="Attributes" type="any" required="true" />
		<cfif isJSON( arguments.Attributes )>
			<cfset variables.instance['attributes'] = arguments.Attributes />
		<cfelseif isStruct( arguments.Attributes )>
			<cfset variables.instance['attributes'] = serializeJSON( arguments.Attributes ) />
		<cfelse>
			<cfset variables.instance['attributes'] = "" />
		</cfif>
	</cffunction>
	<cffunction name="getAttributes" access="public" returntype="string" output="false">
		<cfif isStruct( variables.instance.Attributes )>
			<cfset serializeJSON( variables.instance.Attributes ) />
		</cfif>
		<cfreturn variables.instance.Attributes />
	</cffunction>

	<cffunction name="getAttributesAsStruct" access="public" returntype="struct" output="false">
		<cfif len( getAttributes() ) and isJSON( getAttributes() )>
			<cfreturn deserializeJSON( getAttributes() ) />
		<cfelse>
			<cfreturn StructNew() />
		</cfif>
	</cffunction>

	<cffunction name="setTax" access="public" returntype="void" output="false">
		<cfargument name="Tax" type="numeric" required="true" />
		<cfset variables.instance['tax'] = arguments.Tax />
	</cffunction>
	<cffunction name="getTax" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Tax />
	</cffunction>
	
	<cffunction name="setShipping" access="public" returntype="void" output="false">
		<cfargument name="Shipping" type="numeric" required="true" />
		<cfset variables.instance['shipping'] = arguments.Shipping />
	</cffunction>
	<cffunction name="getShipping" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Shipping />
	</cffunction>
	
	<cffunction name="setDiscount" access="public" returntype="void" output="false">
		<cfargument name="Discount" type="numeric" required="true" />
		<cfset variables.instance['discount'] = arguments.Discount />
	</cffunction>
	<cffunction name="getDiscount" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Discount />
	</cffunction>

	<cffunction name="setProducts" access="public" returntype="void" output="false">
		<cfargument name="Products" type="struct" required="true" />
		<cfset variables.instance['products'] = arguments.Products />
	</cffunction>
	<cffunction name="getProducts" access="public" returntype="struct" output="false">
		<cfif not StructKeyExists(variables.instance,"Products")>
			<cfif not StructKeyExists(variables,"CartService")>
				<cfreturn StructNew() />
			</cfif>
			<cfset variables.instance.Products = variables.CartService.getCartProducts( getCartID() ) />
		</cfif>
		<cfreturn variables.instance.Products />
	</cffunction>
	
	<cffunction name="setModuleIDs" access="public" returntype="void" output="false">
		<cfargument name="ModuleIDs" type="any" required="true" />
		<cfset variables.instance['moduleids'] = arguments.ModuleIDs />
	</cffunction>
	<cffunction name="getModuleIDs" access="public" returntype="struct" output="false">
		<cfif not StructKeyExists(variables.instance,"ModuleIDs")>
			<cfif not StructKeyExists(variables,"CartService")>
				<cfreturn StructNew() />
			</cfif>
			<cfset variables.instance.ModuleIDs = variables.CartService.getCartModuleIDs( getCartID() ) />
		</cfif>
		
		<cfreturn variables.instance.ModuleIDs />
	</cffunction>
	
	<cffunction name="setProductIDs" access="public" returntype="void" output="false">
		<cfargument name="ProductIDs" type="any" required="true" />
		<cfset variables.instance['productids'] = arguments.ProductIDs />
	</cffunction>
	<cffunction name="getProductIDs" access="public" returntype="struct" output="false">
		<cfif not StructKeyExists(variables.instance,"ProductIDs")>
			<cfif not StructKeyExists(variables,"CartService")>
				<cfreturn StructNew()/>
			</cfif>
			<cfset variables.instance.ProductIDs = variables.CartService.getCartProductIDs( getCartID() ) />
		</cfif>

		<cfreturn variables.instance.ProductIDs />
	</cffunction>

	<cffunction name="isProductIDInCart" access="public" returntype="boolean" output="false">
		<cfargument name="ProductID" type="uuid" required="true" />

		<cfreturn StructKeyExists( getProductIDs(),arguments.ProductID ) />
	</cffunction>

	<cffunction name="isModuleIDInCart" access="public" returntype="boolean" output="false">
		<cfargument name="ModuleID" type="uuid" required="true" />

		<cfreturn StructKeyExists( getModuleIDs(),arguments.ModuleID ) />
	</cffunction>

	<cffunction name="getModuleCartProductIDs" access="public" returntype="array" output="false">
		<cfargument name="ModuleID" type="uuid" required="true" />

		<cfset var sModuleIDs		= getModuleIDs() />

		<cfif structKeyExists(sModuleIDs,arguments.ModuleID)>
			<cfreturn ListToArray(sModuleIDs[arguments.ModuleID])>
		</cfif>
	
		<cfreturn ArrayNew(1) />
	</cffunction>

	<cffunction name="getProductSubtotal" access="public" returntype="Numeric" output="false">
		<cfset var sCartProducts	= variables.instance.Products />
		<cfset var iiX				= "" />
		<cfset var cartProductBean	= "" />
		<cfset var subtotal			= 0 />
		
		<cfif not structCount( sCartProducts )>
			<cfreturn subtotal>
		</cfif>
		
		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean = sCartProducts[iiX] />
			<cfset subtotal = subtotal + cartProductBean.getSubTotal() />
		</cfloop>

		<cfreturn subtotal>
	</cffunction>

	<cffunction name="getProductTotal" access="public" returntype="Numeric" output="false">
		<cfset var sCartProducts	= variables.instance.Products />
		<cfset var iiX				= "" />
		<cfset var cartProductBean	= "" />
		<cfset var total			= 0 />
		
		<cfif not structCount( sCartProducts )>
			<cfreturn total>
		</cfif>
		
		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean = sCartProducts[iiX] />
			<cfset total = total + cartProductBean.getTotal() />
		</cfloop>

		<cfreturn total>
	</cffunction>

	<cffunction name="getSubtotal" access="public" returntype="Numeric" output="false">
		<cfreturn getProductSubtotal()>
	</cffunction>

	<cffunction name="getTotal" access="public" returntype="Numeric" output="false">
		<cfif getIsCompleted()>
			<cfreturn 0>
		<cfelse>
			<cfreturn getProductTotal() + getShipping() + getTax() - getDiscount() />
		</cfif>
	</cffunction>

	<cffunction name="getShippingTotal" access="public" returntype="Numeric" output="false">
		<cfif getIsCompleted()>
			<cfreturn 0>
		<cfelse>
			<cfreturn getShipping() + getProductShippingTotal() />
		</cfif>
	</cffunction>

	<cffunction name="getDiscountTotal" access="public" returntype="Numeric" output="false">
		<cfif getIsCompleted()>
			<cfreturn 0>
		<cfelse>
			<cfreturn getDiscount() + getProductDiscountTotal() />
		</cfif>
	</cffunction>

	<cffunction name="getTaxTotal" access="public" returntype="Numeric" output="false">
		<cfif getIsCompleted()>
			<cfreturn 0>
		<cfelse>
			<cfreturn getTax() + getProductTaxTotal() />
		</cfif>
	</cffunction>

	<cffunction name="getCartProductBean" access="public" returntype="any" output="false">
		<cfargument name="CartProductID" type="uuid" required="true" />

		<cfif structKeyExists( variables.instance.products,arguments.CartProductID )>
			<cfreturn variables.instance.products[arguments.CartProductID]>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="getProductShippingTotal" access="public" returntype="Numeric" output="false">
		<cfset var sCartProducts	= variables.instance.Products />
		<cfset var iiX				= "" />
		<cfset var cartProductBean	= "" />
		<cfset var total			= 0 />
		
		<cfif not structCount( sCartProducts )>
			<cfreturn total>
		</cfif>
		
		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean = sCartProducts[iiX] />
			<cfset total = total + cartProductBean.getShippingTotal() />
		</cfloop>

		<cfreturn total>
	</cffunction>

	<cffunction name="getProductTaxTotal" access="public" returntype="Numeric" output="false">
		<cfset var sCartProducts	= variables.instance.Products />
		<cfset var iiX				= "" />
		<cfset var cartProductBean	= "" />
		<cfset var total			= 0 />
		
		<cfif not structCount( sCartProducts )>
			<cfreturn total>
		</cfif>
		
		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean = sCartProducts[iiX] />
			<cfset total = total + cartProductBean.getTaxTotal() />
		</cfloop>

		<cfreturn total>
	</cffunction>

	<cffunction name="getProductDiscountTotal" access="public" returntype="Numeric" output="false">
		<cfset var sCartProducts	= variables.instance.Products />
		<cfset var iiX				= "" />
		<cfset var cartProductBean	= "" />
		<cfset var total			= 0 />
		
		<cfif not structCount( sCartProducts )>
			<cfreturn total>
		</cfif>
		
		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean = sCartProducts[iiX] />
			<cfset total = total + cartProductBean.getDiscountTotal() />
		</cfloop>

		<cfreturn total>
	</cffunction>

	<cffunction name="isEmpty" access="public" returntype="boolean" output="false">

		<cfreturn not StructCount(getProducts())>
	</cffunction>

<!---^^CUSTOMEND^^--->
	<cffunction name="setCartService" access="public" returntype="any" output="false">
		<cfargument name="CartService" type="any" required="true">
		<cfset variables.CartService = arguments.CartService>
	</cffunction>
	<cffunction name="getCartService" access="public" returntype="any" output="false">
		<cfreturn variables.CartService>
	</cffunction>
</cfcomponent>	











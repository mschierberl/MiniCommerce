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


<cfcomponent name="CartService" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="CartService">
		<cfargument name="CartDAO" type="any" required="true" />
		<cfargument name="CartGateway" type="any" required="true" />
		<cfargument name="mmErrorManager" type="any" required="true" />

		<cfset variables.CartDAO		= arguments.CartDAO />
		<cfset variables.CartGateway	= arguments.CartGateway />
		<cfset variables.mmErrorManager	= arguments.mmErrorManager />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createCart" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsProcessed" type="boolean" required="false" />
		<cfargument name="IsSaved" type="boolean" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsPending" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="DatePending" type="string" required="false" />
		<cfargument name="TempUserID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var CartBean = createObject("component","CartBean").init(argumentCollection=arguments) />
		<cfreturn CartBean />
	</cffunction>

	<cffunction name="getCart" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="CartID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		<cfargument name="doProducts" type="boolean" required="false" default="false" />
		
		<cfset var CartBean = createCart(argumentCollection=arguments) />
		<cfset variables.CartDAO.read(CartBean) />
		
		<cfset CartBean.setCartService( this ) />
		
		<cfif cartBean.beanExists() and arguments.doProducts>
			<cfset variables.CartGateway.getCartPRoducts( cartBean ) />
		</cfif>
		
		<cfreturn CartBean />
	</cffunction>

	<cffunction name="getCarts" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsProcessed" type="boolean" required="false" />
		<cfargument name="IsSaved" type="boolean" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsPending" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="DatePending" type="string" required="false" />
		<cfargument name="TempUserID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn variables.CartGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsProcessed" type="boolean" required="false" />
		<cfargument name="IsSaved" type="boolean" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsPending" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="DatePending" type="string" required="false" />
		<cfargument name="TempUserID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfset cartBean = variables.CartGateway.getBeanByAttributes(argumentCollection=arguments) />

		<cfset CartBean.setCartService( this ) />
		<cfreturn cartBean />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn variables.CartGateway.getByArray(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var aCart			= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = variables.CartGateway.search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset aCart				= variables.CartGateway.search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start>
		<cfset sReturn.size			= arguments.size>
		<cfset sReturn.itemarray	= aCart>

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveCart" access="public" output="false" returntype="boolean">
		<cfargument name="CartBean" type="any" required="true" />

		<cfreturn variables.CartDAO.save(CartBean) />
	</cffunction>
	
	<cffunction name="updateCart" access="public" output="false" returntype="boolean">
		<cfargument name="CartBean" type="any" required="true" />

		<cfreturn variables.CartDAO.update(CartBean) />
	</cffunction>

	<cffunction name="deleteCart" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="CartID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var CartBean = createCart(argumentCollection=arguments) />
		<cfreturn variables.CartDAO.delete(CartBean) />
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="getActiveCart" access="public" output="false" returntype="any">
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="doProducts" type="boolean" required="false" default="false" />
		<cfargument name="expireHours" type="numeric"  required="false" default="3" />
		<cfargument name="expireDays" type="numeric"  required="false" default="14" />

		<cfset var cartBean	= variables.CartGateway.getActiveCart(argumentCollection=arguments) />
		<cfset cartBean.setCartService( this ) />

		<cfreturn cartBean />
	</cffunction>

	<cffunction name="emptyCart" access="public" output="false" returntype="boolean">
		<cfargument name="CartID" type="uuid" required="false" />

		<cfreturn getCartProductService().deleteCartProductsInCart( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getCartModuleIDs" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfreturn getCartProductService().getCartModuleIDs( argumentCollection=arguments )>
	</cffunction>

	<cffunction name="getCartProductIDs" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfreturn getCartProductService().getCartProductIDs( argumentCollection=arguments )>
	</cffunction>

	<cffunction name="getCartProducts" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfreturn getCartProductService().getProductsInCart( argumentCollection=arguments )>
	</cffunction>

	<cffunction name="commitCart" access="public" output="false" returntype="void">
		<cfargument name="cartBean" type="any" required="true" />

		<cfset var sProducts 		= cartBean.getProducts() />

		<cfset cartBean.setIsActive( 0 ) />
		<cfset cartBean.setIsSaved( 0 ) />
		<cfset cartBean.setIsProcessed( 1 ) />
		<cfset cartBean.setIsCompleted( 1 ) />

		<cfset updateCart( cartBean ) />

		<cfset getCartProductService().commitCartProducts( sProducts )>
	</cffunction>

<!---^^CUSTOMEND^^--->
	<cffunction name="setMeldMiniCommerceProductManager" access="public" returntype="any" output="false">
		<cfargument name="MeldMiniCommerceProductManager" type="any" required="true">
		<cfset variables.MeldMiniCommerceProductManager = arguments.MeldMiniCommerceProductManager>
	</cffunction>
	<cffunction name="getMeldMiniCommerceProductManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldMiniCommerceProductManager>
	</cffunction>

	<cffunction name="setCartProductService" access="public" returntype="any" output="false">
		<cfargument name="CartProductService" type="any" required="true">
		<cfset variables.CartProductService = arguments.CartProductService>
	</cffunction>
	<cffunction name="getCartProductService" access="public" returntype="any" output="false">
		<cfreturn variables.CartProductService>
	</cffunction>
</cfcomponent>

















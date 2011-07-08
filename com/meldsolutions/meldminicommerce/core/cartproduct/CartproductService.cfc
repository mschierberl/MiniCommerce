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



<cfcomponent name="CartproductService" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="CartproductService">
		<cfargument name="CartproductDAO" type="any" required="true" />
		<cfargument name="CartproductGateway" type="any" required="true" />

		<cfset variables.CartproductDAO = arguments.CartproductDAO />
		<cfset variables.CartproductGateway = arguments.CartproductGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createCartproduct" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartProductID" type="uuid" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="ProductID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="Price" type="numeric" required="false" />
		<cfargument name="Quantity" type="numeric" required="false" />
		<cfargument name="UseQuantity" type="boolean" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="AttributesID" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var CartproductBean = createObject("component","CartproductBean").init(argumentCollection=arguments) />
		<cfreturn CartproductBean />
	</cffunction>

	<cffunction name="getCartproduct" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="CartProductID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var CartproductBean = createCartproduct(argumentCollection=arguments) />
		<cfset variables.CartproductDAO.read(CartproductBean) />
		<cfreturn CartproductBean />
	</cffunction>

	<cffunction name="getCartproducts" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartProductID" type="uuid" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="ProductID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="Price" type="numeric" required="false" />
		<cfargument name="Quantity" type="numeric" required="false" />
		<cfargument name="UseQuantity" type="boolean" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="AttributesID" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn variables.CartproductGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartProductID" type="uuid" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="ProductID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="Price" type="numeric" required="false" />
		<cfargument name="Quantity" type="numeric" required="false" />
		<cfargument name="UseQuantity" type="boolean" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="AttributesID" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn variables.CartproductGateway.getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn variables.CartproductGateway.getByArray(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var aCartproduct			= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = variables.CartproductGateway.search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset aCartproduct				= variables.CartproductGateway.search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start>
		<cfset sReturn.size			= arguments.size>
		<cfset sReturn.itemarray	= aCartproduct>

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveCartproduct" access="public" output="false" returntype="boolean">
		<cfargument name="CartproductBean" type="any" required="true" />

		<cfreturn variables.CartproductDAO.save(CartproductBean) />
	</cffunction>
	
	<cffunction name="updateCartproduct" access="public" output="false" returntype="boolean">
		<cfargument name="CartproductBean" type="any" required="true" />

		<cfreturn variables.CartproductDAO.update(CartproductBean) />
	</cffunction>

	<cffunction name="deleteCartproduct" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="CartProductID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var CartproductBean = createCartproduct(argumentCollection=arguments) />
		<cfreturn variables.CartproductDAO.delete(CartproductBean) />
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="deleteCartproductsInCart" access="public" output="false" returntype="boolean">
		<cfargument name="CartID" type="uuid" required="true" />

		<cfreturn variables.CartproductGateway.deleteCartproductsInCart( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getCartModuleIDs" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfreturn variables.CartproductGateway.getCartModuleIDs( argumentCollection=arguments )>
	</cffunction>

	<cffunction name="getCartProductIDs" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfreturn variables.CartproductGateway.getCartProductIDs( argumentCollection=arguments )>
	</cffunction>

	<cffunction name="getProductsInCart" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfreturn variables.CartproductGateway.getProductsInCart( argumentCollection=arguments )>
	</cffunction>

	<cffunction name="commitCartProducts" access="public" output="false" returntype="void">
		<cfargument name="sProducts" type="struct" required="true" />

		<cfset iiX		= "" />
		
		<cfloop collection="#arguments.sProducts#" item="iiX">
			<cfset updateCartproduct( arguments.sProducts[iiX] ) />
		</cfloop>
	</cffunction>

	<cffunction name="addProduct" access="public" output="false" returntype="any">
		<cfargument name="CartBean" type="any" required="true" />
		<cfargument name="ProductBean" type="any" required="true" />
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var cartProductBean	= createCartproduct() />
		<cfset var sArgs			= arguments.ProductBean.getMemento() />

		<cfif not arguments.cartBean.beanExists()>
			<cfset getCartService().saveCart( cartBean ) />
		<cfelseif not ProductBean.getIsValid()>
			<!--- TODO: error --->
			<cfreturn cartProductBean>
		</cfif>

		<cfset sArgs.cartID			= arguments.CartBean.getCartID() />
		<cfset cartProductBean		= cartProductBean.init( argumentCollection=sArgs ) />

		<cfif variables.CartproductGateway.productExistsInCart( CartProductBean )>
			<cfset variables.CartproductGateway.updateQuantity( cartProductBean ) />
		<cfelseif cartProductBean.getQuantity() gt 0>
			<cfset saveCartproduct( cartProductBean ) />
		<cfelse>
			<cfset CartProductBean.setQuantity( 0 )>
		</cfif>

		<cfreturn cartProductBean />
	</cffunction>

	<cffunction name="updateProduct" access="public" output="false" returntype="any">
		<cfargument name="CartBean" type="any" required="true" />
		<cfargument name="ProductBean" type="any" required="true" />
		<cfargument name="cartProductID" type="uuid" required="true" />
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var cartProductBean	= getCartproduct( arguments.cartProductID ) />
		<cfset var sArgs			= arguments.ProductBean.getMemento() />

		
		<cfif not arguments.cartBean.beanExists()>
			<cfset getCartService().saveCart( cartBean ) />
		<cfelseif not ProductBean.getIsValid()>
			<!--- TODO: error --->
			<cfreturn cartProductBean>
		</cfif>

		<cfset cartProductBean.updateMemento( sArgs ) />

		<cfset deleteCartproduct( arguments.cartProductID ) />
		<cfif cartProductBean.getQuantity() gt 0>
			<cfset saveCartproduct( cartProductBean ) />
		</cfif>
		
		<cfreturn cartProductBean />
	</cffunction>

	<cffunction name="setQuantity" access="public" output="false" returntype="void">
		<cfargument name="CartProductID" type="any" required="true" />
		<cfargument name="Quantity" type="numeric" required="true" />

		<cfset variables.CartproductGateway.setQuantity( argumentCollection=arguments ) />
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













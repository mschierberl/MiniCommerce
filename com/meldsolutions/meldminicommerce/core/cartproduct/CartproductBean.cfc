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



<cfcomponent displayname="CartproductBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="CartProductID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="CartID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ProductID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="ModuleID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Price" type="numeric" default="0.00" required="true" />
	<cfproperty name="Quantity" type="numeric" default="0" required="true" />
	<cfproperty name="UseQuantity" type="boolean" default="1" required="true" />
	<cfproperty name="RemoteID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Attributes" type="string" default="" />
	<cfproperty name="AttributesID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Tax" type="numeric" default="0.00" required="true" />
	<cfproperty name="Shipping" type="numeric" default="0.00" required="true" />
	<cfproperty name="Discount" type="numeric" default="0.00" required="true" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="Name" type="string" default="" />
	<cfproperty name="Summary" type="string" default="" />
	<cfproperty name="Description" type="string" default="" />
	<cfproperty name="FileID" type="string" default="" maxlength="35" />
	<cfproperty name="Url" type="string" default="" maxlength="35" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="CartproductBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartProductID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="CartID" type="string" required="false" default="" />
		<cfargument name="ProductID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="ModuleID" type="string" required="false" default="" />
		<cfargument name="Price" type="numeric" required="false" default="0.00" />
		<cfargument name="Quantity" type="numeric" required="false" default="0" />
		<cfargument name="UseQuantity" type="boolean" required="false" default="1" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="Attributes" type="string" required="false" default="" />
		<cfargument name="AttributesID" type="string" required="false" default="" />
		<cfargument name="Tax" type="numeric" required="false" default="0.00" />
		<cfargument name="Shipping" type="numeric" required="false" default="0.00" />
		<cfargument name="Discount" type="numeric" required="false" default="0.00" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Summary" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="FileID" type="string" required="false" default="" />
		<cfargument name="Url" type="string" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setCartProductID( arguments.CartProductID ) />
		<cfset setCartID( arguments.CartID ) />
		<cfset setProductID( arguments.ProductID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setModuleID( arguments.ModuleID ) />
		<cfset setPrice( arguments.Price ) />
		<cfset setQuantity( arguments.Quantity ) />
		<cfset setUseQuantity( arguments.UseQuantity ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setAttributes( arguments.Attributes ) />
		<cfset setAttributesID( arguments.AttributesID ) />
		<cfset setTax( arguments.Tax ) />
		<cfset setShipping( arguments.Shipping ) />
		<cfset setDiscount( arguments.Discount ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setName( arguments.Name ) />
		<cfset setSummary( arguments.Summary ) />
		<cfset setDescription( arguments.Description ) />
		<cfset setFileID( arguments.FileID ) />
		<cfset setUrl( arguments.Url ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="CartproductBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setCartProductID" access="public" returntype="void" output="false">
		<cfargument name="CartProductID" type="uuid" required="true" />
		<cfset variables.instance['cartproductid'] = arguments.CartProductID />
	</cffunction>
	<cffunction name="getCartProductID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.CartProductID />
	</cffunction>
	
	<cffunction name="setCartID" access="public" returntype="void" output="false">
		<cfargument name="CartID" type="string" required="true" />
		<cfset variables.instance['cartid'] = arguments.CartID />
	</cffunction>
	<cffunction name="getCartID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CartID />
	</cffunction>
	
	<cffunction name="setProductID" access="public" returntype="void" output="false">
		<cfargument name="ProductID" type="string" required="true" />
		<cfset variables.instance['productid'] = arguments.ProductID />
	</cffunction>
	<cffunction name="getProductID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ProductID />
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
	
	<cffunction name="setModuleID" access="public" returntype="void" output="false">
		<cfargument name="ModuleID" type="string" required="true" />
		<cfset variables.instance['moduleid'] = arguments.ModuleID />
	</cffunction>
	<cffunction name="getModuleID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ModuleID />
	</cffunction>
	
	<cffunction name="setPrice" access="public" returntype="void" output="false">
		<cfargument name="Price" type="numeric" required="true" />
		<cfset variables.instance['price'] = arguments.Price />
	</cffunction>
	<cffunction name="getPrice" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Price />
	</cffunction>
	
	<cffunction name="setQuantity" access="public" returntype="void" output="false">
		<cfargument name="Quantity" type="numeric" required="true" />
		<cfset variables.instance['quantity'] = arguments.Quantity />
	</cffunction>
	<cffunction name="getQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Quantity />
	</cffunction>
	
	<cffunction name="setUseQuantity" access="public" returntype="void" output="false">
		<cfargument name="UseQuantity" type="boolean" required="true" />
		<cfset variables.instance['usequantity'] = arguments.UseQuantity />
	</cffunction>
	<cffunction name="getUseQuantity" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.UseQuantity />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setAttributesID" access="public" returntype="void" output="false">
		<cfargument name="AttributesID" type="string" required="true" />
		<cfset variables.instance['attributesid'] = arguments.AttributesID />
	</cffunction>
	<cffunction name="getAttributesID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttributesID />
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
	<cffunction name="getTaxTotal" access="public" returntype="numeric" output="false">
		<cfreturn getTax()*getQuantity() />
	</cffunction>

	<cffunction name="getShippingTotal" access="public" returntype="numeric" output="false">
		<cfreturn getShipping()*getQuantity() />
	</cffunction>

	<cffunction name="getDiscountTotal" access="public" returntype="numeric" output="false">
		<cfreturn getDiscount()*getQuantity() />
	</cffunction>

	<cffunction name="getSubtotal" access="public" returntype="numeric" output="false">
		<cfreturn getPrice()*getQuantity() />
	</cffunction>
	<cffunction name="getTotal" access="public" returntype="numeric" output="false">
		<cfreturn getSubtotal()+ (getTaxTotal()) + (getShippingTotal()) - (getDiscountTotal()) />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['Name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setSummary" access="public" returntype="void" output="false">
		<cfargument name="Summary" type="string" required="true" />
		<cfset variables.instance['summary'] = arguments.Summary />
	</cffunction>
	<cffunction name="getSummary" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Summary />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance['description'] = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>
	
	<cffunction name="setFileID" access="public" returntype="void" output="false">
		<cfargument name="FileID" type="string" required="true" />
		<cfset variables.instance['fileid'] = arguments.FileID />
	</cffunction>
	<cffunction name="getFileID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FileID />
	</cffunction>
	
	<cffunction name="setUrl" access="public" returntype="void" output="false">
		<cfargument name="Url" type="string" required="true" />
		<cfset variables.instance['Url'] = arguments.Url />
	</cffunction>
	<cffunction name="getUrl" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Url />
	</cffunction>

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

	<cffunction name="getAttribute" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />

		<cfset var attributes = getAttributesAsStruct() />

		<cfif StructKeyExists( attributes,arguments.name )>
			<cfreturn attributes[ arguments.name ] />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	














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

<cfcomponent displayname="ProductBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ProductID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Quantity" type="numeric" default="0" required="true" />
	<cfproperty name="Price" type="numeric" default="0.00" required="true" />
	<cfproperty name="Attributes" type="string" default="" />
	<cfproperty name="AttributesID" type="uuid" default="" maxlength="35" />
	<cfproperty name="IsValid" type="boolean" default="0" required="true" />
	<cfproperty name="ModuleID" type="uuid" default="" maxlength="35" />
	<cfproperty name="RemoteID" type="uuid" default="" maxlength="35" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="ProductBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ProductID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Quantity" type="numeric" required="false" default="0" />
		<cfargument name="Price" type="numeric" required="false" default="0.00" />
		<cfargument name="Attributes" type="string" required="false" default="" />
		<cfargument name="AttributesID" type="string" required="false" default="" />
		<cfargument name="IsValid" type="boolean" required="false" default="0" />
		<cfargument name="ModuleID" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->

		<!---^^SETTERS-START^^--->
		<cfset setProductID( arguments.ProductID ) />
		<cfset setQuantity( arguments.Quantity ) />
		<cfset setPrice( arguments.Price ) />
		<cfset setAttributes( arguments.Attributes ) />
		<cfset setAttributesID( arguments.AttributesID ) />
		<cfset setIsValid( arguments.IsValid ) />
		<cfset setModuleID( arguments.ModuleID ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<!---^^SETTERS-END^^--->
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ProductBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="setProductID" access="public" returntype="void" output="false">
		<cfargument name="ProductID" type="uuid" required="true" />
		<cfset variables.instance['productid'] = arguments.ProductID />
	</cffunction>
	<cffunction name="getProductID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.ProductID />
	</cffunction>
	
	<cffunction name="setModuleID" access="public" returntype="void" output="false">
		<cfargument name="ModuleID" type="string" required="true" />
		<cfset variables.instance['Moduleid'] = arguments.ModuleID />
	</cffunction>
	<cffunction name="getModuleID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ModuleID />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['Remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setQuantity" access="public" returntype="void" output="false">
		<cfargument name="Quantity" type="numeric" required="true" />
		<cfset variables.instance['quantity'] = arguments.Quantity />
	</cffunction>
	<cffunction name="getQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Quantity />
	</cffunction>
	
	<cffunction name="setPrice" access="public" returntype="void" output="false">
		<cfargument name="Price" type="numeric" required="true" />
		<cfset variables.instance['price'] = arguments.Price />
	</cffunction>
	<cffunction name="getPrice" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Price />
	</cffunction>
	
	<cffunction name="setAttributes" access="public" returntype="void" output="false">
		<cfargument name="Attributes" type="any" required="true" />
		<cfif isJSON( arguments.Attributes )>
			<cfset variables.instance['attributes'] = arguments.Attributes />
		<cfelseif isStruct( arguments.Attributes )>
			<cfset variables.instance['attributes'] = serializeJSON( arguments.Attributes ) />
		</cfif>
	</cffunction>
	<cffunction name="getAttributes" access="public" returntype="string" output="false">
		<cfif isStruct( variables.instance.Attributes )>
			<cfset serializeJSON( variables.instance.Attributes ) />
		</cfif>

		<cfreturn variables.instance.Attributes />
	</cffunction>
	
	<cffunction name="setAttributesID" access="public" returntype="void" output="false">
		<cfargument name="AttributesID" type="string" required="true" />
		<cfset variables.instance['attributesid'] = arguments.AttributesID />
	</cffunction>
	<cffunction name="getAttributesID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttributesID />
	</cffunction>
	
	<cffunction name="setIsValid" access="public" returntype="void" output="false">
		<cfargument name="IsValid" type="boolean" required="true" />
		<cfset variables.instance['isvalid'] = arguments.IsValid />
	</cffunction>
	<cffunction name="getIsValid" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsValid />
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
	<cffunction name="getAttributesAsStruct" access="public" returntype="string" output="false">
		<cfif len( getAttributes() ) and isJSON( getAttributes() )>
			<cfreturn deserializeJSON( getAttributes() ) />
		<cfelse>
			<cfreturn StructNew() />
		</cfif>
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>
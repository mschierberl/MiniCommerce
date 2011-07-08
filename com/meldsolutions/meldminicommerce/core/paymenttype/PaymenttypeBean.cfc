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


<cfcomponent displayname="PaymenttypeBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="PaymentTypeID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="100" />
	<cfproperty name="Identity" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="RemoteID" type="uuid" default="" maxlength="35" />
	<cfproperty name="IsActive" type="boolean" default="1" required="true" />
	<cfproperty name="Params" type="string" default="" />
	<cfproperty name="PaymentType" type="string" default="card" required="true" maxlength="25" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="PaymenttypeBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PaymentTypeID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Identity" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="1" />
		<cfargument name="Params" type="string" required="false" default="" />
		<cfargument name="PaymentType" type="string" required="false" default="card" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setPaymentTypeID( arguments.PaymentTypeID ) />
		<cfset setName( arguments.Name ) />
		<cfset setIdentity( arguments.Identity ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setParams( arguments.Params ) />
		<cfset setPaymentType( arguments.PaymentType ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="PaymenttypeBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setPaymentTypeID" access="public" returntype="void" output="false">
		<cfargument name="PaymentTypeID" type="uuid" required="true" />
		<cfset variables.instance['paymenttypeid'] = arguments.PaymentTypeID />
	</cffunction>
	<cffunction name="getPaymentTypeID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.PaymentTypeID />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>
	
	<cffunction name="setIdentity" access="public" returntype="void" output="false">
		<cfargument name="Identity" type="string" required="true" />
		<cfset variables.instance['identity'] = arguments.Identity />
	</cffunction>
	<cffunction name="getIdentity" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Identity />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setParams" access="public" returntype="void" output="false">
		<cfargument name="Params" type="string" required="true" />
		<cfset variables.instance['params'] = arguments.Params />
	</cffunction>
	<cffunction name="getParams" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Params />
	</cffunction>
	
	<cffunction name="setPaymentType" access="public" returntype="void" output="false">
		<cfargument name="PaymentType" type="string" required="true" />
		<cfset variables.instance['paymenttype'] = arguments.PaymentType />
	</cffunction>
	<cffunction name="getPaymentType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PaymentType />
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
<!---^^CUSTOMEND^^--->
</cfcomponent>	





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




<cfcomponent name="PaymenttypeService" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="PaymenttypeService">
		<cfargument name="PaymenttypeDAO" type="any" required="true" />
		<cfargument name="PaymenttypeGateway" type="any" required="true" />

		<cfset variables.PaymenttypeDAO = arguments.PaymenttypeDAO />
		<cfset variables.PaymenttypeGateway = arguments.PaymenttypeGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createPaymenttype" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PaymentTypeID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Identity" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="PaymentType" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var PaymenttypeBean = createObject("component","PaymenttypeBean").init(argumentCollection=arguments) />
		<cfreturn PaymenttypeBean />
	</cffunction>

	<cffunction name="getPaymenttype" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="PaymentTypeID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var PaymenttypeBean = createPaymenttype(argumentCollection=arguments) />
		<cfset variables.PaymenttypeDAO.read(PaymenttypeBean) />
		<cfreturn PaymenttypeBean />
	</cffunction>

	<cffunction name="getPaymenttypes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PaymentTypeID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Identity" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="PaymentType" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn variables.PaymenttypeGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PaymentTypeID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Identity" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="PaymentType" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn variables.PaymenttypeGateway.getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn variables.PaymenttypeGateway.getByArray(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var aPaymenttype			= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = variables.PaymenttypeGateway.search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset aPaymenttype				= variables.PaymenttypeGateway.search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start>
		<cfset sReturn.size			= arguments.size>
		<cfset sReturn.itemarray	= aPaymenttype>

		<cfreturn sReturn />
	</cffunction>
	

	<cffunction name="savePaymenttype" access="public" output="false" returntype="boolean">
		<cfargument name="PaymenttypeBean" type="any" required="true" />

		<cfreturn variables.PaymenttypeDAO.save(PaymenttypeBean) />
	</cffunction>
	
	<cffunction name="updatePaymenttype" access="public" output="false" returntype="boolean">
		<cfargument name="PaymenttypeBean" type="any" required="true" />

		<cfreturn variables.PaymenttypeDAO.update(PaymenttypeBean) />
	</cffunction>

	<cffunction name="deletePaymenttype" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="PaymentTypeID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var PaymenttypeBean = createPaymenttype(argumentCollection=arguments) />
		<cfreturn variables.PaymenttypeDAO.delete(PaymenttypeBean) />
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>





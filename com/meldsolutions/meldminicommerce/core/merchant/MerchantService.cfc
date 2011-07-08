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

<cfcomponent name="MerchantService" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="MerchantService">
		<cfargument name="MerchantDAO" type="any" required="true" />
		<cfargument name="MerchantGateway" type="any" required="true" />

		<cfset variables.MerchantDAO = arguments.MerchantDAO />
		<cfset variables.MerchantGateway = arguments.MerchantGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createMerchant" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="MerchantID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Custom1label" type="string" required="false" />
		<cfargument name="Custom2label" type="string" required="false" />
		<cfargument name="Custom3label" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Bean" type="string" required="false" />
		<cfargument name="Param1label" type="string" required="false" />
		<cfargument name="Param2label" type="string" required="false" />
		<cfargument name="Param3label" type="string" required="false" />
		<cfargument name="Param4label" type="string" required="false" />
		<cfargument name="Param5label" type="string" required="false" />
		<cfargument name="Param6label" type="string" required="false" />
		<cfargument name="Param7label" type="string" required="false" />
		<cfargument name="Param8label" type="string" required="false" />
		<cfargument name="Param9label" type="string" required="false" />
		<cfargument name="Param1" type="string" required="false" />
		<cfargument name="Param2" type="string" required="false" />
		<cfargument name="Param3" type="string" required="false" />
		<cfargument name="Param4" type="string" required="false" />
		<cfargument name="Param5" type="string" required="false" />
		<cfargument name="Param6" type="string" required="false" />
		<cfargument name="Param7" type="string" required="false" />
		<cfargument name="Param8" type="string" required="false" />
		<cfargument name="Param9" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="IsCurrent" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var MerchantBean = createObject("component","MerchantBean").init(argumentCollection=arguments) />
		<cfreturn MerchantBean />
	</cffunction>

	<cffunction name="getMerchant" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="MerchantID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var MerchantBean = createMerchant(argumentCollection=arguments) />
		<cfset variables.MerchantDAO.read(MerchantBean) />
		<cfreturn MerchantBean />
	</cffunction>

	<cffunction name="getMerchants" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="MerchantID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Custom1label" type="string" required="false" />
		<cfargument name="Custom2label" type="string" required="false" />
		<cfargument name="Custom3label" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Bean" type="string" required="false" />
		<cfargument name="Param1label" type="string" required="false" />
		<cfargument name="Param2label" type="string" required="false" />
		<cfargument name="Param3label" type="string" required="false" />
		<cfargument name="Param4label" type="string" required="false" />
		<cfargument name="Param5label" type="string" required="false" />
		<cfargument name="Param6label" type="string" required="false" />
		<cfargument name="Param7label" type="string" required="false" />
		<cfargument name="Param8label" type="string" required="false" />
		<cfargument name="Param9label" type="string" required="false" />
		<cfargument name="Param1" type="string" required="false" />
		<cfargument name="Param2" type="string" required="false" />
		<cfargument name="Param3" type="string" required="false" />
		<cfargument name="Param4" type="string" required="false" />
		<cfargument name="Param5" type="string" required="false" />
		<cfargument name="Param6" type="string" required="false" />
		<cfargument name="Param7" type="string" required="false" />
		<cfargument name="Param8" type="string" required="false" />
		<cfargument name="Param9" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="IsCurrent" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn variables.MerchantGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="MerchantID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Custom1label" type="string" required="false" />
		<cfargument name="Custom2label" type="string" required="false" />
		<cfargument name="Custom3label" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Bean" type="string" required="false" />
		<cfargument name="Param1label" type="string" required="false" />
		<cfargument name="Param2label" type="string" required="false" />
		<cfargument name="Param3label" type="string" required="false" />
		<cfargument name="Param4label" type="string" required="false" />
		<cfargument name="Param5label" type="string" required="false" />
		<cfargument name="Param6label" type="string" required="false" />
		<cfargument name="Param7label" type="string" required="false" />
		<cfargument name="Param8label" type="string" required="false" />
		<cfargument name="Param9label" type="string" required="false" />
		<cfargument name="Param1" type="string" required="false" />
		<cfargument name="Param2" type="string" required="false" />
		<cfargument name="Param3" type="string" required="false" />
		<cfargument name="Param4" type="string" required="false" />
		<cfargument name="Param5" type="string" required="false" />
		<cfargument name="Param6" type="string" required="false" />
		<cfargument name="Param7" type="string" required="false" />
		<cfargument name="Param8" type="string" required="false" />
		<cfargument name="Param9" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="IsCurrent" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn variables.MerchantGateway.getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn variables.MerchantGateway.getByArray(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var aMerchant			= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = variables.MerchantGateway.search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset aMerchant				= variables.MerchantGateway.search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start>
		<cfset sReturn.size			= arguments.size>
		<cfset sReturn.itemarray	= aMerchant>

		<cfreturn sReturn />
	</cffunction>
	

	<cffunction name="saveMerchant" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfreturn variables.MerchantDAO.save(MerchantBean) />
	</cffunction>
	
	<cffunction name="updateMerchant" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />
	
		<cfset variables.MerchantDAO.update(MerchantBean) />
		
		<cfif MerchantBean.getIsCurrent()>
			<cfset variables.MerchantGateway.setCurrent( MerchantBean ) />
		</cfif>
		
		<cfreturn true />
	</cffunction>

	<cffunction name="deleteMerchant" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="MerchantID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var MerchantBean = createMerchant(argumentCollection=arguments) />
		<cfreturn variables.MerchantDAO.delete(MerchantBean) />
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>






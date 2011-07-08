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

<cfcomponent displayname="MerchantGateway" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="MerchantGateway">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsnprefix" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dsnusername = arguments.dsnusername>
		<cfset variables.dsnpassword = arguments.dsnpassword>
		<cfset variables.dsnprefix = arguments.dsnprefix>
		<cfset variables.dsntype = arguments.dsntype>
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
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
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mmc_merchant
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"MerchantID") and len(arguments.MerchantID)>
				AND MerchantID = <cfqueryparam value="#arguments.MerchantID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
				AND Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" maxlength="100" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Custom1label") and len(arguments.Custom1label)>
				AND Custom1label = <cfqueryparam value="#arguments.Custom1label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Custom2label") and len(arguments.Custom2label)>
				AND Custom2label = <cfqueryparam value="#arguments.Custom2label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Custom3label") and len(arguments.Custom3label)>
				AND Custom3label = <cfqueryparam value="#arguments.Custom3label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Package") and len(arguments.Package)>
				AND Package = <cfqueryparam value="#arguments.Package#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Bean") and len(arguments.Bean)>
				AND Bean = <cfqueryparam value="#arguments.Bean#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param1label") and len(arguments.Param1label)>
				AND Param1label = <cfqueryparam value="#arguments.Param1label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param2label") and len(arguments.Param2label)>
				AND Param2label = <cfqueryparam value="#arguments.Param2label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param3label") and len(arguments.Param3label)>
				AND Param3label = <cfqueryparam value="#arguments.Param3label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param4label") and len(arguments.Param4label)>
				AND Param4label = <cfqueryparam value="#arguments.Param4label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param5label") and len(arguments.Param5label)>
				AND Param5label = <cfqueryparam value="#arguments.Param5label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param6label") and len(arguments.Param6label)>
				AND Param6label = <cfqueryparam value="#arguments.Param6label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param7label") and len(arguments.Param7label)>
				AND Param7label = <cfqueryparam value="#arguments.Param7label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param8label") and len(arguments.Param8label)>
				AND Param8label = <cfqueryparam value="#arguments.Param8label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param9label") and len(arguments.Param9label)>
				AND Param9label = <cfqueryparam value="#arguments.Param9label#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param1") and len(arguments.Param1)>
				AND Param1 = <cfqueryparam value="#arguments.Param1#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param2") and len(arguments.Param2)>
				AND Param2 = <cfqueryparam value="#arguments.Param2#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param3") and len(arguments.Param3)>
				AND Param3 = <cfqueryparam value="#arguments.Param3#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param4") and len(arguments.Param4)>
				AND Param4 = <cfqueryparam value="#arguments.Param4#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param5") and len(arguments.Param5)>
				AND Param5 = <cfqueryparam value="#arguments.Param5#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param6") and len(arguments.Param6)>
				AND Param6 = <cfqueryparam value="#arguments.Param6#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param7") and len(arguments.Param7)>
				AND Param7 = <cfqueryparam value="#arguments.Param7#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param8") and len(arguments.Param8)>
				AND Param8 = <cfqueryparam value="#arguments.Param8#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Param9") and len(arguments.Param9)>
				AND Param9 = <cfqueryparam value="#arguments.Param9#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Params") and len(arguments.Params)>
				AND Params = <cfqueryparam value="#arguments.Params#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsCurrent") and len(arguments.IsCurrent)>
				AND IsCurrent = <cfqueryparam value="#arguments.IsCurrent#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			<!---^^VALUES-END^^--->
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
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
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","MerchantBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
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
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		

		<cfif qList.recordCount>
			<cfreturn createObject("component","MerchantBean").init(argumentCollection=queryRowToStruct(qList))>
		<cfelse>
			<cfreturn createObject("component","MerchantBean").init()>
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />
		
		<cfset var qList			= "" />		
		<cfset var strObjects			= StructNew() />
		<cfset var tmpObj			= "" />
		<cfset var IDList			= "" />

		<cfif not arrayLen(arguments.idArray)>
			<cfreturn strObjects />
		</cfif>

		<cfset IDList = ArrayToList(arguments.idArray) />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*
			FROM
				#variables.dsnprefix#mmc_merchant
			WHERE
			MerchantID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" />)
		</cfquery>
		
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","MerchantBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset strObjects[qList.MerchantID[i]] = tmpObj />
		</cfloop>
		
		<cfreturn strObjects />
	</cffunction>
	
	
	<cffunction name="search" access="public" output="false" returntype="any">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="true" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="30"/>
		<cfargument name="orderby" type="string" required="false" default=""/>
		<cfargument name="isCount" type="boolean" required="false" default="false"/>
		
		<cfset var arrObjects		= ArrayNew(1)>
		<cfset var qList			= "" />
		<cfset var qExclude			= "" />
		<cfset var qKeep			= "" />
		<cfset var returnFields		= arguments.fieldList />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mssql"> 	
					TOP #(arguments.start+arguments.size)#
				</cfif>
				<cfif arguments.isCount>
					COUNT(MerchantID) AS total
				<cfelse>
					#returnFields#
				</cfif>
			FROM	#variables.dsnprefix#mmc_merchant
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"MerchantID") and len(arguments.criteria.MerchantID)>
			AND MerchantID LIKE <cfqueryparam value="%#arguments.criteria.MerchantID#%" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Name") and len(arguments.criteria.Name)>
			AND Name LIKE <cfqueryparam value="%#arguments.criteria.Name#%" CFSQLType="cf_sql_varchar" maxlength="100" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
			AND IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom1label") and len(arguments.criteria.Custom1label)>
			AND Custom1label LIKE <cfqueryparam value="%#arguments.criteria.Custom1label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom2label") and len(arguments.criteria.Custom2label)>
			AND Custom2label LIKE <cfqueryparam value="%#arguments.criteria.Custom2label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom3label") and len(arguments.criteria.Custom3label)>
			AND Custom3label LIKE <cfqueryparam value="%#arguments.criteria.Custom3label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND RemoteID LIKE <cfqueryparam value="%#arguments.criteria.RemoteID#%" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Package") and len(arguments.criteria.Package)>
			AND Package LIKE <cfqueryparam value="%#arguments.criteria.Package#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Bean") and len(arguments.criteria.Bean)>
			AND Bean LIKE <cfqueryparam value="%#arguments.criteria.Bean#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param1label") and len(arguments.criteria.Param1label)>
			AND Param1label LIKE <cfqueryparam value="%#arguments.criteria.Param1label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param2label") and len(arguments.criteria.Param2label)>
			AND Param2label LIKE <cfqueryparam value="%#arguments.criteria.Param2label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param3label") and len(arguments.criteria.Param3label)>
			AND Param3label LIKE <cfqueryparam value="%#arguments.criteria.Param3label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param4label") and len(arguments.criteria.Param4label)>
			AND Param4label LIKE <cfqueryparam value="%#arguments.criteria.Param4label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param5label") and len(arguments.criteria.Param5label)>
			AND Param5label LIKE <cfqueryparam value="%#arguments.criteria.Param5label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param6label") and len(arguments.criteria.Param6label)>
			AND Param6label LIKE <cfqueryparam value="%#arguments.criteria.Param6label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param7label") and len(arguments.criteria.Param7label)>
			AND Param7label LIKE <cfqueryparam value="%#arguments.criteria.Param7label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param8label") and len(arguments.criteria.Param8label)>
			AND Param8label LIKE <cfqueryparam value="%#arguments.criteria.Param8label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param9label") and len(arguments.criteria.Param9label)>
			AND Param9label LIKE <cfqueryparam value="%#arguments.criteria.Param9label#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param1") and len(arguments.criteria.Param1)>
			AND Param1 LIKE <cfqueryparam value="%#arguments.criteria.Param1#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param2") and len(arguments.criteria.Param2)>
			AND Param2 LIKE <cfqueryparam value="%#arguments.criteria.Param2#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param3") and len(arguments.criteria.Param3)>
			AND Param3 LIKE <cfqueryparam value="%#arguments.criteria.Param3#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param4") and len(arguments.criteria.Param4)>
			AND Param4 LIKE <cfqueryparam value="%#arguments.criteria.Param4#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param5") and len(arguments.criteria.Param5)>
			AND Param5 LIKE <cfqueryparam value="%#arguments.criteria.Param5#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param6") and len(arguments.criteria.Param6)>
			AND Param6 LIKE <cfqueryparam value="%#arguments.criteria.Param6#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param7") and len(arguments.criteria.Param7)>
			AND Param7 LIKE <cfqueryparam value="%#arguments.criteria.Param7#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param8") and len(arguments.criteria.Param8)>
			AND Param8 LIKE <cfqueryparam value="%#arguments.criteria.Param8#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Param9") and len(arguments.criteria.Param9)>
			AND Param9 LIKE <cfqueryparam value="%#arguments.criteria.Param9#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Params") and len(arguments.criteria.Params)>
			AND Params LIKE <cfqueryparam value="%#arguments.criteria.Params#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsCurrent") and len(arguments.criteria.IsCurrent)>
			AND IsCurrent = <cfqueryparam value="#arguments.criteria.IsCurrent#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			<!---^^SEARCH-END^^--->															
			<cfif not arguments.isCount AND len( arguments.orderBy )>
				ORDER BY #arguments.orderBy#
			</cfif>
			<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mysql">
				LIMIT #arguments.start#,#arguments.size#
			</cfif>
		</cfquery>

		<!--- if this is a MS SQL db, we have more work to do --->
		<cfif not arguments.isCount AND variables.dsntype eq "mssql" AND arguments.start gt 0>
			<cfquery name="qExclude" dbtype="query" maxrows="#arguments.start#" >  
	        	SELECT
					merchantID  
				FROM
					qList    
			</cfquery>
			
			<cfquery name="qKeep" dbtype="query" maxrows="#arguments.count#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
					merchantID NOT IN (<cfqueryparam value="#valueList(qExclude.merchantID)#" list="true" />)  
			</cfquery> 

			<cfset qList = qKeep> 
		</cfif>

		<!--- we do not create beans here, in the interest of speed --->
		<cfif arguments.isCount>
			<cfreturn qList.total >
		<cfelse>
			<cfloop from="1" to="#qList.recordCount#" index="i">
				<cfset tmpObj = queryRowToStruct(qList,i) />
				<cfset arrayAppend(arrObjects,tmpObj) />
			</cfloop>
		</cfif>
		<cfreturn arrObjects />
	</cffunction>
	

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->

	<cffunction name="setCurrent" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfset var qCheck = "" />
		<cfset var qUpdate = "" />

		<cfif not MerchantBean.getIsCurrent()>
			<cfreturn false />
		</cfif>

		<cfquery name="qCheck" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				merchantID
			FROM
				#variables.dsnprefix#mmc_merchant
			WHERE
				MerchantID = <cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>

		<cfif not qCheck.recordCount>
			<cfreturn false />
		</cfif>
		
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_merchant
			SET
				IsCurrent = 0
		</cfquery>
		
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_merchant
			SET
				IsCurrent = 1
			WHERE
				MerchantID = <cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
		
			<cfreturn true />
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	






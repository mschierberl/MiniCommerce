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

<cfcomponent displayname="MerchantDAO" output="false">
<!---^^GENERATEDSTART^^--->

	<cffunction name="init" access="public" output="false" returntype="MerchantDAO">
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
		<cfreturn this>
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mmc_merchant
				(
				<!---^^SAVECOLUMNS-START^^--->
				MerchantID,
				Name,
				IsActive,
				Custom1label,
				Custom2label,
				Custom3label,
				RemoteID,
				Package,
				Bean,
				Param1label,
				Param2label,
				Param3label,
				Param4label,
				Param5label,
				Param6label,
				Param7label,
				Param8label,
				Param9label,
				Param1,
				Param2,
				Param3,
				Param4,
				Param5,
				Param6,
				Param7,
				Param8,
				Param9,
				Params,
				IsCurrent
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.MerchantBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="100" />,
				<cfqueryparam value="#arguments.MerchantBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.MerchantBean.getCustom1label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getCustom1label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getCustom2label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getCustom2label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getCustom3label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getCustom3label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getRemoteID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.MerchantBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.MerchantBean.getPackage()#" CFSQLType="cf_sql_varchar" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getBean()#" CFSQLType="cf_sql_varchar" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam1label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam1label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam2label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam2label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam3label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam3label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam4label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam4label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam5label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam5label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam6label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam6label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam7label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam7label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam8label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam8label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam9label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam9label()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam1()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam1()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam2()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam2()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam3()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam3()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam4()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam4()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam5()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam5()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam6()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam6()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam7()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam7()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam8()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam8()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParam9()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam9()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.MerchantBean.getParams()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.MerchantBean.getParams()))#" />,
				<cfqueryparam value="#arguments.MerchantBean.getIsCurrent()#" CFSQLType="cf_sql_tinyint" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mmc_merchant
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND MerchantID = <cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.MerchantBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_merchant
			SET
				<!---^^UPDATEVALUES-START^^--->
				Name = <cfqueryparam value="#arguments.MerchantBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="100" />,
				IsActive = <cfqueryparam value="#arguments.MerchantBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				Custom1label = <cfqueryparam value="#arguments.MerchantBean.getCustom1label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getCustom1label()))#" maxlength="50" />,
				Custom2label = <cfqueryparam value="#arguments.MerchantBean.getCustom2label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getCustom2label()))#" maxlength="50" />,
				Custom3label = <cfqueryparam value="#arguments.MerchantBean.getCustom3label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getCustom3label()))#" maxlength="50" />,
				RemoteID = <cfqueryparam value="#arguments.MerchantBean.getRemoteID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.MerchantBean.getRemoteID()))#" maxlength="35" />,
				Package = <cfqueryparam value="#arguments.MerchantBean.getPackage()#" CFSQLType="cf_sql_varchar" maxlength="50" />,
				Bean = <cfqueryparam value="#arguments.MerchantBean.getBean()#" CFSQLType="cf_sql_varchar" maxlength="250" />,
				Param1label = <cfqueryparam value="#arguments.MerchantBean.getParam1label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam1label()))#" maxlength="50" />,
				Param2label = <cfqueryparam value="#arguments.MerchantBean.getParam2label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam2label()))#" maxlength="50" />,
				Param3label = <cfqueryparam value="#arguments.MerchantBean.getParam3label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam3label()))#" maxlength="50" />,
				Param4label = <cfqueryparam value="#arguments.MerchantBean.getParam4label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam4label()))#" maxlength="50" />,
				Param5label = <cfqueryparam value="#arguments.MerchantBean.getParam5label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam5label()))#" maxlength="50" />,
				Param6label = <cfqueryparam value="#arguments.MerchantBean.getParam6label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam6label()))#" maxlength="50" />,
				Param7label = <cfqueryparam value="#arguments.MerchantBean.getParam7label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam7label()))#" maxlength="50" />,
				Param8label = <cfqueryparam value="#arguments.MerchantBean.getParam8label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam8label()))#" maxlength="50" />,
				Param9label = <cfqueryparam value="#arguments.MerchantBean.getParam9label()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam9label()))#" maxlength="50" />,
				Param1 = <cfqueryparam value="#arguments.MerchantBean.getParam1()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam1()))#" maxlength="250" />,
				Param2 = <cfqueryparam value="#arguments.MerchantBean.getParam2()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam2()))#" maxlength="250" />,
				Param3 = <cfqueryparam value="#arguments.MerchantBean.getParam3()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam3()))#" maxlength="250" />,
				Param4 = <cfqueryparam value="#arguments.MerchantBean.getParam4()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam4()))#" maxlength="250" />,
				Param5 = <cfqueryparam value="#arguments.MerchantBean.getParam5()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam5()))#" maxlength="250" />,
				Param6 = <cfqueryparam value="#arguments.MerchantBean.getParam6()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam6()))#" maxlength="250" />,
				Param7 = <cfqueryparam value="#arguments.MerchantBean.getParam7()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam7()))#" maxlength="250" />,
				Param8 = <cfqueryparam value="#arguments.MerchantBean.getParam8()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam8()))#" maxlength="250" />,
				Param9 = <cfqueryparam value="#arguments.MerchantBean.getParam9()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.MerchantBean.getParam9()))#" maxlength="250" />,
				Params = <cfqueryparam value="#arguments.MerchantBean.getParams()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.MerchantBean.getParams()))#" />,
				IsCurrent = <cfqueryparam value="#arguments.MerchantBean.getIsCurrent()#" CFSQLType="cf_sql_tinyint" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND MerchantID = <cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mmc_merchant
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND MerchantID = <cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="MerchantBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mmc_merchant
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND MerchantID = <cfqueryparam value="#arguments.MerchantBean.getMerchantID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
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
<!---^^CUSTOMEND^^--->
</cfcomponent>	







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



<cfcomponent displayname="DisplaytypeDAO" output="false">
<!---^^GENERATEDSTART^^--->

	<cffunction name="init" access="public" output="false" returntype="DisplaytypeDAO">
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
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mmc_displaytype
				(
				<!---^^SAVECOLUMNS-START^^--->
				Displaytypeid,
				ObjectID,
				Package,
				Name,
				Description,
				Settings,
				IsConfigurable,
				IsActive,
				Version,
				Defaults,
				ModuleID
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.DisplaytypeBean.getDisplaytypeid()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getObjectID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplaytypeBean.getObjectID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getPackage()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getDescription()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplaytypeBean.getDescription()))#" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getSettings()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplaytypeBean.getSettings()))#" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getIsConfigurable()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getVersion()#" CFSQLType="cf_sql_varchar" maxlength="12" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getDefaults()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplaytypeBean.getDefaults()))#" />,
				<cfqueryparam value="#arguments.DisplaytypeBean.getModuleID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplaytypeBean.getModuleID()))#" maxlength="35" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mmc_displaytype
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND Displaytypeid = <cfqueryparam value="#arguments.DisplaytypeBean.getDisplaytypeid()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.DisplaytypeBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_displaytype
			SET
				<!---^^UPDATEVALUES-START^^--->
				ObjectID = <cfqueryparam value="#arguments.DisplaytypeBean.getObjectID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplaytypeBean.getObjectID()))#" maxlength="35" />,
				Package = <cfqueryparam value="#arguments.DisplaytypeBean.getPackage()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				Name = <cfqueryparam value="#arguments.DisplaytypeBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				Description = <cfqueryparam value="#arguments.DisplaytypeBean.getDescription()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplaytypeBean.getDescription()))#" />,
				Settings = <cfqueryparam value="#arguments.DisplaytypeBean.getSettings()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplaytypeBean.getSettings()))#" />,
				IsConfigurable = <cfqueryparam value="#arguments.DisplaytypeBean.getIsConfigurable()#" CFSQLType="cf_sql_tinyint" />,
				IsActive = <cfqueryparam value="#arguments.DisplaytypeBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				Version = <cfqueryparam value="#arguments.DisplaytypeBean.getVersion()#" CFSQLType="cf_sql_varchar" maxlength="12" />,
				Defaults = <cfqueryparam value="#arguments.DisplaytypeBean.getDefaults()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplaytypeBean.getDefaults()))#" />,
				ModuleID = <cfqueryparam value="#arguments.DisplaytypeBean.getModuleID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplaytypeBean.getModuleID()))#" maxlength="35" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND Displaytypeid = <cfqueryparam value="#arguments.DisplaytypeBean.getDisplaytypeid()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mmc_displaytype
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND Displaytypeid = <cfqueryparam value="#arguments.DisplaytypeBean.getDisplaytypeid()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mmc_displaytype
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND Displaytypeid = <cfqueryparam value="#arguments.DisplaytypeBean.getDisplaytypeid()#" CFSQLType="cf_sql_char" maxlength="35" />
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





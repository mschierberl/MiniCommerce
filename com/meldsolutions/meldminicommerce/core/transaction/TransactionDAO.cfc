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










<cfcomponent displayname="TransactionDAO" output="false">
<!---^^GENERATEDSTART^^--->

	<cffunction name="init" access="public" output="false" returntype="TransactionDAO">
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
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mmc_transaction
				(
				<!---^^SAVECOLUMNS-START^^--->
				TransactionID,
				Total,
				DateCreate,
				DateLastUpdate,
				CartID,
				CardLastFour,
				CardMonth,
				CardYear,
				IsCompleted,
				IsApproved,
				ApprovalCode,
				ErrorCode,
				Custom1,
				Custom2,
				Custom3,
				RemoteID,
				Params,
				Tax,
				Shipping,
				Discount,
				Subtotal,
				PaymentTypeID,
				MerchantID,
				OrderIdent,
				SiteID
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.TransactionBean.getTransactionID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.TransactionBean.getTotal()#" CFSQLType="cf_sql_decimal" scale="2" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#arguments.TransactionBean.getCartID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.TransactionBean.getCardLastFour()#" CFSQLType="cf_sql_char" maxlength="4" />,
				<cfqueryparam value="#arguments.TransactionBean.getCardMonth()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.TransactionBean.getCardYear()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.TransactionBean.getIsCompleted()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.TransactionBean.getIsApproved()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.TransactionBean.getApprovalCode()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getApprovalCode()))#" maxlength="45" />,
				<cfqueryparam value="#arguments.TransactionBean.getErrorCode()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getErrorCode()))#" maxlength="45" />,
				<cfqueryparam value="#arguments.TransactionBean.getCustom1()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getCustom1()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.TransactionBean.getCustom2()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getCustom2()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.TransactionBean.getCustom3()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getCustom3()))#" maxlength="250" />,
				<cfqueryparam value="#arguments.TransactionBean.getRemoteID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.TransactionBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.TransactionBean.getParams()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.TransactionBean.getParams()))#" />,
				<cfqueryparam value="#arguments.TransactionBean.getTax()#" CFSQLType="cf_sql_decimal" scale="2" />,
				<cfqueryparam value="#arguments.TransactionBean.getShipping()#" CFSQLType="cf_sql_decimal" scale="2" />,
				<cfqueryparam value="#arguments.TransactionBean.getDiscount()#" CFSQLType="cf_sql_decimal" scale="2" />,
				<cfqueryparam value="#arguments.TransactionBean.getSubtotal()#" CFSQLType="cf_sql_decimal" scale="2" />,
				<cfqueryparam value="#arguments.TransactionBean.getPaymentTypeID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.TransactionBean.getMerchantID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.TransactionBean.getMerchantID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.TransactionBean.getOrderIdent()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getOrderIdent()))#" maxlength="20" />,
				<cfqueryparam value="#arguments.TransactionBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mmc_transaction
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND TransactionID = <cfqueryparam value="#arguments.TransactionBean.getTransactionID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.TransactionBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_transaction
			SET
				<!---^^UPDATEVALUES-START^^--->
				Total = <cfqueryparam value="#arguments.TransactionBean.getTotal()#" CFSQLType="cf_sql_decimal" scale="2" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				CartID = <cfqueryparam value="#arguments.TransactionBean.getCartID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				CardLastFour = <cfqueryparam value="#arguments.TransactionBean.getCardLastFour()#" CFSQLType="cf_sql_char" maxlength="4" />,
				CardMonth = <cfqueryparam value="#arguments.TransactionBean.getCardMonth()#" CFSQLType="cf_sql_tinyint" />,
				CardYear = <cfqueryparam value="#arguments.TransactionBean.getCardYear()#" CFSQLType="cf_sql_integer" />,
				IsCompleted = <cfqueryparam value="#arguments.TransactionBean.getIsCompleted()#" CFSQLType="cf_sql_tinyint" />,
				IsApproved = <cfqueryparam value="#arguments.TransactionBean.getIsApproved()#" CFSQLType="cf_sql_tinyint" />,
				ApprovalCode = <cfqueryparam value="#arguments.TransactionBean.getApprovalCode()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getApprovalCode()))#" maxlength="45" />,
				ErrorCode = <cfqueryparam value="#arguments.TransactionBean.getErrorCode()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getErrorCode()))#" maxlength="45" />,
				Custom1 = <cfqueryparam value="#arguments.TransactionBean.getCustom1()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getCustom1()))#" maxlength="250" />,
				Custom2 = <cfqueryparam value="#arguments.TransactionBean.getCustom2()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getCustom2()))#" maxlength="250" />,
				Custom3 = <cfqueryparam value="#arguments.TransactionBean.getCustom3()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getCustom3()))#" maxlength="250" />,
				RemoteID = <cfqueryparam value="#arguments.TransactionBean.getRemoteID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.TransactionBean.getRemoteID()))#" maxlength="35" />,
				Params = <cfqueryparam value="#arguments.TransactionBean.getParams()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.TransactionBean.getParams()))#" />,
				Tax = <cfqueryparam value="#arguments.TransactionBean.getTax()#" CFSQLType="cf_sql_decimal" scale="2" />,
				Shipping = <cfqueryparam value="#arguments.TransactionBean.getShipping()#" CFSQLType="cf_sql_decimal" scale="2" />,
				Discount = <cfqueryparam value="#arguments.TransactionBean.getDiscount()#" CFSQLType="cf_sql_decimal" scale="2" />,
				Subtotal = <cfqueryparam value="#arguments.TransactionBean.getSubtotal()#" CFSQLType="cf_sql_decimal" scale="2" />,
				PaymentTypeID = <cfqueryparam value="#arguments.TransactionBean.getPaymentTypeID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				MerchantID = <cfqueryparam value="#arguments.TransactionBean.getMerchantID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.TransactionBean.getMerchantID()))#" maxlength="35" />,
				OrderIdent = <cfqueryparam value="#arguments.TransactionBean.getOrderIdent()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.TransactionBean.getOrderIdent()))#" maxlength="20" />,
				SiteID = <cfqueryparam value="#arguments.TransactionBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND TransactionID = <cfqueryparam value="#arguments.TransactionBean.getTransactionID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mmc_transaction
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND TransactionID = <cfqueryparam value="#arguments.TransactionBean.getTransactionID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mmc_transaction
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND TransactionID = <cfqueryparam value="#arguments.TransactionBean.getTransactionID()#" CFSQLType="cf_sql_char" maxlength="35" />
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












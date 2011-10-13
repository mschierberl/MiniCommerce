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




<cfcomponent displayname="TransactionGateway" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="TransactionGateway">
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
		<cfargument name="TransactionID" type="uuid" required="false" />
		<cfargument name="Total" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="CardLastFour" type="string" required="false" />
		<cfargument name="CardMonth" type="boolean" required="false" />
		<cfargument name="CardYear" type="numeric" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="ApprovalCode" type="string" required="false" />
		<cfargument name="ErrorCode" type="string" required="false" />
		<cfargument name="Custom1" type="string" required="false" />
		<cfargument name="Custom2" type="string" required="false" />
		<cfargument name="Custom3" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<cfargument name="Subtotal" type="numeric" required="false" />
		<cfargument name="PaymentTypeID" type="string" required="false" />
		<cfargument name="MerchantID" type="string" required="false" />
		<cfargument name="OrderIdent" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mmc_transaction
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"TransactionID") and len(arguments.TransactionID)>
				AND TransactionID = <cfqueryparam value="#arguments.TransactionID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Total") and len(arguments.Total)>
				AND Total = <cfqueryparam value="#arguments.Total#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CartID") and len(arguments.CartID)>
				AND CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CardLastFour") and len(arguments.CardLastFour)>
				AND CardLastFour = <cfqueryparam value="#arguments.CardLastFour#" CFSQLType="cf_sql_char" maxlength="4" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CardMonth") and len(arguments.CardMonth)>
				AND CardMonth = <cfqueryparam value="#arguments.CardMonth#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CardYear") and len(arguments.CardYear)>
				AND CardYear = <cfqueryparam value="#arguments.CardYear#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsCompleted") and len(arguments.IsCompleted)>
				AND IsCompleted = <cfqueryparam value="#arguments.IsCompleted#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsApproved") and len(arguments.IsApproved)>
				AND IsApproved = <cfqueryparam value="#arguments.IsApproved#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ApprovalCode") and len(arguments.ApprovalCode)>
				AND ApprovalCode = <cfqueryparam value="#arguments.ApprovalCode#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ErrorCode") and len(arguments.ErrorCode)>
				AND ErrorCode = <cfqueryparam value="#arguments.ErrorCode#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Custom1") and len(arguments.Custom1)>
				AND Custom1 = <cfqueryparam value="#arguments.Custom1#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Custom2") and len(arguments.Custom2)>
				AND Custom2 = <cfqueryparam value="#arguments.Custom2#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Custom3") and len(arguments.Custom3)>
				AND Custom3 = <cfqueryparam value="#arguments.Custom3#" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Params") and len(arguments.Params)>
				AND Params = <cfqueryparam value="#arguments.Params#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Tax") and len(arguments.Tax)>
				AND Tax = <cfqueryparam value="#arguments.Tax#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Shipping") and len(arguments.Shipping)>
				AND Shipping = <cfqueryparam value="#arguments.Shipping#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Discount") and len(arguments.Discount)>
				AND Discount = <cfqueryparam value="#arguments.Discount#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Subtotal") and len(arguments.Subtotal)>
				AND Subtotal = <cfqueryparam value="#arguments.Subtotal#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PaymentTypeID") and len(arguments.PaymentTypeID)>
				AND PaymentTypeID = <cfqueryparam value="#arguments.PaymentTypeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"MerchantID") and len(arguments.MerchantID)>
				AND MerchantID = <cfqueryparam value="#arguments.MerchantID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"OrderIdent") and len(arguments.OrderIdent)>
				AND OrderIdent = <cfqueryparam value="#arguments.OrderIdent#" CFSQLType="cf_sql_varchar" maxlength="20" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
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
		<cfargument name="TransactionID" type="uuid" required="false" />
		<cfargument name="Total" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="CardLastFour" type="string" required="false" />
		<cfargument name="CardMonth" type="boolean" required="false" />
		<cfargument name="CardYear" type="numeric" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="ApprovalCode" type="string" required="false" />
		<cfargument name="ErrorCode" type="string" required="false" />
		<cfargument name="Custom1" type="string" required="false" />
		<cfargument name="Custom2" type="string" required="false" />
		<cfargument name="Custom3" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<cfargument name="Subtotal" type="numeric" required="false" />
		<cfargument name="PaymentTypeID" type="string" required="false" />
		<cfargument name="MerchantID" type="string" required="false" />
		<cfargument name="OrderIdent" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","TransactionBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="TransactionID" type="uuid" required="false" />
		<cfargument name="Total" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="CardLastFour" type="string" required="false" />
		<cfargument name="CardMonth" type="boolean" required="false" />
		<cfargument name="CardYear" type="numeric" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="ApprovalCode" type="string" required="false" />
		<cfargument name="ErrorCode" type="string" required="false" />
		<cfargument name="Custom1" type="string" required="false" />
		<cfargument name="Custom2" type="string" required="false" />
		<cfargument name="Custom3" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<cfargument name="Subtotal" type="numeric" required="false" />
		<cfargument name="PaymentTypeID" type="string" required="false" />
		<cfargument name="MerchantID" type="string" required="false" />
		<cfargument name="OrderIdent" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		

		<cfif qList.recordCount>
			<cfreturn createObject("component","TransactionBean").init(argumentCollection=queryRowToStruct(qList))>
		<cfelse>
			<cfreturn createObject("component","TransactionBean").init()>
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
				#variables.dsnprefix#mmc_transaction
			WHERE
			TransactionID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" />)
		</cfquery>
		
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","TransactionBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset strObjects[qList.TransactionID[i]] = tmpObj />
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
		<cfset var qUsers			= "" />
		<cfset var qUser			= "" />
		<cfset var qList			= "" />
		<cfset var qLimit			= "" />
		<cfset var qKeep			= "" />
		<cfset var qCount			= "" />
		<cfset var isSameDB			= false />
		<cfset var returnFields		= arguments.fieldList />
		<cfset var GlobalConfig 	= getMuraManager().getServiceFactory().getBean('configBean') />

		<cfif GlobalConfig.getDataSource() eq variables.dsn or false>
			<cfset isSameDB = true />
		</cfif>		

		<cfif not arguments.isCount and len(arguments.orderBy)>
			<cfswitch expression="#rereplaceNoCase(arguments.orderBy," .*","")#">
				<cfcase value="lname,email">
					<cfset arguments.orderby = "tusers.#arguments.orderby#">
				</cfcase>
				<cfdefaultcase>
					<cfset arguments.orderby = "mmc_transaction.#arguments.orderby#">
				</cfdefaultcase>
			</cfswitch>
		</cfif>

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mssql"> 	
					TOP #(arguments.start+arguments.size)#
				</cfif>
				<cfif arguments.isCount>
					COUNT(TransactionID) AS total
				<cfelseif isSameDB>
					#returnFields#,mmc_cart.userID,mmc_paymenttype.name as paymentname,tusers.fname,tusers.lname,tusers.email
				<cfelse>
					#returnFields#,mmc_cart.userID,mmc_paymenttype.name as paymentname,'' as fname,'' as lname,'' as email
				</cfif>
			FROM	#variables.dsnprefix#mmc_transaction mmc_transaction
			JOIN
				#variables.dsnprefix#mmc_cart mmc_cart
				ON
				(mmc_transaction.cartID = mmc_cart.cartID)
			JOIN
				#variables.dsnprefix#mmc_paymenttype mmc_paymenttype
				ON
				(mmc_transaction.paymentTypeID = mmc_paymenttype.paymentTypeID)
			<cfif isSameDB and not arguments.iscount>
				LEFT JOIN
					tusers tusers
				ON
					(mmc_cart.userID = tusers.userID)
			</cfif>
			WHERE
				0=0
			<cfif structKeyExists(arguments.criteria,"siteID") and len(arguments.criteria.siteID)>
				AND
					mmc_transaction.siteID = <cfqueryparam value="#arguments.criteria.siteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"paymenttype") and len(arguments.criteria.paymenttype)>
				AND
					mmc_paymenttype.identity = <cfqueryparam value="#arguments.criteria.paymenttype#" CFSQLType="cf_sql_varchar" maxlength="100" />
			</cfif>

			<cfif isSameDB and not arguments.isCount>
				<cfif structKeyExists(arguments.criteria,"name") and len(arguments.criteria.name)>
					AND
						(
						tusers.fname LIKE <cfqueryparam value="%#arguments.criteria.name#%" CFSQLType="cf_sql_varchar" maxlength="100" />
						OR
						tusers.lname LIKE <cfqueryparam value="%#arguments.criteria.name#%" CFSQLType="cf_sql_varchar" maxlength="100" />
						)
				</cfif>
	
				<cfif structKeyExists(arguments.criteria,"email") and len(arguments.criteria.email)>
					AND
						tusers.email LIKE <cfqueryparam value="%#arguments.criteria.email#%" CFSQLType="cf_sql_char" maxlength="150" />
				</cfif>
			</cfif>

			<cfif structKeyExists(arguments.criteria,"dateFrom") and len(arguments.criteria.dateFrom) and isDate(arguments.criteria.dateFrom)>
				AND
					mmc_transaction.dateLastUpdate >= <cfqueryparam value="#CreateODBCDate(arguments.criteria.dateFrom)#" CFSQLType="cf_sql_timestamp" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"dateTo") and len(arguments.criteria.dateTo) and isDate(arguments.criteria.dateTo)>
				AND
					mmc_transaction.dateLastUpdate <= <cfqueryparam value="#CreateODBCDate(arguments.criteria.dateTo)#" CFSQLType="cf_sql_timestamp" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"totalFrom") and len(arguments.criteria.totalFrom) and isNumeric(arguments.criteria.totalFrom)>
				AND
					mmc_transaction.total >= <cfqueryparam value="#arguments.criteria.totalFrom#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"totalTo") and len(arguments.criteria.totalTo) and isNumeric(arguments.criteria.totalTo)>
				AND
					mmc_transaction.total <= <cfqueryparam value="#arguments.criteria.totalTo#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"orderIdent") and len(arguments.criteria.orderIdent)>
				AND mmc_transaction.orderIdent LIKE <cfqueryparam value="%#arguments.criteria.orderIdent#%" CFSQLType="cf_sql_varchar" maxlength="20" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"TransactionID") and len(arguments.criteria.TransactionID)>
			AND mmc_transaction.TransactionID = <cfqueryparam value="#arguments.criteria.TransactionID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Total") and len(arguments.criteria.Total)>
			AND mmc_transaction.Total = <cfqueryparam value="#arguments.criteria.Total#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND mmc_transaction.DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND mmc_transaction.DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CartID") and len(arguments.criteria.CartID)>
			AND mmc_transaction.CartID = <cfqueryparam value="#arguments.criteria.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CardLastFour") and len(arguments.criteria.CardLastFour)>
			AND mmc_transaction.CardLastFour LIKE <cfqueryparam value="%#arguments.criteria.CardLastFour#%" CFSQLType="cf_sql_char" maxlength="4" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CardMonth") and len(arguments.criteria.CardMonth)>
			AND mmc_transaction.CardMonth = <cfqueryparam value="#arguments.criteria.CardMonth#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CardYear") and len(arguments.criteria.CardYear)>
			AND mmc_transaction.CardYear = <cfqueryparam value="#arguments.criteria.CardYear#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsCompleted") and len(arguments.criteria.IsCompleted)>
			AND mmc_transaction.IsCompleted = <cfqueryparam value="#arguments.criteria.IsCompleted#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsApproved") and len(arguments.criteria.IsApproved)>
			AND mmc_transaction.IsApproved = <cfqueryparam value="#arguments.criteria.IsApproved#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ApprovalCode") and len(arguments.criteria.ApprovalCode)>
			AND mmc_transaction.ApprovalCode LIKE <cfqueryparam value="%#arguments.criteria.ApprovalCode#%" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom1") and len(arguments.criteria.Custom1)>
			AND mmc_transaction.Custom1 LIKE <cfqueryparam value="%#arguments.criteria.Custom1#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom2") and len(arguments.criteria.Custom2)>
			AND mmc_transaction.Custom2 LIKE <cfqueryparam value="%#arguments.criteria.Custom2#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom3") and len(arguments.criteria.Custom3)>
			AND mmc_transaction.Custom3 LIKE <cfqueryparam value="%#arguments.criteria.Custom3#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom4") and len(arguments.criteria.Custom4)>
			AND mmc_transaction.Custom4 LIKE <cfqueryparam value="%#arguments.criteria.Custom4#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom5") and len(arguments.criteria.Custom5)>
			AND mmc_transaction.Custom5 LIKE <cfqueryparam value="%#arguments.criteria.Custom5#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Custom6") and len(arguments.criteria.Custom6)>
			AND mmc_transaction.Custom6 LIKE <cfqueryparam value="%#arguments.criteria.Custom6#%" CFSQLType="cf_sql_varchar" maxlength="250" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND mmc_transaction.RemoteID = <cfqueryparam value="#arguments.criteria.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Tax") and len(arguments.criteria.Tax)>
			AND mmc_transaction.Tax = <cfqueryparam value="#arguments.criteria.Tax#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Shipping") and len(arguments.criteria.Shipping)>
			AND mmc_transaction.Shipping = <cfqueryparam value="#arguments.criteria.Shipping#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Discount") and len(arguments.criteria.Discount)>
			AND mmc_transaction.Discount = <cfqueryparam value="#arguments.criteria.Discount#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Subtotal") and len(arguments.criteria.Subtotal)>
			AND mmc_transaction.Subtotal = <cfqueryparam value="#arguments.criteria.Subtotal#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PaymentTypeID") and len(arguments.criteria.PaymentTypeID)>
			AND mmc_transaction.PaymentTypeID = <cfqueryparam value="#arguments.criteria.PaymentTypeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"MerchantID") and len(arguments.criteria.MerchantID)>
			AND MerchantID = <cfqueryparam value="#arguments.criteria.MerchantID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>

			<cfif not arguments.isCount AND len( arguments.orderBy ) gt 10>
				ORDER BY #arguments.orderBy#
			</cfif>
			<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mysql">
				LIMIT #arguments.start#,#arguments.size#
			</cfif>
		</cfquery>
			
		<cfif not isSameDB and not arguments.iscount>
			<cfquery name="qUsers" datasource="#GlobalConfig.getDataSource()#" username="#GlobalConfig.getDBUserName()#" password="#GlobalConfig.getDBPassword()#">  
				SELECT
					fname,lname,email,userID
				FROM  
					tusers
				WHERE  
					userID IN (<cfqueryparam value="#valueList(qList.userID)#" list="true" />)  
			</cfquery> 
		
			<cfloop query="qList">
				<cfquery name="qUser" dbtype="query" >   
					SELECT
						*
					FROM  
						qUsers
					WHERE  
						userID = '#qList.userID#'  
				</cfquery> 
						
				<cfif qUser.RecordCount>
					<cfset qList.fname[currentRow] = qUser.fname />
					<cfset qList.lname[currentRow] = qUser.lname />
					<cfset qList.email[currentRow] = qUser.email />
				</cfif>
			</cfloop>
		</cfif>
		
		<!--- if this is a MS SQL db, we have more work to do --->
		<cfif not arguments.isCount AND variables.dsntype eq "mssql" AND arguments.start gt 0>
			<cfquery name="qExclude" dbtype="query" maxrows="#arguments.start#" >  
	        	SELECT
					transactionID  
				FROM
					qList    
			</cfquery>
			
			<cfquery name="qKeep" dbtype="query" maxrows="#arguments.count#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
					transactionID NOT IN (<cfqueryparam value="#valueList(qExclude.transactionID)#" list="true" />)  
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
	<cffunction name="createOrderIdent" access="public" output="false" returntype="string">

		<cfset var qList		= "" />
		<cfset var orderIdent	= right(createUUID(),8) />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				transactionID  
			FROM
				#variables.dsnprefix#mmc_transaction
			WHERE
				OrderIdent = <cfqueryparam value="#orderIdent#" CFSQLType="cf_sql_varchar" maxlength="20" />
		</cfquery>

		<cfif qList.RecordCount>
			<cfreturn createOrderIdent() />
		<cfelse>
			<cfreturn orderIdent />
		</cfif>
	</cffunction>

	
	<cffunction name="getUsersInTransactions" returntype="query" access="public" output="false">
		<cfargument name="qTransactions" type="query" required="true" />

		<cfset var GlobalConfig 	= getMuraManager().getServiceFactory().getBean('configBean') />
		<cfset var qList	= "" />

		<cfquery name="qList" datasource="#GlobalConfig.getDataSource()#" username="#GlobalConfig.getDBUserName()#" password="#GlobalConfig.getDBPassword()#">
			SELECT
				userID,fname,lname,email
			FROM	tusers
			WHERE userID IN (<cfqueryparam value="#valueList(arguments.qTransactions.userID)#" list="true" maxlength="35" />)
		</cfquery>

		<cfreturn qList>
	</cffunction>

<!---^^CUSTOMEND^^--->
	<cffunction name="setMuraManager" access="public" returntype="any" output="false">
		<cfargument name="MuraManager" type="any" required="true">
		<cfset variables.MuraManager = arguments.MuraManager>
	</cffunction>
	<cffunction name="getMuraManager" access="public" returntype="any" output="false">
		<cfreturn variables.MuraManager>
	</cffunction>
</cfcomponent>	











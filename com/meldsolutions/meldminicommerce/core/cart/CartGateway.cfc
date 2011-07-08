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

<cfcomponent displayname="CartGateway" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="CartGateway">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsnprefix" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">
		<cfargument name="expireHours" type="any" required="true">
		<cfargument name="expireDays" type="any" required="true">

		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dsnusername = arguments.dsnusername>
		<cfset variables.dsnpassword = arguments.dsnpassword>
		<cfset variables.dsnprefix = arguments.dsnprefix>
		<cfset variables.dsntype = arguments.dsntype>

		<cfset variables.expireHours = arguments.expireHours>
		<cfset variables.expireDays = arguments.expireDays>
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsProcessed" type="boolean" required="false" />
		<cfargument name="IsSaved" type="boolean" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsPending" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="DatePending" type="string" required="false" />
		<cfargument name="TempUserID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mmc_cart
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"CartID") and len(arguments.CartID)>
				AND CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsProcessed") and len(arguments.IsProcessed)>
				AND IsProcessed = <cfqueryparam value="#arguments.IsProcessed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsSaved") and len(arguments.IsSaved)>
				AND IsSaved = <cfqueryparam value="#arguments.IsSaved#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsCompleted") and len(arguments.IsCompleted)>
				AND IsCompleted = <cfqueryparam value="#arguments.IsCompleted#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsPending") and len(arguments.IsPending)>
				AND IsPending = <cfqueryparam value="#arguments.IsPending#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DatePending") and len(arguments.DatePending)>
				AND DatePending = <cfqueryparam value="#arguments.DatePending#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"TempUserID") and len(arguments.TempUserID)>
				AND TempUserID = <cfqueryparam value="#arguments.TempUserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"UserID") and len(arguments.UserID)>
				AND UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Attributes") and len(arguments.Attributes)>
				AND Attributes = <cfqueryparam value="#arguments.Attributes#" CFSQLType="cf_sql_longvarchar" />
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
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsProcessed" type="boolean" required="false" />
		<cfargument name="IsSaved" type="boolean" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsPending" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="DatePending" type="string" required="false" />
		<cfargument name="TempUserID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","CartBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="IsProcessed" type="boolean" required="false" />
		<cfargument name="IsSaved" type="boolean" required="false" />
		<cfargument name="IsCompleted" type="boolean" required="false" />
		<cfargument name="IsPending" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="DatePending" type="string" required="false" />
		<cfargument name="TempUserID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		

		<cfif qList.recordCount>
			<cfreturn createObject("component","CartBean").init(argumentCollection=queryRowToStruct(qList))>
		<cfelse>
			<cfreturn createObject("component","CartBean").init()>
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
				#variables.dsnprefix#mmc_cart
			WHERE
			CartID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" />)
		</cfquery>
		
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","CartBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset strObjects[qList.CartID[i]] = tmpObj />
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
		<cfset var qLimit			= "" />
		<cfset var qFinal			= "" />
		<cfset var returnFields		= arguments.fieldList />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif arguments.isCount>
					COUNT(CartID) AS total
				<cfelse>
					#returnFields#
				</cfif>
			FROM	#variables.dsnprefix#mmc_cart
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"CartID") and len(arguments.criteria.CartID)>
			AND CartID = <cfqueryparam value="#arguments.criteria.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsProcessed") and len(arguments.criteria.IsProcessed)>
			AND IsProcessed = <cfqueryparam value="#arguments.criteria.IsProcessed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsSaved") and len(arguments.criteria.IsSaved)>
			AND IsSaved = <cfqueryparam value="#arguments.criteria.IsSaved#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsCompleted") and len(arguments.criteria.IsCompleted)>
			AND IsCompleted = <cfqueryparam value="#arguments.criteria.IsCompleted#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsPending") and len(arguments.criteria.IsPending)>
			AND IsPending = <cfqueryparam value="#arguments.criteria.IsPending#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
			AND IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DatePending") and len(arguments.criteria.DatePending)>
			AND DatePending LIKE <cfqueryparam value="%#arguments.criteria.DatePending#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"TempUserID") and len(arguments.criteria.TempUserID)>
			AND TempUserID = <cfqueryparam value="#arguments.criteria.TempUserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"UserID") and len(arguments.criteria.UserID)>
			AND UserID = <cfqueryparam value="#arguments.criteria.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND RemoteID = <cfqueryparam value="#arguments.criteria.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Attributes") and len(arguments.criteria.Attributes)>
			AND Attributes LIKE <cfqueryparam value="%#arguments.criteria.Attributes#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND SiteID LIKE <cfqueryparam value="%#arguments.criteria.SiteID#%" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			<!---^^SEARCH-END^^--->																																																
			<cfif not arguments.isCount AND len( arguments.orderBy )>
				ORDER BY #arguments.orderBy#
			</cfif>
			<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mysql">
				LIMIT #arguments.start#,#arguments.size#
			</cfif>
		</cfquery>

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
	
	<cffunction name="getActiveCart" access="public" output="false" returntype="any">
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="doProducts" type="boolean" required="false" default="false" />
		<cfargument name="expireHours" type="numeric"  required="false" default="3" />
		<cfargument name="expireDays" type="numeric"  required="false" default="14" />

		<cfset var qList 			= "" />		
		<cfset var cartBean			= createObject("component","CartBean").init( siteID=arguments.siteID ) />
		<cfset var cartProductBean	= "" />
		<cfset var sCartProducts	= StructNew() />
		<cfset var iiX				= "" />

		<cfif not StructKeyExists( arguments,'cartID' )
			and not StructKeyExists( arguments,'UserID' )
			and not StructKeyExists( arguments,'RemoteID' )>
			<cfreturn cartBean />
		</cfif>

		<cfset expireCarts( argumentCollection=arguments) />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
			<cfif variables.dsntype eq "mssql"> 	
				TOP 1
			</cfif>
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mmc_cart
			WHERE
				IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
				<cfif structKeyExists(arguments,"CartID") and len(arguments.CartID)>
					AND CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
				</cfif>
	
				<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
					AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
				</cfif>
				ORDER BY dateCreate DESC
			<cfif variables.dsntype eq "mysql">
				LIMIT 1
			</cfif>		
		</cfquery>

		<cfif not qList.RecordCount and structKeyExists(arguments,"UserID") and len(arguments.UserID)>
			<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
				SELECT
				<cfif variables.dsntype eq "mssql"> 	
					TOP 1
				</cfif>
					*,1 AS BeanExists
				FROM	#variables.dsnprefix#mmc_cart
				WHERE
					IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
		
					<cfif structKeyExists(arguments,"UserID") and len(arguments.UserID)>
						AND UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
					</cfif>
		
					<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
						AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
					</cfif>
					ORDER BY dateCreate DESC
				<cfif variables.dsntype eq "mysql">
					LIMIT 1
				</cfif>		
			</cfquery>
		</cfif>
		
		<cfif qList.recordCount>
			<cfif structKeyExists(arguments,"UserID") and len(arguments.UserID)>
				<cfset deleteAbandonedUserCarts( arguments.UserID,qList.CartID )>
			</cfif>
			
			<cfquery name="qTouch" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
				UPDATE
					#variables.dsnprefix#mmc_cart
				SET
					DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime( now() )#" CFSQLType="cf_sql_timestamp" />
				<cfif structKeyExists(arguments,"userID") and len( arguments.userID )>
					,UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
				</cfif>
				WHERE
					CartID = <cfqueryparam value="#qList.CartID#" CFSQLType="cf_sql_char" maxlength="35" /> 
			</cfquery>

			<cfset cartBean.init( argumentCollection=queryRowToStruct(qList) ) />
			
			<cfif arguments.doProducts>
				<cfset getCartProducts( cartBean ) />
			</cfif>
		<cfelse>
			<cfreturn cartBean />
		</cfif>

		<cfreturn cartBean />
	</cffunction>

	<cffunction name="getCartProducts" access="public" output="false" returntype="any">
		<cfargument name="CartBean" type="any" required="true" />

		<cfset var sCartProducts	= StructNew() />
		<cfset var iiX				= "" />
		<cfset var strProductIDs	= StructNew() />
		<cfset var strModuleIDs		= StructNew() />

		<cfset var subTotal			= 0 />
		<cfset var total			= 0 />

		<cfset sCartProducts = getCartProductGateway().getProductsInCart( cartID=cartBean.getCartID() ) />
		<cfset cartBean.setProducts( sCartProducts ) />

		<cfloop collection="#sCartProducts#" item="iiX">
			<cfset cartProductBean = sCartProducts[iiX] />
			<cfset subTotal = subTotal + cartProductBean.getTotal() />

			<cfif len( cartProductBean.getModuleID() )>
				<cfif StructKeyExists( strModuleIDs,cartProductBean.getModuleID() )>
					<cfset strModuleIDs[cartProductBean.getModuleID()] = ListAppend(strModuleIDs[cartProductBean.getModuleID()],cartProductBean.getCartProductID())> 
				<cfelse>
					<cfset strModuleIDs[cartProductBean.getModuleID()] = cartProductBean.getCartProductID() > 
				</cfif>
			</cfif>
			<cfif StructKeyExists( strProductIDs,cartProductBean.getProductID() )>
				<cfset strProductIDs[cartProductBean.getProductID()] = ListAppend(strProductIDs[cartProductBean.getProductID()],cartProductBean.getCartProductID())> 
			<cfelse>
				<cfset strProductIDs[cartProductBean.getProductID()] = cartProductBean.getCartProductID() > 
			</cfif>
		</cfloop>
	</cffunction>	

	<cffunction name="deleteAbandonedUserCarts" access="public" output="false" returntype="any">
		<cfargument name="UserID" type="uuid" required="true" />
		<cfargument name="CartID" type="uuid" required="false" />

		<cfset var qDelete = "" />

		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
				#variables.dsnprefix#mmc_cartproduct
			WHERE
				cartID IN
				(
				SELECT
					cartID
				FROM	#variables.dsnprefix#mmc_cart
				WHERE
					isActive = 1
				AND
					isCompleted = 0
				AND
					isPending = 0
				AND
					isProcessed = 0
				AND
					userID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" /> 
				<cfif structKeyExists(arguments,"CartID") and len(arguments.CartID)>
					AND CartID != <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
				</cfif>
				)
		</cfquery>

		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE
			FROM	#variables.dsnprefix#mmc_cart
				WHERE
					isActive = 1
				AND
					isCompleted = 0
				AND
					isPending = 0
				AND
					isProcessed = 0
				AND
					userID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" /> 
				<cfif structKeyExists(arguments,"CartID") and len(arguments.CartID)>
					AND CartID != <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
				</cfif>
		</cfquery>
	</cffunction>


	<cffunction name="expireCarts" access="public" output="false" returntype="any">
		<cfset var qDelete = "" />

		<cfif variables.ExpireHours lt 1>
			<cfset variables.ExpireHours eq 1>
		</cfif>
		<cfif variables.ExpireDays lt 1>
			<cfset variables.ExpireDays eq 1>
		</cfif>
		
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
				#variables.dsnprefix#mmc_cartproduct
			WHERE
				cartID IN
				(
				SELECT
					cartID
				FROM	#variables.dsnprefix#mmc_cart
				WHERE
					isActive = 1
				AND
					isCompleted = 0
				AND
					isPending = 0
				AND
					isProcessed = 0
				AND
					(
						(
							isSaved = 0
						AND
							DateLastUpdate < <cfqueryparam value="#CreateODBCDateTime( dateAdd("h",variables.ExpireHours*-1,now()) )#" CFSQLType="cf_sql_timestamp" />
						)
					)
					OR
					(
						(
							isSaved = 1
						AND
							DateLastUpdate < <cfqueryparam value="#CreateODBCDateTime( dateAdd("d",variables.ExpireDays*-1,now()) )#" CFSQLType="cf_sql_timestamp" />
						)
					)
				)
		</cfquery>

		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE
			FROM	#variables.dsnprefix#mmc_cart
			WHERE
				isActive = 1
			AND
				isCompleted = 0
			AND
				isPending = 0
			AND
				isProcessed = 0
			AND
				isSaved = 0
			AND
				(
					(
						isSaved = 0
					AND
						DateLastUpdate < <cfqueryparam value="#CreateODBCDateTime( dateAdd("h",variables.ExpireHours*-1,now()) )#" CFSQLType="cf_sql_timestamp" />
					)
				)
				OR
				(
					(
						isSaved = 1
					AND
						DateLastUpdate < <cfqueryparam value="#CreateODBCDateTime( dateAdd("d",variables.ExpireDays*-1,now()) )#" CFSQLType="cf_sql_timestamp" />
					)
				)
		</cfquery>
	</cffunction>

<!--- PRODUCTS --->
	<cffunction name="addProduct" access="public" output="false" returntype="any">
		<cfargument name="CartID" type="uuid" required="false" />
		<cfargument name="ProductBean" type="any" required="false" />
		<cfargument name="UserBean" type="any" required="false" />
		<cfargument name="event" type="any" required="false" />


		<cfreturn variables.CartGateway.addProduct( argumentCollection=arguments ) />
	</cffunction>

<!---^^CUSTOMEND^^--->
	<cffunction name="setCartProductGateway" access="public" returntype="any" output="false">
		<cfargument name="CartProductGateway" type="any" required="true">
		<cfset variables.CartProductGateway = arguments.CartProductGateway>
	</cffunction>
	<cffunction name="getCartProductGateway" access="public" returntype="any" output="false">
		<cfreturn variables.CartProductGateway>
	</cffunction>

	<cffunction name="setMeldMiniCommerceProductManager" access="public" returntype="any" output="false">
		<cfargument name="MeldMiniCommerceProductManager" type="any" required="true">
		<cfset variables.MeldMiniCommerceProductManager = arguments.MeldMiniCommerceProductManager>
	</cffunction>
	<cffunction name="getMeldMiniCommerceProductManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldMiniCommerceProductManager>
	</cffunction>
</cfcomponent>	














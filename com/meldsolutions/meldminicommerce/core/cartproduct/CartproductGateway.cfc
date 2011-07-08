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




<cfcomponent displayname="CartproductGateway" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="CartproductGateway">
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
		<cfargument name="CartProductID" type="uuid" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="ProductID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="Price" type="numeric" required="false" />
		<cfargument name="Quantity" type="numeric" required="false" />
		<cfargument name="UseQuantity" type="boolean" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="AttributesID" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mmc_cartproduct
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"CartProductID") and len(arguments.CartProductID)>
				AND CartProductID = <cfqueryparam value="#arguments.CartProductID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CartID") and len(arguments.CartID)>
				AND CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ProductID") and len(arguments.ProductID)>
				AND ProductID = <cfqueryparam value="#arguments.ProductID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ModuleID") and len(arguments.ModuleID)>
				AND ModuleID = <cfqueryparam value="#arguments.ModuleID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Price") and len(arguments.Price)>
				AND Price = <cfqueryparam value="#arguments.Price#" CFSQLType="cf_sql_decimal" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Quantity") and len(arguments.Quantity)>
				AND Quantity = <cfqueryparam value="#arguments.Quantity#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"UseQuantity") and len(arguments.UseQuantity)>
				AND UseQuantity = <cfqueryparam value="#arguments.UseQuantity#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Attributes") and len(arguments.Attributes)>
				AND Attributes = <cfqueryparam value="#arguments.Attributes#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AttributesID") and len(arguments.AttributesID)>
				AND AttributesID = <cfqueryparam value="#arguments.AttributesID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Tax") and len(arguments.Tax)>
				AND Tax = <cfqueryparam value="#arguments.Tax#" CFSQLType="cf_sql_decimal" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Shipping") and len(arguments.Shipping)>
				AND Shipping = <cfqueryparam value="#arguments.Shipping#" CFSQLType="cf_sql_decimal" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Discount") and len(arguments.Discount)>
				AND Discount = <cfqueryparam value="#arguments.Discount#" CFSQLType="cf_sql_decimal" />
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
		<cfargument name="CartProductID" type="uuid" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="ProductID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="Price" type="numeric" required="false" />
		<cfargument name="Quantity" type="numeric" required="false" />
		<cfargument name="UseQuantity" type="boolean" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="AttributesID" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList		= getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects	= arrayNew(1) />
		<cfset var tmpObj		= "" />
		<cfset var i			= "" />

		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","CartproductBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="CartProductID" type="uuid" required="false" />
		<cfargument name="CartID" type="string" required="false" />
		<cfargument name="ProductID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="Price" type="numeric" required="false" />
		<cfargument name="Quantity" type="numeric" required="false" />
		<cfargument name="UseQuantity" type="boolean" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="Attributes" type="string" required="false" />
		<cfargument name="AttributesID" type="string" required="false" />
		<cfargument name="Tax" type="numeric" required="false" />
		<cfargument name="Shipping" type="numeric" required="false" />
		<cfargument name="Discount" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		

		<cfif qList.recordCount>
			<cfreturn createObject("component","CartproductBean").init(argumentCollection=queryRowToStruct(qList))>
		<cfelse>
			<cfreturn createObject("component","CartproductBean").init()>
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
				#variables.dsnprefix#mmc_cartproduct
			WHERE
			CartProductID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" />)
		</cfquery>
		
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","CartproductBean").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset strObjects[qList.CartProductID[i]] = tmpObj />
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
					COUNT(CartProductID) AS total
				<cfelse>
					#returnFields#
				</cfif>
			FROM	#variables.dsnprefix#mmc_cartproduct
			WHERE
				0=0
			<cfif structKeyExists(arguments.criteria,"CartProductID") and len(arguments.criteria.CartProductID)>
			AND CartProductID = <cfqueryparam value="#arguments.criteria.CartProductID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CartID") and len(arguments.criteria.CartID)>
			AND CartID = <cfqueryparam value="#arguments.criteria.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ProductID") and len(arguments.criteria.ProductID)>
			AND ProductID = <cfqueryparam value="#arguments.criteria.ProductID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ModuleID") and len(arguments.criteria.ModuleID)>
			AND ModuleID = <cfqueryparam value="#arguments.criteria.ModuleID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Price") and len(arguments.criteria.Price)>
			AND Price = <cfqueryparam value="#arguments.criteria.Price#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Quantity") and len(arguments.criteria.Quantity)>
			AND Quantity = <cfqueryparam value="#arguments.criteria.Quantity#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND RemoteID = <cfqueryparam value="#arguments.criteria.RemoteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Attributes") and len(arguments.criteria.Attributes)>
			AND Attributes LIKE <cfqueryparam value="%#arguments.criteria.Attributes#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AttributesID") and len(arguments.criteria.AttributesID)>
			AND AttributesID = <cfqueryparam value="#arguments.criteria.AttributesID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Tax") and len(arguments.criteria.Tax)>
			AND Tax = <cfqueryparam value="#arguments.criteria.Tax#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Shipping") and len(arguments.criteria.Shipping)>
			AND Shipping = <cfqueryparam value="#arguments.criteria.Shipping#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Discount") and len(arguments.criteria.Discount)>
			AND Discount = <cfqueryparam value="#arguments.criteria.Discount#" CFSQLType="cf_sql_decimal" scale="2" />
			</cfif>
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

	<cffunction name="productExistsInCart" access="public" output="false" returntype="boolean">
		<cfargument name="CartProductBean" type="any" required="true" />

		<cfset qCheck = "" />

		<cfquery name="qCheck" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				CartProductID
			FROM
				#variables.dsnprefix#mmc_cartproduct
			WHERE
				CartID = <cfqueryparam value="#arguments.CartProductBean.getCartID()#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				ProductID = <cfqueryparam value="#arguments.CartProductBean.getProductID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfif len(arguments.CartProductBean.getAttributesID())>
			AND
				AttributesID = <cfqueryparam value="#arguments.CartProductBean.getAttributesID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfelse>
			AND
				AttributesID IS NULL
			</cfif>
		</cfquery>

		<cfreturn qCheck.recordCount gt 0>
	</cffunction>

	<cffunction name="setQuantity" access="public" output="false" returntype="void">
		<cfargument name="CartProductID" type="uuid" required="true" />
		<cfargument name="Quantity" type="numeric" required="true" />

		<cfset qUpdate = "" />

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_cartproduct
			SET
				quantity = <cfqueryparam value="#arguments.quantity#" CFSQLType="cf_sql_integer" />
			WHERE
				CartProductID = <cfqueryparam value="#arguments.CartProductID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
	</cffunction>

	<cffunction name="updateQuantity" access="public" output="false" returntype="boolean">
		<cfargument name="CartProductBean" type="any" required="true" />

		<cfset qUpdate = "" />
		<cfset qCheck = "" />

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mmc_cartproduct
			SET
				quantity = quantity + <cfqueryparam value="#arguments.CartProductBean.getQuantity()#" CFSQLType="cf_sql_integer" />,
				price = <cfqueryparam value="#arguments.CartProductBean.getPrice()#" CFSQLType="cf_sql_float" />
			WHERE
				CartID = <cfqueryparam value="#arguments.CartProductBean.getCartID()#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				ProductID = <cfqueryparam value="#arguments.CartProductBean.getProductID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfif len(arguments.CartProductBean.getAttributesID())>
			AND
				AttributesID = <cfqueryparam value="#arguments.CartProductBean.getAttributesID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfelse>
			AND
				AttributesID IS NULL
			</cfif>
		</cfquery>

		<cfquery name="qCheck" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				quantity
			FROM
				#variables.dsnprefix#mmc_cartproduct
			WHERE
				CartID = <cfqueryparam value="#arguments.CartProductBean.getCartID()#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				ProductID = <cfqueryparam value="#arguments.CartProductBean.getProductID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfif len(arguments.CartProductBean.getAttributesID())>
			AND
				AttributesID = <cfqueryparam value="#arguments.CartProductBean.getAttributesID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfelse>
			AND
				AttributesID IS NULL
			</cfif>
		</cfquery>

		<cfif qCheck.recordCount>
			<cfif qCheck.quantity lte 0>
				<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
					DELETE FROM
						#variables.dsnprefix#mmc_cartproduct
					WHERE
						CartID = <cfqueryparam value="#arguments.CartProductBean.getCartID()#" CFSQLType="cf_sql_char" maxlength="35" />
					AND
						ProductID = <cfqueryparam value="#arguments.CartProductBean.getProductID()#" CFSQLType="cf_sql_char" maxlength="35" />
					<cfif len(arguments.CartProductBean.getAttributesID())>
					AND
						AttributesID = <cfqueryparam value="#arguments.CartProductBean.getAttributesID()#" CFSQLType="cf_sql_char" maxlength="35" />
					<cfelse>
					AND
						AttributesID IS NULL
					</cfif>
				</cfquery>
				<cfset CartProductBean.setQuantity( 0 )>
			<cfelse>
				<cfset CartProductBean.setQuantity( qCheck.quantity )>
			</cfif>
		</cfif>
		
		<cfreturn true>
	</cffunction>

	<cffunction name="getCartProductIDs" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfset var qList = "" />		
		<cfset var strObjects	= structNew() />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				cartProductID,productID,cartID
			FROM	#variables.dsnprefix#mmc_cartproduct
			WHERE
				CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfif structKeyExists(arguments,"ModuleID") and len(arguments.ModuleID)>
				AND ModuleID = <cfqueryparam value="#arguments.ModuleID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
		</cfquery>			

		<cfloop query="qList">
			<cfif StructKeyExists( strObjects,productID )>
				<cfset strObjects[productID] = ListAppend(strObjects[productID],cartProductID)> 
			<cfelse>
				<cfset strObjects[productID] = cartProductID > 
			</cfif>
		</cfloop>

		<cfreturn strObjects />
	</cffunction>

	<cffunction name="getCartModuleIDs" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfset var qList = "" />		
		<cfset var strObjects	= structNew() />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				cartProductID,moduleID,cartID
			FROM	#variables.dsnprefix#mmc_cartproduct
			WHERE	
				 CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfif structKeyExists(arguments,"ModuleID") and len(arguments.ModuleID)>
				AND ModuleID = <cfqueryparam value="#arguments.ModuleID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
		</cfquery>			

		<cfloop query="qList">
			<cfif len(moduleID)>
				<cfif StructKeyExists( strObjects,moduleID )>
					<cfset strObjects[moduleID] = ListAppend(strObjects[moduleID],cartProductID)> 
				<cfelse>
					<cfset strObjects[moduleID] = cartProductID > 
				</cfif>
			</cfif>
		</cfloop>

		<cfreturn strObjects />
	</cffunction>

	<cffunction name="deleteCartproductsInCart" access="public" output="false" returntype="boolean">
		<cfargument name="CartID" type="uuid" required="true" />

		<cfset var qList = "" />		

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE 
			FROM	#variables.dsnprefix#mmc_cartproduct
			WHERE	
				 CartID = <cfqueryparam value="#arguments.CartID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>			

		<cfreturn true />
	</cffunction>


	<cffunction name="getProductsInCart" access="public" output="false" returntype="struct">
		<cfargument name="CartID" type="string" required="true" />
		<cfargument name="ModuleID" type="string" required="false" />

		<cfset var qList		= getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var strObjects	= structNew() />
		<cfset var tmpObj		= "" />
		<cfset var i			= "" />

		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","CartproductBean").init(argumentCollection=queryRowToStruct(qList,i)) />
<!---			
			<cfset tmpObj.setSubTotal( tmpObj.getQuantity() * tmpObj.getPrice() ) />
			<cfset tmpObj.setTotal( tmpObj.getSubTotal()  + tmpObj.getTax() + tmpObj.getShipping() ) />
--->			
			<cfset strObjects[tmpObj.getCartProductID()] = tmpObj />
		</cfloop>
				
		<cfreturn strObjects />
	</cffunction>


<!---^^CUSTOMEND^^--->
</cfcomponent>	










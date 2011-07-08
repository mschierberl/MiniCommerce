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



<cfcomponent name="TransactionService" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="TransactionService">
		<cfargument name="TransactionDAO" type="any" required="true" />
		<cfargument name="TransactionGateway" type="any" required="true" />

		<cfset variables.TransactionDAO = arguments.TransactionDAO />
		<cfset variables.TransactionGateway = arguments.TransactionGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createTransaction" access="public" output="false" returntype="any">
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
				
		<cfset var TransactionBean = createObject("component","TransactionBean").init(argumentCollection=arguments) />
		<cfreturn TransactionBean />
	</cffunction>

	<cffunction name="getTransaction" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="TransactionID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var TransactionBean = createTransaction(argumentCollection=arguments) />
		<cfset var CartBean = "" />
		<cfset variables.TransactionDAO.read(TransactionBean) />

		<cfif len( TransactionBean.getCartID() )>
			<cfset cartBean = getCartService().getCart( TransactionBean.getCartID(),true ) />
			
			<cfif cartBean.beanExists()>
				<cfset TransactionBean.setCart( cartBean ) />
			</cfif>
		</cfif>

		<cfreturn TransactionBean />
	</cffunction>

	<cffunction name="getTransactions" access="public" output="false" returntype="array">
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
		
		<cfreturn variables.TransactionGateway.getByAttributes(argumentCollection=arguments) />
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

		<cfreturn variables.TransactionGateway.getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn variables.TransactionGateway.getByArray(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var aTransaction		= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = variables.TransactionGateway.search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset aTransaction			= variables.TransactionGateway.search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start>
		<cfset sReturn.size			= arguments.size>
		<cfset sReturn.itemarray	= aTransaction>

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveTransaction" access="public" output="false" returntype="boolean">
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfset var orderIdent = "" />

		<cfif transactionBean.getisCompleted() and not len( transactionBean.getOrderIdent() )>
			<cfset orderIdent = createOrderIdent() />
			<cfset transactionBean.setOrderIdent( orderIdent ) />
		</cfif>
		
		<cfreturn variables.TransactionDAO.save(TransactionBean) />
	</cffunction>
	
	<cffunction name="updateTransaction" access="public" output="false" returntype="boolean">
		<cfargument name="TransactionBean" type="any" required="true" />

		<cfreturn variables.TransactionDAO.update(TransactionBean) />
	</cffunction>

	<cffunction name="deleteTransaction" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="TransactionID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var TransactionBean = createTransaction(argumentCollection=arguments) />
		<cfreturn variables.TransactionDAO.delete(TransactionBean) />
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->

	<cffunction name="createOrderIdent" access="public" output="false" returntype="string">
		<cfreturn variables.TransactionGateway.createOrderIdent() />
	</cffunction>

	<cffunction name="setCartService" access="public" returntype="any" output="false">
		<cfargument name="CartService" type="any" required="true">
		<cfset variables.CartService = arguments.CartService>
	</cffunction>
	<cffunction name="getCartService" access="public" returntype="any" output="false">
		<cfreturn variables.CartService>
	</cffunction>
<!---^^CUSTOMEND^^--->
</cfcomponent>











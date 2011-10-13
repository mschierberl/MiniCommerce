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

<cfcomponent displayname="TransactionBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="TransactionID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Total" type="numeric" default="0.00" required="true" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="CartID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="CardLastFour" type="string" default="xxxx" required="true" maxlength="4" />
	<cfproperty name="CardMonth" type="boolean" default="0" required="true" />
	<cfproperty name="CardYear" type="numeric" default="0" required="true" />
	<cfproperty name="IsCompleted" type="boolean" default="0" required="true" />
	<cfproperty name="IsApproved" type="boolean" default="0" required="true" />
	<cfproperty name="ApprovalCode" type="string" default="" maxlength="45" />
	<cfproperty name="ErrorCode" type="string" default="" maxlength="45" />
	<cfproperty name="Custom1" type="string" default="" maxlength="250" />
	<cfproperty name="Custom2" type="string" default="" maxlength="250" />
	<cfproperty name="Custom3" type="string" default="" maxlength="250" />
	<cfproperty name="RemoteID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Params" type="string" default="" />
	<cfproperty name="Tax" type="numeric" default="0.00" required="true" />
	<cfproperty name="Shipping" type="numeric" default="0.00" required="true" />
	<cfproperty name="Discount" type="numeric" default="0.00" required="true" />
	<cfproperty name="Subtotal" type="numeric" default="0.00" required="true" />
	<cfproperty name="PaymentTypeID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="MerchantID" type="uuid" default="" maxlength="35" />
	<cfproperty name="OrderIdent" type="string" default="" maxlength="20" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="Cart" type="any" default="" required="false" />
	<cfproperty name="ResponseMessage" type="string" default="" maxlength="250" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="TransactionBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="TransactionID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Total" type="numeric" required="false" default="0.00" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="CartID" type="string" required="false" default="" />
		<cfargument name="CardLastFour" type="string" required="false" default="xxxx" />
		<cfargument name="CardMonth" type="boolean" required="false" default="0" />
		<cfargument name="CardYear" type="numeric" required="false" default="0" />
		<cfargument name="IsCompleted" type="boolean" required="false" default="0" />
		<cfargument name="IsApproved" type="boolean" required="false" default="0" />
		<cfargument name="ApprovalCode" type="string" required="false" default="" />
		<cfargument name="ErrorCode" type="string" required="false" default="" />
		<cfargument name="Custom1" type="string" required="false" default="" />
		<cfargument name="Custom2" type="string" required="false" default="" />
		<cfargument name="Custom3" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="Params" type="string" required="false" default="" />
		<cfargument name="Tax" type="numeric" required="false" default="0.00" />
		<cfargument name="Shipping" type="numeric" required="false" default="0.00" />
		<cfargument name="Discount" type="numeric" required="false" default="0.00" />
		<cfargument name="Subtotal" type="numeric" required="false" default="0.00" />
		<cfargument name="PaymentTypeID" type="string" required="false" default="" />
		<cfargument name="MerchantID" type="string" required="false" default="" />
		<cfargument name="OrderIdent" type="string" required="false" default="" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="Cart" type="any" required="false" default="" />
		<cfargument name="ResponseMessage" type="string" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setTransactionID( arguments.TransactionID ) />
		<cfset setTotal( arguments.Total ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setCartID( arguments.CartID ) />
		<cfset setCardLastFour( arguments.CardLastFour ) />
		<cfset setCardMonth( arguments.CardMonth ) />
		<cfset setCardYear( arguments.CardYear ) />
		<cfset setIsCompleted( arguments.IsCompleted ) />
		<cfset setIsApproved( arguments.IsApproved ) />
		<cfset setApprovalCode( arguments.ApprovalCode ) />
		<cfset setErrorCode( arguments.ErrorCode ) />
		<cfset setCustom1( arguments.Custom1 ) />
		<cfset setCustom2( arguments.Custom2 ) />
		<cfset setCustom3( arguments.Custom3 ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setParams( arguments.Params ) />
		<cfset setTax( arguments.Tax ) />
		<cfset setShipping( arguments.Shipping ) />
		<cfset setDiscount( arguments.Discount ) />
		<cfset setSubtotal( arguments.Subtotal ) />
		<cfset setPaymentTypeID( arguments.PaymentTypeID ) />
		<cfset setMerchantID( arguments.MerchantID ) />
		<cfset setOrderIdent( arguments.OrderIdent ) />
		<cfset setSiteID( arguments.SiteID ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setCart( arguments.Cart ) />
		<cfset setResponseMessage( arguments.ResponseMessage ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="TransactionBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setTransactionID" access="public" returntype="void" output="false">
		<cfargument name="TransactionID" type="uuid" required="true" />
		<cfset variables.instance['transactionid'] = arguments.TransactionID />
	</cffunction>
	<cffunction name="getTransactionID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.TransactionID />
	</cffunction>
	
	<cffunction name="setTotal" access="public" returntype="void" output="false">
		<cfargument name="Total" type="numeric" required="true" />
		<cfset variables.instance['total'] = arguments.Total />
	</cffunction>
	<cffunction name="getTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Total />
	</cffunction>
	
	<cffunction name="setDateCreate" access="public" returntype="void" output="false">
		<cfargument name="DateCreate" type="string" required="true" />
		<cfset variables.instance['datecreate'] = arguments.DateCreate />
	</cffunction>
	<cffunction name="getDateCreate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateCreate />
	</cffunction>
	
	<cffunction name="setDateLastUpdate" access="public" returntype="void" output="false">
		<cfargument name="DateLastUpdate" type="string" required="true" />
		<cfset variables.instance['datelastupdate'] = arguments.DateLastUpdate />
	</cffunction>
	<cffunction name="getDateLastUpdate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastUpdate />
	</cffunction>
	
	<cffunction name="setCartID" access="public" returntype="void" output="false">
		<cfargument name="CartID" type="string" required="true" />
		<cfset variables.instance['cartid'] = arguments.CartID />
	</cffunction>
	<cffunction name="getCartID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CartID />
	</cffunction>
	
	<cffunction name="setCardLastFour" access="public" returntype="void" output="false">
		<cfargument name="CardLastFour" type="string" required="true" />
		<cfset variables.instance['cardlastfour'] = arguments.CardLastFour />
	</cffunction>
	<cffunction name="getCardLastFour" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CardLastFour />
	</cffunction>
	
	<cffunction name="setCardMonth" access="public" returntype="void" output="false">
		<cfargument name="CardMonth" type="boolean" required="true" />
		<cfset variables.instance['cardmonth'] = arguments.CardMonth />
	</cffunction>
	<cffunction name="getCardMonth" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.CardMonth />
	</cffunction>
	
	<cffunction name="setCardYear" access="public" returntype="void" output="false">
		<cfargument name="CardYear" type="numeric" required="true" />
		<cfset variables.instance['cardyear'] = arguments.CardYear />
	</cffunction>
	<cffunction name="getCardYear" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CardYear />
	</cffunction>
	
	<cffunction name="setIsCompleted" access="public" returntype="void" output="false">
		<cfargument name="IsCompleted" type="boolean" required="true" />
		<cfset variables.instance['iscompleted'] = arguments.IsCompleted />
	</cffunction>
	<cffunction name="getIsCompleted" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsCompleted />
	</cffunction>
	
	<cffunction name="setIsApproved" access="public" returntype="void" output="false">
		<cfargument name="IsApproved" type="boolean" required="true" />
		<cfset variables.instance['isapproved'] = arguments.IsApproved />
	</cffunction>
	<cffunction name="getIsApproved" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsApproved />
	</cffunction>
	
	<cffunction name="setApprovalCode" access="public" returntype="void" output="false">
		<cfargument name="ApprovalCode" type="string" required="true" />
		<cfset variables.instance['approvalcode'] = arguments.ApprovalCode />
	</cffunction>
	<cffunction name="getApprovalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ApprovalCode />
	</cffunction>
	
	<cffunction name="setErrorCode" access="public" returntype="void" output="false">
		<cfargument name="ErrorCode" type="string" required="true" />
		<cfset variables.instance['errorcode'] = arguments.ErrorCode />
	</cffunction>
	<cffunction name="getErrorCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ErrorCode />
	</cffunction>
	
	<cffunction name="setCustom1" access="public" returntype="void" output="false">
		<cfargument name="Custom1" type="string" required="true" />
		<cfset variables.instance['custom1'] = arguments.Custom1 />
	</cffunction>
	<cffunction name="getCustom1" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Custom1 />
	</cffunction>
	
	<cffunction name="setCustom2" access="public" returntype="void" output="false">
		<cfargument name="Custom2" type="string" required="true" />
		<cfset variables.instance['custom2'] = arguments.Custom2 />
	</cffunction>
	<cffunction name="getCustom2" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Custom2 />
	</cffunction>
	
	<cffunction name="setCustom3" access="public" returntype="void" output="false">
		<cfargument name="Custom3" type="string" required="true" />
		<cfset variables.instance['custom3'] = arguments.Custom3 />
	</cffunction>
	<cffunction name="getCustom3" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Custom3 />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setParams" access="public" returntype="void" output="false">
		<cfargument name="Params" type="string" required="true" />
		<cfset variables.instance['params'] = arguments.Params />
	</cffunction>
	<cffunction name="getParams" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Params />
	</cffunction>
	
	<cffunction name="setTax" access="public" returntype="void" output="false">
		<cfargument name="Tax" type="numeric" required="true" />
		<cfset variables.instance['tax'] = arguments.Tax />
	</cffunction>
	<cffunction name="getTax" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Tax />
	</cffunction>
	
	<cffunction name="setShipping" access="public" returntype="void" output="false">
		<cfargument name="Shipping" type="numeric" required="true" />
		<cfset variables.instance['shipping'] = arguments.Shipping />
	</cffunction>
	<cffunction name="getShipping" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Shipping />
	</cffunction>
	
	<cffunction name="setDiscount" access="public" returntype="void" output="false">
		<cfargument name="Discount" type="numeric" required="true" />
		<cfset variables.instance['discount'] = arguments.Discount />
	</cffunction>
	<cffunction name="getDiscount" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Discount />
	</cffunction>
	
	<cffunction name="setSubtotal" access="public" returntype="void" output="false">
		<cfargument name="Subtotal" type="numeric" required="true" />
		<cfset variables.instance['subtotal'] = arguments.Subtotal />
	</cffunction>
	<cffunction name="getSubtotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Subtotal />
	</cffunction>
	
	<cffunction name="setPaymentTypeID" access="public" returntype="void" output="false">
		<cfargument name="PaymentTypeID" type="string" required="true" />
		<cfset variables.instance['paymenttypeid'] = arguments.PaymentTypeID />
	</cffunction>
	<cffunction name="getPaymentTypeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PaymentTypeID />
	</cffunction>
	
	<cffunction name="setMerchantID" access="public" returntype="void" output="false">
		<cfargument name="MerchantID" type="string" required="true" />
		<cfset variables.instance['merchantid'] = arguments.MerchantID />
	</cffunction>
	<cffunction name="getMerchantID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.MerchantID />
	</cffunction>
	
	<cffunction name="setOrderIdent" access="public" returntype="void" output="false">
		<cfargument name="OrderIdent" type="string" required="true" />
		<cfset variables.instance['orderident'] = arguments.OrderIdent />
	</cffunction>
	<cffunction name="getOrderIdent" access="public" returntype="string" output="false">
		<cfreturn variables.instance.OrderIdent />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- BeanExists --->
	<cffunction name="setBeanExists" access="public" output="false" returntype="void">
		<cfargument name="BeanExists" type="boolean" required="true" />
		<cfset variables.BeanExists = arguments.BeanExists >
	</cffunction>
	<cffunction name="BeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>

	<!--- DUMP --->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	
	<cffunction name="setCart" access="public" returntype="void" output="false">
		<cfargument name="Cart" type="any" required="true" />
		<cfset variables.instance['cart'] = arguments.Cart />
	</cffunction>
	<cffunction name="getCart" access="public" returntype="any" output="false">
		<cfreturn variables.instance.Cart />
	</cffunction>
	
	<cffunction name="setResponseMessage" access="public" returntype="void" output="false">
		<cfargument name="ResponseMessage" type="string" required="true" />
		<cfset variables.instance['responsemessage'] = arguments.ResponseMessage />
	</cffunction>
	<cffunction name="getResponseMessage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResponseMessage />
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	











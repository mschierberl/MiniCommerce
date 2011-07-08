<!---

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

--->
<cfcomponent displayname="PayPalBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.meldminicommerce.processor.ProcessorBean">

	<cffunction name="init" access="public" output="false" returntype="PayPalBean">
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />
		<cfargument name="merchantBean" type="any" required="true" />
		<cfargument name="billingAddress" type="query" required="true" />

		<cfset super.init( argumentCollection=arguments ) />

		<cfreturn this/>
	</cffunction>

	<cffunction name="processTransaction" access="public" output="false" returntype="any">
		<cfargument name="transactionBean" type="any" required="true" />
		<cfargument name="formData" type="Struct" required="true" />

		<cfset var pplCallerService		= createObject("component","CallerService") />

		<!---
		<cfset var pplURL				= "https://api-3t.paypal.com/nvp" />
		<cfset var pplURL				= "https://api-3t.sandbox.paypal.com/nvp" />
		--->

		<cfset var pplURL				= getMerchantBean().getparam4() />

		<cfset var isSuccess			= false />
		<cfset var requestData			= StructNew() />
		<cfset var responseStruct		= StructNew() />
		<cfset var responseData			= StructNew() />

		<cfset var submitTotal			= 0 />

		<!--- cart has already been processed --->
		<cfif getCartBean().getIsProcessed() neq 0>
			<cfreturn transactionBean />
		</cfif>

		<cfif issimplevalue( getCartBean() )>
			<cflocation url="./?page=payment&ecode=1200" addtoken="false" />
		<cfelseif getCartBean().getIsCompleted() >
			<cflocation url="./?page=payment&ecode=1203" addtoken="false" />
		<cfelseif getCartBean().isEmpty()>
			<cflocation url="./?page=payment&ecode=1202" addtoken="false" />
		</cfif>

		<cfif getCartBean().getIsCompleted()>
			<cflock scope="Session" timeout="15">
				<cfset session.MeldMiniCommerceID = createUUID()>
			</cflock>
			<cflocation url="./?page=payment&ecode=1201" addtoken="false" />
		</cfif>
		
		<cfset transactionBean.setCardLastFour( right( formData.creditCardNumber,4 ) ) />
		<cfset transactionBean.setCardMonth( formData.expDateMonth ) />
		<cfset transactionBean.setCardYear( formData.expDateYear ) />
		<cfset transactionBean.setCardMonth( formData.expDateMonth ) />
		<cfset transactionBean.setSubTotal( getCartBean().getSubTotal() ) />
		<cfset transactionBean.setTotal( getCartBean().getTotal() ) />

		<!--- do the paypal mombo --->
		<cfset requestData.METHOD				= "DoDirectPayment">
		<cfset requestData.PAYMENTACTION		= "Sale" />
		<cfset requestData.VERSION				= "59.0" />

		<!--- TEST --->

		<cfset requestData.USER					= getMerchantBean().getparam1() />
		<cfset requestData.PWD					= getMerchantBean().getparam2() />
		<cfset requestData.SIGNATURE			= getMerchantBean().getparam3() />

		<cfset requestData.FIRSTNAME			= getUserBean().getFName() />
		<cfset requestData.LASTNAME				= getUserBean().getLName() />

		<cfset requestData.STREET				= getBillingAddress().address1 />
		<cfset requestData.ZIP					= getBillingAddress().zip />
		<cfset requestData.STATE				= getBillingAddress().state />
		<cfset requestData.COUNTRYCODE			= getBillingAddress().country />
		<cfset requestData.CITY					= getBillingAddress().city />

		<cfset requestData.AMT					= numberFormat( transactionBean.getTotal(),"___________________.__" ) />
		<cfset requestData.CURRENCYCODE			= getMerchantBean().getparam5() />
		<cfset requestData.CVV2					= formData.cvv2Number />
		<cfset requestData.CREDITCARDTYPE		= getPaymentTypeBean().getIdentity() />
		<cfset requestData.EXPDATE				= formData.expDateMonth & formData.expDateYear />
		<cfset requestData.ACCT					= formData.creditCardNumber />

		<!--- send PayPal Request --->
		<cfset responseStruct = pplCallerService.doHttppost( requestData,pplURL,false ) />

		<!--- parse PayPayl Response --->
		<cfset responseData = pplCallerService.getNVPResponse( URLDecode( responseStruct ) ) />

		<cfset isSuccess = (left(responseData.ack,7) eq "success") />

		<!--- transaction success --->
		<cfif isSuccess>
			<cfset transactionBean.setIsApproved( 1 ) />
			<cfset transactionBean.setIsCompleted( 1 ) />

			<cfset transactionBean.setApprovalCode( responseData.transactionID ) /> <!--- transactionID --->
			<cfset transactionBean.setCustom2( responseData.AVSCODE ) /> <!--- avs --->
		<cfelse>
			<cfif StructKeyExists(responseData,"L_ERRORCODE0")>
				<cfset transactionBean.setErrorCode( responseData.L_ERRORCODE0 ) /> <!--- error --->
			</cfif>
			<cfif StructKeyExists(responseData,"L_ERRORCODE1")>
				<cfset transactionBean.setCustom3( responseData.L_ERRORCODE1 ) /> <!--- error --->
			</cfif>
			
			<cfif StructKeyExists(responseData,"L_LONGMESSAGE0")>
				<cfset transactionBean.setResponseMessage( responseData.L_LONGMESSAGE0 ) /> <!--- error --->
			</cfif>
		</cfif>

		<cfset transactionBean.setCustom1( responseData.CorrelationID ) /> <!--- paypal CorrelationID --->

		<cfset getCartBean().setIsProcessed( 1 ) />
		
		<cfreturn transactionBean />
	</cffunction>
</cfcomponent>
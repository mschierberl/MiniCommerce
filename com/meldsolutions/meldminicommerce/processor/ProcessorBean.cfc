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
<cfcomponent displayname="ProcessorBean" hint="Root for all Processor beans" output="false">
	<cfset variables.instance		= StructNew()>

	<cffunction name="init" access="public" output="false" returntype="ProcessorBean">
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />
		<cfargument name="merchantBean" type="any" required="true" />
		<cfargument name="billingAddress" type="query" required="true" />

		<cfset setCartBean( arguments.cartBean ) />
		<cfset setUserBean( arguments.userBean ) />
		<cfset setMerchantBean( arguments.merchantBean ) />
		<cfset setPaymentTypeBean( arguments.paymentTypeBean ) />
		<cfset setBillingAddress( arguments.billingAddress ) />

		<cfreturn this/>
	</cffunction>

	<cffunction name="processTransaction" access="public" output="false" returntype="any">
		<cfargument name="transactionBean" type="any" required="true" />
			
		<cfreturn transactionBean />
	</cffunction>

	<cffunction name="setCartBean" access="public" returntype="void" output="false">
		<cfargument name="CartBean" type="any" required="true" />
		<cfset variables.instance['cartbean'] = arguments.CartBean />
	</cffunction>
	<cffunction name="getCartBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.CartBean />
	</cffunction>

	<cffunction name="setUserBean" access="public" returntype="void" output="false">
		<cfargument name="UserBean" type="any" required="true" />
		<cfset variables.instance['userbean'] = arguments.UserBean />
	</cffunction>
	<cffunction name="getUserBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.UserBean />
	</cffunction>

	<cffunction name="setPaymentTypeBean" access="public" returntype="void" output="false">
		<cfargument name="PaymentTypeBean" type="any" required="true" />
		<cfset variables.instance['PaymentTypebean'] = arguments.PaymentTypeBean />
	</cffunction>
	<cffunction name="getPaymentTypeBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.PaymentTypeBean />
	</cffunction>

	<cffunction name="setMerchantBean" access="public" returntype="void" output="false">
		<cfargument name="MerchantBean" type="any" required="true" />
		<cfset variables.instance['merchantbean'] = arguments.MerchantBean />
	</cffunction>
	<cffunction name="getMerchantBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.MerchantBean />
	</cffunction>

	<cffunction name="setBillingAddress" access="public" returntype="void" output="false">
		<cfargument name="BillingAddress" type="query" required="true" />
		<cfset variables.instance['billingaddress'] = arguments.BillingAddress />
	</cffunction>
	<cffunction name="getBillingAddress" access="public" returntype="query" output="false">
		<cfreturn variables.instance.BillingAddress />
	</cffunction>

</cfcomponent>
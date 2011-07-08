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
<cfcomponent extends="controller">
	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var paymentTypeService	= getBeanFactory().getBean('paymentTypeService') />
	
		<cfset rc.aPaymentTypes	= paymentTypeService.getPaymentTypes( isActive=1 ) />
		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key('transactions') )>
	</cffunction>

	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var transactionService	= getBeanFactory().getBean('transactionService') />
		<cfset var paymentTypeService	= getBeanFactory().getBean('paymentTypeService') />
		<cfset var merchantService		= getBeanFactory().getBean('merchantService') />

		<cfset var transactionBean		= transactionService.getTransaction( rc.TransactionID ) />
		<cfset var paymentTypeBean		= paymentTypeService.getPaymentType( transactionBean.getPaymentTypeID() ) />

		<cfset var pluginEvent 			= createObject("component","mura.MuraScope") />
		<cfset var pluginManager		= rc.$.getBean('pluginManager') />

		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key('transactions'),'?action=transactions' )>
		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key('viewtransaction') )>

		<cfset rc.cartBean			= transactionBean.getCart() />

		<cfif paymentTypeBean.getPaymentType() eq 'card'>
			<cfset rc.merchantBean			= merchantService.getMerchant( transactionBean.getMerchantID() ) />
		</cfif>

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginEvent.setValue('cartBean',rc.cartBean ) />
		<cfset pluginManager.announceEvent("onMeldMiniCommerceGetCart",pluginEvent) />

		<cfset rc.cartBean	= pluginEvent.getValue('cartBean') />

		<cfset rc.transactionBean	= transactionBean />
		<cfset rc.products			= rc.cartBean.getProducts() />
		<cfset rc.userBean			= rc.$.getBean('userManager').read(userID=rc.cartbean.getUserID(),siteID=rc.siteID) />
		<cfset rc.paymentTypeBean	= paymentTypeBean />

		<cfset pluginEvent.setValue('transactionBean',rc.transactionBean ) />
		<cfset pluginEvent.setValue('sProducts',rc.products ) />
		<cfset pluginEvent.setValue('userBean',rc.userBean ) />
		<cfset pluginEvent.setValue('paymentTypeBean',rc.paymentTypeBean ) />
		<cfset rc.renderView = pluginManager.renderEvent( "onMeldMiniCommerceRenderTransactionView",pluginEvent )>
	</cffunction>

</cfcomponent>
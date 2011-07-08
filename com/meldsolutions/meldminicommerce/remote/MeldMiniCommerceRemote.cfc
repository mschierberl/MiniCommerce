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
<cfcomponent displayname="MeldMiniCommerceRemote" output="false" hint="Provides remote core functionality calls.">
	<cfset variables.instance = StructNew() />
	
	<cffunction name="init" returntype="MeldMiniCommerceRemote" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="getTransactionList" access="remote" returntype="any" returnformat="json" output="false" hint="Retrieves transactions.">
		<cfset var mmFormTools			= getMeldMiniCommerceManager().getBeanFactory().getBean("mmFormTools") />
		<cfset var mmResourceBundle		= getMeldMiniCommerceManager().getBeanFactory().getBean("mmResourceBundle") />
		<cfset var TransactionService	= getMeldMiniCommerceManager().getBeanFactory().getBean("TransactionService") />
		<cfset var MiniCommerceManager		= getMeldMiniCommerceManager().getBeanFactory().getBean("MeldMiniCommerceManager") />
		
		<cfset var returnStruct			= StructNew() />
		<cfset var sTransaction			= StructNew() />
		<cfset var aTransactionData		= ArrayNew(1) />
		<cfset var sCols				= StructNew() />

		<cfset var iiX					= "" />
		<cfset var cTransaction			= "" />
		<cfset var aTransaction			= ArrayNew(1) />
									  							<!--- data,skip empty,append global --->
		<cfset var sData				= mmFormTools.scopeFormSubmission( arguments,true,false )>
		<cfset var sCriteria			= StructNew() />

		<cfset sData['criteria']['siteid'] = session.siteID>

		<!--- sortable columns, as per database query --->
		<cfset sCols['0'] = "">
		<cfset sCols['1'] = "">
		<cfset sCols['2'] = "lname">
		<cfset sCols['3'] = "email">
		<cfset sCols['4'] = "total">
		<cfset sCols['5'] = "dateLastUpdate">

		<cfset sCriteria	= setCriteria( sData,sCols,0 ) />
		<cfset sTransaction	= TransactionService.search( argumentCollection=sCriteria )>

		<cfloop from="1" to="#ArrayLen(sTransaction.itemarray)#" index="iiX">
			<cfset cTransaction 	= sTransaction.itemarray[iiX] />
			<cfset aTransaction	= ArrayNew(1) />
			<cfset ArrayAppend(aTransaction,"
			<ul class='table-buttons two'>
			<li class='blank'></li>
			<li><span title='#mmResourceBundle.key('Transaction')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-document' href='?action=transactions.view&amp;TransactionID=#cTransaction.TransactionID#'></a></span></li>
			</ul>
			" ) />
			<cfset ArrayAppend( aTransaction,cTransaction.orderident ) />
			<cfset ArrayAppend( aTransaction,"<a title='#mmResourceBundle.key('user.name','mura')#' href='/admin/index.cfm?fuseaction=cPublicUsers.editUser&siteid=default&userid=#cTransaction.userID#'>#cTransaction.lname#, #cTransaction.fname#</a>" ) />
			<cfset ArrayAppend( aTransaction,cTransaction.email ) />
			<cfset ArrayAppend( aTransaction,lsCurrencyFormat(cTransaction.total) ) />
			<cfset ArrayAppend( aTransaction,lsDateFormat(cTransaction.dateLastUpdate,"short") & " " & lsTimeFormat(cTransaction.dateLastUpdate,"short") ) />
			<cfset ArrayAppend( aTransaction,cTransaction.paymentname ) />
			<cfset ArrayAppend( aTransaction,mmResourceBundle.key( "approved"& cTransaction.isApproved )) />
			<cfset ArrayAppend( aTransaction,mmResourceBundle.key( "completed"& cTransaction.isCompleted )) />
			<cfset ArrayAppend( aTransactionData,aTransaction ) />
		</cfloop>

		<cfset returnStruct['sEcho']					= getTickCount()>
		<cfset returnStruct['iTotalDisplayRecords']		= sTransaction.count>
		<cfset returnStruct['iTotalRecords']			= sTransaction.count>
		<cfset returnStruct['aaData']					= aTransactionData>
		<cfset returnStruct['success']					= true>

		<cfcontent type="application/json">
		<cfreturn returnStruct />
	</cffunction>

	<cffunction name="getPaymentTypeList" access="remote" returntype="any" returnformat="json" output="false" hint="Retrieves payment types.">
		<cfset var mmFormTools			= getMeldMiniCommerceManager().getBeanFactory().getBean("mmFormTools") />
		<cfset var mmResourceBundle		= getMeldMiniCommerceManager().getBeanFactory().getBean("mmResourceBundle") />
		<cfset var PaymentTypeService	= getMeldMiniCommerceManager().getBeanFactory().getBean("PaymentTypeService") />
		<cfset var MiniCommerceManager		= getMeldMiniCommerceManager().getBeanFactory().getBean("MeldMiniCommerceManager") />
		
		<cfset var returnStruct			= StructNew() />
		<cfset var sPaymentType			= StructNew() />
		<cfset var aPaymentTypeData		= ArrayNew(1) />
		<cfset var sCols				= StructNew() />

		<cfset var iiX					= "" />
		<cfset var cPaymentType			= "" />
		<cfset var aPaymentType			= ArrayNew(1) />
									  							<!--- data,skip empty,append global --->
		<cfset var sData				= mmFormTools.scopeFormSubmission( arguments,true,false )>
		<cfset var sCriteria			= StructNew() />

		<!--- sortable columns, as per database query --->
		<cfset sCols['0'] = "">
		<cfset sCols['1'] = "name">
		<cfset sCols['2'] = "paymenttype">

		<cfset sCriteria	= setCriteria( sData,sCols,0 ) />
		<cfset sPaymentType	= PaymentTypeService.search( argumentCollection=sCriteria )>

		<cfloop from="1" to="#ArrayLen(sPaymentType.itemarray)#" index="iiX">
			<cfset cPaymentType 	= sPaymentType.itemarray[iiX] />
			<cfset aPaymentType	= ArrayNew(1) />
			<cfset ArrayAppend(aPaymentType,"
			<ul class='table-buttons two'>
			<li class='blank'></li>
			<li><span title='#mmResourceBundle.key('PaymentType')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-pencil' href='?action=PaymentTypes.edit&amp;PaymentTypeID=#cPaymentType.PaymentTypeID#'></a></span></li>
			</ul>
			" ) />
			<cfset ArrayAppend( aPaymentType,cPaymentType.name ) />
			<cfset ArrayAppend( aPaymentType,mmResourceBundle.key( cPaymentType.paymenttype ) ) />
			<cfset ArrayAppend( aPaymentType,mmResourceBundle.key( "yesno"& cPaymentType.isActive ) ) />
			<cfset ArrayAppend( aPaymentTypeData,aPaymentType ) />
		</cfloop>

		<cfset returnStruct['sEcho']					= getTickCount()>
		<cfset returnStruct['iTotalDisplayRecords']		= sPaymentType.count>
		<cfset returnStruct['iTotalRecords']			= sPaymentType.count>
		<cfset returnStruct['aaData']					= aPaymentTypeData>
		<cfset returnStruct['success']					= true>

		<cfcontent type="application/json">
		<cfreturn returnStruct />
	</cffunction>

	<cffunction name="getMerchantList" access="remote" returntype="any" returnformat="json" output="false" hint="Retrieves payment types.">
		<cfset var mmFormTools			= getMeldMiniCommerceManager().getBeanFactory().getBean("mmFormTools") />
		<cfset var mmResourceBundle		= getMeldMiniCommerceManager().getBeanFactory().getBean("mmResourceBundle") />
		<cfset var MerchantService	= getMeldMiniCommerceManager().getBeanFactory().getBean("MerchantService") />
		<cfset var MiniCommerceManager		= getMeldMiniCommerceManager().getBeanFactory().getBean("MeldMiniCommerceManager") />
		
		<cfset var returnStruct			= StructNew() />
		<cfset var sMerchant			= StructNew() />
		<cfset var aMerchantData		= ArrayNew(1) />
		<cfset var sCols				= StructNew() />

		<cfset var iiX					= "" />
		<cfset var cMerchant			= "" />
		<cfset var aMerchant			= ArrayNew(1) />
									  							<!--- data,skip empty,append global --->
		<cfset var sData				= mmFormTools.scopeFormSubmission( arguments,true,false )>
		<cfset var sCriteria			= StructNew() />

		<cfset sData['criteria']['isactive'] = 1>

		<!--- sortable columns, as per database query --->
		<cfset sCols['0'] = "">
		<cfset sCols['1'] = "name">
		<cfset sCols['2'] = "Merchant">

		<cfset sCriteria	= setCriteria( sData,sCols,0 ) />
		<cfset sMerchant	= MerchantService.search( argumentCollection=sCriteria )>

		<cfloop from="1" to="#ArrayLen(sMerchant.itemarray)#" index="iiX">
			<cfset cMerchant 	= sMerchant.itemarray[iiX] />
			<cfset aMerchant	= ArrayNew(1) />
			<cfset ArrayAppend(aMerchant,"
			<ul class='table-buttons two'>
			<li class='blank'></li>
			<li><span title='#mmResourceBundle.key('Merchant')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-pencil' href='?action=Merchants.edit&amp;MerchantID=#cMerchant.MerchantID#'></a></span></li>
			</ul>
			" ) />
			<cfset ArrayAppend( aMerchant,cMerchant.name ) />
			<cfset ArrayAppend( aMerchant,mmResourceBundle.key( "yesnull"& cMerchant.isCurrent ) ) />
			<cfset ArrayAppend( aMerchantData,aMerchant ) />
		</cfloop>

		<cfset returnStruct['sEcho']					= getTickCount()>
		<cfset returnStruct['iTotalDisplayRecords']		= sMerchant.count>
		<cfset returnStruct['iTotalRecords']			= sMerchant.count>
		<cfset returnStruct['aaData']					= aMerchantData>
		<cfset returnStruct['success']					= true>

		<cfcontent type="application/json">
		<cfreturn returnStruct />
	</cffunction>

	<cffunction name="setCriteria" access="private" returntype="struct" output="false" hint="Creates the search critera structure">
		<cfargument name="sData" required="true" type="struct">
		<cfargument name="cols" required="true" type="struct">
		<cfargument name="defaultSortCol" required="false" type="string" default="1">

		<cfset var sCriteria		= StructNew() />
		<cfset var sortDir			= "" />

		<cfset sCriteria.criteria	= StructNew()>
		<cfset sCriteria.orderBy	= "">

		<cfif structkeyexists(sData,"criteria")>
			<cfset sCriteria.criteria = sData.criteria>
		</cfif>

		<cfif structkeyexists(sData,"mm_global") and structkeyexists(sData.mm_global,"iDisplayStart")>
			<cfset sCriteria.start	= sData['mm_global'].iDisplayStart>
			<cfset sCriteria.size	= sData['mm_global'].iDisplayLength>
			<cfset sCriteria.count	= 0>
		</cfif>

		<cfif structkeyexists(sData,"iSortCol") and structKeyExists( arguments.cols,sData.iSortCol['0'] )>
			<cfif sData.sSortDir['0'] eq "asc">
				<cfset sortDir = "ASC">
			<cfelse>
				<cfset sortDir = "DESC">
			</cfif>
			<cfset sCriteria.orderBy = "#arguments.cols[ sData.iSortCol['0'] ]# #sortDir#">
		<cfelse>
			<cfset sCriteria.orderBy = "#arguments.cols[ arguments.defaultSortCol ]# ASC">
		</cfif>

		<cfreturn sCriteria>	
	</cffunction>

	<cffunction name="setMeldMiniCommerceManager" access="public" returntype="void" output="false">
		<cfargument name="MeldMiniCommerceManager" type="any" required="true" />
		<cfset variables.instance.MeldMiniCommerceManager = arguments.MeldMiniCommerceManager />
	</cffunction>
	<cffunction name="getMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfreturn variables.instance.MeldMiniCommerceManager />
	</cffunction>
</cfcomponent>
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

		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key("paymenttypes"),"" )>
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">


		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq rc.mmRBF.key('cancel')>
				<cflocation url="?action=admin:paymenttypes" addtoken="false">
			<!--- save? --->
			<cfelseif rc.btaction eq  rc.mmRBF.key('save')>
				<cfset success = doSavePaymentType( argumentCollection=arguments ) /> 
				<cfif success eq true>
					<cflocation url="?action=admin:paymenttypes" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif rc.btaction eq  rc.mmRBF.key('update')>
				<cfset success = doUpdatePaymentType( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=admin:paymenttypes" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("rc.btdeleteconfirm") and rc.btdeleteconfirm eq "delete">
			<cfset success = doDeletePaymentType( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=admin:paymenttypes" addtoken="false">
			</cfif> 
		</cfif>

		<cfset doGetPaymentType( argumentCollection=arguments ) />

		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key("paymenttypes"),"?action=admin:paymenttypes" )>

		<cfif rc.PaymentTypeBean.beanExists()>
			<cfset rc.mmBC.addCrumb( arguments.rc,rc.PaymentTypeBean.getName(),"" )>
		<cfelse>
			<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key("paymenttypenew"),"" )>
		</cfif>		
	</cffunction>

	<cffunction name="doGetPaymentType" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var PaymentTypeService	= getBeanFactory().getBean("paymenttypeService") />
		<cfset var PaymentTypeBean		= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var sPresets				= StructNew() />

		<cfif StructKeyExists(rc,"paymenttypeID")>
			<cfset PaymentTypeBean = PaymentTypeService.getPaymentType( rc.PaymentTypeID ) />
		<cfelse>
			<cfset PaymentTypeBean	= PaymentTypeService.createPaymentType( argumentCollection=sArgs ) />
		</cfif>

		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(PaymentTypeBean,sPresets) />

		<cfset rc.PaymentTypeBean = PaymentTypeBean />
	</cffunction>


	<cffunction name="doSavepaymentType" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var paymentTypeService	= getBeanFactory().getBean("paymentTypeService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var paymentTypeBean			= "" />
		<cfset var formData				= StructNew() />

		<cfset var sArgs				= StructNew() /> 

		<cfset sArgs					= StructNew() /> 
		<cfset sArgs.paymentTypeID		= rc.paymentTypeID />
		<cfset sArgs.siteID				= rc.siteID />
		<cfset sArgs.adminID			= rc.$.currentUser('userID') />

		<cfset paymentTypeBean = paymentTypeService.createpaymentType( argumentCollection=sArgs ) />

		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(paymentTypeBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset paymentTypeBean.updateMemento( formData.paymentTypeBean )>
		<cfset rc.paymentTypeBean = paymentTypeBean />
		
		<cfif getErrorManager().hasErrors( rc.$.event() )>
			<cfreturn false>
		</cfif>

		<cfset paymentTypeService.savepaymentType( paymentTypeBean ) />
	
		<cfreturn true>
	</cffunction>


	<cffunction name="doUpdatepaymentType" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var paymentTypeService			= getBeanFactory().getBean("paymentTypeService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var paymentTypeBean			= "" />
		<cfset var formData				= StructNew() />

		<cfset var sArgs				= StructNew() /> 

		<cfset sArgs					= StructNew() /> 
		<cfset sArgs.paymentTypeID			= rc.paymentTypeID />

		<cfset paymentTypeBean = paymentTypeService.getpaymentType( argumentCollection=sArgs ) />

		<cfif not paymentTypeBean.beanExists()>
			<!--- error --->
			<cfreturn false>
		</cfif>

		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(paymentTypeBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset paymentTypeBean.updateMemento( formData.paymentTypeBean )>
		<cfset rc.paymentTypeBean = paymentTypeBean />

		<cfif not getErrorManager().hasErrors( rc.$.event() )>
			<cfset paymentTypeService.updatepaymentType( paymentTypeBean ) />
		</cfif>	
	
		<cfif not getErrorManager().hasErrors( rc.$.event() )>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>


	<cffunction name="doDeletepaymentType" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var paymentTypeService		= getBeanFactory().getBean("paymentTypeService") />

		<cfset var sArgs			= StructNew() /> 

		<cfset sArgs				= StructNew() /> 
		<cfset sArgs.paymentTypeID		= rc.paymentTypeID />

		<cfset paymentTypeService.deletepaymentType( argumentCollection=sArgs ) />
	
		<cfif getErrorManager().hasErrors( rc.$.event() )>
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>

</cfcomponent>
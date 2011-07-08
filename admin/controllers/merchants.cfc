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

		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key("merchants"),"" )>
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">


		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq rc.mmRBF.key('cancel')>
				<cflocation url="?action=admin:merchants" addtoken="false">
			<!--- save? --->
			<cfelseif rc.btaction eq  rc.mmRBF.key('save')>
				<cfset success = doSaveMerchant( argumentCollection=arguments ) /> 
				<cfif success eq true>
					<cflocation url="?action=admin:merchants" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif rc.btaction eq  rc.mmRBF.key('update')>
				<cfset success = doUpdateMerchant( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=admin:merchants" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("rc.btdeleteconfirm") and rc.btdeleteconfirm eq "delete">
			<cfset success = doDeleteMerchant( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=admin:merchants" addtoken="false">
			</cfif> 
		</cfif>

		<cfset doGetMerchant( argumentCollection=arguments ) />

		<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key("merchants"),"?action=admin:merchants" )>

		<cfif rc.MerchantBean.beanExists()>
			<cfset rc.mmBC.addCrumb( arguments.rc,rc.MerchantBean.getName(),"" )>
		<cfelse>
			<cfset rc.mmBC.addCrumb( arguments.rc,rc.mmRBF.key("merchantnew"),"" )>
		</cfif>		
	</cffunction>

	<cffunction name="doGetMerchant" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var MerchantService	= getBeanFactory().getBean("merchantService") />
		<cfset var MerchantBean		= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var sPresets				= StructNew() />

		<cfif StructKeyExists(rc,"merchantID")>
			<cfset MerchantBean = MerchantService.getMerchant( rc.MerchantID ) />
		<cfelse>
			<cfset MerchantBean	= MerchantService.createMerchant( argumentCollection=sArgs ) />
		</cfif>

		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(MerchantBean,sPresets) />

		<cfset rc.MerchantBean = MerchantBean />
	</cffunction>


	<cffunction name="doSaveMerchant" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var MerchantService	= getBeanFactory().getBean("MerchantService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var MerchantBean			= "" />
		<cfset var formData				= StructNew() />

		<cfset var sArgs				= StructNew() /> 

		<cfset sArgs					= StructNew() /> 
		<cfset sArgs.MerchantID			= rc.MerchantID />
		<cfset sArgs.siteID				= rc.siteID />
		<cfset sArgs.adminID			= rc.$.currentUser('userID') />

		<cfset MerchantBean = MerchantService.createMerchant( argumentCollection=sArgs ) />

		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(MerchantBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset MerchantBean.updateMemento( formData.MerchantBean )>
		<cfset MerchantBean.setIsActive( 1 ) />

		<cfset rc.MerchantBean = MerchantBean />
		
		<cfif getErrorManager().hasErrors( rc.$.event() )>
			<cfreturn false>
		</cfif>

		<cfset MerchantService.saveMerchant( MerchantBean ) />
	
		<cfreturn true>
	</cffunction>


	<cffunction name="doUpdateMerchant" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var MerchantService			= getBeanFactory().getBean("MerchantService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var MerchantBean			= "" />
		<cfset var formData				= StructNew() />

		<cfset var sArgs				= StructNew() /> 

		<cfset sArgs					= StructNew() /> 
		<cfset sArgs.MerchantID			= rc.MerchantID />

		<cfset MerchantBean = MerchantService.getMerchant( argumentCollection=sArgs ) />

		<cfif not MerchantBean.beanExists()>
			<!--- error --->
			<cfreturn false>
		</cfif>

		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(MerchantBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset MerchantBean.updateMemento( formData.MerchantBean )>
		<cfset MerchantBean.setIsActive( 1 ) />

		<cfset rc.MerchantBean = MerchantBean />

		<cfif not getErrorManager().hasErrors( rc.$.event() )>
			<cfset MerchantService.updateMerchant( MerchantBean ) />
		</cfif>	
	
		<cfif not getErrorManager().hasErrors( rc.$.event() )>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>


	<cffunction name="doDeleteMerchant" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var MerchantService		= getBeanFactory().getBean("MerchantService") />

		<cfset var sArgs			= StructNew() /> 

		<cfset sArgs				= StructNew() /> 
		<cfset sArgs.MerchantID		= rc.MerchantID />

		<cfset MerchantService.deleteMerchant( argumentCollection=sArgs ) />
	
		<cfif getErrorManager().hasErrors( rc.$.event() )>
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>

</cfcomponent>
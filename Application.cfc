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
<cfcomponent extends="framework" output="false">
	<cfset request.tcCount = getTickCount() />
	<cfinclude template="../../config/applicationSettings.cfm">
	<cfinclude template="../../config/mappings.cfm">
	<cfinclude template="../mappings.cfm">

	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="isAdminRequest" output="false">
		<cfif left(request.context.action,5) eq 'admin'>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
	<cffunction name="secureRequest" output="false">
		<cfargument name="$">
		<cfif isAdminRequest() and not ($.currentUser().isSuperUser() or $.currentUser().isInGroup('admin') eq true)>
			<cfif not isDefined("variables.pluginConfig") or variables.pluginConfig.getPackage() neq variables.framework.applicationKey>
				<cfset variables.pluginConfig=application.pluginManager.getConfig(variables.framework.applicationKey)>
			</cfif>
			<cfif not structKeyExists(session,"siteID") or not application.permUtility.getModulePerm(variables.pluginConfig.getValue('moduleID'),session.siteid)>
				<cflocation url="#$.globalConfig().getContext()#/admin/" addtoken="false">
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="setupRequest" output="false">
		<cfset var muraScope = "" />

		<cfif not structKeyExists(request.context,"$")>
			<cfset request.context.$ = getMuraScope() />
		</cfif>

		<cfset secureRequest(request.context.$)>
	</cffunction>

	<cffunction name="setupApplication" output="false">
		<cfset var beanFactory				= "" />
		<cfset var coldspringXml			= "" />
		<cfset var coldspringXmlPath		= "" />
		<cfset var defaultProperties		= StructNew()>
	
		<!--- ensure that we have PluginConfig in the variables scope and $ --->
		<cfif not isDefined("variables.pluginConfig") or variables.pluginConfig.getPackage() neq variables.framework.applicationKey>
			<cfif not structKeyExists(application,"pluginManager")>
				<cfinclude template="/muraWRM/config/appcfc/onApplicationStart_include.cfm" />
			</cfif>

			<cfset variables.pluginConfig=application.pluginManager.getConfig(variables.framework.applicationKey)>
		</cfif>

		<cfif not isDefined("$")>
			<cfset $ = getMuraScope() />
		</cfif>
				
		<cfset coldspringXmlPath	= "#expandPath('/plugins')#/#variables.pluginConfig.getDirectory()#/coldspring/coldspring.xml.cfm" />

		<!--- read in coldspringXml --->
		<cffile action="read" file="#coldspringXmlPath#" variable="coldspringXml" />

		<!--- parse the coldspringXml and replace all [plugin] with the plugin mapping path, and |plugin| with the physical path --->
		<cfset coldspringXml = replaceNoCase( coldspringXml, "[plugin]", "plugins.#variables.pluginConfig.getDirectory()#.", "ALL") />
		<cfset coldspringXml = replaceNoCase( coldspringXml, "|plugin|", "plugins/#variables.pluginConfig.getDirectory()#/", "ALL") />

		<!--- set the default values --->
		<cfset defaultProperties.dsn				= variables.pluginConfig.getSetting( "dsn" )>
		<cfset defaultProperties.dsnusername		= variables.pluginConfig.getSetting( "dsnusername" )>
		<cfset defaultProperties.dsnpassword		= variables.pluginConfig.getSetting( "dsnpassword" )>
		<cfset defaultProperties.dsnprefix			= variables.pluginConfig.getSetting( "dsnprefix" )>
		<cfset defaultProperties.dsntype			= variables.pluginConfig.getSetting( "dsntype" )>

		<!---
		UNUSED
		<cfset defaultProperties.expireHours		= variables.pluginConfig.getSetting( "expireHours" )>
		<cfset defaultProperties.expireDays			= variables.pluginConfig.getSetting( "expireDays" )>
		--->
		<cfset defaultProperties.expireHours		= 12>
		<cfset defaultProperties.expireDays			= 12>

		<cfset defaultProperties.pluginFileRoot		= expandpath("/#variables.pluginConfig.getPackage()#")>
		<cfset defaultProperties.pluginDirectory	= variables.pluginConfig.getDirectory()>
		<cfset defaultProperties.fileDirectory		= $.globalConfig().getFileDir()>
		<cfset defaultProperties.muraWebRoot		= application.configBean.getContext()>
		<cfset defaultProperties.pluginConfig		= variables.pluginConfig>

		<cfset defaultProperties.applicationKey		= lcase(variables.pluginConfig.getPackage())>
		
		<cfset defaultProperties.rblocale			= "en" />
		
		<cfset variables.pluginConfig.setValue("DefaultProperties",defaultProperties) />

		<!--- build CS factory --->
		<cfset beanFactory=createObject("component","coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties=defaultProperties ) />

		<!--- load beans --->
		<cfset beanFactory.loadBeansFromXmlRaw( coldspringXml ) />

		<!--- set the FW/1 bean factory as our new ColdSpring bean factory --->
		<cfset setBeanFactory( beanFactory ) />

		<!---
			NOTE: do not set Mura's service factory as parent to our bean factory, as getBean() will
			default to Mura's, not ours!
		--->

		<!--- set the pluginConfig for our plugin into the fw1 application scope --->
		<cfset setPluginConfig( variables.pluginConfig )>

		<!--- push the ColdSpring factory into plugin application scope --->
		<cfset variables.pluginConfig.getApplication().setValue( "beanFactory", beanFactory ) />

		<cfset beanFactory.getBean('MuraManager').setServiceFactory( $.event().getServiceFactory() ) />

		<!--- push the ColdSpring factory and pluginConfig into the manager --->
		<cfset beanFactory.getBean('MeldMiniCommerceManager').setBeanFactory( beanFactory ) />
		<cfset beanFactory.getBean('MeldMiniCommerceManager').setPluginConfig( getPluginConfig() ) />

		<!--- Mura Interfaces --->
		<cfset beanFactory.getBean('MuraDisplayObjectManager').setMuraScope( $ ) />
		<cfset beanFactory.getBean('MuraEventHandlerManager').setMuraScope( $ ) />

		<!--- set the main FW/1 bean factory as the parent factory --->
		<cfset beanFactory.getBean("mmResourceBundle").setParentFactory( application.serviceFactory.getBean("resourceBundleFactory") ) />
		
		<cfif variables.framework.reloadApplicationOnEveryRequest or StructKeyExists(url,variables.framework.reload)>
			<cfset application[ variables.framework.applicationKey & "BeanFactory" ] = beanFactory>
		</cfif>
		
		<cfset loadSubSystems() />
	</cffunction>

	<cffunction name="setupSubsystem" output="false">
		<cfargument name="subsystem" type="string" required="true" />
		<cfargument name="displayTypeBean" type="any" required="false"/>

		<cfset var beanFactory				= "" />
		<cfset var coldspringXml			= "" />
		<cfset var coldspringXmlPath		= "" />
		<cfset var displayPath				= "" />
		<cfset var defaultProperties		= StructNew()>

		<cfset var muraDisplayObjectManager	= getBeanFactory().getBean("muraDisplayObjectManager") />
		<cfset var muraEventHandlerManager	= getBeanFactory().getBean("muraEventHandlerManager") />
		<cfset var displaytypeService		= getBeanFactory().getBean("DisplaytypeService") /> 
		<cfset var displayObjectBean		= "" />

		<cfset var sArgs					= StructNew() />
	
		<cfif not isDefined("variables.pluginConfig") or variables.pluginConfig.getPackage() neq variables.framework.applicationKey>
			<cfif not structKeyExists(application,"pluginManager")>
				<cfinclude template="/muraWRM/config/appcfc/onApplicationStart_include.cfm" />
			</cfif>

			<cfset variables.pluginConfig=application.pluginManager.getConfig(variables.framework.applicationKey)>
		</cfif>

		<cfif not isDefined("$")>
			<cfset $ = getMuraScope() />
		</cfif>

		<cfset displayPath					= "#expandPath( '/plugins' )#/#variables.pluginConfig.getDirectory()#/#arguments.subsystem#" />

		<!--- ensure that we have PluginConfig in the variables scope --->
		<cfif arguments.subsystem eq variables.framework.defaultSubsystem>
			<cfreturn>
		</cfif>

		<cfset coldspringXmlPath = "#displayPath#/coldspring/coldspring.xml.cfm" />

		<!--- if the subApplication has it's own bean factory, read in coldspringXml --->
		<cfif fileExists( coldspringXmlPath )>
			<cffile action="read" file="#coldspringXmlPath#" variable="coldspringXml" />
	
		<!--- parse the coldspringXml and replace all [plugin] with the plugin mapping path, and |plugin| with the physical path --->
			<cfset coldspringXml = replaceNoCase( coldspringXml, "[plugin]", "plugins.#variables.pluginConfig.getDirectory()#.#arguments.subsystem#.", "ALL") />
			<cfset coldspringXml = replaceNoCase( coldspringXml, "|plugin|", "plugins/#variables.pluginConfig.getDirectory()#/#arguments.subsystem#/", "ALL") />
	
			<!--- set the default values --->
			<cfset defaultProperties.dsn				= variables.pluginConfig.getSetting( "dsn" )>
			<cfset defaultProperties.dsnusername		= variables.pluginConfig.getSetting( "dsnusername" )>
			<cfset defaultProperties.dsnpassword		= variables.pluginConfig.getSetting( "dsnpassword" )>
			<cfset defaultProperties.dsnprefix			= variables.pluginConfig.getSetting( "dsnprefix" )>
			<cfset defaultProperties.dsntype			= variables.pluginConfig.getSetting( "dsntype" )>
			<cfset defaultProperties.pluginDirectory	= variables.pluginConfig.getDirectory()>
			<cfset defaultProperties.muraRoot			= application.configBean.getContext()>

			<cfif isDefined('session') and StructKeyExists( session,'locale')>
				<cfset defaultProperties.rblocale			= session.locale />
			<cfelse>
				<cfset defaultProperties.rblocale			= "en" />
			</cfif>
	
			<!--- build CS factory --->
			<cfset beanFactory=createObject("component","coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties=defaultProperties ) />
			<!--- load beans --->
			<cfset beanFactory.loadBeansFromXmlRaw( coldspringXml ) />
			<!--- set the main FW/1 bean factory as the parent factory --->
			<cfset beanFactory.setParent( variables.pluginConfig.getApplication().getValue("beanFactory") ) />
			<cfset setSubsystemBeanFactory( subsystem, beanFactory )>
		</cfif>

		<!--- check/register the display object --->
		<cfif directoryExists( "#displayPath#/display" ) and fileExists( "#displayPath#/display/displayManager.cfc" ) >
			<cfif not StructKeyExists(arguments,"displayTypeBean")>
				<cfset sArgs						= StructNew() />
				<cfset sArgs.package				= arguments.subsystem />
	 			<cfset displayTypeBean				= displayTypeService.getBeanByAttributes( argumentCollection=sArgs ) />
	 		</cfif>

			<cfset sArgs = StructNew() />
			<cfset sArgs.moduleID			= getPluginConfig().getValue('moduleID') />
			<cfset sArgs.name				= displayTypeBean.getName() />
			<cfif len( displayTypeBean.getObjectID() )>
				<cfset sArgs.objectID		= displayTypeBean.getObjectID() />
			</cfif>
			<cfset sArgs.location			= "global" />
			<cfset sArgs.component			= "#arguments.subsystem#.display.displayManager" />
			<cfset sArgs.displayMethod		= "renderApp" />
			<cfset displayObjectBean = muraDisplayObjectManager.registerDisplayObject( argumentCollection=sArgs ) />

			<cfif isObject(displayObjectBean)>
				<cfset displayTypeBean.setModuleID( displayObjectBean.getModuleID() ) />
				<cfset displayTypeBean.setObjectID( displayObjectBean.getObjectID() ) />
				<cfset displayTypeService.updateDisplaytype( displayTypeBean ) />
			</cfif>
		</cfif>
		
		<!--- check/register the event handler --->
		<cfif directoryExists( "#displayPath#/events" ) and fileExists( "#displayPath#/events/eventHandler.cfc" ) >
			<cfset sArgs = StructNew() />
			<cfset sArgs.moduleID		= getPluginConfig().getValue('moduleID') />
			<cfset sArgs.component		= "#arguments.subsystem#.events.eventHandler" />
			<cfset sArgs.runat			= "onApplicationLoad" />
			
			<cfset muraEventHandlerManager.registerEventHandler( argumentCollection=sArgs ) />
		</cfif>

	</cffunction>

	<cffunction name="loadSubsystems" output="false">
		<!--- SETUP TIP: DisplayObjectTypes table needed to automatically instantiate Display SubSystems --->

		<cfset var sArgs			= StructNew() />
		<!---<cfset sArgs.moduleID		= getPluginConfig().getValue('moduleID') />--->

		<cfset var displayTypeService		= getBeanFactory().getBean("DisplayTypeService") /> 
		<cfset var aDisplayObjectTypes		= displayTypeService.getDisplayTypes( argumentCollection=sArgs ) /> 
	
		<cfloop from="1" to="#ArrayLen( aDisplayObjectTypes )#" index="iiX">
			<cfset setupSubsystem( aDisplayObjectTypes[iiX].getPackage(),aDisplayObjectTypes[iiX] ) />
		</cfloop>
	</cffunction>

	<cffunction name="setPluginConfig" output="false">
		<cfargument name="pluginConfig" type="any" required="true">
		<cfset application[ variables.framework.applicationKey ].pluginConfig = arguments.pluginConfig>
	</cffunction>

	<cffunction name="getPluginConfig" output="false">
		<cfreturn application[ variables.framework.applicationKey ].pluginConfig>
	</cffunction>

	<cffunction name="onRequestEnd" output="false">
		<!--- TODO: Move to master layout, as per Sean Corfield --->
		<cfset var iiX = 0>
		<cfif not structkeyexists( request.context,"headLoader" )>
			<cfreturn>
		</cfif>

		<cfloop from="1" to="#arrayLen(request.context.headLoader)#" index="iiX">
			<cfhtmlhead text="#request.context.headLoader[iiX]#">
		</cfloop>
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="frameworkConfig.cfm" />

		<cfreturn framework />		
	</cffunction>

	<!--- fix issue with Mura grabbing my framework settings --->
	<cffunction name="onMissingView" output="false">
		<cfparam name="url.action" default="" />

		<cfif left(url.action,1) eq "c" and not findNoCase(pluginConfig.getDirectory(),cgi.script_name)>
			<cflocation url="./?ma=#url.action#" addtoken="false" />
		<cfelse>
			<cfset super.onMissingView( argumentCollection=arguments ) />			
		</cfif>
	</cffunction>

	<cffunction name="preseveInternalState" output="false">
		<cfargument name="state">
		<cfset var preserveKeyList="context,base,cfcbase,subsystem,subsystembase,section,item,services,action,controllerExecutionStarted">
		<cfset var preserveKeys=structNew()>
		<cfset var k="">
		
		<cfloop list="#preserveKeyList#" index="k">
			<cfif isDefined("arguments.state.#k#")>
				<cfset preserveKeys[k]=arguments.state[k]>
				<cfset structDelete(arguments.state,k)>
			</cfif>
		</cfloop>
		
		<cfif StructKeyExists(request,'controllers')>
			<cfset structDelete(request,'controllers') />
		</cfif>
		
		<cfset structDelete( arguments.state, "serviceExecutionComplete" )>
		
		<cfreturn preserveKeys>
	</cffunction>
		
	<cffunction name="restoreInternalState" output="false">
		<cfargument name="state">
		<cfargument name="restore">
		<cfset var preserveKeyList="context,base,cfcbase,subsystem,subsystembase,section,item,services,action,controllerExecutionStarted">
		
		<cfloop list="#preserveKeyList#" index="k">
				<cfset structDelete(arguments.state,k)>
		</cfloop>
		
		<cfset structAppend(state,restore,true)>
		<cfset structDelete( state, "serviceExecutionComplete" )>
	</cffunction>
	
	<cffunction name="getMuraScope" output="false">
		<cfset var $ = application.serviceFactory.getBean("MuraScope")>
		<cfset var sInitArgs = StructNew()>

		<cfif isDefined('session') and structKeyExists(session,"siteID")>
			<cfset sInitArgs.siteID = session.siteID>
		<cfelse>
			<cfset sInitArgs.siteID = "default">
		</cfif>
		<cfset $.init(sInitArgs)>
		
		<cfreturn $ />
	</cffunction>
</cfcomponent>
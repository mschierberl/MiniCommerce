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
<cfcomponent output="false">

	<cfset variables.config=""/>
	<cfset variables.instance.extensionManager = application.classExtensionManager />
	
	<cffunction name="init" returntype="any" access="public" 	output="false">
		<cfargument name="config"  type="any" default="">
		<cfset variables.config = arguments.config>
	</cffunction>
	
	<cffunction name="refresh" returntype="void" access="public" output="false">
		<cfset install() />
	</cffunction>
	
	<cffunction name="install" returntype="void" access="public" output="false">

		<cfset var serviceFactory	= variables.config.getApplication().getValue("serviceFactory")>
		<cfset var dsn				= variables.config.getSetting( "dsn" )>
		<cfset var dsnusername		= variables.config.getSetting( "dsnusername" )>
		<cfset var dsnpassword		= variables.config.getSetting( "dsnpassword" )>
		<cfset var dsnprefix		= variables.config.getSetting( "dsnprefix" )>
		<cfset var dsntype			= variables.config.getSetting( "dsntype" )>
		<cfset var tablename		= "#dsnprefix#mf_settings">
		<cfset var errorType		= "">
		<cfset var msg				= "">
		<cfset var catch			= "">
		<cfset var sql				= "">
		<cfset var aSql				= "">
		<cfset var iiX				= "">
		<cfset var error 			= false>
		<cfset var qExists 			= "">
		<cfset var compiler			= variables.config.getConfigBean().getCompiler() />

		<cfset application.appInitialized=false />

		<cfset setExtensions() />

		<cftry>
			<cfquery name="qExists" datasource="#dsn#" username="#dsnusername#"  password="#dsnpassword#" maxrows="1">
				SELECT count(1) as idexists
				FROM	#dsnprefix#mmc_paymenttype
			</cfquery>

			<cfif qExists.recordCount>
				<!--- exist --->
				<cfreturn>
			</cfif>

			<cfcatch>
			</cfcatch>		
		</cftry>

		<cfif not isUserInRole("s2")>
			<cflocation url="./?ecode=3000" addtoken="false">
		</cfif>
		<cftry>
			<cfquery name="qExists" datasource="#dsn#" username="#dsnusername#"  password="#dsnpassword#" maxrows="1">
			<cfswitch expression="#dsntype#">
				<cfcase value="mysql">
					CREATE TABLE `mmc_testDSN` ( `test` CHAR(35) NOT NULL, PRIMARY KEY (`test`)) ENGINE = InnoDB;
				</cfcase>
				<cfcase value="mssql">
					CREATE TABLE [mmc_testDSN]([test] [nvarchar](35) NOT NULL) ON [PRIMARY]  			
				</cfcase>
			</cfswitch>
			</cfquery>

			<cfcatch type="database">
				<!--- combine the message and detail so we can check against the both as the CFML engines do not contain similar structures of information --->
				
				<cfset catch = cfcatch />
				<cfset msg = cfcatch.message & cfcatch.detail />
				
				<!--- check to see if the db is there --->
				<cfif FindNoCase( tablename, msg ) or FindNoCase( "00942", msg )>
					<cfset errorType = "database" />
				</cfif>
				
				<!--- check to see if it's a datasource error --->
				<cfif REFindNoCase( "datasource (.*?) doesn't exist", msg )
					OR REFindNoCase( "can't connect to datasource (.*?)", msg )
					OR FindNoCase( "Login failed", msg )
					OR FindNoCase( "Access denied", msg )>
					<cfset errorType = "datasource" />
				</cfif>
				<!--- check to see if it's a broken pipe error --->
				<cfif FindNoCase( "broken pipe", msg )>
					<cfset errorType = "brokenpipe" />
				</cfif>
				
				<!--- if an error is not caught then catch it anyways and log it to a file for review --->
				<cfif not len(errorType)>
					<cfset errorType = "unknown" />
				</cfif>
				<cfif errorType neq "database">
					<cfset error = true>
					<!---<cfset serviceFactory.getBean("ErrorManager").addError(event,cfcatch.message,errorType,cfcatch.errorcode,cfcatch.detail)>--->
				</cfif>
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
			<cfcatch type="any">
				<!--- if an error is not caught then catch it anyways and log it to a file for review --->
				<cfset errorType = "unknown" />
				<cfset error = true>
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
		</cftry>

		<cftry>
		<cfquery name="qExists" datasource="#dsn#" username="#dsnusername#"  password="#dsnpassword#" maxrows="1">
			DROP TABLE mmc_testDSN
		</cfquery>
		<cfcatch></cfcatch>
		</cftry>

		<cfif error>
			<cfreturn>
		</cfif>
		
		<!--- get selected DB type --->
		<cffile action="read" file="#expandPath("/plugins")#/#variables.config.getDirectory()#/install/db/#dsntype#.sql" variable="sql" />
		
		<cfset sql = replacenocase(sql,"||PRE||",dsnprefix,"all")>
			
		<cfswitch expression="#dsntype#">
			<cfcase value="mysql">
				<cfset aSql = ListToArray(sql, ';')>
				<!--- loop over items --->
	            <cfloop index="iiX" from="1" to="#arrayLen(aSql) - 1#">
		            <!--- we placed a small check here to skip empty rows --->
		            <cfif len( trim( aSql[iiX] ) )>
		            	<cfquery datasource="#dsn#" username="#dsnusername#" password="#dsnpassword#">
		                    #keepSingleQuotes(aSql[iiX])#
		                </cfquery>
					
		                <!---<cfquery datasource="#dsn#" username="#dsnusername#" password="#dsnpassword#">
		                    #keepSingleQuotes(aSql[iiX])#
		                </cfquery>--->
	                </cfif>
	            </cfloop>
			</cfcase>
			<cfcase value="mssql">
				<cfset aSql = ListToArray(sql, ';')>
				<!--- loop over items --->
	            <cfloop index="iiX" from="1" to="#arrayLen(aSql) - 1#">
		            <!--- we placed a small check here to skip empty rows --->
		            <cfif len( trim( aSql[iiX] ) )>
		            	<cfquery datasource="#dsn#" username="#dsnusername#" password="#dsnpassword#">
		                    #keepSingleQuotes(aSql[iiX])#
		                </cfquery>
	                </cfif>
	            </cfloop>
			</cfcase>
		</cfswitch>
		
		<cfif error>
			<cfreturn>
		</cfif>
	</cffunction>

	<cffunction name="keepSingleQuotes" returntype="string" output="false">
		<cfargument name="str">
		<cfreturn preserveSingleQuotes(arguments.str)>
	</cffunction>
	
	<cffunction name="update" returntype="void" access="public" output="false">
		<cfset application.appInitialized=false />
		<cfset setExtensions() />
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" output="false">

	</cffunction>

	<cffunction name="setExtensions" returntype="void" access="private" output="false">

		<cfset var extension	= "" />
		<cfset var extendSet	= "" />
		<cfset var extendSetID	= "" />
		<cfset var sArgs		= StructNew() />
		<cfset var qSites		= variables.config.getAssignedSites() />

		<cfset extension		= addExtension( 'default','Page','Product' ) />

		<cfif not isSimpleValue( extension )>
			<cfset extendSet		= addExtendSet( 'default','default',extension.getSubTypeID()  ) />
			<cfset extendSetID		= extendSet.getExtendSetID() />
		
			<cfset addAttribute( 'default',extendSetID,1,'useQuantity','Use Quantity',false,1,'','','','SelectBox','0^1','No^Yes' ) />
			<cfset addAttribute( 'default',extendSetID,2,'price','Price',true,'0.00','Numeric' ) />
			<cfset addAttribute( 'default',extendSetID,3,'productType','Product Type',false,'','Regex','^[a-zA-Z0-9_]*$','Product Type can only contain letters and/or numbers; no spaces or punctuation' ) />
			<cfset addAttribute( 'default',extendSetID,4,'shipping','Shipping',false,'0.00','Numeric' ) />
			<cfset addAttribute( 'default',extendSetID,5,'tax','Tax',false,'0.00','Numeric' ) />
			<cfset addAttribute( 'default',extendSetID,6,'discount','Discount',false,'0.00','Numeric' ) />
		</cfif>
	
		<cfloop query="qSites">
			<cfif siteID neq "default">
				<cfset variables.instance.extensionManager.syncDefinitions( 'default',siteID,'Page','Product' ) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="addExtension" returntype="any" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="Type" type="string" required="true">
		<cfargument name="subType" type="string" required="false" default="Default">
		<cfargument name="BaseKeyField" type="string" required="false" default="contentHistID">
		<cfargument name="BaseTable" type="string" required="false" default="tcontent">
		<cfargument name="DataTable" type="string" required="false" default="tclassextenddata">

		<cfset var sExtension	= variables.instance.extensionManager.getSubTypeByName( arguments.type,arguments.subType,arguments.siteID )>
		<Cfset var qSets		= sExtension.getSetsQuery() />
		
		<cfif qSets.recordCount>
			<!--- already exists --->
			<cfreturn "" />
		</cfif>

		<cfset sExtension.setType(arguments.Type)>
		<cfset sExtension.setSubType(arguments.subType)>
		<cfset sExtension.setIsActive(1)>
		<cfset sExtension.setBaseKeyField(arguments.baseKeyField)>
		<cfset sExtension.setBaseTable(arguments.baseTable)>
		<cfset sExtension.setDataTable(arguments.dataTable)>
		<cfset sExtension.setSiteID(arguments.siteID)>
		
		<cfset sExtension.save()>

		<cfreturn sExtension />
	</cffunction>

	<cffunction name="addAttribute" returntype="any" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="extendSetID" type="string" required="true">
		<cfargument name="orderNo" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="label" type="string" required="true">
		<cfargument name="required" type="string" required="true">
		<cfargument name="defaultValue" type="string" required="false" default="">
		<cfargument name="validation" type="string" required="false" default="">
		<cfargument name="regex" type="string" required="false" default="">
		<cfargument name="message" type="string" required="false" default="">
		<cfargument name="type" type="string" required="false" default="TextBox">
		<cfargument name="optionList" type="string" required="false" default="">
		<cfargument name="optionLabelList" type="string" required="false" default="">

		<cfset var sAttribute = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean().getattributeBean()>

		<cfset sAttribute.setSiteID(arguments.siteID)>
		<cfset sAttribute.setExtendSetID(arguments.extendSetID)>
		<cfset sAttribute.setName(arguments.name)>
		<cfset sAttribute.setLabel(arguments.label)>
		<cfset sAttribute.setRequired(arguments.required)>
		<cfset sAttribute.setValidation(arguments.validation)>
		<cfset sAttribute.setRegex(arguments.regex)>
		<cfset sAttribute.setMessage(arguments.message)>
		<cfset sAttribute.setType(arguments.type)>
		<cfset sAttribute.setDefaultValue(arguments.defaultValue)>
		<cfset sAttribute.setOptionList(arguments.optionList)>
		<cfset sAttribute.setOptionLabelList(arguments.optionLabelList)>
		<cfset sAttribute.setOrderNo(arguments.orderno)>

		<cfset sAttribute.save()>
		
		<cfreturn sAttribute />
	</cffunction>

	<cffunction name="addExtendSet" returntype="any" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="subTypeID" required="true" type="string">
		<cfargument name="container" required="false" type="string" default="Basic">

		<cfset var sExtendSet = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean()>
		<cfset var attName = "">

		<cfset sExtendSet.setSubTypeID(arguments.subTypeID)>
		<cfset sExtendSet.setName(arguments.name)>
		<cfset sExtendSet.setOrderNo(0)>
		<cfset sExtendSet.setIsActive(1)>
		<cfset sExtendSet.setSiteID(arguments.siteID)>
		<cfset sExtendSet.setContainer( arguments.container )>
		<cfset sExtendSet.save()>
		
		<cfreturn sExtendSet />
	</cffunction>
</cfcomponent>
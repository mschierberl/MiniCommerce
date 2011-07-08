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
<cfcomponent displayname="MeldMiniCommerceManager" output="false" hint="Main Manager">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldMiniCommerceManager" access="public" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsnprefix" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dsnusername = arguments.dsnusername>
		<cfset variables.dsnpassword = arguments.dsnpassword>
		<cfset variables.dsnprefix = arguments.dsnprefix>
		<cfset variables.dsntype = arguments.dsntype>
		<cfreturn this />

		<cfreturn this>
	</cffunction>

	<cffunction name="getDisplayURL" returntype="string" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="page" type="any" required="true" default="checkout" />
		
		<cfset var contentRenderer		= $.getContentRenderer() /> 
		<cfset var redirectURL			= "" /> 
		<cfset var GlobalConfig 		= getMuraManager().getServiceFactory().getBean('configBean') />
		
		<cfquery name="qList" datasource="#GlobalConfig.getDatasource()#" username="#GlobalConfig.getDBUsername()#" password="#GlobalConfig.getDBPassword()#" maxrows="1">
			SELECT
				tcontent.filename
			FROM
				tcontent
			JOIN
				tcontentobjects
			ON
				(tcontent.contentID = tcontentobjects.contentID)
			JOIN
				tplugindisplayobjects
			ON
				(tcontentobjects.objectID = tplugindisplayobjects.objectID)	
			JOIN
				tplugins
			ON
				(tplugindisplayobjects.moduleID = tplugindisplayobjects.moduleID)	
			WHERE
				tcontent.active = 1
			AND
				tcontentobjects.name = <cfqueryparam value="#arguments.page#" CFSQLType="cf_sql_varchar" maxlength="35" />
		</cfquery>
		
		<cfif qList.RecordCount>
			<cfset redirectURL = $.getContentRenderer().getURLStem( $.event().getValue('siteID'),qList.fileName ) />
		</cfif>

		<cfreturn redirectURL />
	</cffunction>

	<cffunction name="getCartURL" returntype="string" access="public" output="false">
		<cfargument name="$" type="any" required="true" />

		<cfreturn getDisplayURL( $,'Cart' ) />
	</cffunction>

	<cffunction name="getCheckoutURL" returntype="string" access="public" output="false">
		<cfargument name="$" type="any" required="true" />

		<cfreturn getDisplayURL( $,'Checkout' ) />
	</cffunction>


	<cffunction name="getCart" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="doProducts" type="boolean" required="true" default="true" />
		
		<cfset var cartService		= getBeanFactory().getBean('cartService') />
		<cfset var sessionCartID	= getPluginConfig().getSession().getValue( 'cartID' ) />
		<cfset var cartBean			= "" />
		<cfset var sArgs			= StructNew() />

		<cfset sArgs.siteID			= $.event().getValue('siteID') />
		<cfset sArgs.isActive		= 1 />
		<cfset sArgs.doProducts		= doProducts />

		<cfif len(sessionCartID)>
			<cfset sArgs.cartID	= sessionCartID />
		</cfif>
		<cfif $.currentUser().isLoggedIn()>
			<cfset sArgs.userID	= $.currentUser().getUserID() />
		</cfif>

		<cfset cartBean		= cartService.getActiveCart( argumentCollection=sArgs ) />

		<cfif not len( sessionCartID ) or cartBean.getCartID() neq sessionCartID>
			<cflock scope="Session" timeout="15">
				<cfset getPluginConfig().getSession().setValue( 'cartID',cartBean.getCartID() ) />
			</cflock>  
		</cfif>

		<cfif cartBean.beanExists()
			and not cartBean.isEmpty()
			and $.currentUser().isLoggedIn()
			and not len( cartBean.getUserID() )>
			<cfset cartBean.setUserID( $.currentUser().getUserID() )>
			<cfset cartService.updateCart( cartBean ) />			
		</cfif>

		<cfreturn cartBean />
	</cffunction>

	<cffunction name="getCartID" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		
		<cfset var miniCommerceManager	= getBeanFactory().getBean('MeldMiniCommerceManager') />
		<cfset var sessionCartID	= getPluginConfig().getSession().getValue( 'cartID' ) />
		<cfset var cartBean			= "" />
		<cfset var sArgs			= StructNew() />

		<cfset cartBean		= getCart( $,false ) />

		<cfreturn cartBean.getCartID() />
	</cffunction>

	<cffunction name="getDashboard" returntype="Struct" access="public" output="false">

		<cfset var sStats				= StructNew() />
		<cfset var qList				= "" />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				COUNT(cartID) as activeCarts
			FROM	#variables.dsnprefix#mmc_cart
			WHERE
				dateCreate >= #dateAdd("d",-1,CreateODBCDateTime(now()))#
			AND
				isActive = 1
		</cfquery>

		<cfset sStats.activeCarts = qList.activeCarts />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				COUNT(cartID) as activeCarts
			FROM	#variables.dsnprefix#mmc_cart
			WHERE
				dateLastUpdate >= #dateAdd("d",-1,CreateODBCDateTime(now()))#
			AND
				isActive = 1
		</cfquery>
		<cfset sStats.activeCarts		= qList.activeCarts />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				COUNT(cartID) as closedCarts
			FROM	#variables.dsnprefix#mmc_cart
			WHERE
				dateLastUpdate >= #dateAdd("d",-1,CreateODBCDateTime(now()))#
			AND
				isCompleted = 1
		</cfquery>
		<cfset sStats.closedCarts		= qList.closedCarts />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				COUNT(cartID) as addedProducts
			FROM	#variables.dsnprefix#mmc_cartproduct
			WHERE
				dateLastUpdate >= #dateAdd("d",-1,CreateODBCDateTime(now()))#
		</cfquery>
		<cfset sStats.addedProducts		= qList.addedProducts />

		<cfreturn sStats>
	</cffunction>

	<cffunction name="getStates" returntype="query" access="public" output="false">

		<cfset var qList	= "" />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				name,value
			FROM	#variables.dsnprefix#mmc_location
			WHERE	locationType='state'
			ORDER BY orderNo
		</cfquery>

		<cfreturn qList>
	</cffunction>

	<cffunction name="getCountries" returntype="query" access="public" output="false">

		<cfset var qList	= "" />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				name,value
			FROM	#variables.dsnprefix#mmc_location
			WHERE	locationType='country'
			ORDER BY orderNo
		</cfquery>

		<cfreturn qList>
	</cffunction>

	<cffunction name="getAddress" returntype="query" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="type" type="any" required="true" />

		<cfset var userManager	= $.getBean('userManager') />
		<cfset var qAddresses	= $.currentUser().getUserBean().getAddresses() />	

		<cfset var qTypeAddress	= "" />
		<cfset var AddressBean	= "" />
		
		<cfset var sArgs		= StructNew() />
		
		<cfif qAddresses.recordCount>
			<cfquery name="qTypeAddress" dbtype="query" maxrows="1">
				SELECT
					*
				FROM
					qAddresses
				WHERE
					addressname = <cfqueryparam value="#arguments.type#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfquery>
				
			<cfif qTypeAddress.recordCount>
				<cfreturn qTypeAddress  />			
			<cfelse>
				<cfreturn qAddresses />			
			</cfif>
		<cfelse>
			<cfreturn qAddresses>
		</cfif>
	</cffunction>

	<cffunction name="getMessage" returntype="string" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="cartBean" type="any" required="true">
		<cfargument name="userBean" type="any" required="true">
		<cfargument name="transactionBean" type="any" required="true">
		<cfargument name="paymentTypeBean" type="any" required="true">
		<cfargument name="type" type="string" required="true">

		<cfset var strOut			= "" />

		<cfset var cartProductBean	= "" />
		<cfset var iiX				= "" />

		<cfset var sProducts		= arguments.cartBean.getProducts() />
		<cfset var siteConfig		= $.siteConfig() />
		<cfset var customPath 		= "/" & session.siteID & "/includes/display_objects/custom/meldminicommerce/" />
		<cfset var local			= StructNew() />
		<cfset var address			= getAddress($,"Billing") />

		<cfsilent>
		<cfsavecontent variable="strOut">
		<cfswitch expression="#arguments.type#">		
			<cfcase value="receiptMessage">
				<cfif fileExists( customPath & "notify_receiptmessage.cfm")>
					<cfinclude template="#customPath#notify_receiptmessage.cfm">
				<cfelse>
					<cfinclude template="/MeldMiniCommerce/includes/include_receiptmessage.cfm">
				</cfif>
			</cfcase>
			<cfcase value="receiptSubject">
				<cfif fileExists( customPath & "notify_receiptsubject.cfm")>
					<cfinclude template="#customPath#notify_receiptsubject.cfm">
				<cfelse>
					<cfinclude template="/MeldMiniCommerce/includes/include_receiptsubject.cfm">
				</cfif>
			</cfcase>
			<cfcase value="notifyMessage">
				<cfif fileExists( customPath & "notify_notifymessage.cfm")>
					<cfinclude template="#customPath#notify_notifymessage.cfm">
				<cfelse>
					<cfinclude template="/MeldMiniCommerce/includes/include_notifymessage.cfm">
				</cfif>
			</cfcase>
			<cfcase value="notifySubject">
				<cfif fileExists( customPath & "notify_notifysubject.cfm")>
					<cfinclude template="#customPath#notify_notifysubject.cfm">
				<cfelse>
					<cfinclude template="/MeldMiniCommerce/includes/include_notifysubject.cfm">
				</cfif>
			</cfcase>
			<cfcase value="displayMessage">
				<cfif fileExists( customPath & "notify_displaymessage.cfm")>
					<cfinclude template="#customPath#notify_displaymessage.cfm">
				<cfelse>
					<cfinclude template="/MeldMiniCommerce/includes/include_displaymessage.cfm">
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="You did not specify a type of: receiptMessage,receiptSubject,notifyMessage,notifySubject,displayMessage" />
			</cfdefaultcase>
		</cfswitch>
		</cfsavecontent>
		</cfsilent>
		<cfreturn trim(strOut)>
	</cffunction>

	<cffunction name="sendReceipt" returntype="string" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="cartBean" type="any" required="true" />
		<cfargument name="userBean" type="any" required="true" />
		<cfargument name="transactionBean" type="any" required="true" />
		<cfargument name="paymentTypeBean" type="any" required="true" />

		<cfset var pluginManager	= $.getBean('PluginManager') />
		<cfset var pluginEvent		= $.getBean("MuraScope") />
		<cfset var sArgs 			= StructNew() />
		<cfset var mailer			= $.getBean("mailer") />
		<cfset var siteConfig		= $.siteConfig() />
		<cfset var aNotifyEmail		= ArrayNew(1) />

		<cfset var receiptSubject	= "" />
		<cfset var receiptMessage	= "" />
		<cfset var notifySubject	= "" />
		<cfset var notifyMessage	= "" />
		<cfset var displayMessage	= "" />

		<cfset sArgs.$		 			= $ />
		<cfset sArgs.cartBean 			= cartBean />
		<cfset sArgs.userBean 			= userBean />
		<cfset sArgs.transactionBean	= transactionBean />
		<cfset sArgs.paymentTypeBean	= PaymentTypeBean />

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />

		<cfset pluginEvent.setValue('siteID',cartBean.getSiteID() ) />

		<cfset pluginEvent.setValue('sentReceipt',false ) />
		<cfset pluginEvent.setValue('receiptSubject',"" ) />
		<cfset pluginEvent.setValue('receiptMessage',"" ) />
		<cfset pluginEvent.setValue('pageMessage',"" ) />
		<cfset pluginEvent.setValue('notifySubject',"" ) />
		<cfset pluginEvent.setValue('notifyMessage',"" ) />

		<cfset pluginEvent.setValue('fromEmail',siteConfig.getContactEmail() ) />
		<cfset pluginEvent.setValue('notifyEmail',siteConfig.getContactEmail() ) />
		<cfset pluginEvent.setValue('userBean',sArgs.userBean ) />
		<cfset pluginEvent.setValue('cartBean',sArgs.cartBean ) />
		<cfset pluginEvent.setValue('transactionBean',sArgs.transactionBean ) />
		<cfset pluginEvent.setValue('paymentTypeBean',sArgs.paymentTypeBean ) />

		<!--- SEND RECEIPT! --->
		<cfset pluginManager.announceEvent("onMeldMiniCommerceSendReceipt",pluginEvent) />

		<cfif len( pluginEvent.getValue('receiptSubject') )>
			<cfset receiptSubject =pluginEvent.getValue('receiptSubject') />
		<cfelse>
			<cfset sArgs.type = "receiptSubject" />
			<cfset receiptSubject = getMessage( argumentCollection=sArgs ) />
		</cfif>
		<cfif len( pluginEvent.getValue('receiptMessage') )>
			<cfset receiptMessage =pluginEvent.getValue('receiptMessage') />
		<cfelse>
			<cfset sArgs.type = "receiptMessage" />
			<cfset receiptMessage = getMessage( argumentCollection=sArgs ) />
		</cfif>

		<cfif len( pluginEvent.getValue('notifySubject') )>
			<cfset notifySubject =pluginEvent.getValue('notifySubject') />
		<cfelse>
			<cfset sArgs.type = "notifySubject" />
			<cfset notifySubject = getMessage( argumentCollection=sArgs ) />
		</cfif>
		<cfif len( pluginEvent.getValue('notifyMessage') )>
			<cfset notifyMessage =pluginEvent.getValue('notifyMessage') />
		<cfelse>
			<cfset sArgs.type = "notifyMessage" />
			<cfset notifyMessage = getMessage( argumentCollection=sArgs ) />
		</cfif>

		<cfif len( pluginEvent.getValue('displayMessage') )>
			<cfset displayMessage =pluginEvent.getValue('displayMessage') />
		<cfelse>
			<cfset sArgs.type = "displayMessage" />
			<cfset displayMessage = getMessage( argumentCollection=sArgs ) />
		</cfif>

		<cfif pluginEvent.getValue('sentReceipt') eq false>
			<cftry>
			<cfset mailer.sendHTML(receiptMessage,
				userBean.getEmail(),
				siteConfig.getContactName(),
				receiptSubject,
				cartBean.getSiteID(),
				pluginEvent.getValue('fromEmail') ) />
			<cfcatch>
				<!--- TODO MURA ERROR: MAIL INFO --->
			</cfcatch>
			</cftry>
		</cfif>

		<cfif isSimpleValue( pluginEvent.getValue('notifyEmail') ) and len( pluginEvent.getValue('notifyEmail') )>
			<cfset aNotifyEmail	= ArrayNew(1) />
			<cfset ArrayAppend( aNotifyEmail,pluginEvent.getValue('notifyEmail') ) />	
 		<cfelseif isArray( pluginEvent.getValue('notifyEmail') )>
			<cfset aNotifyEmail = pluginEvent.getValue('notifyEmail') />
		</cfif>		

		<cfif ArrayLen( aNotifyEmail )>
			<cfloop from="1" to="#ArrayLen( aNotifyEmail )#" index="iiX">
				<cftry>
				<cfset mailer.sendHTML(notifyMessage,
					aNotifyEmail[iiX],
					siteConfig.getContactName(),
					notifySubject,
					cartBean.getSiteID(),
					pluginEvent.getValue('fromEmail') ) />
				<cfcatch>
					<!--- TODO MURA ERROR: MAIL INFO --->
				</cfcatch>
				</cftry>
			</cfloop>
		</cfif>
		
		<cfreturn displayMessage />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>

	<cffunction name="setMuraManager" access="public" returntype="any" output="false">
		<cfargument name="MuraManager" type="any" required="true">
		<cfset variables.MuraManager = arguments.MuraManager>
	</cffunction>
	<cffunction name="getMuraManager" access="public" returntype="any" output="false">
		<cfreturn variables.MuraManager>
	</cffunction>

	<cffunction name="setPluginConfig" access="public" returntype="any" output="false">
		<cfargument name="PluginConfig" type="any" required="true">
		<cfset variables.PluginConfig = arguments.PluginConfig>
	</cffunction>
	<cffunction name="getPluginConfig" access="public" returntype="any" output="false">
		<cfreturn variables.PluginConfig>
	</cffunction>

	<cffunction name="setBeanFactory" access="public" returntype="any" output="false">
		<cfargument name="BeanFactory" type="any" required="true">
		<cfset variables.BeanFactory = arguments.BeanFactory>
	</cffunction>
	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.BeanFactory>
	</cffunction>


</cfcomponent>
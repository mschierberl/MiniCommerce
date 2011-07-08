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
<cfcomponent displayname="MeldMiniCommerceEventManager" output="false" hint="Main Manager">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldMiniCommerceEventManager" access="public" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="getCartID" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		
		<cfreturn getMeldMiniCommerceManager().getCartID( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="emptyCart" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		
		<cfset var cartService	= getBeanFactory().getBean('cartService') />
		<cfset var cartID		= getCartID( $ ) />

		<cfset cartBean		= cartService.emptyCart( cartID ) />
	</cffunction>

	<cffunction name="getCart" returntype="any" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		
		<cfreturn getMeldMiniCommerceManager().getCart( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="renderProductForm" returntype="any" access="public" output="false">
		<cfargument name="$">

		<cfset var productType			= $.content().getValue("productType") />
		<cfset var customPath			= "" />
		<cfset var strOut				= "" />

		<cfset var pluginEvent 			= createObject("component","mura.MuraScope") />
		<cfset var pluginManager		= $.getBean('pluginManager') />
		<cfset var mmRBF				= getBeanFactory().getBean('mmResourceBundle') />

		<cfset var local				= StructNew() />
		<cfset var cartProductService 	= getBeanFactory().getBean('cartProductService') />
		<cfset var cartProductBean		= "" />


		<cfif structKeyExists( url,"cartProductID" )>
			<cftry>
				<cfset cartProductBean = cartProductService.getCartproduct( url.cartProductID ) />
				<cfset $.event().setValue('cartProductBean',cartProductBean) />
			<cfcatch></cfcatch>
			</cftry>
		</cfif>

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue('contentBean',$.content() ) />
		<cfset pluginEvent.setValue('userBean',$.currentUser().getUserBean() ) />
		<cfset pluginEvent.setValue('siteID',session.siteID ) />

		<cfset strOut = application.pluginManager.renderEvent("onMeldMiniCommerceRenderProduct",pluginEvent)>

		<cfif len( strOut )>
			<cfreturn strOut />
		</cfif>

		<cfif len( productType )>
			<cfset customPath = "/" & session.siteID & "/includes/display_objects/custom/meldminicommerce/product_#lcase(productType)#.cfm" />
			<cfif fileExists( expandPath( customPath ) )>
				<cfsavecontent variable="strOut">
					<cfinclude template="#customPath#">
				</cfsavecontent>
			</cfif>
		</cfif>
		
		<cfif not len( strOut )>
			<cfset customPath = "/MeldMiniCommerce/includes/product_default.cfm" /> 
			<cfsavecontent variable="strOut">
				<cfinclude template="#customPath#">
			</cfsavecontent>
		</cfif>
		
		<cfreturn strOut />
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn getMeldMiniCommerceManager().getBeanFactory()>
	</cffunction>

	<cffunction name="getPluginConfig" access="public" returntype="any" output="false">
		<cfreturn getMeldMiniCommerceManager().getPluginConfig()>
	</cffunction>

	<cffunction name="setMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfargument name="MeldMiniCommerceManager" type="any" required="true">
		<cfset variables.MeldMiniCommerceManager = arguments.MeldMiniCommerceManager>
	</cffunction>
	<cffunction name="getMeldMiniCommerceManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldMiniCommerceManager>
	</cffunction>
</cfcomponent>
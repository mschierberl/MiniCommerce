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
<cfcomponent extends="MeldMiniCommerce.com.meldsolutions.mura.MuraEventHandler">

	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">

		<cfset var state=preseveInternalState(request)>
		<cfset var appreloadKey = $.GlobalConfig().getValue('appreloadKey') />

		<cfif len( appreloadKey ) and structKeyExists(url,appreloadKey)> 
			<cfset url[variables.framework.reload] = true />
		</cfif>

		<!--- invoke onApplicationStart in the application.cfc so the framework can do its thing --->
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onApplicationStart" />
		<cfset restoreInternalState(request,state)>

		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<cffunction name="onAdminModuleNav">
		<cfargument name="$">

		<cfif structKeyExists(session,"MeldMiniCommerceAppreinit")>
			<cfset structDelete(session,"MeldMiniCommerceAppreinit") />
			<cfif not StructKeyExists(url,"appreload")>
				<cflocation url="./?appreload&reload=appreload" addtoken="false">
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="onGlobalSessionStart" output="false">
		<cfargument name="$" required="true" hint="mura scope" />
		<cfset var state=preseveInternalState(request)>
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onSessionStart" />
		<cfset restoreInternalState(request,state)>
	</cffunction>
	
	<cffunction name="onSiteRequestStart">
		<cfargument name="$">
	</cffunction>

	<cffunction name="onMeldMiniCommerceAddProduct" output="false" returntype="void">
		<cfargument name="$">

		<cfset var pluginEvent 		= createObject("component","mura.MuraScope") />
		<cfset var pluginManager	= $.getBean('pluginManager') />

		<cfset var beanFactory		= pluginConfig.getApplication().getValue('beanFactory')>
		<cfset var mcProductManager	= beanFactory.getBean('MeldMiniCommerceProductManager') />
		<cfset var cartEventManager	= beanFactory.getBean('MeldMiniCommerceEventManager') />
		<cfset var cartID			= cartEventManager.getCartID( $ ) />

		<cfset var productBean		= "" />
		<cfset var cartProductBean	= "" />

		<cfif $.event().valueExists('productBean')>
			<cfset productBean		= $.event().getValue('productBean' ) />
		<cfelse>
			<cfset productBean		= mcProductManager.createProduct( $.event().getAllValues() ) />
		</cfif>

		<cfif productBean.getIsValid()>
			<cfset cartProductBean = mcProductManager.addProduct( cartID,productBean,$.currentUser().getUserBean(),$.event() ) />
		</cfif>

		<cfif isObject( cartProductBean )>
			<cfset $.event().setValue('CartProductBean',CartProductBean ) />
			<cfset $.event().setValue('MeldMiniCommerceProductAdded',true ) />
			
			<!--- announce separate 'product added' event --->
			<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
			<cfset pluginEvent.setValue('userID',$.currentUser().getUserID() ) />
			<cfset pluginEvent.setValue('cartID',cartID ) />
			<cfset pluginEvent.setValue('siteID',$.event().getValue('siteid') ) />
			<cfset pluginEvent.setValue('ProductBean',productBean ) />
			<cfset pluginEvent.setValue('CartProductBean',cartProductBean) />
			<cfset pluginManager.announceEvent("onMeldMiniCommerceProductAdded",pluginEvent)>
		</cfif>	
	</cffunction>

	<cffunction name="onMeldMiniCommerceUpdateProduct" output="false" returntype="void">
		<cfargument name="$">

		<cfset var pluginEvent 		= createObject("component","mura.MuraScope") />
		<cfset var pluginManager	= $.getBean('pluginManager') />

		<cfset var beanFactory		= pluginConfig.getApplication().getValue('beanFactory')>
		<cfset var mcProductManager	= beanFactory.getBean('MeldMiniCommerceProductManager') />
		<cfset var cartEventManager	= beanFactory.getBean('MeldMiniCommerceEventManager') />
		<cfset var cartID			= cartEventManager.getCartID( $ ) />

		<cfset var productBean		= "" />
		<cfset var cartProductBean	= "" />

		<cfif not $.event().valueExists('cartProductID')>
			<cfreturn>
		</cfif>

		<cfif $.event().valueExists('productBean')>
			<cfset productBean		= $.event().getValue('productBean' ) />
		<cfelse>
			<cfset productBean		= mcProductManager.createProduct( $.event().getAllValues() ) />
		</cfif>


		<cfif productBean.getIsValid()>
			<cfset cartProductBean = mcProductManager.updateProduct( cartID,productBean,cartProductID,$.currentUser().getUserBean(),$.event() ) />
		</cfif>

		<cfif isObject( cartProductBean )>
			<cfset $.event().setValue('CartProductBean',CartProductBean ) />
			<cfset $.event().setValue('MeldMiniCommerceProductAdded',true ) />
			
			<!--- announce separate 'product added' event --->
			<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
			<cfset pluginEvent.setValue('userID',$.currentUser().getUserID() ) />
			<cfset pluginEvent.setValue('cartID',cartID ) />
			<cfset pluginEvent.setValue('siteID',$.event().getValue('siteid') ) />
			<cfset pluginEvent.setValue('ProductBean',productBean ) />
			<cfset pluginEvent.setValue('CartProductBean',cartProductBean) />
			<cfset pluginManager.announceEvent("onMeldMiniCommerceProductAdded",pluginEvent)>
		</cfif>	
	</cffunction>

	<cffunction name="onMeldMiniCommerceRemoveProduct" output="false" returntype="void">
		<cfargument name="$">

		<cfset var beanFactory			= pluginConfig.getApplication().getValue('beanFactory')>
		<cfset var cartService			= beanFactory.getBean('cartService') />

		<cfset var pluginEvent 			= createObject("component","mura.MuraScope") />
		<cfset var pluginManager		= $.getBean('pluginManager') />
		<cfset var cartProductService	= beanFactory.getBean('cartProductService') />
		<cfset var cartEventManager		= beanFactory.getBean('MeldMiniCommerceEventManager') />

		<cfset var cartID				= cartEventManager.getCartID( $ ) />
		<cfset var cartProductID		= "" />

		<cfif $.event().valueExists( 'cartProductID' ) and len( $.event().getValue( 'cartProductID' ) )>
			<cfset cartProductID = $.event().getValue( 'cartProductID' ) />
			<cfset cartProductService.deleteCartproduct( cartProductID ) />

			<!--- announce separate 'product removed' event --->
			<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
			<cfset pluginEvent.setValue('userID',$.currentUser().getUserID() ) />
			<cfset pluginEvent.setValue('cartID',cartID ) />
			<cfset pluginEvent.setValue('siteID',$.event().getValue('siteid') ) />
			<cfset pluginEvent.setValue('cartProductID',cartProductID ) />
			<cfset pluginManager.announceEvent("onMeldMiniCommerceProductRemoved",pluginEvent)>
		</cfif>
	</cffunction>

	<cffunction name="onMeldMiniCommerceGetCart" output="false" returntype="void">
		<cfargument name="$">

		<cfset var beanFactory			= pluginConfig.getApplication().getValue('beanFactory')>
		<cfset var cartService			= beanFactory.getBean('cartService') />

		<cfset var pluginEvent 			= createObject("component","mura.MuraScope") />
		<cfset var pluginManager		= $.getBean('pluginManager') />
		<cfset var cartProductService	= beanFactory.getBean('cartProductService') />
		<cfset var cartEventManager		= beanFactory.getBean('MeldMiniCommerceEventManager') />
		<cfset var cartProductManager	= beanFactory.getBean('MeldMiniCommerceProductManager') />

		<cfif not $.event().valueExists('cartBean')>
			<cfset cartBean = cartEventManager.getCart( $ ) />
		<cfelse>
			<cfset cartBean = $.event().getValue('cartBean') />
		</cfif>

		<cfif structCount( cartBean.getProducts() )>
			<!--- announce onMeldMiniCommerceRequestProductInfo to get product Information --->
			<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
			<cfset pluginEvent.setValue('siteID',$.event().getValue('siteID') ) />
			<cfif not len( cartBean.getUserID() )>
				<cfset pluginEvent.setValue('userID',$.currentUser().getUserID() ) />
			<cfelse>
				<cfset pluginEvent.setValue('userID',cartBean.getUserID() ) />
			</cfif>
			<cfset pluginEvent.setValue('cartID',cartBean.getCartID() ) />
			<cfset pluginEvent.setValue('siteID',$.event().getValue('siteid') ) />
			<cfset pluginEvent.setValue('cartBean',cartBean ) />
			<cfset pluginEvent.setValue('moduleIDs',cartBean.getModuleIDs() ) />
			<cfset pluginEvent.setValue('productIDs',cartBean.getProductIDs() ) />

			<cfset pluginManager.announceEvent("onMeldMiniCommerceRequestProductInfo",pluginEvent)>

			<cfset pluginManager.announceEvent("onMeldMiniCommerceRequestShippingInfo",pluginEvent)>
			<cfset pluginManager.announceEvent("onMeldMiniCommerceRequestDiscountInfo",pluginEvent)>
			<cfset pluginManager.announceEvent("onMeldMiniCommerceRequestTaxInfo",pluginEvent)>
		</cfif>

		<cfset cartProductManager.updatePricing( cartBean ) />
		<cfset $.event().setValue('cartBean',cartBean) />
	</cffunction>

	<cffunction name="onRenderStart" output="false" returntype="string">
		<cfargument name="$">

		<cfset var beanFactory			= variables.pluginConfig.getApplication().getValue('beanFactory')>
		<cfset var cartManager			= "" />
		<cfset var cartEventManager		= "" />
		<cfset var cartProductManager	= "" />
		<cfset var mmFormTools			= "" />
		<cfset var pluginEvent 			= "" />
		<cfset var pluginManager		= "" />
		<cfset var customPath			= "" />
		<cfset var data					= Structnew() />
		<cfset var sForm				= Structnew() />
		<cfset var contentBean			= "" />

		<cfif isSimpleValue( beanFactory ) or $.content().getSubType() neq "Product">
			<cfreturn>
		</cfif>
		
		<cfif structCount(form) and structKeyExists(form,"productID")>
			<cfset pluginEvent 				= createObject("component","mura.MuraScope") />
			<cfset pluginManager			= $.getBean('pluginManager') />
			<cfset cartManager				= beanFactory.getBean("MeldMiniCommerceManager") />
			<cfset cartEventManager			= beanFactory.getBean("MeldMiniCommerceEventManager") />
			<cfset cartProductManager		= beanFactory.getBean("MeldMiniCommerceProductManager") />
			<cfset mmFormTools				= beanFactory.getBean("mmFormTools") />

			<cfset sForm			= mmFormTools.scopeFormSubmission( form ) />
			<cfset data				= sForm.mm_global />
			<cfset data.moduleID	= $.content().getModuleID() />
			<cfset data.name		= $.content().getTitle() />
			<cfset data.price		= $.content().getValue('price') />
			
			<cfif not structKeyExists(data,"quantity")>
				<cfset data.quantity = 1 />
			</cfif>
			<cfif structKeyExists(sForm,"attributes")>
				<cfset data['attributes']	= sForm.attributes />
			</cfif> 

			<cfset productBean = cartProductManager.createProduct( data,$.event() ) />


			<cfif productBean.getIsValid()>
				<cfset pluginEvent=pluginEvent.init( StructNew() ).getEvent()>
				<cfset pluginEvent.setValue('siteID',$.event().getValue('siteid') ) />
				<cfset pluginEvent.setValue('productBean',productBean) />
			</cfif>
		
			<cfif structKeyExists(form,"addProduct")>
				<cfset pluginManager.announceEvent("onMeldMiniCommerceAddProduct",pluginEvent)>
				<cfif pluginEvent.valueExists('cartProductBean')>
					<cfset $.event().setValue('cartProductBean',pluginEvent.getValue('cartProductBean') ) />
					<cfset $.event().setValue('MeldMiniCommerceProductAdded',true ) />
				</cfif>
			<cfelseif structKeyExists(form,"updateProduct") and  structKeyExists(form,"cartProductID")>
				<cfset pluginEvent.setValue('cartProductID',form.cartProductID ) />
				<cfset pluginManager.announceEvent("onMeldMiniCommerceUpdateProduct",pluginEvent)>
				
				<cfif pluginEvent.valueExists('cartProductBean')>
					<cfset $.event().setValue('cartProductBean',pluginEvent.getValue('cartProductBean') ) />
					<cfset $.event().setValue('MeldMiniCommerceProductUpdated',true ) />
				</cfif>
				<cflocation url="#cartManager.getDisplayURL( $,'Cart' )#" addtoken="false" />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="onPageProductBodyRender" output="false" returntype="string">
		<cfargument name="$">

		<cfset var beanFactory			= pluginConfig.getApplication().getValue('beanFactory')>
		<cfset var cartProductManager	= beanFactory.getBean("MeldMiniCommerceProductManager") />
		<cfset var cartEventManager		= beanFactory.getBean("MeldMiniCommerceEventManager") />

		<cfset var strHead				= "" />
		<cfset var strContent			= "" />
		<cfset var strOut				= "" />


		<cfsavecontent variable="strHead">
			<cfoutput><link rel="stylesheet" href="#$.globalConfig().getContext()#/plugins/#variables.pluginConfig.getDirectory()#/assets/css/base.css" type="text/css" media="screen" /></cfoutput>
		</cfsavecontent>

		<cfset strContent = cartEventManager.renderProductForm( $ ) />
		
		<cfif len( strContent )>
			<cfhtmlhead text="#strHead#">
			<cfsavecontent variable="strOut">
			<div class="meld-minicommerce-product clearfix">
			<cfif
				len($.content().getFileID()) 
				and $.content().getContentType() eq "Image" 
				and listFind("jpg,jpeg,gif,png",lcase($.content().getFileExt()))>
					<cfset $.loadShadowBoxJS() />
					<cfoutput>
					<a href="#$.globalConfig().getContext()#/tasks/render/file/?fileID=#$.content().getFileID()#&amp;ext=.#$.content().getFileExt()#" title="#HTMLEditFormat($.content().getMenuTitle())#" rel="shadowbox[body]" id="svAsset"><img src="#$.createHREFForImage($.event('siteID'),$.content().getFileID(),$.content().getFileEXT(),'medium')#" class="imgMed" alt="#HTMLEditFormat($.content().getMenuTitle())#" /></a>
					</cfoutput>	
			</cfif>
			<cfoutput>#strContent#</cfoutput>
			</div>
			<cfoutput>#$.dspMultiPageContent($.content('body'))#</cfoutput>
			</cfsavecontent>
			<cfreturn $.setDynamicContent(strOut) />
		</cfif>
	</cffunction>

	<cffunction name="onSiteRequestInit" output="false" returntype="void">
		<cfargument name="$">
		<cfset var beanFactory	= pluginConfig.getApplication().getValue('beanFactory') />
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false" access="private">
		<cfset var framework = StructNew() />

		<cfinclude template="../frameworkConfig.cfm" />

		<cfreturn framework />		
	</cffunction>
</cfcomponent>
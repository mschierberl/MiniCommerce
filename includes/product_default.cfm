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
<cfsilent>
	<!--- local is var safe! --->
	<cfparam name="local.quantity" default="1" />
	<cfset local.isAdded	= $.event().valueExists('MeldMiniCommerceProductAdded') />
	<cfset local.isUpdated	= $.event().valueExists('MeldMiniCommerceProductUpdated') />
	<cfset local.isUpdate	= false />

	<cfif $.event().valueExists('cartProductBean') and not local.isUpdated and not local.isAdded>
		<cfset local.isUpdate			= true />
		<cfset local.cartProductBean	= $.event().getValue('cartProductBean') />
		<cfset local.quantity			= local.cartProductBean.getQuantity() />
		<cfset local.attributes			= local.cartProductBean.getAttributes() />
		<cfset local.cartProductID		= local.cartProductBean.getCartProductID() />
	</cfif>
</cfsilent><cfoutput>

<div class="meld-minicommerce-product-form clearfix">
	<form method="post" action="./" class="meld-form">
	<input type="hidden" name="productID" value="#$.content('contentID')#">
	<cfif local.isAdded>
		<div class="meld-minicommerce-product-added">#mmRBF.key('productadded')#</div>
	<cfelseif local.isUpdated>
		<div class="meld-minicommerce-product-added">#mmRBF.key('productupdated')#</div>
	</cfif>
	<ul>
	<cfif $.content().getValue('useQuantity') eq true>
		<li>
			<label>#mmRBF.key('quantity')#</label>
			<input type="text" class="text small" value="#local.quantity#" name="quantity">
		</li>
	</cfif>
		<cfif $.content().getValue('discount') gt 0>
			<li class="price">
				<label>#mmRBF.key('price')#</label>
				<span>#lsCurrencyFormat( $.content().getValue('price') )#</span>
			</li>
			<li class="discount">
				<label>#mmRBF.key('discount')#</label>
				<span>#lsCurrencyFormat( -$.content().getValue('discount') )#</span>
			</li>
			<li class="total">
				<label>#mmRBF.key('now')#</label>
				<span>#lsCurrencyFormat( $.content().getValue('price')-$.content().getValue('discount') )#</span>
			</li>
		<cfelse>
			<li class="total">
				<label>#mmRBF.key('price')#</label>
				<span>#lsCurrencyFormat( $.content().getValue('price') )#</span>
			</li>
		</cfif>
		<li>
			<cfif local.isUpdate>
				<input type="hidden" name="CartProductID" value="#local.cartProductID#" />
				<button class="submit" name="updateProduct">#mmRBF.key('updateproduct')#</button>
			<cfelse>
				<button class="submit" name="addProduct">#mmRBF.key('addproduct')#</button>
			</cfif>
		</li>
	</table>
	</form>
</div>
</cfoutput>
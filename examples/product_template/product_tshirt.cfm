<cfsilent>
	<!--- local is var safe! --->
	<cfparam name="local.quantity"	default="1" />
	<cfparam name="local.color"		default="" />
	<cfparam name="local.size"		default="1" />

	<!--- the product has been added to the cart --->
	<cfset local.isAdded	= $.event().valueExists('MeldMiniCommerceProductAdded') />
	<!--- the product has been updated in the cart --->
	<cfset local.isUpdated	= $.event().valueExists('MeldMiniCommerceProductUpdated') />
	<!--- by default this is not a cart update --->
	<cfset local.isUpdate	= false />

	<!--- this is an update request --->
	<cfif $.event().valueExists('cartProductBean') and not local.isUpdated and not local.isAdded>
		<!--- this is a product update --->
		<cfset local.isUpdate			= true />
		<cfset local.cartProductBean	= $.event().getValue('cartProductBean') />
		<cfset local.quantity			= local.cartProductBean.getQuantity() />
		<cfset local.attributes			= local.cartProductBean.getAttributes() />
		<cfset local.cartProductID		= local.cartProductBean.getCartProductID() />

		<!--- custom attributes --->
		<cfset local.color				= local.cartProductBean.getAttribute('color') />
		<cfset local.size				= local.cartProductBean.getAttribute('size') />
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
		<li>
			<label>Color</label>
			<select name="attributes_color" id="attributes_color">
				<cfloop list="White,Black,Red,Blue,Green,Orange,Red" index="local.x">
					<option value="#local.x#" <cfif local.x eq local.color>SELECTED</cfif>>#local.x#</option>
				</cfloop>
			</select>
		</li>
		<li>
			<label>Size</label>
			<select name="attributes_size" id="attributes_size">
				<cfloop list="S,M,L,XL,XXL" index="local.x">
					<option value="#local.x#" <cfif local.x eq local.size>SELECTED</cfif>>#local.x#</option>
				</cfloop>
			</select>
		</li>

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
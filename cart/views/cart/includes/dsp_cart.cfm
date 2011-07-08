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
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc.cartBean	= rc.cartBean>
	<cfset local.rc.products	= rc.cartBean.getProducts() />
	
	<cfset local.hasProductShipping	= (rc.cartBean.getProductShippingTotal() gt 0)>
	<cfset local.hasProductTax		= (rc.cartBean.getProductTaxTotal() gt 0)>
	<cfset local.hasProductDiscount	= (rc.cartBean.getProductDiscountTotal() gt 0)>
	<cfset local.extraCols			= 0>
	<cfset local.useQuantity		= 0>

	<cfloop collection="#local.rc.products#" item="local.iiX">
		<cfif local.rc.products[local.iiX].getUseQuantity()>
			<cfset local.useQuantity = 1 />
			<cfbreak />
		</cfif>
	</cfloop>
	
</cfsilent>
<cfoutput>

<div class="meld-minicommerce-cart">
	<form method="post" action="./" class="meld-form" id="meld-form" onsubmit="validate(this);">
	<input type="hidden" name="mode" id="meld-form-mode" value="" />
	<table class="cart">
		<tr>
			<th class="varWidth">
				#rc.mmRBF.key('product')#
			</th>
			<cfif local.useQuantity>
			<cfset local.extraCols++>
			<th class="info">
				#rc.mmRBF.key('quantity')#
			</th>
			</cfif>
			<th class="info">
				#rc.mmRBF.key('price')#
			</th>
		<cfif local.hasProductShipping>
			<cfset local.extraCols++>
			<th class="info">
				#rc.mmRBF.key('shipping')#
			</th>
		</cfif>			
		<cfif local.hasProductTax>
			<cfset local.extraCols++>
			<th class="info">
				#rc.mmRBF.key('tax')#
			</th>
		</cfif>			
		<cfif local.hasProductDiscount>
			<cfset local.extraCols++>
			<th class="info discount">
				#rc.mmRBF.key('discount')#
			</th>
		</cfif>			
			<th class="values">
				&nbsp;
			</th>
		</tr>	
	<cfloop collection="#local.rc.products#" item="local.iiX">
		<cfset local.cartProduct	= local.rc.products[local.iiX]>
		<cfset local.isAdjusted		= (local.cartProduct.getSubTotal() neq local.cartProduct.getTotal())>
		<tr class="minicommerce-product">
			<td>
				<cfif len(local.cartProduct.getUrl())>
					<h5><a href="#local.cartProduct.getUrl()#">#local.cartProduct.getName()#</a></h5>
				<cfelse>
					<h5>#local.cartProduct.getName()#</h5>
				</cfif>
				<cfif len( local.cartProduct.getSummary() )>
				#local.cartProduct.getSummary()#
				</cfif>
				<cfif StructCount( local.cartProduct.getAttributesAsStruct() )>
					<cfset local.attributes = local.cartProduct.getAttributesAsStruct() />

					<ul class="attributes">
						<cfloop collection="#local.Attributes#" item="local.att">
						<li><strong>#local.att#: </strong> #local.Attributes[local.att]#</li>
						</cfloop>
					</ul>
				</cfif>
			</td>
			<cfif local.useQuantity>
			<td class="info gray">
				<input type="text" class="text tiny" name="quantity_#local.cartProduct.getCartProductID()#" value="#local.cartProduct.getQuantity()#"
					maxlength="5" required="true" validation="numeric" message="#rc.mmRBF.key('quantity','validate')#">
			</td>
			</cfif>
			<td class="info">
				#lsCurrencyFormat( local.cartProduct.getPrice() )#
			</td>
		<cfif local.hasProductShipping>
			<td class="info">
				#lsCurrencyFormat( local.cartProduct.getShipping() )#
			</td>
		</cfif>			
		<cfif local.hasProductTax>
			<td class="values">
				#lsCurrencyFormat( local.cartProduct.getTax() )#
			</td>
		</cfif>			
		<cfif local.hasProductDiscount>
			<td class="values discount">
				#lsCurrencyFormat( local.cartProduct.getDiscount() )#
			</td>
		</cfif>			
			<td class="values gray bar">
				#lsCurrencyFormat( local.cartProduct.getTotal() )#
			</td>
		</tr>
	</cfloop>
		<tr>
			<td colspan="#(2+local.extraCols)#" class="bar">
				<strong>#rc.mmRBF.key('subtotal')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.cartBean.getProductTotal() )#
				</strong>
			</td>
		</tr>
		<cfif local.rc.cartBean.getShipping()>
		<tr>
			<td colspan="#(2+local.extraCols)#" class="bar">
				<strong>#rc.mmRBF.key('shipping')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.cartBean.getShipping() )#
				</strong>
			</td>
		</tr>
		</cfif>
		<cfif local.rc.cartBean.getTax()>
		<tr>
			<td colspan="#(2+local.extraCols)#" class="bar">
				<strong>#rc.mmRBF.key('tax')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.cartBean.getTax() )#
				</strong>
			</td>
		</tr>
		</cfif>
		<cfif local.rc.cartBean.getDiscount()>
		<tr>
			<td colspan="#(2+local.extraCols)#" class="bar discount">
				<strong>#rc.mmRBF.key('discount')#:</strong>
			</td>
			<td class="values bar discount">
				<strong>
				#lsCurrencyFormat( -local.rc.cartBean.getDiscount() )#
				</strong>
			</td>
		</tr>
		</cfif>
		<tr>
			<td colspan="#(2+local.extraCols)#" class="bar">
				<strong>#rc.mmRBF.key('total')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.cartBean.getTotal() )#
				</strong>
			</td>
		</tr>
	</table>
	<div class="cartbuttons">
		<p>
		<cfif not local.rc.cartBean.isEmpty()>
			<button class="submit" name="updatecart" value="updatecart" onclick="$('##meld-form-mode').val('updatecart')">#rc.mmRBF.key('updatecart')#</button>
		</cfif>
			<button class="submit" name="checkout" value="checkout" onclick="$('##meld-form-mode').val('checkout')">#rc.mmRBF.key('purchasecart')#</button>
		<cfif not local.rc.cartBean.isEmpty()>
			<button class="submit delete" name="clearcart" value="clearcart" onclick="$('##meld-form-mode').val('clearcart')">#rc.mmRBF.key('clearcart')#</button>
		</cfif>
		</p>
	</div>
	</form>
</div>
</cfoutput>


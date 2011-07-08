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
	
</cfsilent>
<cfoutput>
<div class="meld-minicommerce-cart">
<cfif structCount(local.rc.products)>
	<table class="cart">
		<tr>
			<th class="varWidth">
				#rc.mmRBF.key('product')#
			</th>
			<th class="info">
				#rc.mmRBF.key('quantity')#
			</th>
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
			<th class="values bar">
				&nbsp;
			</th>
		</tr>	
	<cfloop collection="#local.rc.products#" item="local.iiX">
		<cfset local.cartProduct	= local.rc.products[local.iiX]>
		<cfset local.isAdjusted		= (local.cartProduct.getSubTotal() neq local.cartProduct.getTotal())>
		<tr class="minicommerce-product">
			<td class="varWidth">
				<h5>#local.cartProduct.getName()#</h5>
				<cfif len( local.cartProduct.getSummary() )>
					<p>#local.cartProduct.getSummary()#</p>
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
			<td class="info gray">
				#local.cartProduct.getQuantity()#
			</td>
			<td class="info bar">
				#lsCurrencyFormat( local.cartProduct.getPrice() )#
			</td>
		<cfif local.hasProductShipping>
			<td class="info bar">
				#lsCurrencyFormat( local.cartProduct.getShipping() )#
			</td>
		</cfif>			
		<cfif local.hasProductTax>
			<td class="values bar">
				#lsCurrencyFormat( local.cartProduct.getTax() )#
			</td>
		</cfif>			
		<cfif local.hasProductDiscount>
			<td class="values bar discount">
				#lsCurrencyFormat( local.cartProduct.getDiscount() )#
			</td>
		</cfif>			
			<td class="values gray bar">
				#lsCurrencyFormat( local.cartProduct.getTotal() )#
			</td>
		</tr>
	</cfloop>
		<tr>
			<td colspan="#(3+local.extraCols)#" class="bar rt">
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
			<td colspan="#(3+local.extraCols)#" class="bar rt">
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
			<td colspan="#(3+local.extraCols)#" class="bar rt">
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
			<td colspan="#(3+local.extraCols)#" class="bar discount rt">
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
			<td colspan="#(3+local.extraCols)#" class="bar rt">
				<strong>#rc.mmRBF.key('total')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.cartBean.getTotal() )#
				</strong>
			</td>
		</tr>
	</table>
</cfif>
</div>
</cfoutput>


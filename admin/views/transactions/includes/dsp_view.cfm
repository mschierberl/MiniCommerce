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
	<cfset local.rc			= rc>

	<cfset local.hasProductShipping	= (rc.cartBean.getProductShippingTotal() gt 0)>
	<cfset local.hasProductTax		= (rc.cartBean.getProductTaxTotal() gt 0)>
	<cfset local.hasProductDiscount	= (rc.cartBean.getProductDiscountTotal() gt 0)>
	<cfset local.extraCols			= 0>

	<cfset local.ct			= 0>
	<cfset local.ctClass	= "">

	<!--- headers --->
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	<ul class="metadata">
		<li><strong>#rc.mmRBF.key('user.name','mura')#:</strong> <a href="/admin/index.cfm?fuseaction=cPublicUsers.editUser&siteid=default&userid=#rc.userBean.getUserID()#" target="_new">#rc.userBean.getFName()# #rc.userBean.getLName()#</a> (<a href="mailto:#rc.userBean.getEmail()#">#rc.userBean.getEmail()#</a>)</li>
		<cfif rc.transactionBean.getisCompleted()>
			<li><strong>#rc.mmRBF.key('orderident')#:</strong>#rc.transactionBean.getOrderIdent()#</li>
		</cfif>
		<li><strong>#rc.mmRBF.key('transactiondate')#:</strong> #lsDateFormat(rc.transactionBean.getDateLastUpdate(),"medium")# #lsTimeFormat(rc.transactionBean.getDateLastUpdate(),"medium")# </li>
		<li><strong>#rc.mmRBF.key('cartdate')#:</strong> #lsDateFormat(rc.cartBean.getDateCreate(),"medium")# #lsTimeFormat(rc.cartBean.getDateCreate(),"medium")# </li>
	</ul>
	<hr noshade="noshade" />
	<ul class="metadata">
		<li><strong>#rc.mmRBF.key('paymenttype')#:</strong> #rc.paymentTypeBean.getName()#</li>

		<li><strong>#rc.mmRBF.key('total')#:</strong> #lsCurrencyFormat(rc.transactionBean.getTotal())#</li>
		<cfif rc.paymentTypeBean.getPaymentType() eq 'card'>
			<cfif rc.transactionBean.getIsApproved()>
				<li><strong>#rc.mmRBF.key('approved')#:</strong> #rc.mmRBF.key('yes')# <cfif len(rc.transactionBean.getApprovalCode())>(#rc.transactionBean.getApprovalCode()#)</cfif>
			<cfelse>
				<li><strong>#rc.mmRBF.key('approved')#:</strong> #rc.mmRBF.key('no')# <cfif len(rc.transactionBean.getErrorCode())>(#rc.transactionBean.getErrorCode()#)</cfif>
			</cfif>
			</li>
			<li><strong>#rc.mmRBF.key('cardlastfour')#:</strong> #rc.transactionBean.getCardLastFour()#</li>
			<li><strong>#rc.mmRBF.key('cardexpiry')#:</strong> #rc.transactionBean.getCardMonth()# / #rc.transactionBean.getCardYear()#</li>
		<cfelse>
			<li><strong>#rc.mmRBF.key('completed')#:</strong> #rc.mmRBF.key('completed#rc.transactionBean.getIsCompleted()#')#</li>
		</cfif>
		<cfif len(rc.transactionBean.getCustom1())>
			<li><strong>#rc.mmRBF.key(rc.merchantBean.getCustom1Label())#:</strong> #rc.transactionBean.getCustom1()#
		</cfif>
		<cfif len(rc.transactionBean.getCustom2())>
			<li><strong>#rc.mmRBF.key(rc.merchantBean.getCustom2Label())#:</strong> #rc.transactionBean.getCustom2()#
		</cfif>
		<cfif len(rc.transactionBean.getCustom3())>
			<li><strong>#rc.mmRBF.key(rc.merchantBean.getCustom3Label())#:</strong> #rc.transactionBean.getCustom3()#
		</cfif>
		</li>
	</ul>
<cfif structCount(rc.products)>
	<div class="meld-minicommerce">
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
	<cfloop collection="#rc.products#" item="local.iiX">
		<cfset local.ct++>
		<cfif local.ct mod 2>
			<cfset local.ctClass = " alt">
		<cfelse>
			<cfset local.ctClass = "">
		</cfif>
		<cfset local.cartProduct	= rc.products[local.iiX]>
		<cfset local.isAdjusted		= (local.cartProduct.getSubTotal() neq local.cartProduct.getTotal())>
		<tr class="minicommerce-product#local.ctClass#">
			<td class="varWidth">
				<h5>#local.cartProduct.getName()#</h5>
				<cfif len( #local.cartProduct.getSummary()# )>
					<span>#local.cartProduct.getSummary()#</span>
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
		<cfif local.rc.transactionBean.getShipping()>
		<tr>
			<td colspan="#(3+local.extraCols)#" class="bar rt">
				<strong>#rc.mmRBF.key('shipping')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.transactionBean.getShipping() )#
				</strong>
			</td>
		</tr>
		</cfif>
		<cfif local.rc.transactionBean.getTax()>
		<tr>
			<td colspan="#(3+local.extraCols)#" class="bar rt">
				<strong>#rc.mmRBF.key('tax')#:</strong>
			</td>
			<td class="values bar">
				<strong>
				#lsCurrencyFormat( local.rc.transactionBean.getTax() )#
				</strong>
			</td>
		</tr>
		</cfif>
		<cfif local.rc.transactionBean.getDiscount()>
		<tr>
			<td colspan="#(3+local.extraCols)#" class="bar discount rt">
				<strong>#rc.mmRBF.key('discount')#:</strong>
			</td>
			<td class="values bar discount">
				<strong>
				#lsCurrencyFormat( -local.rc.transactionBean.getDiscount() )#
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
				#lsCurrencyFormat( rc.transactionBean.getTotal() )#
				</strong>
			</td>
		</tr>
	</table>
	</div>
	</cfif>
</div>	
<!--- end content --->
</cfoutput> 
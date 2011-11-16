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
	<cfparam name="rc.paymenttype" default="" />
	<cfparam name="rc.expDateMonth" default="" />
	<cfparam name="rc.expDateYear" default="" />
	<cfparam name="rc.paymenttype" default="" />

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
	<form method="post" action="./" class="meld-form" onsubmit="return purchasevalidate(this,'purchaseterms');">
		<input type="hidden" name="pagemode" value="process">
		<ul>
			<li>
				<label for="paymenttype">#rc.mmRBF.key('paymentType')#<span class="required">*</span></label>
				<select name="paymenttype" class="select" id="paymenttype" data-required="true" message="#rc.mmRBF.key('paymenttype','validate')#">
					<option value="">#rc.mmRBF.key('selectpaymenttype')#</option>
					<cfloop from="1" to="#ArrayLen(rc.aPaymentTypes)#" index="local.iiX">
						<cfset local.paymentType = rc.aPaymentTypes[local.iiX] />
						<option data-iscc="#iif(local.paymentType.getPaymentType() eq 'card',de(true),de(false))#" value="#local.paymentType.getPaymentTypeID()#"<cfif rc.paymenttype eq local.paymentType.getPaymentTypeID()> SELECTED</cfif>>#local.paymentType.getName()#</option>
					</cfloop>
				</select>
			</li>
			<li class="meld-cc-info">
				<label for="creditCardNumber">#rc.mmRBF.key('cardnumber')#<span class="required">*</span></label>
				<input type="text" class="text" maxlength="19" name="creditCardNumber" id="creditCardNumber" data-required="true" validate="numeric" message="#rc.mmRBF.key('cardnumber','validate')#" style="width: 200px"/>			
			</li>
			<li class="meld-cc-info">
				<label for="expDateMonth">#rc.mmRBF.key('expirydate')#<span class="required">*</span></label>
				<select name="expDateMonth" id="expDateMonth">
					<cfloop from="1" to="12" index="iMonth">
						<cfif len(iMonth) lt 2>
							<cfset iMonth = 0 & #iMonth#>
						</cfif>
						<option value="#imonth#"<cfif iMonth eq rc.expDateMonth> SELECTED</cfif>>#imonth#</option>
					</cfloop>
				</select>
				<select name="expDateYear" id="expDateYear">
					<cfloop from="#datePart("yyyy",now())#" to="#datePart("yyyy",dateAdd("yyyy",12,now()))#" index="iiY">
					<option value="#iiY#"<cfif iiY eq rc.expDateYear> SELECTED</cfif>>#iiY#</option>
					</cfloop>
				</select>
			</li>
			<li class="meld-cc-info">
				nh ji<label for="cvv2Number">#rc.mmRBF.key('verificationnumber')#<span class="required">*</span></label>
				<input type="text" size="3" maxlength="4" name="cvv2Number" id="cvv2Number" data-required="true" validate="numeric" message="#rc.mmRBF.key('verificationnumber','validate')#" style="width: 50px"/>
				<span class="hint">#rc.mmRBF.key('verificationnumber','tip')#</span>
			</li>
			<li>
				<label id="nullBox"></label>
				<input type="checkbox" value="1" name="purchaseterms" id="purchaseterms" data-required="true" message="#rc.mmRBF.key('purchaseterms','validate')#" />
				<input type="hidden" name="purchaseterms_default" id="purchaseterms_default" value="" data-required="true" validate="numeric" message="#rc.mmRBF.key('purchaseterms','validate')#" />
				#rc.mmRBF.key('termslink')#
			</li>
		</ul>
		<div class="cartbuttons">
			<input type="submit" class="submit" name="submit" id="purchase_submit" value="#rc.mmRBF.key('checkoutnext_purchase')#"/>
		</div>
	</form>
</div>
</cfoutput>


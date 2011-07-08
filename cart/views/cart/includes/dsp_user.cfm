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
	<form method="post" action="./" class="meld-form" onsubmit="return validate(this);">
		<input type="hidden" name="pagemode" value="user">
		<ul>
		<li>
		<label for="fName">#rc.mmRBF.key('user.fname','mura')#<span class="required">*</span></label>
		<input type="text" id="fName" class="text" name="fname" value="#rc.$.currentUser().getfName()#" required="true" message="#htmlEditFormat(rc.mmRBF.key('user.fnamerequired','mura'))#" maxlength="50"/>
		</li>
		<li>
		<label for="lName">#rc.mmRBF.key('user.lname','mura')#<span class="required">*</span></label>
		<input type="text" id="lName" class="text" name="lname" value="#rc.$.currentUser().getlname()#" required="true" message="#htmlEditFormat(rc.mmRBF.key('user.lnamerequired','mura'))#" maxlength="50"/>
		</li>
		<li>
		<label for="company">#rc.mmRBF.key('user.company','mura')#</label>
		<input type="text" id="company" class="text" name="company" value="#rc.$.currentUser().getcompany()#" required="false" maxlength="50"/>
		</li>
		<li>
		<label for="email">#rc.mmRBF.key('user.email','mura')#<span class="required">*</span></label>
		<input type="text" id="email" class="text" name="email" value="#rc.$.currentUser().getemail()#" required="true" message="#rc.mmRBF.key('user.emailrequired','mura')#" maxlength="50" style="width: 200px">
		</li>
		</ul>
		<fieldset>
		<legend class="cartlegend">#rc.mmRBF.key('billingaddress')#</legend>
		<ul>
		<li>
		<label for="billing_address1">#rc.mmRBF.key('user.address','mura')#<span class="required">*</span></label>
		<input name="billing_address1" id="billing_address1txt" type="text" value="#rc.billingAddress.address1#" class="text" required="true" message="#rc.mmRBF.key('billingaddressrequired')#" maxlength="50" style="width: 200px">
		</li>	
		<li>
		<label for="billing_address2">#rc.mmRBF.key('user.address','mura')# (2)</label>
		<input name="billing_address2" id="billing_address2txt" type="text" value="#rc.billingAddress.address2#" class="text"  required="no" maxlength="50" style="width: 200px">
		</li>	
		<li>
		<label for="billing_city">#rc.mmRBF.key('user.city','mura')#<span class="required">*</span></label>
		<input name="billing_city" id="billing_citytxt" type="text" value="#rc.billingAddress.city#" class="text"  required="true" message="#rc.mmRBF.key('billingcityrequired')#" maxlength="50" style="width: 100px">
		</li>	
		<li>
		<label for="billing_state">#rc.mmRBF.key('user.state','mura')#</label>
			<select name="billing_state" id="billing_state">
				<cfset local.state = rc.billingAddress.state>
				<cfinclude template="inc_states.cfm">
			</select>
		</li>	
		<li>
		<label for="billing_country">#rc.mmRBF.key('user.country','mura')#<span class="required">*</span></label>
			<select name="billing_country" id="billing_country" required="true" message="#rc.mmRBF.key('user.country','validate')#">
				<cfset local.country = rc.billingAddress.country>
				<cfinclude template="inc_countries.cfm">
			</select>
		</li>	
		<li>
		<label for="billing_zip">#rc.mmRBF.key('user.zip','mura')#</label>
		<input name="billing_zip" id="billing_ziptxt" type="text" value="#rc.billingAddress.zip#" class="text"  required="false" maxlength="50" style="width: 50px">
		</li>	
		<li>
		<label for="billing_phone">#rc.mmRBF.key('user.phone','mura')#</label>
		<input name="billing_phone" id="billing_phonetxt" type="text" value="#rc.billingAddress.phone#" class="text"  required="no" maxlength="50" style="width: 100px">
		</li>	
		</ul>
		</fieldset>
		<!---
		<fieldset>
		<legend class="cartlegend">#rc.mmRBF.key('shippingaddress')#</legend>
		<ul>
		<li>
		<label for="address1">#rc.mmRBF.key('sameasabove')#<span class="required">*</span></label>
			<input name="shipping_sameasabove" id="shipping_sameasabove" type="checkbox">
		</li>	
		<li>
		<label for="address1">#rc.mmRBF.key('user.address','mura')#<span class="required">*</span></label>
			<input name="shipping_address1" id="shipping_address1txt" type="text" value="#rc.$.currentUser().getaddress1()#" class="text" required="false" maxlength="50" style="width: 200px">
		</li>	
		<li>
		<label for="address2">#rc.mmRBF.key('user.address','mura')# (2)</label>
			<input name="shipping_address2" id="shipping_address2txt" type="text" value="#rc.$.currentUser().getaddress2()#" class="text"  required="no" maxlength="50" style="width: 200px">
		</li>	
		<li>
		<label for="city">#rc.mmRBF.key('user.city','mura')#<span class="required">*</span></label>
			<input name="shipping_city" id="shipping_citytxt" type="text" value="#rc.$.currentUser().getcity()#" class="text"  required="false" maxlength="50" style="width: 100px">
		</li>	
		<li>
		<label for="shipping_state">#rc.mmRBF.key('user.state','mura')#<span class="required">*</span></label>
			<select name="shipping_state" id="shipping_state">
				<cfinclude template="inc_states.cfm">
			</select>
		</li>	
		<li>
		<label for="country">#rc.mmRBF.key('user.country','mura')#<span class="required">*</span></label>
			<select name="country" id="shipping_country">
				<cfinclude template="inc_countries.cfm">
			</select>
		</li>	
		<li>
		<label for="zip">#rc.mmRBF.key('user.zip','mura')#</label>
		<input name="shipping_zip" id="shipping_ziptxt" type="text" value="#rc.$.currentUser().getzip()#" class="text"  required="false" maxlength="50" style="width: 50px">
		</li>	
		<li>
		<label for="phone">#rc.mmRBF.key('user.phone','mura')#</label>
		<input name="shipping_phone" id="shipping_phonetxt" type="text" value="#rc.$.currentUser().getphone()#" class="text"  required="no" maxlength="50" style="width: 100px">
		</li>	
		</ul>
		</fieldset>
		--->
		<div class="cartbuttons">
			<input type="submit" class="submit" name="submit" value="#rc.mmRBF.key('checkoutnext_paymentinfo')#" />
		</div>
	</form>
<cfelse>
	<h5>#rc.mmRBF.key('emptycart')#</h5>
</cfif>
</div>
</cfoutput>


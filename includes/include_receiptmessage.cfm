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
<!---
	AVAILABLE
	-cartBean (bean)
	-transactionBean (bean)
	-paymentTypeBean (bean)
	-userBean (bean)
	-siteConfig (mura bean)
	-sProducts (struct)	

 --->
</cfsilent>
<cfoutput>
<style>
##meld-receipt-message {
	border: 2px solid ##666;
	padding: 20px;
}
##meld-receipt-details {
	border: 2px solid ##e6f1a5;
	background-color: ##fdfef5;
	margin: 5px;
	padding: 10px;
}
##meld-receipt-products ul {
	list-style: none;
}
##meld-receipt-products li {
	line-height: 1em;
	margin: 0;
}
</style>
<div id="meld-receipt-message">
<p>Thank you, #userBean.getFname()#, your purchase is complete.</p>
<cfif paymentTypeBean.getPaymentType() eq 'card'>
	<p>Your purchase has been processed and approved.</p>

	<h3>Receipt</h3>
<cfelse>
	<h3>Information</h3>
</cfif>
<h4>
	<strong>Order No.: </strong> #transactionBean.getOrderIdent()#
</h4>
<div id="meld-receipt-details">
<p>
<span style="font-weight: bold;">Name:</span> #userBean.getFname()# #userBean.getLname()#
</p>
<cfif len( #userBean.getCompany()# ) >
<p>
	<span style="font-weight: bold;">Organization:</span> #userBean.getCompany()#
</p>
</cfif>
<p>
	<span style="font-weight: bold;">Total</span>:&nbsp; #lsCurrencyFormat(transactionBean.getTotal())#
</p>
<p>
	<strong>Date: </strong>#lsdateformat(cartBean.getDateLastUpdate(),"medium")# #lstimeformat(cartBean.getDateLastUpdate())#
</p>
<cfif paymentTypeBean.getPaymentType() eq 'card'>
<p>
	<span style="font-weight: bold;">Approval Code</span><strong>: </strong>#transactionBean.getApprovalCode()# <br />
</p>
<cfelse>
	<hr noshade>
	<p>
	<span style="font-weight: bold;">Please Email your #paymentTypeBean.getName()# to:</span><br  />
	#siteConfig.getContactAddress()#<br />
	#siteConfig.getContactCity()#, #siteConfig.getContactState()#<br />
	#siteConfig.getContactZip()#<br />
	#siteConfig.getContactAddress()#<br />
	</p>
	<p>
	<strong>Phone: </strong> #siteConfig.getContactPhone()#
	</p>
	<p>
	<strong>Email: </strong> #siteConfig.getContactEmail()#
	</p>
</cfif>
</div>
<div id="meld-receipt-products">
<h3>Products</h3>
<ul>
	<cfloop collection="#sProducts#" item="iiX">
		<cfset cartProductBean = sProducts[iiX]>
		<li>#cartProductBean.getName()# (#cartProductBean.getQuantity()#)
		<cfif StructCount( cartProductBean.getAttributesAsStruct() )>
			<cfset local.attributes = cartProductBean.getAttributesAsStruct() />
			<ul class="attributes">
				<cfloop collection="#local.Attributes#" item="local.att">
				<li><strong>#local.att#: </strong> #local.Attributes[local.att]#</li>
				</cfloop>
			</ul>
		</cfif>
		</li>
	</cfloop>
</ul>
</div>
</cfoutput>

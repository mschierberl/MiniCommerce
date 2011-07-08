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
	<cfset rc		= rc>
	<!--- headers --->
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
<form id="meld-edit-form" class="meld-form" method="post" action="index.cfm" onsubmit="return meldvalidate(this);">
<input type="hidden" name="action" value="admin:paymenttypes.edit">
<input type="hidden" name="paymentTypeID" value="#rc.paymentTypeBean.getpaymentTypeID()#">
<div>
	<div>
	<ul class="form">
		<li class="first">
			<label for="paymentTypebean_name">
				#rc.mmRBF.key('name')# <a href="##" class="tooltip"><span>#rc.mmRBF.key('name','tip')#</span>&nbsp;</a>
			</label>
			<input class="text short" type="text" name="paymentTypebean_name" id="paymentTypebean_name" value="#form.paymentTypebean_name#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key('name','validate')#" />
		</li>
		<li>
			<label for="paymentTypebean_identity">
				#rc.mmRBF.key('identity')# <a href="##" class="tooltip"><span>#rc.mmRBF.key('identity','tip')#</span>&nbsp;</a>
			</label>
			<input class="text short" type="text" name="paymentTypebean_identity" id="paymentTypebean_identity" value="#form.paymentTypebean_identity#" size="25" maxlength="25" required="true" message="#rc.mmRBF.key('identity','validate')#" />
		</li>
		<li>
			<label for="paymentTypebean_isActive">
				#rc.mmRBF.key('isActive')# <a href="##" class="tooltip"><span>#rc.mmRBF.key('isActive','tip')#</span>&nbsp;</a>
			</label>
			<select name="paymentTypebean_isActive" id="paymentTypebean_isActive">
				<option value="0">#rc.mmRBF.key('no')#</option>
				<option value="1"<cfif form.paymentTypebean_isActive> SELECTED</cfif>>#rc.mmRBF.key('yes')#</option>
			</select>
		</li>
		<li>
			<label for="paymentTypebean_PaymentType">
				#rc.mmRBF.key('PaymentType')# <a href="##" class="tooltip"><span>#rc.mmRBF.key('PaymentType','tip')#</span>&nbsp;</a>
			</label>
			<select name="paymentTypebean_PaymentType" id="paymentTypebean_PaymentType">
				<cfloop list="card,mail,custom" index="local.iix">
				<option value="#local.iix#"<cfif form.paymentTypebean_PaymentType eq local.iix> SELECTED</cfif>>#rc.mmRBF.key(local.iix)#</option>
				</cfloop>
			</select>
		</li>
		<li>
			<label for="paymentTypebean_remoteID">
				#rc.mmRBF.key('remoteID')# <a href="##" class="tooltip"><span>#rc.mmRBF.key('remoteID','tip')#</span>&nbsp;</a>
			</label>
			<input class="text short" type="text" name="paymentTypebean_remoteID" id="paymentTypebean_remoteID" value="#form.paymentTypebean_remoteID#" size="35" maxlength="35" />
		</li>
	</ul>
	</div>
	<div>
		<ul class="form-buttons">
			<li><input name="btaction" id="btcancel" type="submit" class="submit ui-state-default" value="#rc.mmRBF.key('cancel')#"></li>
			<cfif rc.paymentTypeBean.beanExists()>
				<li><input name="btaction" id="btupdate" type="submit" class="submit ui-state-default" value="#rc.mmRBF.key('update')#"></li>
				<li class="right">
					<input type="hidden" id="btdeleteconfirm" name="btdeleteconfirm" value="" />
					<input data-delete="#rc.mmRBF.key('delete')#" data-cancel="#rc.mmRBF.key('cancel')#" data-title="#rc.mmRBF.key('delete')#" data-message="#rc.mmRBF.key('deletepaymentType','validation')#" id="btdelete" name="btaction" type="submit" class="submit ui-state-highlight" value="#rc.mmRBF.key('delete')#">
				</li>
			<cfelse>
				<li><input name="btaction" id="btsave" type="submit" class="submit ui-state-default" value="#rc.mmRBF.key('save')#"></li>
			</cfif>
		</ul>
	</div>
</div>	
</form>


<!---	<form method="post" enctype="multipart/form-data">
		<input type="file" name="newpaymentType">
		<input type="submit">
	</form>
--->
</div>	
<!--- end content --->
</cfoutput> 
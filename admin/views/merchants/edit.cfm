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
	<cfset local.rc		= rc>
	<!--- headers --->
</cfsilent><cfoutput>
<!--- global menu --->
	<cfinclude template="/#local.rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui-tabs.cfm">
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
<form id="meld-edit-form" class="meld-form" method="post" action="index.cfm" onsubmit="return meldvalidate(this);">
<input type="hidden" name="action" value="admin:merchants.edit">
<input type="hidden" name="merchantID" value="#rc.merchantBean.getmerchantID()#">
<div id="msTabs">
	<ul>
		<li><a id="msTabs-Options-Tab" href="##msTabs-Settings">#local.rc.mmRBF.key('settings')#</a></li>
		<li><a id="msTabs-Advanced-Tab" href="##msTabs-Advanced">#local.rc.mmRBF.key('advanced')#</a></li>
	</ul>
	<div id="msTabs-panels">
		#view("merchants/includes/edit_settings")#
		#view("merchants/includes/edit_advanced")#
	</div>
	<div>
		<ul class="form-buttons">
			<li><input name="btaction" id="btcancel" type="submit" class="submit ui-state-default" value="#rc.mmRBF.key('cancel')#"></li>
			<cfif rc.merchantBean.beanExists()>
				<li><input name="btaction" id="btupdate" type="submit" class="submit ui-state-default" value="#rc.mmRBF.key('update')#"></li>
				<!---
				<li class="right">
					<input type="hidden" id="btdeleteconfirm" name="btdeleteconfirm" value="" />
					<input data-delete="#rc.mmRBF.key('delete')#" data-cancel="#rc.mmRBF.key('cancel')#" data-title="#rc.mmRBF.key('delete')#" data-message="#rc.mmRBF.key('deletemerchant','validation')#" id="btdelete" name="btaction" type="submit" class="submit ui-state-highlight" value="#rc.mmRBF.key('delete')#">
				</li>
				--->
			<cfelse>
				<li><input name="btaction" id="btsave" type="submit" class="submit ui-state-default" value="#rc.mmRBF.key('save')#"></li>
			</cfif>
		</ul>
	</div>
</div>	
</form>

</div>	
<!--- end content --->
</cfoutput>
 <div>

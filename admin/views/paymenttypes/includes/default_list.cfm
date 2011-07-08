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
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
<div class="section clearfix">
	<table class="ms-datatable display hideTable" id="ms-datatable"
		data-url="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/com/meldsolutions/meldminicommerce/remote/MeldMiniCommerceRemoteAOP.cfc?method=getPaymentTypeList&data&returnFormat=json">
		<thead class="headers">
		<tr>
			<th class="nosort nopad ui-state-active" data-class="nopad">&nbsp;</th>
			<th class="varWidth ui-state-active">#rc.mmRBF.key('name')#</th>
			<th class="minWidth ui-state-active" data-class="center">#rc.mmRBF.key('paymenttype')#</th>
			<th class="minWidth ui-state-active" data-class="center">#rc.mmRBF.key('isactive')#</th>
		</tr>
		</thead>
		<thead class="search" id="ms-datatable_search">
		<tr>
			<th>
			<ul class='table-buttons two'>
				<li><span title="#rc.mmRBF.key('clearfilter')#" id="clearFilter" class="sb-button ui-state-active"><span class="ui-icon ui-icon-arrowreturnthick-1-w"></span></span></li>
				<li><span title="#rc.mmRBF.key('setfilter')#" id="setFilter" class="sb-button ui-state-active"><span class="ui-icon ui-icon-check"></span></span></li>
			</ul>
			<th><input class="searchable text full" type="text" id="flt_name" data-column="name"></th>
			<th>
			<select class="select" name="paymenttype" id="flt_paymenttype" data-column="paymenttype">
				<option value="">#rc.mmRBF.key('all')#</option>
				<option value="card">#rc.mmRBF.key("creditcard")#</option>
				<option value="mail">#rc.mmRBF.key("mail")#</option>
				<option value="custom">#rc.mmRBF.key("custom")#</option>
			</select>
			</th>
			<th>
			<select class="select" name="isCompleted" id="flt_isactive" data-column="isactive">
				<option value="">#rc.mmRBF.key('all')#</option>
				<option value="0">#rc.mmRBF.key("no")#</option>
				<option value="1">#rc.mmRBF.key("yes")#</option>
			</select>
			</th>
		</tr>
		</thead>
		<tbody>
	</table>
</div>

</cfoutput>
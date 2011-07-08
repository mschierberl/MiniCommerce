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
	<div id="msTabs-Advanced">
		<h3>#local.rc.mmRBF.key('advanced')#: #rc.merchantBean.getName()#</h3>
		<ul class="form">
			<li class="first">
				<label for="merchantbean_isCurrent">
					#rc.mmRBF.key('isCurrent')# <a href="##" class="tooltip"><span>#rc.mmRBF.key('isCurrent','tip')#</span>&nbsp;</a>
				</label>
				<select name="merchantbean_isCurrent" id="merchantbean_isCurrent">
					<option value="0">#rc.mmRBF.key('no')#</option>
					<option value="1"<cfif form.merchantbean_isCurrent> SELECTED</cfif>>#rc.mmRBF.key('yes')#</option>
				</select>
			</li>
			<li class="last">
				<label for="merchantbean_remoteID">
					#rc.mmRBF.key( 'remoteID' )# <a href="##" class="tooltip"><span>#rc.mmRBF.key('remoteID','tip')#</span>&nbsp;</a>
				</label>
				<input class="text" type="text" name="merchantbean_remoteID" id="merchantbean_remoteID" value="#form.merchantbean_remoteID#" size="35" maxlength="35" />
			</li>
		</ul>
	</div>
</cfoutput>
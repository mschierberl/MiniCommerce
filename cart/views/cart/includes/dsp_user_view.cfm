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
<cfoutput>
<cfif not rc.cartBean.IsEmpty()>
<div class="columns2">
	<div class="col">
	<dl class="profile">
			<dt>#rc.mmRBF.key('user.name','mura')#:</dt>
			<dd>#rc.$.currentUser().getFName()# #rc.$.currentUser().getLName()#</dd>
			<dt>#rc.mmRBF.key('user.email','mura')#:</dt>
			<dd>#rc.$.currentUser().getEmail()#</dd>
	</dl>
	</div>
	<div class="col">
	<dl class="profile">
			<dt>#rc.mmRBF.key('user.address','mura')#:</dt>
			<dd>
			#rc.billingAddress.address1# #rc.billingAddress.address2#<br />
			#rc.billingAddress.city#, #rc.billingAddress.state#<br />
			#rc.billingAddress.country#<br />
			#rc.billingAddress.zip#</dd>
	</dl>	
	</div>
	<a class="submit" href="./">#rc.mmRBF.key('updateuserinfo')#</a>
</div>
</cfif>
</cfoutput>

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
<ul id="meld-nav-main">
	<li class="first"><a href="?">#rc.mmRBF.key('dashboard')#</a></li>
	<li><a href="?action=transactions">#rc.mmRBF.key('transactions')#</a></li>
	<li><a href="?action=paymenttypes">#rc.mmRBF.key('paymenttypes')#</a></li>
	<li><a href="?action=merchants">#rc.mmRBF.key('merchants')#</a></li>
	<li class="about">
		<a title="#rc.mmRBF.key('AboutMiniCommerce')#" href="?action=admin:about">#rc.mmRBF.key('About')#</a>
		<ul>
			<li class="first"><a href="?action=admin:about">#rc.mmRBF.key('AboutMiniCommerce')#</a></li>
			<li><a href="?action=admin:about.documentation">#rc.mmRBF.key('Documentation')#</a></li>
			<li><a href="?action=admin:about.support">#rc.mmRBF.key('Support')#</a></li>
			<li class="last"><a href="?action=admin:about.license">#rc.mmRBF.key('license')#</a></li>
		</ul>
	</li>
</ul>

</cfoutput>
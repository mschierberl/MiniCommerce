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
	<!--- headers --->
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div class="meld-display">
	<cfif rc.errors.hasErrors( rc.$.event() )>
		<div class="error">
			#rc.errors.displayErrorsHTML( rc.$.event() )#
		</div>
	</cfif>
	<cfif len( rc.renderCartWidget )>
		#rc.renderCartWidget#
	<cfelse>
		<div class="meld-cart-widget">
			<h4>#rc.mmRBF.key('yourcart')#</h4>
			<cfif rc.quantity>
				<p><a href="#rc.cartURL#">#rc.mmRBF.key('products')#</a>: #rc.quantity#</p>
			<cfelse>
				<p>#rc.mmRBF.key('products')#: 0</p>
			</cfif>
		</div>
	</cfif>
</div>	
<!--- end content --->
</cfoutput> 
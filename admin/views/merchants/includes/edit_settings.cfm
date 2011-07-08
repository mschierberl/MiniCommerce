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
	<div id="msTabs-Settings">
		<h3>#local.rc.mmRBF.key('settings')#: #rc.merchantBean.getName()#</h3>
			<ul class="form">
				<cfif len( rc.merchantBean.getParam1label() )> 
				<li class="first">
					<label for="merchantbean_param1">
						#rc.mmRBF.key( rc.merchantBean.getParam1label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getParam1label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param1" id="merchantbean_param1" value="#form.merchantbean_param1#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam1label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam2label() )> 
				<li>
					<label for="merchantbean_param2">
						#rc.mmRBF.key( rc.merchantBean.getparam2label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getParam2label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param2" id="merchantbean_param2" value="#form.merchantbean_param2#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam2label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam3label() )> 
				<li>
					<label for="merchantbean_param3">
						#rc.mmRBF.key( rc.merchantBean.getparam3label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getParam3label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param3" id="merchantbean_param3" value="#form.merchantbean_param3#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam3label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam4label() )> 
				<li>
					<label for="merchantbean_param4">
						#rc.mmRBF.key( rc.merchantBean.getparam4label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getParam4label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param4" id="merchantbean_param4" value="#form.merchantbean_param4#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam4label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam5label() )> 
				<li>
					<label for="merchantbean_param5">
						#rc.mmRBF.key( rc.merchantBean.getparam5label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getparam5label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param5" id="merchantbean_param5" value="#form.merchantbean_param5#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam5label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam6label() )> 
				<li>
					<label for="merchantbean_param6">
						#rc.mmRBF.key( rc.merchantBean.getparam6label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getparam6label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param6" id="merchantbean_param6" value="#form.merchantbean_param6#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam6label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam7label() )> 
				<li>
					<label for="merchantbean_param7">
						#rc.mmRBF.key( rc.merchantBean.getparam7label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getparam7label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param7" id="merchantbean_param7" value="#form.merchantbean_param7#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam7label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam8label() )> 
				<li>
					<label for="merchantbean_param8">
						#rc.mmRBF.key( rc.merchantBean.getparam8label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getparam8label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param8" id="merchantbean_param8" value="#form.merchantbean_param8#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam8label(),'validate')#" />
				</li>
				</cfif>
				<cfif len( rc.merchantBean.getParam9label() )> 
				<li>
					<label for="merchantbean_param9">
						#rc.mmRBF.key( rc.merchantBean.getparam9label() )# <a href="##" class="tooltip"><span>#rc.mmRBF.key(rc.merchantBean.getparam9label(),'tip')#</span>&nbsp;</a>
					</label>
					<input class="text" type="text" name="merchantbean_param9" id="merchantbean_param9" value="#form.merchantbean_param9#" size="30" maxlength="100" required="true" message="#rc.mmRBF.key(rc.merchantBean.getParam9label(),'validate')#" />
				</li>
				</cfif>
			</ul>
		<div style="display: none;">
			#rc.mmRBF.key( rc.merchantBean.getCustom1label() )#
			#rc.mmRBF.key( rc.merchantBean.getCustom2label() )#
			#rc.mmRBF.key( rc.merchantBean.getCustom3label() )#
		</div>
	</div>
</cfoutput>
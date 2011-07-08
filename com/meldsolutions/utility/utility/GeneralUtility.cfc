<!---

This file is part of the Meld Manager application.

Meld Manager is licensed under the GPL 2.0 license
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
<cfcomponent displayname="GeneralUtility" output="false">

	<cffunction name="lowerStruct" access="public" output="false" returntype="struct">
		<cfargument name="sValue" type="struct" required="true">
		
		<cfset var sObj		= StructNew() />
		<cfset var iiX		= "" />
		
		<cfloop collection="#arguments.sValue#" item="iiX">
			<cfset sObj[lcase(iiX)] = arguments.sValue[iiX] />		
		</cfloop>
		
		<cfreturn sObj>				
	</cffunction>

	<cffunction name="createUUIDFromString" access="public" output="false" returntype="string">
		<cfargument name="value" type="string" required="true" />
		
		<cfset var hashString	= hash( arguments.value ) />
		<cfset var newUUID		= left(hashString,8) & "-" & mid(hashString,9,4) & "-" & "3" & mid(hashString,13,3) & "-" & right(hashString,16) />

		<cfreturn newUUID />
	</cffunction>
	
	<cffunction name="stripHTML" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true">
	
		<cfset var sReturn = rereplace(trim(value),"<.[^<>]*>","","all")>

		<cfreturn sReturn>
	</cffunction>

	<cffunction name="cleanHTML" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true">
	
		<cfset var sReturn = rereplace(trim(value),"<","&lt;","all")>
		<cfset sReturn = rereplace(sReturn,">","&gt;","all")>

		<cfreturn sReturn>
	</cffunction>
</cfcomponent>
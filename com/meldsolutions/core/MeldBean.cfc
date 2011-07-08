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
<cfcomponent displayname="MeldBean" hint="Root for all mm-based beans" output="false">
	<cfset variables.values		= StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldBean">
		<cfreturn this/>
	</cffunction>

	<!--- will update an existing bean's memento with data values --->
	<cffunction name="updateMemento" access="public" output="false" returntype="void">
		<cfargument name="data" type="struct" required="true">

		<cfset var iiX = "">
		<cfloop collection="#arguments.data#" item="iiX">
			<cfif structKeyExists( variables.instance,iiX )>
				<cfset variables.instance[lcase(iiX)] = arguments.data[iiX]>
			</cfif>
		</cfloop>

		<cfif isDefined("arguments.data.values") and isStruct( arguments.data.values )>
			<cfloop collection="#arguments.data.values#" item="iiX">
				<cfset variables.values[lcase(iiX)] = arguments.data.values[iiX]>
			</cfloop>
		</cfif>
	</cffunction>

	<!--- VALUES --->
	<cffunction name="valueExists" access="public" output="false" returntype="boolean">
		<cfargument name="key" type="string" required="true">
		
		<cfreturn structkeyexists( variables.values,arguments.key) />
	</cffunction>
	<cffunction name="getAllValues" access="public" output="false" returntype="struct">
		<cfreturn variables.values />
	</cffunction>
	<cffunction name="setAllValues" access="public" output="false" returntype="void">
		<cfargument name="value" type="struct" required="true">
		
		<cfset variables.values = structCopy( arguments.value ) />
	</cffunction>

	<cffunction name="clearAllValues" access="public" output="false" returntype="struct">
		<cfreturn structclear(variables.values) />
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset variables.values[arguments.key] = arguments.value />
	</cffunction>

	<cffunction name="getValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		
		<cfif structkeyexists( variables.values,arguments.key)>
			<cfreturn variables.values[arguments.key] />
		</cfif>
		<cfreturn "" />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfif isDate( getDateCreate() )>
			<cfreturn true />
		</cfif>
		<cfreturn false />
	</cffunction>

</cfcomponent>
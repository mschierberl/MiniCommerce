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
<cfcomponent displayname="MeldInterceptKeySet" output="false">
	<cfproperty name="id" required="false" type="string" hint="id for the keyset.  Only required if multiple keysets are used">
	<cfproperty name="EventKey" required="false" type="string" hint="event key.  Useful when using an event-driven framework like FuseBox">
	<cfproperty name="keys" required="false" type="array" hint="an array of structures, which will be turned into keys">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldInterceptKeySet">
		<cfargument name="id" required="false" type="string" default="">
		<cfargument name="EventKey" required="false" type="string" default="">
		<cfargument name="keys" required="false" type="any" default="#ArrayNew(1)#">

		<cfset variables.instance.Keys = ArrayNew(1)>
		<cfset variables.instance.Keys = ArrayNew(1)>
		<cfset variables.instance.KeyStruct = StructNew()>

		<cfif not isArray(arguments.keys)>
			<cfset arguments.keys = ArrayNew(1)>
		</cfif>

		<cfset setID(arguments.id)>
		<cfset setEventKey(arguments.EventKey)>
		<cfset setKeys(arguments.keys)>

		<cfreturn this/>
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="TimeTableAttribute" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

<!--- ID --->
	<cffunction name="setID" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.ID = arguments.value>
	</cffunction>
	<cffunction name="getID" access="public" output="false" returntype="string">
		<cfreturn variables.instance.ID>
	</cffunction>

<!--- EventKey --->
	<cffunction name="setEventKey" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.EventKey = arguments.value>
	</cffunction>
	<cffunction name="getEventKey" access="public" output="false" returntype="string">
		<cfreturn variables.instance.EventKey>
	</cffunction>

<!--- Keys --->
	<cffunction name="setKeys" access="public" output="false" returntype="void">
		<cfargument name="value" type="array" required="true">
		<cfset var iiX = 0>
		<cfset var MeldInterceptKey = "">

		<cfloop from="1" to="#ArrayLen(arguments.value)#" index="iiX">
			<cfset MeldInterceptKey = createObject("component","MeldInterceptKey").init(argumentCollection=arguments.value[iiX])>
			<cfset variables.instance.KeyStruct[MeldInterceptKey.getName()] = MeldInterceptKey>
			<cfset ArrayAppend(variables.instance.Keys,MeldInterceptKey)>
		</cfloop>
	</cffunction>

	<cffunction name="getKeys" access="public" output="false" returntype="array">
		<cfreturn variables.instance.Keys>
	</cffunction>

	<cffunction name="addKey" access="public" output="false" returntype="void">
		<cfargument name="value" type="any" required="true">
		<cfset var MeldInterceptKey = arguments.value>
		<cfset variables.instance.keyStruct[MeldInterceptKey.getName()] = MeldInterceptKey>
		<cfset ArrayAppend(variables.instance.Keys,MeldInterceptKey)>
	</cffunction>

	<cffunction name="getKey" access="public" output="false" returntype="any">
		<cfargument name="value" type="string" required="true">
		<cfreturn variables.instance.keyStruct[value]>
	</cffunction>
	<cffunction name="keyExists" access="public" output="false" returntype="boolean">
		<cfargument name="value" type="string" required="true">
		<cfreturn structKeyExists(variables.instance.keyStruct,value)>
	</cffunction>

	<cffunction name="dumpValues" access="public" output="false" returntype="struct">
		<cfargument name="doAbort" type="boolean" required="false" default="false">
		<cfset var keys = "">
		<cfset var str = "">
		<cfset var dumpStruct = StructNew()>
		
		<cfset dumpStruct.id = getID()>
		<cfset dumpStruct.eventkey = getEventKey()>
		<cfset dumpStruct.keys = ArrayNew(1)>
		<cfset keys = getKeys()>
		<cfloop from="1" to="#ArrayLen( keys )#" index="iiX">
			<cfset ArrayAppend(dumpStruct.keys,keys[iiX].getMemento() )>
		</cfloop>
		<cfif arguments.doAbort>
			<cfsavecontent variable="str"><cfoutput>
			</cfoutput></cfsavecontent>
			<cfdump var="#dumpStruct#">
			<cfabort>
		</cfif>
		<cfreturn dumpStruct>
	</cffunction>
</cfcomponent>
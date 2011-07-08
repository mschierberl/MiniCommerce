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
<cfcomponent displayname="MeldInterceptResponse" output="false">
	<cfproperty name="name" required="true" type="string" hint="friendy name of the intercept">
	<cfproperty name="package" required="true" type="string" hint="name of the matched intercept">
	<cfproperty name="keysetid" required="false" type="string" hint="id of the matched keyset">
	<cfproperty name="EventKey" required="false" type="string" hint="event key.  Useful when using an event-driven framework like FuseBox">
	<cfproperty name="matchstring" required="false" type="string" hint="if regex was used in the MeldIntercept, this is the matched string from the url">
	<cfproperty name="data" required="false" type="struct" hint="keyset data">
	<cfproperty name="extra" required="false" type="array" hint="values that were not part of a keyset">
	<cfproperty name="validated" required="false" type="boolean" hint="keys have been validated" default="false">
	<cfproperty name="valid" required="false" type="boolean" hint="keyset is valid" default="true">
	<cfproperty name="failed" required="false" type="array" hint="keys that failed validation">
	<cfproperty name="filename" required="false" type="array" hint="keys that failed validation">
	<cfproperty name="tcount" required="false" type="numeric" hint="processing time in msec">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldInterceptResponse">
		<cfargument name="name" required="true" type="string">
		<cfargument name="package" required="true" type="string">
		<cfargument name="keysetid" required="false" type="string" default="">
		<cfargument name="EventKey" required="false" type="string" default="">
		<cfargument name="matchstring" required="false" type="string" default="">
		<cfargument name="data" required="false" type="struct" default="#structNew()#">
		<cfargument name="extra" required="false" type="array" default="#arrayNew(1)#">
		<cfargument name="validated" required="false" type="boolean" default="false">
		<cfargument name="isvalid" required="false" type="boolean" default="false">
		<cfargument name="failed" required="false" type="array" default="#arrayNew(1)#">
		<cfargument name="filename" required="false" type="string" default="">
		<cfargument name="tcount" required="false" type="numeric" default="0">

		<cfset setName(arguments.name)>
		<cfset setPackage(arguments.package)>
		<cfset setKeySetID(arguments.keysetid)>
		<cfset setEventKey(arguments.EventKey)>
		<cfset setMatchString(arguments.matchstring)>
		<cfset setData(arguments.data)>
		<cfset setExtra(arguments.extra)>
		<cfset setValidated(arguments.validated)>
		<cfset setIsValid(arguments.isvalid)>
		<cfset setFailed(arguments.failed)>
		<cfset setFileName(arguments.filename)>
		<cfset setTCount(arguments.tcount)>

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

<!--- Name --->
	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Name = arguments.value>
	</cffunction>
	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn variables.instance.name>
	</cffunction>

<!--- Package --->
	<cffunction name="setPackage" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Package = arguments.value>
	</cffunction>
	<cffunction name="getPackage" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Package>
	</cffunction>

<!--- KeySetID --->
	<cffunction name="setKeySetID" access="public" output="false" returnKeySetID="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.KeySetID = arguments.value>
	</cffunction>
	<cffunction name="getKeySetID" access="public" output="false" returnKeySetID="string">
		<cfreturn variables.instance.KeySetID>
	</cffunction>

<!--- EventKey --->
	<cffunction name="setEventKey" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.EventKey = arguments.value>
	</cffunction>
	<cffunction name="getEventKey" access="public" output="false" returntype="string">
		<cfreturn variables.instance.EventKey>
	</cffunction>

<!--- MatchString --->
	<cffunction name="setMatchString" access="public" output="false" returnMatchString="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.MatchString = arguments.value>
	</cffunction>
	<cffunction name="getMatchString" access="public" output="false" returnMatchString="string">
		<cfreturn variables.instance.MatchString>
	</cffunction>

<!--- Data --->
	<cffunction name="setData" access="public" output="false" returnData="void">
		<cfargument name="value" type="struct" required="true">
		<cfset variables.instance.Data = arguments.value>
	</cffunction>
	<cffunction name="getData" access="public" output="false" returnData="struct">
		<cfreturn variables.instance.Data>
	</cffunction>

<!--- Extra --->
	<cffunction name="setExtra" access="public" output="false" returnExtra="void">
		<cfargument name="value" type="array" required="true">
		<cfset variables.instance.Extra = arguments.value>
	</cffunction>
	<cffunction name="getExtra" access="public" output="false" returnExtra="array">
		<cfreturn variables.instance.Extra>
	</cffunction>

<!--- Validated --->
	<cffunction name="setValidated" access="public" output="false" returntype="void">
		<cfargument name="value" type="boolean" required="true">
		<cfset variables.instance.Validated = arguments.value>
	</cffunction>
	<cffunction name="getValidated" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.Validated>
	</cffunction>

<!--- IsValid --->
	<cffunction name="setIsValid" access="public" output="false" returntype="void">
		<cfargument name="value" type="boolean" required="true">
		<cfset variables.instance.IsValid = arguments.value>
	</cffunction>
	<cffunction name="getIsValid" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.IsValid>
	</cffunction>

<!--- Failed --->
	<cffunction name="setFailed" access="public" output="false" returntype="void">
		<cfargument name="value" type="array" required="true">
		<cfset variables.instance.Failed = arguments.value>
	</cffunction>
	<cffunction name="getFailed" access="public" output="false" returntype="array">
		<cfreturn variables.instance.Failed>
	</cffunction>

<!--- FileName --->
	<cffunction name="setFileName" access="public" output="false" returnFileName="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.FileName = arguments.value>
	</cffunction>
	<cffunction name="getFileName" access="public" output="false" returnFileName="string">
		<cfreturn variables.instance.FileName>
	</cffunction>


<!--- tCount --->
	<cffunction name="setTCount" access="public" output="false" returntype="void">
		<cfargument name="value" type="numeric" required="true">
		<cfset variables.instance.tCount = arguments.value>
	</cffunction>
	<cffunction name="getTCount" access="public" output="false" returntype="numeric">
		<cfreturn variables.instance.tCount>
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset variables.instance.ValueStruct[arguments.name] = arguments.value>
	</cffunction>
	<cffunction name="getValue" access="public" output="false" returntype="string">
		<cfargument name="name" type="string" required="true">
		<cfreturn variables.instance.ValueStruct[arguments.name]>
	</cffunction>

	<cffunction name="valueExists" access="public" output="false" returntype="boolean">
		<cfargument name="name" type="string" required="true">
		<cfreturn structKeyExists(variables.instance.ValueStruct,name)>
	</cffunction>

	<cffunction name="getAllValues" access="public" output="false" returntype="struct">
		<cfargument name="name" type="string" required="true">
		<cfreturn variables.instance.ValueStruct>
	</cffunction>

	<cffunction name="setValidationError" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		<cfset setIsValid( false )>
		<cfset variables.instance.ValidationErrorStruct[arguments.name] = arguments.value>
	</cffunction>
	<cffunction name="getValidationErrors" access="public" output="false" returntype="struct">
		<cfreturn variables.instance.ValidationErrorStruct>
	</cffunction>
</cfcomponent>
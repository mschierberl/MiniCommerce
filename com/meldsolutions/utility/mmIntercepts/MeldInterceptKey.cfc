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
<cfcomponent displayname="MeldInterceptKey" output="false">
	<cfproperty name="name" required="true" type="string" hint="name of variable">
	<cfproperty name="validate" required="false" type="boolean" hint="do validation" default="false">
	<cfproperty name="type" required="false" type="string" hint="type: alpha, number, boolean, regex (string)" default="">
	<cfproperty name="regex" required="false" type="string" hint="regex value" default="">
	<cfproperty name="maxlength" required="false" type="string" hint="maximum length of value" default="">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldInterceptKey">
		<cfargument name="name" required="true" type="string">
		<cfargument name="validate" required="false" type="string" default="false">
		<cfargument name="type" required="false" type="string" default="any">
		<cfargument name="regex" required="false" type="string" default="">
		<cfargument name="maxlength" required="false" type="string" default="">

		<cfset setName(arguments.Name)>
		<cfset setValidate(arguments.validate)>
		<cfset setType(arguments.type)>
		<cfset setRegex(arguments.regex)>
		<cfset setMaxLength(arguments.maxlength)>

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
		<cfreturn variables.instance.Name>
	</cffunction>
	
<!--- Validate --->
	<cffunction name="setValidate" access="public" output="false" returntype="void">
		<cfargument name="value" type="boolean" required="true">
		<cfset variables.instance.Validate = arguments.value>
	</cffunction>
	<cffunction name="getValidate" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.Validate>
	</cffunction>

<!--- Type --->
	<cffunction name="setType" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Type = arguments.value>
	</cffunction>
	<cffunction name="getType" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Type>
	</cffunction>

<!--- Regex --->
	<cffunction name="setRegex" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Regex = arguments.value>
	</cffunction>
	<cffunction name="getRegex" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Regex>
	</cffunction>

<!--- MaxLength --->
	<cffunction name="setMaxLength" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.MaxLength = arguments.value>
	</cffunction>
	<cffunction name="getMaxLength" access="public" output="false" returntype="string">
		<cfreturn variables.instance.MaxLength>
	</cffunction>
</cfcomponent>
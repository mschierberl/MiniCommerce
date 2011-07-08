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
<cfcomponent displayname="MeldIntercept" output="false">
	<cfproperty name="name" required="true" type="string" hint="friendy name of the intercept">
	<cfproperty name="package" required="true" type="string" hint="package name of the intercept">
	<cfproperty name="isActive" required="true" type="boolean" hint="type of intercept: keyword, path, regex" default="true">
	<cfproperty name="siteID" required="true" type="string" hint="siteID for the intercept" default="">
	<cfproperty name="intercept" required="false" type="string" hint="intercept trigger value" default="">
	<cfproperty name="pathprefix" required="false" type="string" hint="document path preceding intercept" default="">
	<cfproperty name="matchFromRoot" required="false" type="boolean" hint="the path-based prefix must match from the document root onward" default="false">
	<cfproperty name="strict" required="false" type="boolean" hint="must match the full / ... / in the path" default="false">
	<cfproperty name="recurse" required="false" type="boolean" hint="will match keys below the root directory" default="false">
	<cfproperty name="regex" required="false" type="string" hint="regex value" default="">
	<cfproperty name="extravars" required="false" type="string" hint="path elements not specifically identified with keys will be placed in this variable name" default="extravars">
	<cfproperty name="identmatchesonly" required="false" type="boolean" hint="only exact keyset itent matches will be fully processed (intercept will function regardless)" default="false">
	<cfproperty name="keysets" required="false" type="array" hint="an array of structures, which will be turned into keysets">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldIntercept">
		<cfargument name="name" required="true" type="string">
		<cfargument name="package" required="true" type="string">
		<cfargument name="siteID" required="true" type="string">
		<cfargument name="isActive" required="false" type="boolean" default="true">
		<cfargument name="intercept" required="false" type="string" default="">
		<cfargument name="pathprefix" required="false" type="string" default="">
		<cfargument name="matchFromRoot" required="false" type="boolean" default="false">
		<cfargument name="strict" required="false" type="boolean" default="false">
		<cfargument name="recurse" required="false" type="boolean" default="false">
		<cfargument name="regex" required="false" type="string" default="">
		<cfargument name="extravars" required="false" type="string" default="">
		<cfargument name="identmatchesonly" required="false" type="boolean" default="false">
		<cfargument name="keysets" required="false" type="array" default="#ArrayNew(1)#">


		<cfset variables.instance.KeySets = ArrayNew(1)>
		<cfset variables.instance.KeySetStruct = StructNew()>

		<cfset setName(arguments.name)>
		<cfset setPackage(arguments.package)>
		<cfset setSiteID(arguments.siteID)>
		<cfset setIsActive(arguments.isActive)>
		<cfset setIntercept(arguments.intercept)>
		<cfset setPathPrefix(arguments.pathprefix)>
		<cfset setMatchFromRoot(arguments.matchFromRoot)>
		<cfset setStrict(arguments.Strict)>
		<cfset setRecurse(arguments.recurse)>
		<cfset setRegex(arguments.regex)>
		<cfset setExtraVars(arguments.extravars)>
		<cfset setIdentMatchesOnly(arguments.identmatchesonly)>
		<cfset setKeySets(arguments.keysets)>

		<cfset setUseIdents( ArrayLen(arguments.keysets) )>

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

<!--- SiteID --->
	<cffunction name="setSiteID" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.SiteID = arguments.value>
	</cffunction>
	<cffunction name="getSiteID" access="public" output="false" returntype="string">
		<cfreturn variables.instance.SiteID>
	</cffunction>


<!--- IsActive --->
	<cffunction name="setIsActive" access="public" output="false" returntype="void">
		<cfargument name="value" type="boolean" required="true">
		<cfset variables.instance.IsActive = arguments.value>
	</cffunction>
	<cffunction name="getIsActive" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.IsActive>
	</cffunction>

<!--- Intercept --->
	<cffunction name="setIntercept" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Intercept = arguments.value>
	</cffunction>
	<cffunction name="getIntercept" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Intercept>
	</cffunction>

<!--- PathPrefix --->
	<cffunction name="setPathPrefix" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.PathPrefix = arguments.value>
	</cffunction>
	<cffunction name="getPathPrefix" access="public" output="false" returntype="string">
		<cfreturn variables.instance.PathPrefix>
	</cffunction>

<!--- MatchFromRoot --->
	<cffunction name="setMatchFromRoot" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.MatchFromRoot = arguments.value>
	</cffunction>
	<cffunction name="getMatchFromRoot" access="public" output="false" returntype="string">
		<cfreturn variables.instance.MatchFromRoot>
	</cffunction>
	
<!--- Strict --->
	<cffunction name="setStrict" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Strict = arguments.value>
	</cffunction>
	<cffunction name="getStrict" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Strict>
	</cffunction>
	
<!--- recurse --->
	<cffunction name="setRecurse" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.recurse = arguments.value>
	</cffunction>
	<cffunction name="getRecurse" access="public" output="false" returntype="string">
		<cfreturn variables.instance.recurse>
	</cffunction>

<!--- Regex --->
	<cffunction name="setRegex" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.Regex = arguments.value>
	</cffunction>
	<cffunction name="getRegex" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Regex>
	</cffunction>

<!--- ExtraVars --->
	<cffunction name="setExtraVars" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.ExtraVars = arguments.value>
	</cffunction>
	<cffunction name="getExtraVars" access="public" output="false" returntype="string">
		<cfreturn variables.instance.ExtraVars>
	</cffunction>

<!--- IdentMatchesOnly --->
	<cffunction name="setIdentMatchesOnly" access="public" output="false" returntype="void">
		<cfargument name="value" type="boolean" required="true">
		<cfset variables.instance.IdentMatchesOnly = arguments.value>
	</cffunction>
	<cffunction name="getIdentMatchesOnly" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.IdentMatchesOnly>
	</cffunction>

<!--- UseIdents --->
	<cffunction name="setUseIdents" access="public" output="false" returntype="void">
		<cfargument name="value" type="string" required="true">
		<cfset variables.instance.UseIdents = arguments.value>
	</cffunction>
	<cffunction name="getUseIdents" access="public" output="false" returntype="string">
		<cfreturn variables.instance.UseIdents>
	</cffunction>

<!--- KeySets --->
	<cffunction name="setKeySets" access="public" output="false" returntype="void">
		<cfargument name="value" type="array" required="true">
		<cfset var iiX = 0>
		<cfset var MeldInterceptKeySet = "">

		<cfloop from="1" to="#ArrayLen(arguments.value)#" index="iiX">
			<cfset MeldInterceptKeySet = createObject("component","MeldInterceptKeySet").init(argumentCollection=arguments.value[iiX])>
			<cfset variables.instance.KeySetstruct[MeldInterceptKeySet.getID()] = MeldInterceptKeySet>
			<cfset ArrayAppend(variables.instance.KeySets,MeldInterceptKeySet)>
		</cfloop>
	</cffunction>

	<cffunction name="getKeySets" access="public" output="false" returntype="array">
		<cfreturn variables.instance.KeySets>
	</cffunction>

	<cffunction name="addKeySet" access="public" output="false" returntype="void">
		<cfargument name="value" type="any" required="true">
		<cfset var MeldInterceptKeySet = arguments.value>
		<cfset variables.instance.KeySetstruct[MeldInterceptKeySet.getID()] = MeldInterceptKeySet>
		<cfset ArrayAppend(variables.instance.KeySets,MeldInterceptKeySet)>
	</cffunction>

	<cffunction name="getKeySet" access="public" output="false" returntype="any">
		<cfargument name="value" type="string" required="true">
		<cfreturn variables.instance.KeySetstruct[value]>
	</cffunction>
	<cffunction name="keySetExists" access="public" output="false" returntype="boolean">
		<cfargument name="value" type="string" required="true">
		<cfreturn structKeySetExists(variables.instance.KeySetstruct,value)>
	</cffunction>

	<cffunction name="dumpValues" access="public" output="false" returntype="struct">
		<cfargument name="doAbort" type="boolean" required="false" default="false">

		<cfset var str = "">
		<cfset var keyset = getKeySets()>
		<cfset var dumpStruct = StructNew()>

		<cfset dumpStruct = StructCopy(getMemento())>
		<cfset dumpStruct.keysets = ArrayNew(1)>
		<cfset structDelete(dumpStruct,"keysetstruct")>
		<cfloop from="1" to="#ArrayLen( keyset )#" index="iiX">
			<cfset ArrayAppend( dumpStruct.keysets,keyset[iiX].dumpValues() )>
		</cfloop>
		<cfif arguments.doAbort>
			<cfdump var="#dumpStruct#">
			<cfabort>
		</cfif>
		<cfreturn dumpStruct>
	</cffunction></cfcomponent>
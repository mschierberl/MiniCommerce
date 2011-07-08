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
<cfcomponent displayname="mmErrorManager" output="false">

	<cffunction name="init" access="public" output="false" returntype="mmErrorManager">
		<cfreturn this/>
	</cffunction>

	<cffunction name="purge" access="public" output="false" returntype="void">
	</cffunction>

	<cffunction name="hasErrors" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="any" required="true">
		<cfargument name="type" type="string" required="false" default="">
		<cfargument name="byExclude" type="boolean" required="false" default="false">

		<cfset var aErrors = getErrors(arguments.event)>

		<cfif len(arguments.type)>
			<cfset aErrors  = getErrorsByType(arguments.event,arguments.type,arguments.byExclude)>
			<cfreturn ArrayLen(aErrors) gt 0>
		<cfelse>
			<cfreturn ArrayLen(aErrors) gt 0>
		</cfif>
	</cffunction>

	<cffunction name="displayErrorsHTML" access="public" output="false" returntype="string">
		<cfargument name="event" type="any" required="true">
		<cfargument name="type" type="string" required="false" default="">
		<cfargument name="byExclude" type="boolean" required="false" default="false">
		
		<cfset var aErrors  = ArrayNew(1)>
		<cfset var sReturn	= "">
		<cfset var iiX		= "">

		<cfset aErrors = getErrorsByType(arguments.event,arguments.type,arguments.byExclude)>

		<cfif not ArrayLen(aErrors)>
			<cfreturn sReturn>
		</cfif>

		<cfsavecontent variable="sReturn"><cfoutput>
		<ul style="list-style: none">
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="iiX">
			<li class="code#aErrors[iiX].getCode()#">#aErrors[iiX].getMessage()# <cfif len( aErrors[iiX].getDetail() )>(<a href="##" onclick="return doShowHide('ed#iiX#')">#getmmResourceBundle().key("more")#</a>)</cfif>
			<div class="errordetail" style="display: none" id="ed#iiX#">'#aErrors[iiX].getDetail()#'</div>
			</li>
		</cfloop>
		</ul>
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="iiX">
			
		</cfloop>
		</cfoutput></cfsavecontent>
		<cfreturn sReturn>
	</cffunction>

	<cffunction name="addError" access="public" output="false" returntype="void">
		<cfargument name="event" type="any" required="true">
		<cfargument name="message" type="string" required="true">
		<cfargument name="type" type="string" required="false" default="">
		<cfargument name="code" type="string" required="false" default="">
		<cfargument name="detail" type="string" required="false" default="">
		<cfargument name="throw" type="boolean" required="false" default="false">
		
		<cfset var errorBean = "">
		<cfset var aErrors = ArrayNew(1)>

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors"))>
			<cfset arguments.event.setValue("MeldErrors",ArrayNew(1))>
		</cfif>
	
		<cfset aErrors = arguments.event.getValue("MeldErrors")>
		
		<cfif arguments.type eq "custom">
			<cfset errorBean = createObject("component","errorBean").init( getmmResourceBundle().key(arguments.message,'error'),arguments.type,arguments.code,arguments.detail )>
		<cfelseif arguments.type eq "notice">
			<cfset errorBean = createObject("component","errorBean").init( getmmResourceBundle().key(arguments.message,'notice'),arguments.type,arguments.code,arguments.detail )>
		<cfelse>
			<cfset errorBean = createObject("component","errorBean").init( arguments.message,arguments.type,arguments.code,arguments.detail )>
		</cfif>
		
		<cfif arguments.throw>
			<cfthrow type="custom" message="#errorBean.getMessage()#" />
		</cfif>
		
		<cfset ArrayAppend(aErrors,errorBean)>
		<cfset arguments.event.setValue("MeldErrors",aErrors)>
	</cffunction>

	<cffunction name="addErrorByCode" access="public" output="false" returntype="void">
		<cfargument name="event" type="any" required="true">
		<cfargument name="code" type="string" required="false" default="">
		
		<cfset var errorBean	= "">
		<cfset var aErrors		= ArrayNew(1)>
		<cfset var msg			= getmmResourceBundle().key("error#code#","error")>

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors"))>
			<cfset arguments.event.setValue("MeldErrors",ArrayNew(1))>
		</cfif>
	
		<cfset aErrors = arguments.event.getValue("MeldErrors")>
		<cfset errorBean = createObject("component","errorBean").init( getmmResourceBundle().key("error#code#","error"),"custom",arguments.code )>

		<cfset getMuraManager().getBean('utility').logEvent("#arguments.code#: #getmmResourceBundle().key("error#code#","error")#","","Meld",false)>		
		
		<cfset ArrayAppend(aErrors,errorBean)>
		<cfset arguments.event.setValue("MeldErrors",aErrors)>
	</cffunction>

	<cffunction name="getErrors" access="public" output="false" returntype="array">
		<cfargument name="event" type="any" required="true">
		<cfargument name="type" type="string" required="false" default="">

		<cfset var aErrors  = ArrayNew(1)>

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors") )>
			<cfreturn aErrors>
		</cfif>

		<cfreturn arguments.event.getValue("MeldErrors")>
	</cffunction>

	<cffunction name="getErrorsByCode" access="public" output="false" returntype="array">
		<cfargument name="event" type="any" required="true">
		<cfargument name="code" type="string" required="false" default="">
		
		<cfset var aErrors  = ArrayNew(1)>
		<cfset var rErrors  = ArrayNew(1)>
		<cfset var iiX = "">

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors"))>
			<cfreturn aErrors>
		</cfif>

		<cfset aErrors = arguments.event.getValue("MeldErrors")>

		<cfloop from="1" to="#ArrayLen(aErrors)#" index="iiX">
			<cfif aErrors[iiX].getCode() eq arguments.code>
				<cfset arrayAppend(rErrors,aErrors[iiX])>
			</cfif>
		</cfloop>

		<cfreturn rErrors>
	</cffunction>

	<cffunction name="getErrorsByType" access="public" output="false" returntype="array">
		<cfargument name="event" type="any" required="true">
		<cfargument name="type" type="string" required="false" default="">
		<cfargument name="byExclude" type="boolean" required="false" default="false">
		
		<cfset var aErrors  = ArrayNew(1)>
		<cfset var rErrors  = ArrayNew(1)>
		<cfset var iiX = "">

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors") )>
			<cfreturn aErrors>
		</cfif>

		<cfset aErrors = arguments.event.getValue("MeldErrors")>
	
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="iiX">
			<cfif not len(arguments.type)>
				<cfset arrayAppend(rErrors,aErrors[iiX])>
			<cfelseif aErrors[iiX].getType() eq arguments.type and not arguments.byExclude>
				<cfset arrayAppend(rErrors,aErrors[iiX])>
			<cfelseif aErrors[iiX].getType() neq arguments.type and arguments.byExclude>
				<cfset arrayAppend(rErrors,aErrors[iiX])>
			<cfelseif arguments.type eq "other" and aErrors[iiX].getType() neq "custom" and aErrors[iiX].getType() neq "notice">
				<cfset arrayAppend(rErrors,aErrors[iiX])>
			</cfif>
		</cfloop>
		<cfreturn rErrors>
	</cffunction>

	<cffunction name="dumpErrors" access="public" output="true" returntype="void">
		<cfargument name="event" type="any" required="true">
		<cfset var iiX = "">
		<cfset var aErrors  = ArrayNew(1)>

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors") )>
			<cfreturn>
		</cfif>

		<cfset aErrors = arguments.event.getValue("MeldErrors")>

		<cfloop from="1" to="#ArrayLen(aErrors)#" index="iiX">
			<cfdump var="#aErrors[iiX].getMemento()#">
		</cfloop>
	</cffunction>

	<cffunction name="throwErrors" access="public" output="true" returntype="void">
		<cfargument name="event" type="any" required="true">
		<cfargument name="detail" type="any" required="true" default="">

		<cfset var iiX = "">
		<cfset var aErrorString  = "">

		<cfif isSimpleValue( arguments.event.getValue("MeldErrors") )>
			<cfreturn>
		</cfif>

		<cfset aErrors = arguments.event.getValue("MeldErrors")>

		<cfloop from="1" to="#ArrayLen(aErrors)#" index="iiX">
			<cfset aErrorString = aErrorString & aErrors[iiX].getMessage() & "<br>" />
		</cfloop>
		
		<cfthrow type="custom" message="#aErrorString#" detail="#arguments.detail#" />
	</cffunction>

	<cffunction name="setMuraManager" access="public" returntype="any" output="false">
		<cfargument name="MuraManager" type="any" required="true">
		<cfset variables.MuraManager = arguments.MuraManager>
	</cffunction>
	<cffunction name="getMuraManager" access="public" returntype="any" output="false">
		<cfreturn variables.MuraManager>
	</cffunction>

	<cffunction name="setmmResourceBundle" access="public" returntype="any" output="false">
		<cfargument name="mmResourceBundle" type="any" required="true">
		<cfset variables.mmResourceBundle = arguments.mmResourceBundle>
	</cffunction>
	<cffunction name="getmmResourceBundle" access="public" returntype="any" output="false">
		<cfreturn variables.mmResourceBundle>
	</cffunction>
</cfcomponent>
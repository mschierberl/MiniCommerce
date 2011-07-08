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
<cfcomponent displayname="MeldInterceptManager" hint="Intercepts Mura Urls and parses out strings for application data" output="false">
	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldInterceptManager">
		<cfset resetIntercepts()>
		<cfreturn this/>
	</cffunction>

	<cffunction name="loadInterceptFromXML" access="public" returntype="void" output="false">
		<cfargument name="xmlParsed" type="XML" required="true">
		
		<cfset var MeldIntercept = "">
		<cfset var iStruct = StructNew()>
	
		<cfset iStruct = xmlChildrenToStruct(xmlParsed.xmlRoot)>
		<cfif structKeyExists(iStruct,"isActive") and iStruct.isActive>
			<cfset MeldIntercept = createObject("component","MeldIntercept").init(argumentCollection=iStruct)>
			<cfset addIntercept(MeldIntercept)>
		</cfif>
	</cffunction>

	<cffunction name="resetIntercepts" access="public" returntype="void" output="false">
		<cfset variables.instance.Intercepts = ArrayNew(1)>
		<cfset variables.instance.InterceptStruct = StructNew()>
		<cfset variables.instance.InterceptIdentArray = ArrayNew(1)>
	</cffunction>


	<cffunction name="readInterceptsFromDirectory" access="public" returntype="void" output="false">
		<cfargument name="interceptPath" required="true" type="string">
		<cfset var loadXML = "">
		<cfset var xmlParsed = "">
	
		<cfif not directoryExists(arguments.interceptPath)>
			<cfthrow type="Custom" message="interceptpath directory at #xmlPath# does not exists">
		</cfif>
		<cfdirectory action="list" directory="#arguments.interceptPath#" name="interceptList" filter="*.xml.cfm">
		
		<cfloop query="interceptList">
			<cffile action="read" file="#arguments.interceptPath#/#name#" variable="loadXML" />
			<cfset xmlParsed = xmlParse(loadXML)>
			<cfset loadInterceptFromXML(xmlParsed)>			
		</cfloop>
	</cffunction>

	<cffunction name="getIntercepts" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="true">
		
		<cfset var aIntercepts = ArrayNew(1)>		
		<cfset var iiX = "">		

		<cfif not siteInterceptsExist(arguments.siteID)>
			<cfreturn aIntercepts>
		</cfif>
		
		<cfloop collection="#variables.instance.InterceptStruct[arguments.siteID]#" item="iiX">
			<cfset ArrayAppend(aIntercepts,variables.instance.InterceptStruct[arguments.siteID][iiX])>
		</cfloop>
		<cfreturn aIntercepts>
	</cffunction>

	<cffunction name="addIntercept" access="public" output="false" returntype="void">
		<cfargument name="value" type="any" required="true">
		<cfset var MeldIntercept = arguments.value>

		<cfif not StructKeyExists(variables.instance.InterceptStruct,MeldIntercept.getSiteID())>
			<cfset variables.instance.InterceptStruct[MeldIntercept.getSiteID()] = StructNew()>
		</cfif>
		<cfset variables.instance.InterceptStruct[MeldIntercept.getSiteID()][MeldIntercept.getPackage()] = MeldIntercept>

		<cfset ArrayAppend(variables.instance.Intercepts,MeldIntercept)>
	</cffunction>

	<cffunction name="getIntercept" access="public" output="false" returntype="any">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="package" type="string" required="true">
		<cfif interceptExists(arguments.siteID,arguments.package)>
			<cfreturn variables.instance.InterceptStruct[siteID][package]>
		<cfelse>
			<cfreturn "">
		</cfif>
	</cffunction>

	<cffunction name="siteInterceptsExist" access="public" output="false" returntype="boolean">
		<cfargument name="siteID" type="string" required="true">
		<cfreturn structKeyExists(variables.instance.InterceptStruct,siteID)>
	</cffunction>

	<cffunction name="interceptExists" access="public" output="false" returntype="boolean">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="value" type="string" required="true">
		<cfreturn structKeyExists(variables.instance.InterceptStruct,siteID) AND structKeyExists(variables.instance.InterceptStruct[siteID],value)>
	</cffunction>

	<cffunction name="processPath" access="public" returntype="void" output="false">
		<cfargument name="$" type="any" required="false" default="">

		<cfset var iArray = getIntercepts($.event("siteID"))>
		<cfset var ksArray = ArrayNew(1)>
		<cfset var iiX = 0>
		<cfset var iiY = 0>
		<cfset var MeldIntercept = "">
		<cfset var MeldInterceptKeySet = "">
		<cfset var useIdents = false>
		<cfset var matchPos = 0>
		<cfset var keyPos = 0>
		<cfset var matchStruct = "">
		<cfset var matchString = "">
		<cfset var fullMatchString = "">
		<cfset var tCountStart = getTickCount()>

		<!--- get rid of any extra path information --->
		<cfset var path = rereplace($.event("path"),"/.[^/]*$","/")>
		
		<!--- first, look for intercept matches --->
		<cfloop from="1" to="#ArrayLen(iArray)#" index="iiX">
			<cfset MeldIntercept = iArray[iiX]>
			<cfset matchString = iif(len(MeldIntercept.getPathPrefix()),de( MeldIntercept.getPathPrefix() & "/"),de("")) & MeldIntercept.getIntercept()>
			<cfif MeldIntercept.getMatchFromRoot() and len( matchString )>
				<cfif left($.event("currentfilename"),len( matchstring )) eq matchString>
					<cfset matchPos = findNoCase( "/#matchString#/",path )+1>
					<cfif matchPos gt 1>
						<cfbreak>
					</cfif>
				</cfif>
			<cfelseif len( matchString )>
				<cfset matchPos = findNoCase( "/#matchString#/",path )+1>
				<cfif matchPos gt 1>
					<cfbreak>
				</cfif>
			</cfif>
		</cfloop>

		<!--- next, look for keyset matches --->
		<cfif matchPos gt 1 and len(path) gt (matchPos + len(matchString))>
			<!--- look for intercept Key matches if we actually have keysets to match --->
			<cfif ArrayLen( MeldIntercept.getKeySets() ) gt 1>
				<cfset ksArray = MeldIntercept.getKeySets()>
				<cfloop from="1" to="#ArrayLen(ksArray)#" index="iiY">
					<cfset MeldInterceptKeySet = ksArray[iiY]>
					<!--- blank id, a no no! --->
					<cfif not len( MeldInterceptKeySet.getID() )>
						<cfbreak>
					</cfif>
					<!--- use "/" as the demarcation for the end of the match --->
					<cfif MeldInterceptKeySet.getID() & "/" eq mid(path,matchPos+len(matchString)+1,len(MeldInterceptKeySet.getID())+1)>
						<cfset keyPos = findnocase(MeldInterceptKeySet.getID() & "/",path,matchPos)>
						<cfset processMatch( MeldIntercept,$.event(),keyPos,matchString,tCountStart,MeldInterceptKeySet )>
						<cfreturn>
					<cfelseif MeldIntercept.getRecurse() and findnocase(MeldInterceptKeySet.getID() & "/",mid(path,matchPos+len(matchString)+1,len(path)))>
						<cfset keyPos = findnocase(MeldInterceptKeySet.getID() & "/",path,matchPos)>
						<cfset processMatch( MeldIntercept,$.event(),keyPos,matchString,tCountStart,MeldInterceptKeySet )>
						<cfreturn>
					</cfif>
				</cfloop>
				<!--- no match, so we bail (it's either a real Mura page or a 404/bad request) --->
				<cfif MeldIntercept.getStrict()>
					<cfreturn>
				</cfif>
			<!--- found only one keyset in the array --->
			<cfelse>
				<cfset ksArray = MeldIntercept.getKeySets()>
				<cfset keyPos = findnocase(ksArray[1].getID() & "/",path,matchPos)>
				<cfset processMatch( MeldIntercept,$.event(),keyPos,matchString,tCountStart,ksArray[1])>
				<cfreturn>
			</cfif>
		<!--- matched root of intercept, that is all; we'll use this if not strict --->
		<cfelseif matchPos gt 1 and not MeldIntercept.getStrict()>
			<cfset keyPos = findNoCase( "/#matchString#/",path ) + len(matchString) + 2>
			<cfset processMatch( MeldIntercept,$.event(),keyPos,matchString,tCountStart )>
			<cfreturn>
		</cfif>


		<cfif matchPos gt 1 and not MeldIntercept.getStrict()>
			<cfset keyPos = findNoCase( "/#matchString#/",path ) + len(matchString) + 2>
			<cfset processMatch( MeldIntercept,$.event(),keyPos,matchString,tCountStart )>
			<cfreturn>
		</cfif>

		<cfreturn>
	</cffunction>

	<cffunction name="processMatch" access="private" returntype="void" output="false">
		<cfargument name="MeldIntercept" type="any" required="true">
		<cfargument name="event" type="any" required="true">
		<cfargument name="keyPos" type="numeric" required="true">
		<cfargument name="matchString" type="string" required="true">
		<cfargument name="timeCount" type="numeric" required="true">
		<cfargument name="MeldInterceptKeySet" type="any" required="false">

		<cfset var newPath				= "">
		<cfset var newFileName			= "">
		<cfset var valueArray			= ArrayNew(1)>
		<cfset var MeldInterceptResponse	= "">
		<cfset var preMatch				= 0>

		<!--- our newpath ends where we find our keyPos (the beginning of the matched key) --->
		<cfset newPath = left(arguments.event.getValue("path"),arguments.keyPos-1)>
		<!--- our newfilename is newpath with the siteID trimmed off, we just find the first non-leading (i.e. second) slash and zip to the end --->
		<cfset newFileName	= mid(newPath,refind("./",newPath)+2,len(newPath))>
		<!--- no trailing slash allowed, remove if found --->
		<cfset newFileName = rereplace(newFileName,"\/$","")>
		<!--- everything from the keyPos on is going to be values for the response --->
		<cfset valueArray = listToArray( mid(arguments.event.getValue("path"),arguments.keyPos,len(arguments.event.getValue("path"))),"/" )>

		<cfset arguments.event.setValue("path",newPath)>
		<cfset arguments.event.setValue("currentfilename",newFileName)>

		<cfif isDefined("arguments.MeldInterceptKeySet")>
			<cfset MeldInterceptResponse = createResponse( arguments.MeldIntercept,valueArray,arguments.matchString,newFilename,arguments.timeCount,arguments.MeldInterceptKeySet )>
		<cfelse>
			<cfset MeldInterceptResponse = createResponse( arguments.MeldIntercept,valueArray,arguments.matchString,newFilename,arguments.timeCount )>
		</cfif>

		<cfset arguments.event.setValue("MeldInterceptResponse",MeldInterceptResponse)>
		<cfreturn>
	</cffunction>

	<cffunction name="createResponse" access="private" returntype="any" output="false">
		<cfargument name="MeldIntercept" type="any" required="true">
		<cfargument name="valueArray" type="array" required="true">
		<cfargument name="matchString" type="string" required="true">
		<cfargument name="filename" type="string" required="true">
		<cfargument name="timeCount" type="numeric" required="true">
		<cfargument name="MeldInterceptKeySet" type="any" required="false">

		<cfset var MeldInterceptResponse = "">
		<cfset var MeldInterceptKey = "">
		<cfset var kArray = ArrayNew(1)>
		<cfset var iStruct = StructNew()>
		<cfset var dataStruct = StructNew()>
		<cfset var iiX = 0>
		<cfset var failedArray = ArrayNew(1)>
				
		<cfset iStruct.name			= MeldIntercept.getName()>
		<cfset iStruct.package		= MeldIntercept.getPackage()>
		<cfset iStruct.keysetID		= "">
		<cfset iStruct.eventKey		= "">
		<cfset iStruct.data			= StructNew()>
		<cfset iStruct.extra		= ArrayNew(1)>
		<cfset iStruct.filename		= arguments.filename>

		<cfif isDefined("arguments.MeldInterceptKeySet")>
			<cfif arguments.MeldInterceptKeySet.getID() eq valueArray[1]>
				<cfset ArrayDeleteAt(arguments.valueArray,1)>
			</cfif>
			<cfset iStruct.keysetID	= arguments.MeldInterceptKeySet.getID()>
			<cfset iStruct.eventKey	= arguments.MeldInterceptKeySet.getEventKey()>
			
			<cfset kArray = MeldInterceptKeySet.getKeys()>
			<!--- loop through the shorter of the two arrays --->
			<cfloop from="1" to="#iif( (ArrayLen(arguments.valueArray) lt ArrayLen(kArray)),de(ArrayLen(arguments.valueArray)),de(ArrayLen(kArray)))#" index="iiX">
				<cfset MeldInterceptKey = kArray[iiX]>
				<cfif MeldInterceptKey.getValidate() and len( MeldInterceptKey.getType() ) and not validateValue( MeldInterceptKey,arguments.valueArray[1] )>
					<cfset ArrayAppend( failedArray,MeldInterceptKey.getName() )>
				<cfelseif len( MeldInterceptKey.getMaxLength() ) and len( arguments.valueArray[1] ) gt MeldInterceptKey.getMaxLength()>
					<cfset ArrayAppend( failedArray,MeldInterceptKey.getName() )>
				</cfif>

				<cfset dataStruct[MeldInterceptKey.getName()] = arguments.valueArray[1]>
				<cfset ArrayDeleteAt(arguments.valueArray,1)>
			</cfloop>
		</cfif>
		<!--- tag anything extra on to ... well, extra --->
		<cfset iStruct.validated	= true>
		<cfset iStruct.isvalid		= not ArrayLen( failedArray )>
		<cfset iStruct.failed		= failedArray>
		<cfset iStruct.matchString	= arguments.matchString>
		<cfset iStruct.data			= dataStruct>
		<cfset iStruct.extra		= arguments.valueArray>
		<cfset iStruct.tCount		= getTickCount()-arguments.timeCount>

		<cfset MeldInterceptResponse = createObject("component","MeldInterceptResponse").init(argumentCollection=iStruct)>
		<cfreturn MeldInterceptResponse>
	</cffunction>

	<cffunction name="validateValue" access="private" returntype="any" output="false">
		<cfargument name="MeldInterceptKeySet" type="any" required="false">
		<cfargument name="value" type="string" required="true">

		<!--- any, number, boolean, regex (string) --->
		<cfswitch expression="#arguments.MeldInterceptKeySet.getType()#">
			<cfcase value="alpha">
				<cfif refindNoCase("^[[:alpha]].*$",arguments.value)>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="number,numeric">
				<cfif isNumeric(arguments.value)>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="boolean">
				<cfif isBoolean(arguments.value)>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="regex">
				<cfif refindNoCase("#arguments.MeldInterceptKeySet.getRegex()#",arguments.value)>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="string">
				<cfif len(arguments.value)>
					<cfreturn true>
				</cfif>
			</cfcase>
		</cfswitch>

		<cfreturn false>
	</cffunction>

	<cffunction name="xmlChildrenToStruct" access="private" returntype="any" output="false">
		<cfargument name="xmlChild" required="true" type="xml">

		<cfset var currentChild = "">
		<cfset var rsStruct = StructNew()>
		<cfset var iiX = 0>
		<cfset var iiY = 0>
		<cfset var cArray = ArrayNew(1)>
		<cfset var cStruct = StructNew()>

		<cfloop from="1" to="#ArrayLen(xmlChild.xmlChildren)#" index="iiX">
			<cfset currentChild = xmlChild.xmlChildren[iiX]>
			<cfif ArrayLen(currentChild.xmlChildren)>
				<cfloop from="1" to="#ArrayLen(currentChild.xmlChildren)#" index="iiY">
					<cfset cStruct = xmlChildrenToStruct(currentChild.xmlChildren[iiY])>	
					<cfset ArrayAppend(cArray,cStruct)>
				</cfloop>
				<cfset rsStruct["#currentChild.xmlName#"] = cArray>
			<cfelse>
				<cfset rsStruct["#currentChild.xmlName#"] = currentChild.xmlText>
			</cfif>
		</cfloop>

		<cfreturn rsStruct>
	</cffunction>

	<cffunction name="dumpValues" access="public" output="false" returntype="struct">
		<cfargument name="intercept" type="any">
		<cfargument name="doAbort" type="boolean" required="false" default="false">

		<cfset var str = "">
		<cfset var keyset = "">
		<cfset var dumpStruct = StructNew()>

		<cfset keyset = arguments.intercept.getKeySets()>
		<cfset dumpStruct = StructCopy(intercept.getMemento())>
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
	</cffunction>
</cfcomponent>
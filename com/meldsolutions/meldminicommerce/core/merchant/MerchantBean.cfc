<!---^^LICENSE-START^^--->

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

<!---^^LICENSE-END^^--->




<cfcomponent displayname="MerchantBean" output="false" extends="MeldMiniCommerce.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="MerchantID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="100" />
	<cfproperty name="IsActive" type="boolean" default="1" required="true" />
	<cfproperty name="Custom1label" type="string" default="" maxlength="50" />
	<cfproperty name="Custom2label" type="string" default="" maxlength="50" />
	<cfproperty name="Custom3label" type="string" default="" maxlength="50" />
	<cfproperty name="RemoteID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Package" type="string" default="" required="true" maxlength="50" />
	<cfproperty name="Bean" type="string" default="" required="true" maxlength="250" />
	<cfproperty name="Param1label" type="string" default="" maxlength="50" />
	<cfproperty name="Param2label" type="string" default="" maxlength="50" />
	<cfproperty name="Param3label" type="string" default="" maxlength="50" />
	<cfproperty name="Param4label" type="string" default="" maxlength="50" />
	<cfproperty name="Param5label" type="string" default="" maxlength="50" />
	<cfproperty name="Param6label" type="string" default="" maxlength="50" />
	<cfproperty name="Param7label" type="string" default="" maxlength="50" />
	<cfproperty name="Param8label" type="string" default="" maxlength="50" />
	<cfproperty name="Param9label" type="string" default="" maxlength="50" />
	<cfproperty name="Param1" type="string" default="" maxlength="250" />
	<cfproperty name="Param2" type="string" default="" maxlength="250" />
	<cfproperty name="Param3" type="string" default="" maxlength="250" />
	<cfproperty name="Param4" type="string" default="" maxlength="250" />
	<cfproperty name="Param5" type="string" default="" maxlength="250" />
	<cfproperty name="Param6" type="string" default="" maxlength="250" />
	<cfproperty name="Param7" type="string" default="" maxlength="250" />
	<cfproperty name="Param8" type="string" default="" maxlength="250" />
	<cfproperty name="Param9" type="string" default="" maxlength="250" />
	<cfproperty name="Params" type="string" default="" />
	<cfproperty name="IsCurrent" type="boolean" default="0" required="true" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="MerchantBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="MerchantID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="1" />
		<cfargument name="Custom1label" type="string" required="false" default="" />
		<cfargument name="Custom2label" type="string" required="false" default="" />
		<cfargument name="Custom3label" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="Package" type="string" required="false" default="" />
		<cfargument name="Bean" type="string" required="false" default="" />
		<cfargument name="Param1label" type="string" required="false" default="" />
		<cfargument name="Param2label" type="string" required="false" default="" />
		<cfargument name="Param3label" type="string" required="false" default="" />
		<cfargument name="Param4label" type="string" required="false" default="" />
		<cfargument name="Param5label" type="string" required="false" default="" />
		<cfargument name="Param6label" type="string" required="false" default="" />
		<cfargument name="Param7label" type="string" required="false" default="" />
		<cfargument name="Param8label" type="string" required="false" default="" />
		<cfargument name="Param9label" type="string" required="false" default="" />
		<cfargument name="Param1" type="string" required="false" default="" />
		<cfargument name="Param2" type="string" required="false" default="" />
		<cfargument name="Param3" type="string" required="false" default="" />
		<cfargument name="Param4" type="string" required="false" default="" />
		<cfargument name="Param5" type="string" required="false" default="" />
		<cfargument name="Param6" type="string" required="false" default="" />
		<cfargument name="Param7" type="string" required="false" default="" />
		<cfargument name="Param8" type="string" required="false" default="" />
		<cfargument name="Param9" type="string" required="false" default="" />
		<cfargument name="Params" type="string" required="false" default="" />
		<cfargument name="IsCurrent" type="boolean" required="false" default="0" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setMerchantID( arguments.MerchantID ) />
		<cfset setName( arguments.Name ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setCustom1label( arguments.Custom1label ) />
		<cfset setCustom2label( arguments.Custom2label ) />
		<cfset setCustom3label( arguments.Custom3label ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setPackage( arguments.Package ) />
		<cfset setBean( arguments.Bean ) />
		<cfset setParam1label( arguments.Param1label ) />
		<cfset setParam2label( arguments.Param2label ) />
		<cfset setParam3label( arguments.Param3label ) />
		<cfset setParam4label( arguments.Param4label ) />
		<cfset setParam5label( arguments.Param5label ) />
		<cfset setParam6label( arguments.Param6label ) />
		<cfset setParam7label( arguments.Param7label ) />
		<cfset setParam8label( arguments.Param8label ) />
		<cfset setParam9label( arguments.Param9label ) />
		<cfset setParam1( arguments.Param1 ) />
		<cfset setParam2( arguments.Param2 ) />
		<cfset setParam3( arguments.Param3 ) />
		<cfset setParam4( arguments.Param4 ) />
		<cfset setParam5( arguments.Param5 ) />
		<cfset setParam6( arguments.Param6 ) />
		<cfset setParam7( arguments.Param7 ) />
		<cfset setParam8( arguments.Param8 ) />
		<cfset setParam9( arguments.Param9 ) />
		<cfset setParams( arguments.Params ) />
		<cfset setIsCurrent( arguments.IsCurrent ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="MerchantBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setMerchantID" access="public" returntype="void" output="false">
		<cfargument name="MerchantID" type="uuid" required="true" />
		<cfset variables.instance['merchantid'] = arguments.MerchantID />
	</cffunction>
	<cffunction name="getMerchantID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.MerchantID />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setCustom1label" access="public" returntype="void" output="false">
		<cfargument name="Custom1label" type="string" required="true" />
		<cfset variables.instance['custom1label'] = arguments.Custom1label />
	</cffunction>
	<cffunction name="getCustom1label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Custom1label />
	</cffunction>
	
	<cffunction name="setCustom2label" access="public" returntype="void" output="false">
		<cfargument name="Custom2label" type="string" required="true" />
		<cfset variables.instance['custom2label'] = arguments.Custom2label />
	</cffunction>
	<cffunction name="getCustom2label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Custom2label />
	</cffunction>
	
	<cffunction name="setCustom3label" access="public" returntype="void" output="false">
		<cfargument name="Custom3label" type="string" required="true" />
		<cfset variables.instance['custom3label'] = arguments.Custom3label />
	</cffunction>
	<cffunction name="getCustom3label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Custom3label />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setPackage" access="public" returntype="void" output="false">
		<cfargument name="Package" type="string" required="true" />
		<cfset variables.instance['package'] = arguments.Package />
	</cffunction>
	<cffunction name="getPackage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Package />
	</cffunction>
	
	<cffunction name="setBean" access="public" returntype="void" output="false">
		<cfargument name="Bean" type="string" required="true" />
		<cfset variables.instance['bean'] = arguments.Bean />
	</cffunction>
	<cffunction name="getBean" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Bean />
	</cffunction>
	
	<cffunction name="setParam1label" access="public" returntype="void" output="false">
		<cfargument name="Param1label" type="string" required="true" />
		<cfset variables.instance['param1label'] = arguments.Param1label />
	</cffunction>
	<cffunction name="getParam1label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param1label />
	</cffunction>
	
	<cffunction name="setParam2label" access="public" returntype="void" output="false">
		<cfargument name="Param2label" type="string" required="true" />
		<cfset variables.instance['param2label'] = arguments.Param2label />
	</cffunction>
	<cffunction name="getParam2label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param2label />
	</cffunction>
	
	<cffunction name="setParam3label" access="public" returntype="void" output="false">
		<cfargument name="Param3label" type="string" required="true" />
		<cfset variables.instance['param3label'] = arguments.Param3label />
	</cffunction>
	<cffunction name="getParam3label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param3label />
	</cffunction>
	
	<cffunction name="setParam4label" access="public" returntype="void" output="false">
		<cfargument name="Param4label" type="string" required="true" />
		<cfset variables.instance['param4label'] = arguments.Param4label />
	</cffunction>
	<cffunction name="getParam4label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param4label />
	</cffunction>
	
	<cffunction name="setParam5label" access="public" returntype="void" output="false">
		<cfargument name="Param5label" type="string" required="true" />
		<cfset variables.instance['param5label'] = arguments.Param5label />
	</cffunction>
	<cffunction name="getParam5label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param5label />
	</cffunction>
	
	<cffunction name="setParam6label" access="public" returntype="void" output="false">
		<cfargument name="Param6label" type="string" required="true" />
		<cfset variables.instance['param6label'] = arguments.Param6label />
	</cffunction>
	<cffunction name="getParam6label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param6label />
	</cffunction>
	
	<cffunction name="setParam7label" access="public" returntype="void" output="false">
		<cfargument name="Param7label" type="string" required="true" />
		<cfset variables.instance['param7label'] = arguments.Param7label />
	</cffunction>
	<cffunction name="getParam7label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param7label />
	</cffunction>
	
	<cffunction name="setParam8label" access="public" returntype="void" output="false">
		<cfargument name="Param8label" type="string" required="true" />
		<cfset variables.instance['param8label'] = arguments.Param8label />
	</cffunction>
	<cffunction name="getParam8label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param8label />
	</cffunction>
	
	<cffunction name="setParam9label" access="public" returntype="void" output="false">
		<cfargument name="Param9label" type="string" required="true" />
		<cfset variables.instance['param9label'] = arguments.Param9label />
	</cffunction>
	<cffunction name="getParam9label" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param9label />
	</cffunction>
	
	<cffunction name="setParam1" access="public" returntype="void" output="false">
		<cfargument name="Param1" type="string" required="true" />
		<cfset variables.instance['param1'] = arguments.Param1 />
	</cffunction>
	<cffunction name="getParam1" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param1 />
	</cffunction>
	
	<cffunction name="setParam2" access="public" returntype="void" output="false">
		<cfargument name="Param2" type="string" required="true" />
		<cfset variables.instance['param2'] = arguments.Param2 />
	</cffunction>
	<cffunction name="getParam2" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param2 />
	</cffunction>
	
	<cffunction name="setParam3" access="public" returntype="void" output="false">
		<cfargument name="Param3" type="string" required="true" />
		<cfset variables.instance['param3'] = arguments.Param3 />
	</cffunction>
	<cffunction name="getParam3" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param3 />
	</cffunction>
	
	<cffunction name="setParam4" access="public" returntype="void" output="false">
		<cfargument name="Param4" type="string" required="true" />
		<cfset variables.instance['param4'] = arguments.Param4 />
	</cffunction>
	<cffunction name="getParam4" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param4 />
	</cffunction>
	
	<cffunction name="setParam5" access="public" returntype="void" output="false">
		<cfargument name="Param5" type="string" required="true" />
		<cfset variables.instance['param5'] = arguments.Param5 />
	</cffunction>
	<cffunction name="getParam5" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param5 />
	</cffunction>
	
	<cffunction name="setParam6" access="public" returntype="void" output="false">
		<cfargument name="Param6" type="string" required="true" />
		<cfset variables.instance['param6'] = arguments.Param6 />
	</cffunction>
	<cffunction name="getParam6" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param6 />
	</cffunction>
	
	<cffunction name="setParam7" access="public" returntype="void" output="false">
		<cfargument name="Param7" type="string" required="true" />
		<cfset variables.instance['param7'] = arguments.Param7 />
	</cffunction>
	<cffunction name="getParam7" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param7 />
	</cffunction>
	
	<cffunction name="setParam8" access="public" returntype="void" output="false">
		<cfargument name="Param8" type="string" required="true" />
		<cfset variables.instance['param8'] = arguments.Param8 />
	</cffunction>
	<cffunction name="getParam8" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param8 />
	</cffunction>
	
	<cffunction name="setParam9" access="public" returntype="void" output="false">
		<cfargument name="Param9" type="string" required="true" />
		<cfset variables.instance['param9'] = arguments.Param9 />
	</cffunction>
	<cffunction name="getParam9" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Param9 />
	</cffunction>
	
	<cffunction name="setParams" access="public" returntype="void" output="false">
		<cfargument name="Params" type="string" required="true" />
		<cfset variables.instance['params'] = arguments.Params />
	</cffunction>
	<cffunction name="getParams" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Params />
	</cffunction>
	
	<cffunction name="setIsCurrent" access="public" returntype="void" output="false">
		<cfargument name="IsCurrent" type="boolean" required="true" />
		<cfset variables.instance['iscurrent'] = arguments.IsCurrent />
	</cffunction>
	<cffunction name="getIsCurrent" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsCurrent />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- BeanExists --->
	<cffunction name="setBeanExists" access="public" output="false" returntype="void">
		<cfargument name="BeanExists" type="boolean" required="true" />
		<cfset variables.BeanExists = arguments.BeanExists >
	</cffunction>
	<cffunction name="BeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>

	<!--- DUMP --->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	






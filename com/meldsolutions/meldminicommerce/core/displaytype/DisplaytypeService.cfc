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



<cfcomponent name="DisplaytypeService" output="false">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="DisplaytypeService">
		<cfargument name="DisplaytypeDAO" type="any" required="true" />
		<cfargument name="DisplaytypeGateway" type="any" required="true" />

		<cfset variables.DisplaytypeDAO = arguments.DisplaytypeDAO />
		<cfset variables.DisplaytypeGateway = arguments.DisplaytypeGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createDisplaytype" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="IsConfigurable" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Version" type="string" required="false" />
		<cfargument name="Defaults" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var DisplaytypeBean = createObject("component","DisplaytypeBean").init(argumentCollection=arguments) />
		<cfreturn DisplaytypeBean />
	</cffunction>

	<cffunction name="getDisplaytype" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var DisplaytypeBean = createDisplaytype(argumentCollection=arguments) />
		<cfset variables.DisplaytypeDAO.read(DisplaytypeBean) />
		<cfreturn DisplaytypeBean />
	</cffunction>

	<cffunction name="getDisplaytypes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="IsConfigurable" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Version" type="string" required="false" />
		<cfargument name="Defaults" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn variables.DisplaytypeGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="IsConfigurable" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Version" type="string" required="false" />
		<cfargument name="Defaults" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn variables.DisplaytypeGateway.getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Struct" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn variables.DisplaytypeGateway.getByArray(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var aDisplaytype			= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = variables.DisplaytypeGateway.search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset aDisplaytype				= variables.DisplaytypeGateway.search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start>
		<cfset sReturn.size			= arguments.size>
		<cfset sReturn.itemarray	= aDisplaytype>

		<cfreturn sReturn />
	</cffunction>
	

	<cffunction name="saveDisplaytype" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfreturn variables.DisplaytypeDAO.save(DisplaytypeBean) />
	</cffunction>
	
	<cffunction name="updateDisplaytype" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfreturn variables.DisplaytypeDAO.update(DisplaytypeBean) />
	</cffunction>

	<cffunction name="deleteDisplaytype" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var DisplaytypeBean = createDisplaytype(argumentCollection=arguments) />
		<cfreturn variables.DisplaytypeDAO.delete(DisplaytypeBean) />
	</cffunction>
<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>




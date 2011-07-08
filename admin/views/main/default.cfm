<cfsilent>
	<cfparam name="rc.renderCart" default="" />
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc		= rc>
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	<cfif len(rc.renderCart)>
		#rc.renderCart#
	<cfelse>
		#view('main\includes\dsp_dashboard')#
	</cfif>
</div>	
<!--- end content --->
</cfoutput> 
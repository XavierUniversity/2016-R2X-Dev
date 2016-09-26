<cfcomponent>

	<cfquery name="getDates" datasource="#application.roadtoDB#">
    select label, triggerDate
    from dates
    </cfquery>
    
    <cfloop query="getDates">
    	<cfset structInsert(application,label,triggerDate,true)>
    </cfloop>
</cfcomponent>
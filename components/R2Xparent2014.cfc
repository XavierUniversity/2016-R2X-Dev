<cfcomponent name="R2Xparent2014" hint="adds a level of abstraction for web,mobile to use the same code">
	
    <!--- ***
	Log In the Parent
	*** --->
    
    <cffunction name="loginUser" access="public" returntype="boolean">
    	<cfargument name="parentidIn" required="yes" type="numeric">
        <cfargument name="studentidIn" required="yes" type="numeric">
        
        <cftry>
        
        <cfparam name="hopsonk1i" default="FALSE">
        
        <!--- record the visit --->
        <cfquery datasource="#application.roadtoDB#">
        update parent
        set visitCount = visitCount + 1, lastvisit = <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
        where parentID = <cfqueryparam value="#arguments.parentIDIn#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <!--- get the student info --->
        <cfquery name="getStudentInfo" datasource="#Application.RoadtoDB#">
            select *
            from bannerstudent
            where bannerstudent.bannerid = <cfqueryparam value="#arguments.studentidIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <!--- load student info into session --->
        <cfloop index="dbItem" list="#getStudentInfo.columnlist#"> 
            <cfif dbItem NEQ 'password'>
                <cfset result = StructInsert(SESSION, dbItem, trim(Evaluate("getStudentInfo." & dbItem)), TRUE)>
            </cfif>
        </cfloop>
        
        <!--- see if using the test transfer account --->
        <cfif isdefined("request.hopsonk1t") and request.hopsonk1t>
            <cfset session.studentType = 'T'>
            <cfset session.firstname = 'Transfer Kristyn'>
        </cfif>
        
        <!--- see if using the test spring account --->
        <cfif isdefined("request.hopsonk1s") and request.hopsonk1s>
            <cfset session.entryTerm = '#left(session.entryTerm,4)#01'>
            <cfset session.firstname = 'Spring Kristyn'>
        </cfif>
        
        <!--- see if using the test international account --->
        <cfif isdefined("request.hopsonk1i") and request.hopsonk1i>
            <cfset session.firstname = 'International Kristyn'>
        </cfif>
        
        <!--- see if using the test international account --->
        <cfif isdefined("request.hopsonk1c") and request.hopsonk1c>
            <cfset session.firstname = 'Commuter Kristyn'>
            <cfset session.housingDeposit = ''>
        </cfif>
        
        <!--- init some variables --->
        <cfset session.currentInterests = ''>
        
        <!--- get the finaid counselor info --->
        <cfquery name="getFinaidCounselor" datasource="#Application.XavierWeb#">
            select *
            from finaidMapping
            where firstLetter = <cfqueryparam value="#left(session.lastName,1)#" cfsqltype="cf_sql_char" maxlength="1">
        </cfquery>
        <!--- Load up finaid session vars --->
        <cfif getFinaidCounselor.recordCount GT 0>
            <cfset session.finaidCounselor = trim(getFinaidCounselor.finaidCounselor)>
        <cfelse>
            <cfset session.finaidCounselor = 'purtelld1'>
        </cfif>
        
        <!--- check for scholars --->
        <cfquery name="getScholars" datasource="#Application.RoadtoDB#">
        select ID
        from scholars
        where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getScholars.recordCount GT 0>
        	<cfset session.scholars = TRUE>
        <cfelse>
        	<cfset session.scholars = FALSE>
        </cfif> 
        
        <!--- check for athletes --->
        <cfquery name="getAthletes" datasource="#Application.RoadtoDB#">
        select ID
        from athletes
        where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getAthletes.recordCount GT 0>
        	<cfset session.athlete = TRUE>
        <cfelse>
        	<cfset session.athlete = FALSE>
        </cfif> 
        
        <!--- check for FSP --->
        <cfquery name="getFSP" datasource="#Application.RoadtoDB#">
        select ID
        from FSP
        where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getFSP.recordCount GT 0>
        	<cfset session.FSP = TRUE>
        <cfelse>
        	<cfset session.FSP = FALSE>
        </cfif>
        
        <!--- check for ROTC --->
        <cfquery name="getROTC" datasource="#Application.RoadtoDB#">
        select ID
        from ROTC
        where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getROTC.recordCount GT 0>
        	<cfset session.ROTC = TRUE>
        <cfelse>
        	<cfset session.ROTC = FALSE>
        </cfif>
        
        <!--- check for Reg Pilot --->
        <cfquery name="getPilot" datasource="#Application.RoadtoDB#">
        select passThrough
        from pilotGroup
        where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getPilot.recordCount GT 0>
        	<cfset session.pilot = TRUE>
            <cfset session.pilotPassThough = getPilot.passThrough>
            <cfif getPilot.passThrough EQ '1'>
            	<cfset session.reg_start = application.pilot_registration_start>
            <cfelse>
            	<cfset session.reg_start = application.registration_start>
            </cfif>
        <cfelse>
        	<cfset session.pilot = FALSE>
            <cfset session.reg_start = application.registration_start>
        </cfif>
        
        
        <!--- load tuition into session --->
        <cfquery name="getTuition" datasource="#Application.RoadtoDB#">
        select *
        from terms
        where termcode = <cfqueryparam value="#session.entryTerm#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getTuition.recordCount EQ 0>
        	<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Web: Tuition Term NOT Found" type="html">
                <p>IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#</p>
                <cfdump var="#getTuition#" label="getTuition">
                <cfdump var="#form#" label="Form">
                <cfdump var="#cgi#" label="CGI">
            </cfmail>
        <cfelse>
        	<cfloop index="dbItem" list="#getTuition.columnlist#"> 
				<cfif left(dbItem,7) EQ 'tuition'>
                    <cfset result = StructInsert(SESSION, dbItem, trim(Evaluate("getTuition." & dbItem)), TRUE)>
                </cfif>
            </cfloop>
        </cfif>
        
        <cfif session.tuitionCurrent>
        	<cfset session.tuitionMessage = ''>
        </cfif>
        
        <!--- check for intl --->
        <cfquery name="getIntl" datasource="#Application.RoadtoDB#">
            select *
            from international
            where bannerid = <cfqueryparam value="#arguments.studentidIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        
        <cfif getIntl.recordCount EQ 0 and not hopsonk1i>
            <cfset session.international = FALSE>
        <cfelse>
            <cfset session.international = TRUE>
            <cfset session.finaidCounselor = 'marschnerdp'>
        </cfif>
        
        <cfset justLoggedIn = true>
        <cfreturn true>
        
        <cfcatch>
            <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Parent: Login Function Error" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#cfcatch#" label="Catch">
                <cfdump var="#variables#" label="Variables">
                <cfdump var="#session#" label="Session">
                <cfdump var="#application#" label="Application">
                <cfdump var="#form#" label="Form">
                <cfdump var="#cgi#" label="CGI">
            </cfmail>
            
            <cfreturn false>
        </cfcatch>
        </cftry>
    </cffunction>

</cfcomponent>
<cfcomponent name="R2Xstudent2014" hint="adds a level of abstraction for web,mobile to use the same code">
	
	<!--- ***
	Log In the Student
	*** --->
	
	<cffunction name="loginUser" access="public" returntype="boolean">
		<cfargument name="idIn" required="yes" type="numeric">
		
		<cftry>
		
			<!--- If the user wants to be remembered, set the login cookie --->
			<cfif isdefined("form.keepMeLoggedIn")>
				<cfset strRememberMe = (CreateUUID() & ":" & arguments.idIn & ":" & CreateUUID()) />
				
				<!--- Encrypt the value. --->
				<cfset strRememberMe = Encrypt( strRememberMe, APPLICATION.EncryptionKey, "cfmx_compat", "hex" ) />
				
				<!--- Store the cookie such that it never expires. --->
				<cfcookie name="R2X_web" value="#strRememberMe#" expires="never" />
			</cfif>
			
			<cfparam name="request.hopsonk1i" default="FALSE">
			
			<!--- get the student info --->
			<cfquery name="getStudentInfo" datasource="#Application.RoadtoDB#">
			select *
			from bannerstudent left join student on bannerstudent.bannerid = student.bannerid
			where bannerstudent.bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
			</cfquery>
			
			<!--- load student info into session --->
			<cfloop index="dbItem" list="#getStudentInfo.columnlist#"> 
				<cfif dbItem NEQ 'password'>
					<cfset result = StructInsert(SESSION, dbItem, trim(Evaluate("getStudentInfo." & dbItem)), TRUE)>
				</cfif>
			</cfloop>
			
			<!--- load their inbox message status into the session --->
			<!--- get the student info --->
			<cfquery name="getStudentInbox" datasource="#Application.RoadtoDB#">
			select *
			from inboxStudent
			where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
			</cfquery>
			
			<!--- load student info into session --->
			<cfset session.inboxRead = {}>
			<cfloop query="getStudentInbox"> 
				<cfset result = StructInsert(session.inboxRead, getStudentInbox.letterID, 1, TRUE)>
			</cfloop>
			
			
			<!--- get the major display and save it into the session --->
			<cfquery name="getMajorDisplay" datasource="#Application.RoadtoDB#">
			select major, college from major
			where bannerMajorCode = <cfqueryparam value="#getStudentInfo.bannerMajorCode#" cfsqltype="cf_sql_varchar">
			</cfquery>
			
			<cfif getmajorDisplay.recordcount GT 0>
				<cfset session.majorDisplay = getmajorDisplay.major>
				<cfset session.college = getmajorDisplay.college>
			<cfelse>
				<cfset session.majorDisplay = ''>
				<cfset session.college = ''>
			</cfif>
			
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
			
			<!--- see if using the test commuter account --->
			<cfif isdefined("request.hopsonk1c") and request.hopsonk1c>
				<cfset session.firstname = 'Commuter Kristyn'>
				<cfset session.housingDeposit = ''>
			</cfif>
			
			<!--- init some variables --->
			<cfset session.currentInterests = ''>
			<cfif getStudentInfo.dtLastUpdated GT createDate(2000,1,1)><cfset session.profile = true><cfelse><cfset session.profile = false></cfif>
			
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
			
			<!--- Temporary 'B' overwrite --->
			<!---<cfif listFindNoCase('Bl,Bm,Bn,Bo,Bp,Bq,Br,Bs,Bt,Bu,Bv,Bw,Bx,By,Bz',left(session.lastName,2))>
			<cfset session.finaidCounselor = 'goodloe'>
			</cfif>--->
			
			<!--- load tuition into session --->
			<cfquery name="getTuition" datasource="#Application.RoadtoDB#">
			select *, tuitionIntlBusiness,tuitionIntlNonBusiness
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
			select ID
			from international
			where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
			</cfquery>
			
			<cfif getIntl.recordCount GT 0 OR request.hopsonk1i>
				<cfset session.international = TRUE>
				<cfset session.finaidCounselor = 'marschnerdp'>
			<cfelse>
				<cfset session.international = FALSE>
			</cfif>
			
			<!--- check for spring --->
			<cfif right(session.entryTerm,2) EQ '01'>
				<cfset session.spring = TRUE>
			<cfelse>
				<cfset session.spring = FALSE>
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
			
			<cfset session.reg_start = application.registration_start>
			
			<!--- check for Reg Pilot --->
			<!---<cfquery name="getPilot" datasource="#Application.RoadtoDB#">
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
			</cfif> --->
			
			<!--- check for Peer Mentor Manual --->
			
			<!---<cfquery name="getPMM" datasource="#Application.RoadtoDB#">
			select ID
			from PeerMentorManual
			where bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
			</cfquery>
			
			
			<cfif getPMM.recordCount GT 0>
			<cfset session.PMM = TRUE>
			<cfelse>
			<cfset session.PMM = FALSE>
			</cfif>--->
			
			
			<!--- check for admission poster --->
			
			<cfset localFile = ExpandPath( "/documents" ) />
			 
			 <cfif FileExists("#localFile#/posterImage/#session.BannerID#.jpg")>
				<cfset session.admitPoster = TRUE>
				<cfelse>
				<cfset session.admitPoster = FALSE>
			 </cfif>
			
			
			<!--- update visitCount & last visit --->
			<cfquery datasource="#Application.RoadtoDB#">
			update student
			set visitCount = visitCount +1, LastVisit = #createODBCDateTime(now())#
			where bannerid = #session.BannerID#
			</cfquery>
			
			<cfset request.justLoggedIn = true>
			
			<!--- Gamify! --->     	
			   
			<!--- main entry --->
			<cfset session.gamification.addItem(session.bannerid,'Xlogin')>
			<!--- mobile --->
			<cfif findNoCase('r2',cgi.HTTP_HOST)><cfset session.gamification.addItem(session.bannerid,'Xmobile')></cfif>
			<!--- deposit --->
			<cfif session.deposited EQ '1'><cfset session.gamification.addItem(session.bannerid,'Xdeposit')></cfif>
			<!--- PREP --->
			<cfif session.PREP EQ '1'><cfset session.gamification.addItem(session.bannerid,'Xprep')></cfif>
			<!--- Placement Tests --->
			<cfif session.langPlacement EQ '1'><cfset session.gamification.addItem(session.bannerid,'processPlacement','lang')></cfif>
			<cfif session.mathPlacement EQ '1'><cfset session.gamification.addItem(session.bannerid,'processPlacement','math')></cfif>
			<!--- Meal Plan --->
			<cfif session.mealPlanComplete EQ '1'><cfset session.gamification.addItem(session.bannerid,'processMealplanAgreement')></cfif>
			<!--- Housing --->
			<cfif session.housingComplete EQ '1'><cfset session.gamification.addItem(session.bannerid,'processHousingAgreement')></cfif>
			<!--- Campus Visit? --->
			
			<cfreturn true>
		
		<cfcatch>
			<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu;sparkse1@xavier.edu" subject="R2X Web: Login Function Error" type="html">
			IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
			<cfdump var="#cfcatch#" label="Catch">
			<cfdump var="#variables#" label="Variables">
			<cfdump var="#session#" label="Session">
			<cfdump var="#application#" label="Application">
			<cfdump var="#form#" label="Form">
			<cfdump var="#cgi#" label="CGI">
			<cfdump var="#server#" label="server">
			</cfmail>
			
			<cfreturn false>
		</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>
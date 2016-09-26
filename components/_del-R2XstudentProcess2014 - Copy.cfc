<cfcomponent name="R2XstudentProcess2014" hint="adds a level of abstraction for web,mobile to use the same code">

<!---init--->
<cffunction name="init" access="public" returntype="R2XStudentProcess2014" output="false">
		<cfreturn this />
</cffunction>

	<!--- *** 
	RETURN: Boolean, based on whether or not item was added
	*** --->
    <cffunction name="setComplete" returntype="boolean">
    	<cfargument name="banneridIn">
        <cfargument name="itemCodeIn">
            <cfif this.isProcessItemComplete(arguments.banneridIn,arguments.itemCodeIn)>
        	<cfreturn false>
        <cfelse>
            <cfquery datasource="#application.roadtoDB#">
            insert into processStudent(bannerid,itemCode,date_completed)
            values(
                <cfqueryparam value="#arguments.banneridIn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.itemCodeIn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
            )
            </cfquery>
                    <cfreturn true>
    	</cfif>
    </cffunction>

    <!--- *** RETURN: Void. Just add the item as incomplete.*** --->
    <cffunction name="setIncomplete" returntype="boolean">
    	<cfargument name="banneridIn">
        <cfargument name="itemCodeIn">
            <cfquery datasource="#application.roadtoDB#">
        update processStudent
        set date_deleted = <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
        where bannerID = <cfqueryparam value="#arguments.banneridIn#" cfsqltype="cf_sql_varchar">
          and itemCode = <cfqueryparam value="#arguments.itemCodeIn#" cfsqltype="cf_sql_varchar">
          and date_deleted is NULL
        </cfquery>
            <cfreturn true>
    </cffunction>  

	<!---  ***
	RETURN: Boolean for whether or not the student has completed the item 
	***--->
    <cffunction name="isProcessItemComplete" returntype="boolean">
    	<cfargument name="bannerIDin">
        <cfargument name="itemCodeIn">
                <cfloop list="#arguments.itemCodeIn#" index="singleItem">
            <cfquery name="checkItem" datasource="#application.roadtoDB#">
            select ID
            from processStudent
            where bannerid = <cfqueryparam value="#arguments.banneridin#" cfsqltype="cf_sql_varchar" maxlength="50">
              and itemCode = <cfqueryparam value="#trim(singleItem)#" cfsqltype="cf_sql_varchar" maxlength="50">
              and date_deleted is null
            </cfquery>
            <cfif checkItem.recordCount EQ 0>
            	<cfreturn false>
            </cfif>
        </cfloop>
    		<cfreturn true>
	</cffunction>
    <!---  ***RETURN: Date item completed ***--->
    <cffunction name="dateProcessItemComplete" returntype="date">
    	<cfargument name="bannerIDin">
        <cfargument name="itemCodeIn">
            <cfquery name="checkItem" datasource="#application.roadtoDB#">
        select max(date_completed) as dc
        from processStudent
        where bannerid = <cfqueryparam value="#arguments.banneridin#" cfsqltype="cf_sql_varchar" maxlength="50">
          and itemCode = <cfqueryparam value="#trim(arguments.itemCodeIn)#" cfsqltype="cf_sql_varchar" maxlength="50">
          and date_deleted is null
        </cfquery>

        <cfif checkItem.recordCount EQ 0>
            <cfreturn '1/1/2020'>
       	<cfelse>
        	<cfreturn checkItem.dc>
        </cfif>
    	</cffunction>
    <!--- ***
	RETURN: String for date
	*** --->
    <cffunction name="generalMonth" returntype="string">
    	<cfargument name="dateIn">
            <cfset dayP = datePart('d',arguments.dateIn)>
            <cfif dayP LE 10>
        	<cfset returnString = 'Early'>
        <cfelseif dayP LE 20>
        	<cfset returnString = 'Middle of'>
        <cfelse>
        	<cfset returnString = 'Late'>
        </cfif>
            <cfset returnString = returnString & ' ' & dateFormat(arguments.dateIn,'mmmm')>
            <cfreturn returnString>
	</cffunction>
	 	
	<cffunction name="displayIcon" returnType="string">
		<cfargument name="categoryIn" type="string" required="yes">
		
				<cfswitch expression="#arguments.categoryIn#">

				<cfcase value="ToDo">
					<span  class="fa-stack fa-lg ToDo-Text">
						<i class="fa fa-circle fa-stack-2x"></i>
						<i class="fa fa fa-clock-o fa-stack-1x fa-inverse"></i>
					</span>
				</cfcase>

				<cfcase value="Housing">
		
				 	<span  class="fa-stack fa-lg Housing-Text">
						<i class="fa fa-circle fa-stack-2x"></i>
						<i class="fa fa fa-home fa-stack-1x fa-inverse"></i>
					</span>
			
				</cfcase>
				
				<cfcase value="Orientation">
					<span  class="fa-stack fa-lg Orientation-Text">
						<i class="fa fa-circle fa-stack-2x"></i>
						<i class="fa fa fa-compass fa-stack-1x fa-inverse"></i>
					</span>
				</cfcase>
	
				
			    <cfcase value="Financial">  			        
					<span  class="fa-stack fa-lg Financial-Text">
					<i class="fa fa-circle fa-stack-2x"></i>
					<i class="fa fa fa-dollar fa-stack-1x fa-inverse"></i>
					</span>
				</cfcase>
				
				<cfcase value="AboutXavier">
					<span  class="fa-stack fa-lg AboutXavier-Text">
						<i class="fa fa-circle fa-stack-2x"></i>
						<i class="fa fa fa-info fa-stack-1x fa-inverse"></i>
					</span>
				</cfcase>
				
				<cfcase value="registration">
					<span  class="fa-stack fa-lg registration-Text">
						<i class="fa fa-circle fa-stack-2x"></i>
						<i class="fa fa fa-pencil fa-stack-1x fa-inverse"></i>
					</span>
				</cfcase>
				
				<cfdefaultcase>
					<cfoutput>#arguments.categoryIn#</cfoutput>
				</cfdefaultcase>
			</cfswitch>
			
								 
	 </cffunction>
	
	<cffunction name="displayCategory" returnType="string">
		<cfargument name="categoryIn" type="string" required="yes">
		<cfoutput>
			<span class="category #arguments.categoryIn#">
		<cfswitch expression="#arguments.categoryIn#">
			<cfcase value="ToDo">
			Take Action
			</cfcase>
			<cfcase value="AboutXavier">
			About Xavier
			</cfcase>
			<cfdefaultcase>
			#arguments.categoryIn#
			</cfdefaultcase>
		</cfswitch>
		</span>
		</cfoutput>
	</cffunction>

	<cffunction name="getStepCount" returnType="string">
		<cfargument name="categoryName" type="string" required="yes" default="R2X">
		<cfset nextStepsArray = getNextSteps()>
		<cfset nsCount = 0  >
		<cfset nsMax = 3 >
		
	
		<cfloop index="i" from="1" to="#arrayLen(nextStepsArray)#">
			
			<cfif categoryName is 'R2X' >
				
				<cfif nextStepsArray[i].status EQ 'active' and nextStepsArray[i].topic is not 'registration' and nextStepsArray[i].topic is not 'housing'>
					<cfset nsCount = nsCount + 1>
				</cfif>
  			
  			<cfelseif nextStepsArray[i].topic is  'housing'>
  			
  				<cfset nsCount = nsCount + 1>

			<cfelse>
  			
  			<cfif nextStepsArray[i].status EQ 'active' and nextStepsArray[i].topic is '#categoryName#' >
				<cfset nsCount = nsCount + 1>
  			</cfif>
  			
			</cfif>		
  			
  			
  			<cfif nsCount EQ nsMax> 
  				<cfbreak>
  			</cfif>
		</cfloop>
		<cfreturn nsCount >

	</cffunction>

	<cffunction name="getNextStepCount" returnType="string">
		<cfargument name="categoryName" type="string" required="yes" default="R2X">
		<cfset nextStepsArray = getNextSteps()>
		<cfset nextStepCount = 0  >
		<cfset nextStepMax = 3 >
	
		<cfloop index="i" from="1" to="#arrayLen(nextStepsArray)#">
			
			<cfif categoryName is 'R2X' >
				
				<cfif nextStepsArray[i].status is not 'preview' and nextStepsArray[i].status is not 'complete' and nextStepsArray[i].topic is not 'registration' and nextStepsArray[i].topic is not 'housing' >
					<cfset nextStepCount = nextStepCount + 1>
					
				</cfif>
				
				<cfelse>
				
				<cfif nextStepsArray[i].status is not 'preview' and nextStepsArray[i].status is not 'complete' and nextStepsArray[i].topic is '#categoryName#'>
					<cfset nextStepCount = nextStepCount + 1>
					
				</cfif>
				
			</cfif>		
				
  			
  			<cfif nextStepCount EQ nextStepMax > 
  				<cfbreak>
  			</cfif>
  		
		</cfloop>
		
			  	<cfreturn nextStepCount >

	</cffunction>
	
    <!--- ***
	RETURN: Array of the next steps for the student. I had to split this because it was too big.
	*** --->
    <cffunction name="getNextSteps" returntype="array">
    	<!--- *** Generate the Array *** --->
        <cfset nextStepsArray = []>
    	<cfset getNextStepsPart1()>
        <cfset getNextStepsPart2()>
            <cfreturn nextStepsArray>
    </cffunction>
   
    <cffunction name="getNextStepsPart1" returntype="void">
            <!--- get the finaid counselor --->
        <cfquery name="finaidCounselor" datasource="#application.XavierWeb#">
        select * from finaidCounselor where counselorCode = <cfqueryparam value="#session.finaidCounselor#" cfsqltype="cf_sql_varchar">
        </cfquery>
            <!--- allow the date to be changed, for demo --->
		<cfif isdefined("url.currentDate") and url.currentDate NEQ ''>
            <cfset compDate = createDate(mid(url.currentDate,1,4),mid(url.currentDate,5,2),mid(url.currentDate,7,2))>
        <cfelse>
            <cfset compDate = now()>
        </cfif>
    <!--- Deposit --->  
          <!--- *** Process Item Code: deposit - ALL *** ---> 
		<!--- This must be done for each step --->
            <cfset stepStruct = {}>
            <cfset stepStruct.itemCode = 'deposit'>
        <cfset stepStruct.topic = 'Financial'>
        <cfset stepStruct.timeframe = '2016-05-01'>
        <cfset stepStruct.link = 'https://roadto.xavier.edu/about/deposit.cfm'>
            <cfif session.studentType EQ 'T'>
            <cfset stepStruct.title = 'Send In Your Deposit To Join the Xavier Family'>
        <cfelseif session.international>
            <cfset stepStruct.title = 'Submit Your Deposit'>
        <cfelse>
            <cfset stepStruct.title = 'Send in your deposit and join The Class of 2020!'>
        </cfif>
                <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
            <cfset stepStruct.status = 'Complete'>
        <cfelse>
            <cfset stepStruct.status = 'Active'>
        </cfif>
            <cfset stepStruct.type = 'auto'>
        <cfset stepStruct.typeText = 'Submit Your Deposit to Complete'>
                <cfsavecontent variable="stepStruct.body">
        <p>Once you have made your decision that Xavier is the right place for you, all you need to do to secure your spot in the class is submit your tuition and housing deposits. These are $200 each and can be <a href="/about/deposit.cfm">submitted online</a> or by check. <a href="/about/deposit.cfm">Visit the deposit page for more information.</a></p>
        </cfsavecontent>
            <cfset stepStruct.image = 'classof2013.jpg'>
                   <cfset arrayAppend(nextStepsArray,stepStruct)>
        <!--- End Deposit Section --->
    
<!--- FAFSA Preview --->   
        <!--- *** Process Item Code: fafsa - Trad, Tran *** --->
        <cfif isdefined("url.showAll") OR (NOT session.international) and datecompare(compDate, Application.fafsa_start) lt 0>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'fafsa'>
            <cfset stepStruct.timeframe = '<span class="timeframe-label">Required Timeframe:</span> Begins #dateFormat(application.fafsa_start,'long')#, Complete by #dateFormat(application.fafsa_stop,'long')#'>

            <cfset stepStruct.title = 'File the Free Application for Federal Student Aid (FAFSA)'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfsavecontent variable="stepStruct.body">
            <p>If you want to be considered for need-based financial assistance, complete the Free Application for Federal Student Aid (FAFSA) <a href="http://www.fafsa.ed.gov/" target="_blank">online</a> or request a paper copy of the FAFSA from 800-4FED-AID. The completed FAFSA should be submitted to the federal processor before Xavier's February 15 priority deadline; however, financial aid will still be reviewed for students who submit the FAFSA after the priority deadline. Be sure to designate Xavier to receive your results. Xavier's federal school code for the FAFSA is 003144.</p>
            </cfsavecontent>
                	<cfset stepStruct.topic = 'Financial'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- FAFSA --->   
            <!--- *** Process Item Code: fafsa - Trad, Tran *** --->
        <cfif isdefined("url.showAll") OR (NOT session.international) and datecompare(compDate, Application.fafsa_start) ge 0>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'fafsa'>
            <cfset stepStruct.timeframe = "#dateFormat(application.fafsa_stop,'long')#">
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfif datecompare(compDate, Application.fafsa_stop) lt 0>
                	<cfset stepStruct.status = 'Active'>
                <cfelse>
                	<cfset stepStruct.status = 'Passed'>
                </cfif>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Will update when FAFSA is processed'>
                            <cfset stepStruct.title = 'File the Free Application for Federal Student Aid (FAFSA)'>
                    <cfsavecontent variable="stepStruct.body">
            <p>If you want to be considered for need-based financial assistance, complete the Free Application for Federal Student Aid (FAFSA) <a href="http://www.fafsa.ed.gov/" target="_blank">online</a> or request a paper copy of the FAFSA from 800-4FED-AID. The completed FAFSA should be submitted to the federal processor before Xavier's February 15 priority deadline; however, financial aid will still be reviewed for students who submit the FAFSA after the priority deadline. Be sure to designate Xavier to receive your results. Xavier's federal school code for the FAFSA is 003144.</p>
            </cfsavecontent>
                    <cfset stepStruct.topic = 'Financial'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end fafsa section --->

<!--- visit --->  
          <!--- *** Process Item Code: visit - Trad, Tran *** --->
        <cfif isdefined("url.showAll") OR (NOT session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'visit'>
                    <cfset stepStruct.timeframe = '2016-07-01'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfif datecompare(compDate, Application.campus_visit_stop) lt 0>
                	<cfset stepStruct.status = 'Active'>
                <cfelse>
                	<cfset stepStruct.status = 'Passed'>
                </cfif>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                   <!--- <cfset stepStruct.timeframe = '<span class="timeframe-label">Required Timeframe:</span> Complete by #dateFormat(application.campus_visit_stop,'long')#'>--->
                    <cfset stepStruct.title = 'Schedule a Campus Visit'>
                    <cfsavecontent variable="stepStruct.body">
            <p>If you have not been on our campus, or would like to come back for another visit, let us know! We would be happy to arrange for you to sit in on one class and/or visit with an academic department. We encourage you to visit us on campus to fully explore your future home. Then come back to see us for a XU Preview on April 10, a visit day designed specifically for admitted students.</p>
			<p><a href="http://www.xavier.edu/undergraduate-admission/visit-xavier/" target="_blank">Schedule your visit on-line</a> or  please call the Office of Admission at 877 XU-ADMIT to set up your visit.</p>
            </cfsavecontent>
                    <cfset stepStruct.topic = 'AboutXavier'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end visit section --->
        
<!--- International Special --->            <!--- *** Process Item Code: intlVisa - Intl *** --->
        <cfif isdefined("url.showAll") OR (session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'intlVisa'>
                    <cfset stepStruct.timeframe = '2016-06-15'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Submit Your Visa Information'>
                    <cfsavecontent variable="stepStruct.body">
            <p>If you have not done so, please submit the <a href="http://www.xavier.edu/international-admission/Applications-and-Requirements.cfm" target="_blank">required paperwork</a> to obtain your Form I-20 or Form DS-2019, which are required to obtain your visa.</p>
            </cfsavecontent>
                    <cfset stepStruct.link = 'http://www.xavier.edu/international-admission/Applications-and-Requirements.cfm'>
                    <cfset stepStruct.topic = 'ToDo'>                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
 <!--- end intlVisa section --->
    
<!--- International Housing ---> 
   
<!--- *** Process Item Code: intHousing - Intl *** --->
        <cfif isdefined("url.showAll") OR (session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'intlHousing'>
                    <cfset stepStruct.timeframe = '2016-05-29'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                           <cfset stepStruct.title = 'Learn More About Housing at Xavier'>
                    <cfsavecontent variable="stepStruct.body">
            <p>International students are encouraged to apply for on-campus housing as soon as possible. A housing deposit is required. Once the deposit is received students will be sent a housing contract for signature. More information about housing can be found on the <a href="http://www.xavier.edu/international-students/Housing.cfm" target="_blank">housing section</a> of the international student orientation website.</p>
            </cfsavecontent>
                    <cfset stepStruct.link = 'http://www.xavier.edu/international-students/Housing.cfm'>
                	<cfset stepStruct.topic = 'Housing'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
<!--- end intlHousing section --->


<!--- Parent Access ---> 

<!--- *** Process Item Code: parentAccess - Trad, Int'l *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.parent_access_start) ge 0) and session.studentType NEQ 'T' )>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
            <cfset stepStruct.itemCode = 'parentAccess'>
            <cfset stepStruct.timeframe = '2016-05-15'>
            <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Enable parent access to complete'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Enable Parent Access'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Ever since you were accepted to Xavier your parents have had access to a special site just for them - <a href="https://roadto.xavier.edu/parent" target="_blank">The Parent Road to Xavier</a>. Now that you are deposited you need to grant special access, based on email address, to your parents to enable them to complete their Road to Xavier process.</p>
            
            	<cfif session.parentlogin is FALSE >
					<p><a href="https://roadto.xavier.edu/your-road/parent-access.cfm" class="button radius">Enable Parent Access Now</a></p>
            	</cfif>	
            
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/parent-access.cfm">
                	<cfset stepStruct.topic = 'ToDo'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
    <!--- end Parent Access --->   
	
	<!--- ***
	Registration Phase 1
	--->
  
    <!--- genAdvising --->  

        <!--- *** Process Item Code: genAdvising - Preview - Trad, Intl *** --->
        <cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.adv_start) lt 0) and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
            <cfset stepStruct.itemCode = 'genAdvising'>
            <cfset stepStruct.status = 'Preview'>
            <cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.adv_start)#'>
            <cfset stepStruct.type = ''>
           	<cfset stepStruct.typeText = ''>
            <cfset stepStruct.title = 'Prepare for Registration'>
			
            <cfsavecontent variable="stepStruct.body">
            <p>You're studying for finals. You're working. You're trying to enjoy your last days of high school. We get it - you're busy.</p> 

			<p>Luckily, we here at Xavier have made course registration as easy as possible. It's all online so you can complete it from home. And you'll want to do this as soon as possible so you can pick your own classes and get your college career off on the right foot.</p>

			<p>Just stay tuned to Road to Xavier for more details on how and when to complete these next steps.</p>
            </cfsavecontent>
            <cfset stepStruct.image = 'prep.jpg'>
            <cfset stepStruct.topic = 'Registration'>
            <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
		<!--- end genAdvising section --->
        
		<!--- removed in 2016 --->
		
		<!--- Prepare for Registration --->
        <!--- *** Process Item Code: advisingWelcome - Trad, Intl *** --->
        <!---<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
            <cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'advisingWelcome'>
			<cfset stepStruct.title = 'Prepare for Registration'>
			<cfset stepStruct.timeframe = '2016-05-15'>
            <cfset stepStruct.topic = 'Registration'>
            <cfset stepStruct.link  = "https://roadto.xavier.edu/your-road/adv-welcome.cfm">
			<cfsavecontent variable="stepStruct.body">
				<p>Now that you are deposited it is time to start preparing for the fall semester. Check out these welcome videos to learn more about the registration process at Xavier. Pay attention - there will be a quiz later.</p>
	
				<cfif session.parentlogin is FALSE >
					<p><a href="/registration/welcome.cfm" class="button radius">Watch the Advising Videos Now</a></p>
				</cfif>
		
		
			</cfsavecontent>
			<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
            <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>                    
			
			<cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>--->
    	<!--- end Prepare for Registration ---> 
  
	<!--- Registration FAQ --->  
	<!--- *** Process Item Code: advisingFAQ - Preview - Trad, Intl *** --->
	<!---<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and not this.isProcessItemComplete(session.bannerid,'advisingWelcome') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingFAQ'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = 'End of April'>
		<cfset stepStruct.title = 'Read Through the Registration FAQ'>
		<cfsavecontent variable="stepStruct.body">
			<p>Once you have completed 'Prepare for Registration' there will be a list of frequently asked questions for you to review. These will cover everything from "What classes will I take my first semester?" to "When may I make adjustments to my fall semester schedule?".</p>
		</cfsavecontent>  
		<cfset stepStruct.topic = 'Registration'>                        
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>--->
	<!--- end Registration FAQ --->  
              
	<!--- *** Process Item Code: advisingFAQ - Trad, Intl *** --->
	<!---<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingWelcome') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
		<cfset stepStruct = {}>
		<cfset stepStruct.title = 'Read Through the Registration FAQ'>
		<cfset stepStruct.itemCode = 'advisingFAQ'>
		<cfset stepStruct.timeframe = '2016-05-15'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = ''>
		<cfsavecontent variable="stepStruct.body">
			<p>We are sure you learned a lot from the videos, but now you probably have more questions about some of the details. Review the Registration Frequently Asked Questions to learn more about the advising and course registration process.</p>
			
			<cfif session.parentlogin is FALSE >
				<p><a href="/registration/faq.cfm" class="button radius">Review the Advising FAQ Now</a></p>
			</cfif>
			
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/your-road/adv-faq.cfm">
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>--->
		
	<!--- Advising Quiz Preview--->
	<!--- *** Process Item Code: advisingQuiz - Preview - Trad, Intl *** --->
	<!---<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and not this.isProcessItemComplete(session.bannerid,'advisingFAQ') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingQuiz'>
		<cfset stepStruct.title = 'Take the Registration Quiz'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.timeframe = 'Early May'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfsavecontent variable="stepStruct.body">
			<p>Once you have watched the registration videos and read through the FAQ a short quiz will be available to help review what you have learned.</p>
		</cfsavecontent>  
		<cfset stepStruct.topic = 'Registration'>                        
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>--->
	<!--- Advising Quiz Preview End --->
  
 
	<!--- Advising Quiz ---> 
	<!--- *** Process Item Code: advisingQuiz - Trad, Intl *** --->
	<!---<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingFAQ') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingQuiz'>
		<cfset stepStruct.timeframe = '2016-06-15'>
		<cfset stepStruct.title = 'Take the Registration Quiz'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Take the quiz to complete'>
		<cfsavecontent variable="stepStruct.body">
			<p>Now that you have watched the registration videos and read through the FAQ, take the short quiz to help review what you have learned.</p>
			
				<cfif session.parentlogin is FALSE >
					<p><a href="/registration/quiz.cfm" class="button radius">Take the Registration Quiz Now</a></p>
				</cfif>
				
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/your-road/adv-quiz.cfm">
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>--->
	<!--- Advising Quiz End---> 
	
	<!--- / end removed in 2016 --->        
	 
	<!---Submit Your Academic Profile Preview ---> 
	<!--- *** Process Item Code: advisingForm - Preview - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.adv_start) lt 0) and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingForm'>
		<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.adv_start)#'>
		<cfset stepStruct.title = 'Submit Your Academic Profile'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfsavecontent variable="stepStruct.body">
			<p>Once registration is active, you'll be able to submit your academic profile. This information will be used when you build your first semester schedule.</p>
		</cfsavecontent> 
		<cfset stepStruct.topic = 'Registration'>                         
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- End Submit Your Academic Profile Preview --->


	<!---Submit Academic Profile ---> 
	<!--- *** Process Item Code: advisingForm - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingForm'>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Submit Your Academic Profile'>
		
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Submit your academic profile to complete'>
		<cfsavecontent variable="stepStruct.body">
			<p>Ready to begin building your first semester schedule at Xavier? Take the first step. We just need a few more points of information - your intended major, your prior experience with language and math, and any previous college-level work you may have completed.</p>

			<p>This helps us determine what classes you need to begin your Xavier career.</p>

			<p>Need help? Call 513-745-3301.</p>
			
			<cfif session.parentlogin is FALSE >
				<p><a href="/registration/academic-profile.cfm" class="button radius">Submit Your Academic Profile Now</a></p>
			</cfif>
				
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/academic-profile.cfm">
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- End Submit Academic Profile --->  
	           
	<!--- Placement Tests Preview --->
	<!--- *** Process Item Code: genPlacement - Preview - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR (((NOT this.isProcessItemComplete(session.bannerid,'deposit,advisingForm') OR datecompare(compDate, Application.adv_start) lt 0)) and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'genPlacement'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.title = 'Take Your Online Placement Tests'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.pt_start)#'>
		<cfsavecontent variable="stepStruct.body">
			<p>Okay, now things are getting a little more important. All students must complete two online placement tests, one for math and one for foreign language. </p>

			<p>We understand you may already have credits for the courses you took in high school. Our online tests are only for placement purposes. But that doesn't mean they aren't important. They must be completed before you can register for classes. And take them seriously - your performance will serve as a guide so you and your advisor can select the courses that best suit your needs for the first semester schedule. You do not want to qualify for a class that does not count toward your degree.</p>

			<p>Online placement tests, along with other important registration information, will be available in early April, once you've submitted your academic profile.</p>
		</cfsavecontent>
		<cfset stepStruct.image = 'tests.jpg'>
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
  
	<!--- *** Process Item Code: genPlacement - Active - Tran *** --->
	<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and NOT session.international and session.studentType EQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'genPlacement'>
		<cfset stepStruct.timeframe = '2016-06-01'>
		<cfset stepStruct.title = 'Academic Advising and Online Placement Tests'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = ''>
		
		<cfsavecontent variable="stepStruct.body">
		<cfoutput>
		<p>If you have not taken college level mathematics or  foreign language courses, you will be required to take placement tests in  either or both areas prior to scheduling classes with an advisor. To access the  appropriate placement test go to <a href="http://www.xavier.edu/test-info/" target="_blank">http://www.xavier.edu/test-info/</a>.</p>
		<p>If you have college credit  for mathematics and foreign language, your next step is to coordinate your advising  appointment with the appropriate advisor of your intended major, as identified  in your acceptance packet and below.</p>
		<p><strong>&nbsp;</strong></p>
		<p><strong>College  of Arts &amp; Science or College of Social Science, Health and Education</strong><br />
		Barb Garand, Academic Advisor<br />
		513 745-2975 <br />
		<a href="mailto:garand@xavier.edu">garand@xavier.edu</a></p>
		<p><strong>College of Business</strong><br />
		Cindy Stockwell, Assistant Dean, Undergraduate Program<br />
		513 745-3131<br />
		<a href="mailto:mazza@xavier.edu">mazza@xavier.edu</a> Nancy  Mazza will schedule appointments for Cindy</p>
		<p><strong>School of Nursing</strong><br />
		Marilyn Gomez<br />
		Director of Nursing Student Services<br />
		513 745-4392 <br />
		<a href="mailto:Gomez@xavier.edu">Gomez@xavier.edu</a></p>
		<p><strong>College of Social Science, Health and Education - PSYCHOLOGY Majors</strong><br />
		Margaret Maybury<br />
		Assistant Director for Enrollment and Student Services, Psychology<br />
		513 745-1053<br />
		<a href="mailto:Maybury@xavier.edu">Maybury@xavier.edu</a></p>
		<p>Should you have difficulty with accessing the placement tests please call #application.helpPhone# or email <a href="emailto:#application.helpEmail#">#application.helpEmail#</a>.</p>
		</cfoutput>
		</cfsavecontent>
		
		<cfset stepStruct.image = 'tests.jpg'>
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- End Placement Tests --->
      
	<!--- Math Placement Test ---> 
	<!--- *** Process Item Code: mathPlacement - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingForm') and datecompare(compDate, Application.pt_start) ge 0) and session.studentType NEQ 'T')>
	<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'mathPlacement'>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Complete Your Math Placement'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Complete your math placement test to complete'>
		
		<cfsavecontent variable="stepStruct.body">
			<p>Your online math placement test is now available, and should be completed by May 15. </p>

			<p>Our online tests are only for placement purposes. But that doesn't mean they aren't important. Take them seriously - your performance will serve as a guide so you and your advisor can select the courses that best suit your needs for the first semester schedule. The tests must be completed before you can register for classes.</p>

			<p>And if you do not fare as well as you hoped, you should access the ALEKS system for a retest. You will be required to complete an eight-hour learning module before the retest. This can eliminate the need to take a math class that does not count toward your degree.</p>
			
			<cfif session.parentlogin is FALSE >
				<p><a href="/registration/placement-tests.cfm" class="button radius">Take Your Math Placement Test Now</a></p>
			</cfif>
		
		</cfsavecontent>
		
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/placement-tests.cfm">
		<cfset stepStruct.image = 'tests.jpg'>
		<cfset stepStruct.topic = 'Registration'>                        
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- End Math Placement Test --->            

	<!--- Math Placement Test Results --->
	<!--- *** connect to Banner *** --->
	<cfset bannerDown = false>
	<cfset bannerRecord = false>
	<cftry>
		<cfquery name="getPidm" datasource="ERP">
		select spriden_pidm from spriden 
		where spriden_id = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar"> 
		and spriden_change_ind is null
		</cfquery>
		
		<!--- get all of the their math placement --->
		<cfif getPidm.recordCount GT 0>
			<cfset bannerRecord = true>
			
			<!--- get their placement results --->
			<cfquery name="getPlacement" datasource="ERP">
			select * from sortest 
			where sortest_pidm = <cfqueryparam value="#getPidm.spriden_pidm#" cfsqltype="cf_sql_integer"> 
			and SORTEST_TESC_CODE = 'MATH'
			order by sortest_test_date desc
			</cfquery>
		<cfelse>
			<cfset bannerRecord = false>
			<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Placement Missing Profile Email" type="html">
			<p>A banner record was not found for #bannerid#, who is trying to view their placement results.</p>
			<cfdump var="#session#" label="session">
			<cfdump var="#cgi#" label="CGI">
			</cfmail>
		</cfif>
	<cfcatch>
		<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Placements Banner Down Email" type="html">
		<cfdump var="#cfcatch#" label="CATCH">
		<cfdump var="#cgi#" label="CGI">
		</cfmail>
		<cfset bannerDown = true>
	</cfcatch>
	</cftry>
	
	<!--- we have the placement, if they have one --->
	<cftry>
		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit,mathPlacement') and session.studentType NEQ 'T' and bannerRecord and getPlacement.recordcount GT 0 ) >  	
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'mathResults'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Review Your Math Placement Level'>
		
		<cfparam name="getPlacement.SORTEST_TEST_SCORE" default="UNKNOWN">
		<cfswitch expression="#getPlacement.SORTEST_TEST_SCORE#">
		<cfcase value="105">
		<cfset placementOut = "'105', which means MATH 105. <b>This class counts as a general elective, but does not satisfy the core requirement for math. If you have not done so already, please complete the ALEKS Prep and Learning Module, referenced below, in an attempt to raise your score</b>">
		</cfcase>
		<cfcase value="PRE">
		<cfset placementOut = "MATH 113, 115, 116, 120, 125, 169, 201, 202, 211, 212; CSCI 170">
		</cfcase>
		<cfcase value="ELC">
		<cfset placementOut = "MATH 125, 140, 147, 150, 156, 201, 202, 211, 212, 225; CSCI 170; STAT 210">
		</cfcase>
		<cfcase value="ADV">
		<cfset placementOut = "MATH 140, 147, 150, 156, 170, 222, 225; CSCI 170; STAT 210">
		</cfcase>
		<cfdefaultcase>
		<cfset placementOut = 'UNKNOWN'>
		</cfdefaultcase>
		</cfswitch>
		<cfsavecontent variable="stepStruct.body">
		<cfif getPlacement.recordCount EQ 1>
			<p>Thanks for completing Xavier's Math Placement test. You've qualified to take any of the following Math classes: <cfoutput>#placementOut#</cfoutput>. You'll be able to see which of these classes works best for your major during the course registration process. </p>
			<cfif getPlacement.SORTEST_TEST_SCORE EQ '105'>
				<p><b>Based on your placement level, it is in your best interest to complete a Prep and Learning Module within the ALEKS system which may result in achieving a higher math placement level.</b>  If you choose to do this you will be required to spend at least 8 hours in the ALEKS system working to complete the module.</p>
				<p>Once you have completed this module you will have the opportunity to take the math placement test again, and raise your placement level. This can eliminate the need to take a math class that does not count toward your degree. You may only improve your placement once, and only to the next highest level.</p>
				<p>Access to the ALEKS system will remain open to you via this screen.</p>
			<cfelseif getPlacement.SORTEST_TEST_SCORE EQ 'ADV'>
				<p>You have placed into the highest level available in the ALEKS placement test system.  No further action is required at this time.</p>
			<cfelse>
				<p>Based on your placement level, you are eligible, but not required, to complete a Prep and Learning Module within the ALEKS system which may result in achieving a higher math placement level.  If you choose to do this you will be required to spend at least 8 hours in the ALEKS system working to complete the module.</p>
				<p>Once you have completed this module you will have the opportunity to take the math placement test again, and raise your placement level. You may only improve your placement once, and only to the next highest level.</p>
				<p>Access to the ALEKS system will remain open to you via the this screen.</p>
			</cfif>
			<p>For more information, you can visit our <a href="http://www.xavier.edu/mathematics-department/ALEKS-FAQ.cfm" target="_blank">ALEKS FAQ</a>.</p>
		<cfelseif getPlacement.recordCount GT 1>
			<p>We have received the results from your second math placement test. It indicates that your math placement level, which will guide you to select your first math course, is <cfoutput>#placementOut#</cfoutput>. We will provide more detailed information about this when it is time for you to register for classes.</p>
			<p>According to our records this is the second time you have taken the math placement test, which is the maximum number of times you are allowed to take it.</p>
			<p>For more information, you can visit our <a href="http://www.xavier.edu/mathematics-department/ALEKS-FAQ.cfm" target="_blank">ALEKS FAQ</a>.</p>
		</cfif>
		</cfsavecontent>
		
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/index.cfm">
		<cfset stepStruct.image = 'tests.jpg'>
		<cfset stepStruct.topic = 'Registration'>                        
		<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>
	<cfcatch>
	<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="Quick Email" type="html">
		<p>#listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#</p>
		<cfdump var="##" label="">
		<cfdump var="#cgi#" label="CGI">
		</cfmail>
	</cfcatch>
	</cftry>
	<!--- End Math Placement Results --->
	
	<!--- Foreign Language Placement Test --->             
	<!--- *** Process Item Code: langPlacement - Trad *** --->
	<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingForm') and datecompare(compDate, Application.pt_start) ge 0) and session.studentType NEQ 'T' and not session.international )>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'langPlacement'>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Complete Your Foreign Language Placement Test'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Complete your foreign language placement test to complete'>
		<cfsavecontent variable="stepStruct.body">
		<p>Your online foreign language placement test is now available, and should be completed by May 15.</p> 

Our online tests are only for placement purposes. But that doesn’t mean they aren’t important. Take them seriously – your performance will serve as a guide so you and your advisor can select the courses that best suit your needs for the first semester schedule. The tests must be completed before you can register for classes.
</p>
		<p><a href="/registration/placement-tests.cfm" class="button radius">Take Your Foreign Language Placement Test Now</a></p>
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/placement-tests.cfm">
		<cfset stepStruct.image = 'tests.jpg'> 
		<cfset stepStruct.topic = 'Registration'>                       
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
		
		
	<!--- *** Process Item Code: langPlacement - Intl *** --->
	<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingForm') and datecompare(compDate, Application.pt_start) ge 0) and session.studentType NEQ 'T'  and session.international  )>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'langPlacement'>
		<cfset stepStruct.timeframe = '2016-06-10'>
		<cfset stepStruct.title = 'Complete Your Foreign Language Placement Test'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = ''>
		<cfsavecontent variable="stepStruct.body">
		<p>International students whose native language is not English are exempt from the foreign language requirement.  Contact <a href="mailto:byrn@xavier.edu">Dr. Shannon Byrne</a> or <a href="mailto:abneya@xavier.edu">Anja Abney</a> for more information.</p>
		<p><a href="/registration/placement-tests.cfm" class="button radius">Take Your Foreign Language Placement Test Now</a></p>
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/placement-tests.cfm">
		<cfset stepStruct.image = 'tests.jpg'>  
		<cfset stepStruct.topic = 'Registration'>                      
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	
	
	<!--- ***
	Registration Phase 2
	--->
	
		<!--- Student Responsibility Statement Preview --->
	<!--- *** Process Item Code: advisingSRStatement - Preview - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and not this.isProcessItemComplete(session.bannerid,'advisingReady') and datecompare(compDate, Application.adv_start) ge 0) and session.studentType NEQ 'T')>
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingSRStatement'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = 'Middle of May'>
		<cfset stepStruct.title = 'Review the Student Responsibility Statement'>
		<cfsavecontent variable="stepStruct.body">
			<p>The Xavier University catalog includes our academic policies and procedures; course descriptions; requirements for all majors, minors, and concentrations and much more. It is important for you to be familiar with the provisions of the university catalog so that you can take charge of your academic progress. Get started by finding and agreeing to the catalog's Student Responsibility statement.</p>
		</cfsavecontent> 
		<cfset stepStruct.topic = 'Registration'>                         
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- End Student Responsibility Statement Preview ---> 

	<!--- Student Responsibility Statement ---> 
	<!--- *** Process Item Code: advisingSRStatement - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR 
	(
	(
	this.isProcessItemComplete(session.bannerid,'deposit,advisingReady')  or
	(this.isProcessItemComplete(session.bannerid,'deposit') AND session.studentType EQ 'T')
	) 
	and datecompare(compDate, Application.adv_start) ge 0)>
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingSRStatement'>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Review the Student Responsibility Statement'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Review the Student Responsibility Statement to complete'>
		<cfsavecontent variable="stepStruct.body">
			<p>The Xavier University catalog includes our academic policies and procedures; course descriptions; requirements for all majors, minors, and concentrations and much more. It is important for you to be familiar with the provisions of the university catalog so that you can take charge of your academic progress. Get started by finding and agreeing to the catalog's Student Responsibility statement.</p>
			
			<cfif session.parentlogin is FALSE >
				<p><a href="/registration/responsibility-statement.cfm" class="button radius">Review the Student Responsibilty Statement Now</a></p>
			</cfif>
				
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/responsibility-statement.cfm">
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- End Student Responsibility Statement ---> 
	
	<!---  Advising and Registration Training Preview --->	
	<!--- *** Process Item Code: advisingGenTraining - Preview - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and (NOT this.isProcessItemComplete(session.bannerid,'advisingSRStatement') OR datecompare(compDate, application.registration_prep_start) lt 0)  and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingRegistrationTraining'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(session.reg_start)#'>
		<cfset stepStruct.title = 'Complete Advising and Registration Training'>
		<cfsavecontent variable="stepStruct.body">
		<p>When registration is enabled AND you have completed all of the 'Registration' steps that come before this, advising information and registration materials will be made available. These materials will educate you about the steps for registration and help you build your first semester schedule.</p>
		</cfsavecontent>
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
     
	<!--- Registration Training --->               
	<!--- *** Process Item Code: advisingRegistrationTraining - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingSRStatement') and datecompare(compDate, application.registration_prep_start) ge 0) and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingRegistrationTraining'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Complete Advising and Registration Training'>
		<cfsavecontent variable="stepStruct.body">
		<p>Your placement tests have been processed by the Road to Xavier and you are now ready to prepare for the registration process.</p>
		<p>Before you register you will need to learn how to look-up classes and how to select the classes you want. This is the same process that you will use during your time at Xavier.</p>
		<p><strong>You must mark this item complete before you are allowed to register for classes.</strong> This information will always be available via the 'Registration and Advising' section on the right.</p>
		
		<cfif session.parentlogin is FALSE >
		<p><a href="/registration/registration-training.cfm" class="button radius">Access the Training Materials Now</a></p>
		</cfif>
		
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/registration-training.cfm">
		<cfset stepStruct.topic = 'Registration'>                      
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	
	<!--- ***
	Registration Phase 3
	--->
	

	<!--- *** Process Item Code: xavierAccountCreation - Preview - ALL *** --->
	<cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, application.xavier_account_start) lt 0))>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'xavierAccountCreation'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.xavier_account_start)#'>
		<cfset stepStruct.title = 'Your Xavier Account'>
		<cfsavecontent variable="stepStruct.body">
		<p>Your Xavier account is how you will access your Xavier email, register for classes in Banner Self-Service (course registration), and access other Xavier systems.</p>
		</cfsavecontent>
		<cfset stepStruct.topic = 'AboutXavier'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>

	<!--- Xavier Account --->
	<!--- *** Process Item Code: xavierAccountCreation - ALL *** --->
	<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, application.xavier_account_start) ge 0 )>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'xavierAccountCreation'>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Your Xavier Account'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = ''>
		<cfsavecontent variable="stepStruct.body">
		<p>Your Xavier account is how you will access your Xavier email, Banner Self-Service (course registration), and other Xavier systems. <b>The username and password for your Xavier account are the same as your Road to Xavier login</b>. As long as your account is active in the Road to Xavier<!---, which is currently scheduled for September 11, 2015--->, your password will be managed through the Road to Xavier. <!---When your Road to Xavier account is no longer active you will be able to manage your password using the link on the <a href="http://www.xavier.edu/students/" target="_blank">Student Hub</a>.---></p>
		<!---<p>Many Xavier systems are accessible via the <a href="http://www.xavier.edu/students/" target="_blank">Student Hub</a> at <a href="http://www.xavier.edu/students/" target="_blank">http://www.xavier.edu/students/</a> , including Banner Self-Service and Xavier email. <b>Your Xavier email address is <cfoutput>#trim(session.username)#</cfoutput>@xavier.edu.</b> It is important that you begin to check your Xavier email periodically, especially for messages regarding registration. We will do our best to send messages to your personal and Xavier email accounts, but some automated messages will only go to your Xavier email.</p>--->
		<p>Should you need it for anything, your Student ID (or Banner ID, as it is sometimes called) is <cfoutput>#session.bannerid#</cfoutput>.</p>
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/">
		<cfset stepStruct.topic = 'AboutXavier'>                      
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>

		
		
	<!---  Contact Info Preview  --->  
	<!--- Contact Info Update --->
	<!--- *** Process Item Code: contactInfoUpdate - Preview - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'advisingReady') and NOT this.isProcessItemComplete(session.bannerid,'advisingRegistrationTraining') and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'contactInfoUpdate'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(session.reg_start)#'>
		<cfset stepStruct.title = 'Update Your Contact Info'>
		<cfsavecontent variable="stepStruct.body">
		<p>During the advising and registration process we may need to contact you to confirm your choices. Once your Xavier Account is created we will ask you to update the contact info that we have on file, to ensure that we have the most recent data.</p>
		</cfsavecontent>
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
		
	<!---  Contact Info Preview  --->  
	<!--- *** Process Item Code: contactInfoUpdate - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'advisingRegistrationTraining') and datecompare(compDate, session.reg_start) ge 0 and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'contactInfoUpdate'>
		<cfset stepStruct.title = 'Update Your Contact Info'>
		
		<cfset stepStruct.timeframe = ''>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Update your contact info to complete this step'>
		<cfsavecontent variable="stepStruct.body">
		<p>During the advising and registration process we may need to contact you to confirm your choices. Please take a moment to update the email address and phone numbers that we have on file.</p>
		
		<cfif session.parentlogin is FALSE>
		<p><a href="/registration/contact-info-update.cfm" class="button radius">Update Your Contact Info Now</a></p>
		</cfif>
		
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/registration/contact-info-update.cfm">
		<cfset stepStruct.topic = 'Registration'>                      
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
             
	<!--- Register First Semester Preview --->             
	<!--- *** Process Item Code: advisingCoursesRegistered - Preview - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR ( datecompare(compDate, application.registration_start) LT 0 OR not this.isProcessItemComplete(session.bannerid,'advisingRegistrationTraining') and session.studentType NEQ 'T')>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingCoursesRegistered'>
		<cfset stepStruct.status = 'Preview'>
		<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Register for Your First Semester Courses'>
		<cfsavecontent variable="stepStruct.body">
		<p>Registration will be available beginning on <cfoutput>#dateFormat(application.registration_start,'long')#</cfoutput>. Once you have completed all of the previous registration steps you will be able to register for your courses.</p>
		</cfsavecontent> 
		<cfset stepStruct.topic = 'Registration'>                         
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
				
	<!--- Register First Semester --->                 
	<!--- *** Process Item Code: advisingCoursesRegistered - Trad, Intl *** --->
	<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit,advisingRegistrationTraining') and datecompare(compDate, session.reg_start) ge 0 and session.studentType NEQ 'T') >
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'advisingCoursesRegistered'>
		<cfset stepStruct.timeframe = ''>
		<cfset stepStruct.title = 'Register for Your First Semester Courses'>
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		<cfset stepStruct.type = 'auto'>
		<cfset stepStruct.typeText = 'Finalize your schedule to complete'>
		<cfsavecontent variable="stepStruct.body">
		<p>You are now ready to register for your first semester classes. By now you should have learned about the registration process and created your first semester schedule based on the guidelines provided for students in your major. Remember that that information is always available under the 'Advising and Registration' section on the right, if you need to refer back to it.</p>
		<p>This step has two parts. First you must enroll in your classes using Banner Self-Service. Once you are finished and your schedule is complete, notify us that your schedule is to be reviewed by an academic advisor.</p>
		<p><a href="https://ssomgr.xavier.edu:7007/ssomanager/c/SSB" class="button radius" target="_blank">Step 1: Register for Classes in Banner Self-Service</a></p>
		
		<cfif session.parentlogin is FALSE >
			<p><a href="/registration/submit-schedule.cfm" class="button radius">Step 2: Finalize Your Completed Schedule</a></p>
		</cfif>
		
		</cfsavecontent>
		<cfset stepStruct.link = "https://ssomgr.xavier.edu:7007/ssomanager/c/SSB">
		<cfset stepStruct.topic = 'Registration'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	
	<!--- registration end --->

    </cffunction>
    
	<!--- the next steps function had to be divided in 2 because it was too long --->
	<cffunction name="getNextStepsPart2" returntype="array">
            <cfquery name="checkFWS" datasource="#application.roadtodb#">
		select bannerid 
        from bannerfinance 
        where bannerfinance.bannerid = <cfqueryparam value='#session.bannerid#' cfsqltype="varchar"> 
          and fund_code in ('UNIEMP','FWS')
        </cfquery>
        
        <!--- Housing --->   

 		<!--- Phase 1 Housing Agreement--->
 		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and NOT this.isProcessItemComplete(session.bannerid,'housingAgreement') and  datecompare(compDate, Application.housing_contract_start) gt 0 )>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'housingAgreement'>
                    <cfset stepStruct.topic = 'Housing'>
                    <cfset stepStruct.status = 'manual'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>    
        
        
        <!--- Phase 2 Roommate Selection --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and NOT this.isProcessItemComplete(session.bannerid,'housingRoommateGroups') and  datecompare(compDate, Application.housing_roommate_start) gt 0 )>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'housingRoommateGroups'>
                    <cfset stepStruct.topic = 'Housing'>
                    <cfset stepStruct.status = 'manual'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif> 
		
		<!--- /end housing --->


		<!--- Check for Stafford/Direct Loan --->
         <cfset hasStaff = 0>
         
         <cfquery name="getStaff" datasource="#application.roadtoDB#">
        select * from bannerFinance 
        where fund_code in ('DSTAFF','DUNSUB') and bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif getStaff.recordcount gt 0 >
            <cfset hasStaff = 1>
        </cfif>
         
            <!--- Check Perkins & Stafford 
		<cfset hasPerk = 0>
            <cfquery name="getPerk" datasource="#application.roadtoDB#">
        select * from bannerFinance 
        where fund_code = 'FPERK' and bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif getPerk.recordcount gt 0 >
            <cfset hasPerk = 1>
        </cfif>
            
            <!--- get the finaid counselor --->
        <cfquery name="finaidCounselor" datasource="#application.XavierWeb#">
        select * from finaidCounselor where counselorCode = <cfqueryparam value="#session.finaidCounselor#" cfsqltype="cf_sql_varchar">
        </cfquery>
            <!--- allow the date to be changed, for demo --->
		<cfif isdefined("url.currentDate") and url.currentDate NEQ ''>
            <cfset compDate = createDate(mid(url.currentDate,1,4),mid(url.currentDate,5,2),mid(url.currentDate,7,2))>
        <cfelse>
            <cfset compDate = now()>
        </cfif>--->
        
		
		
		<!--- Housing - removed in 2016 because they moved to a new system ---> 

 		<!--- *** Process Item Code: housingAgreement - Preview - ALL *** --->
        <!---<cfif isdefined("url.showAll") OR (NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.housing_contract_start) lt 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'housingAgreement'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.housing_contract_start)#'>
                    <cfset stepStruct.title = 'Complete Your Housing Agreement'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Once we have received your housing deposit, you will be able to submit your housing forms.</p>
            </cfsavecontent>
                    <cfset stepStruct.image = 'housing.jpg'>
                    <cfset stepStruct.topic = 'Housing'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>    
        
              
		<!--- *** Process Item Code: housingAgreement - Active - ALL *** --->
		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.housing_contract_start) ge 0 and session.housingDeposit EQ '1')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'housingAgreement'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Submit your housing agreement to complete'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Submit Your Housing Agreement'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Welcome to Xavier University and on-campus housing!  Your $200 Housing room reservation deposit has been received by the  Office of  Admission and we have been notified of your intent to live on  campus for the  2015-2016 and 2016-2017 academic years. We know that you  will benefit from  living in our residential environment and are pleased to confirm a space in  on-campus housing for you for the  2015-2016 and 2016-2017 academic years.</p>
			<p>Please submit the&nbsp;<a href="https://roadto.xavier.edu/housing/index.cfm">2015-2016 and 2016-2017  Xavier University On-Campus Housing Agreement and Provisions for Occupancy </a>as   soon as possible.  Failure to submit the  Agreement could prohibit us  from assigning a space to you.&nbsp; If your plans  have changed about living  on campus or attending Xavier for the 2015-2016 academic year, you  must contact the Office of Admission immediately at 513-745-3301.</p>
            <cfif session.studentType EQ 'T'>
            	<p>The information provided when you sign your housing agreement will be used by the Office of Residence Life when they configure your housing assignment. You will be notified of your housing assignment over the summer.</p>
            </cfif>
            
            	<cfif session.parentlogin is FALSE >
					<p><a href="https://roadto.xavier.edu/housing/index.cfm" class="button radius">Complete Your Housing Agreement Now</a></p>
            	</cfif>
			
			<p>Contact the Office of Residence Life at 513-745-3203 or <a href="mailto:reslife@xavier.edu">reslife@xavier.edu</a> with questions.</p>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/housing/index.cfm">
                    <cfset stepStruct.image = 'housing.jpg'>
                    <cfset stepStruct.topic = 'Housing'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end housingAgreement section --->--->

<!--- Housing Prefs --->   
<!--- 		<!--- *** Process Item Code: housingPrefManual - Preview - N,I *** --->
        <cfif isdefined("url.showAll") OR (session.studentType NEQ 'T' and (NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.housing_room_selection_start) lt 0 OR NOT this.isProcessItemComplete(session.bannerid,'housingAgreement')))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'housingPrefManual'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.housing_room_selection_start)#'>
                    <cfset stepStruct.title = 'Select Your Housing Preferences'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Once you have completed your housing agreement you will be able to access the housing preferences system, where you can indicate your housing preferences for the 2015-2016 school year.</p>
            </cfsavecontent>
                    <cfset stepStruct.image = 'housing.jpg'>
                    <cfset stepStruct.topic = 'Housing'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>               <!--- *** Process Item Code: housingPrefManual - Active - N,I *** --->
		<cfif isdefined("url.showAll") OR (session.studentType NEQ 'T' and this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.housing_room_selection_start) ge 0 and session.housingDeposit EQ '1' and this.isProcessItemComplete(session.bannerid,'housingAgreement'))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'housingPrefManual'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = 'Mark this item complete when you have selected your housing preferences.'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Select your Housing Preferences'>
                    <cfsavecontent variable="stepStruct.body">
            <p>You now have access to the first year room selection system. This separate website is designed to allow you to specify your housing preferences and choose your roommates. For now you can set up your profile and view other students' profiles. From May 1 through May 31 you will be able to form roommate groups that will be used when you are assigned to your room. You should complete your housing preferences by June 1. Your room assignment will be available through the Road to Xavier in early July.</p>
            <p>As you start to indicate your housing choices, please keep in mind that in addition to the traditional housing opportunities you can sign up for, <a href="/housing/llc-intro.cfm">Xavier also hosts several Living-Learning Communities.</a> Living-Learning Communities connect residential students' curricular and co-curricular experiences with the intention of integrating community living and academic learning. More information about Living-Learning Communities and instructions for signing up will be available in early May.</p> 
        			<p>Before you get started, check out the <a href="http://www.xavier.edu/residence-life/first-year-room-selection/index.cfm" target="_blank">First Year Room Selection website</a>. Here you can learn about the timeline for the process and each step along the way. If you have questions about any part of the process, this is where you can start. After reading the documentation and watching the videos that we have provided about the housing assignment process, we invite you to contact us with any questions via email at <a href="mailto:reslife@xavier.edu">reslife@xavier.edu</a> or by calling us at 513-745-3203.</p>
			<p><a href="https://roadto.xavier.edu/housing/room-selection-handoff.cfm" class="button radius">Access the First Year Housing Preferences System now!</a></p>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/housing/room-selection-handoff.cfm">
                    <cfset stepStruct.image = 'housing.jpg'>
                    <cfset stepStruct.topic = 'Housing'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end housingAgreement section --->    --->
		
		
    <!--- Smooth Transitions --->    		
	<!--- *** Process Item Code: stRegister - Preview - Trad *** --->
	<cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.st_start) lt 0) and (session.ethnicityID EQ '1' or session.ethnicityID EQ '2' or session.ethnicityID EQ '3' or session.ethnicityID EQ '4' or session.ethnicityID EQ '8') and session.studentType NEQ 'T' and NOT session.international)>
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
				<cfset stepStruct.itemCode = 'stRegister'>
				<cfset stepStruct.status = 'Preview'>
				<cfset stepStruct.type = ''>
		<cfset stepStruct.typeText = ''>
				<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.st_start)#'>
				<cfset stepStruct.title = 'Learn About Smooth Transitions'>
				<cfsavecontent variable="stepStruct.body">
		<p>In collaboration with Manresa, Xavier's new student orientation program, Smooth Transitions is the first-year student orientation program designed specifically for students of color. Incoming first-year students are given valuable information that can be put to use throughout their academic career. We'll show you how to access student resources such as health and counseling, student involvement, spiritual development, academic advising and more.</p>
		</cfsavecontent>
				<cfset stepStruct.image = 'smooth-transitions.jpg'>
				<cfset stepStruct.topic = 'Orientation'>
					  <cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>
	<!--- end stRegister section --->
    
	<!--- ALL Card --->    		
	<!--- *** Process Item Code: acPhotoUploaded - Preview - ALL *** --->
        <cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.ac_photo_start) lt 0) and session.studentType NEQ 'T' and NOT session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'acPhotoUploaded'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.ac_photo_start)#'>
                    <cfset stepStruct.title = 'Upload Your All Card Photo'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Xavier's all-purpose student ID card is the ALL Card. Submit your own photo electronically. Look for more information on the ALL Card photo upload process in early March. <a href="http://www.xavier.edu/auxiliary-services/all-card-center.cfm" target="_blank">In the meantime, take some time to learn more about the ALL Card&rsquo;s outstanding features and benefits</a>.</p>
            </cfsavecontent>
                    <cfset stepStruct.image = 'allcard.jpg'>
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end acPhotoUploaded section --->
        
		<!--- *** Process Item Code: acPhotoUploaded - Preview  - Intl*** --->
        <cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.ac_photo_start) lt 0) and session.studentType NEQ 'T' and session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'acPhotoUploaded'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.ac_photo_start)#'>
                    <cfset stepStruct.title = 'Upload Your All Card Photo'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Xavier's all-purpose student ID card is the ALL Card. While you will receive your physical ALL Card at International Student Orientation, you will be able to submit your own photo electronically prior to International Student Orientation so your personalized ALL Card is waiting for you when you arrive. Look for more information on the ALL Card photo upload process in early March. <a href="http://www.xavier.edu/auxiliary-services/all-card-center.cfm" target="_blank">In the meantime, take some time to learn more about the ALL Card&rsquo;s outstanding features and benefits</a>.</p>
            </cfsavecontent>
                    <cfset stepStruct.image = 'allcard.jpg'>
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        
		<!--- *** Process Item Code: acPhotoUploaded - Active - ALL *** --->
		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.ac_photo_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
            <cfset stepStruct.itemCode = 'acPhotoUploaded'>
			
            <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
            	<cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
            
			<cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Upload your ALL Card photo to complete'>
			<cfset stepStruct.timeframe = 'July 31 2016'>
			<cfset stepStruct.title = 'Upload Your ALL Card Photo'>
			<cfsavecontent variable="stepStruct.body">
				<!---  <p><a href="https://roadto.xavier.edu/allcard/" class="button radius">Upload Your Photo Now</a></p> --->
				<p><strong>Welcome to the Xavier ALL Card!&nbsp;&nbsp;</strong>The ALL Card is the official form of identification for the Xavier University community. However, it is much more...</p>
	<p>The mission of the ALL Card Center is to continue to improve on the quality and convenience of campus life. The ALL Card is a multi-functioning campus card. Convenience, simplicity, security... one card does it ALL!</p>
	<p>In addition to serving as a form of identification to access University facilities, the ALL Card&rsquo;s X Cash program also serves as a stored value campus card for purchases at most on-campus vending machines and retail operations, as well as some off campus merchants.&nbsp;</p>
	<p>The ALL Card can also function as a full service U.S. Bank ATM card and PIN-based debit card. We have direct integration with our long time banking partner, U.S Bank, to provide their customers with the added benefit of using their ALL Card as an ATM/Debit Card to access their checking account.</p>
	<p>The ALL Card is also tied into campus security and is used as the door key for campus residents to access their specific residence halls.&nbsp;&nbsp;&nbsp;Conveniently swipe your card to gain access to campus buildings and if you happen to lose it you can deactivate the card at anytime by logging in to your card management site through the ALL Card website.</p>
	<p><a href="http://www.xavier.edu/auxiliary-services/all-card-center.cfm" target="_blank">&raquo; Learn More About the ALL Card</a></p>
	
				<cfif session.parentlogin is FALSE >
				<p><a href="https://roadto.xavier.edu/allcard/" class="button radius">Upload Your Photo Now</a></p>
				</cfif>  
			
			</cfsavecontent>
	
			<cfset stepStruct.link = "https://roadto.xavier.edu/allcard/">
			<cfset stepStruct.image = 'allcard.jpg'>
			<cfset stepStruct.topic = 'ToDo'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>
		<!--- end acPhotoUploaded section --->
            
            
		<!--- Meal Plan --->    		
		<!--- *** Process Item Code: mealplanAgreement - Preview - ALL *** --->
		<cfif isdefined("url.showAll") OR (NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.mealplan_contract_start) lt 0)>
			<!--- This must be done for each step --->
			<cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'mealplanAgreement'>
			<cfset stepStruct.status = 'Preview'>
			<cfset stepStruct.type = ''>
			<cfset stepStruct.typeText = ''>
			<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.mealplan_contract_start)#'>
			<cfset stepStruct.title = 'Select Your Meal Plan'>
			<cfsavecontent variable="stepStruct.body">
				<p>Xavier Dining offers meal plans to meet the needs of both resident students and commuter students. We take pride in offering dishes to meet the needs of our guests  including vegetarian, vegan, and balanced choices. We are prepared to work  hard at making sure that you have the best dining experience with foods that  are satisfying and appealing.</p>
				<p>Learn more by visiting <a href="http://www.xavier.edu/dining" target="_blank">www.xavier.edu/dining</a></p>
			</cfsavecontent>
			<cfset stepStruct.image = 'meal-plan.jpg'>
			<cfset stepStruct.topic = 'ToDo'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>

		<!--- *** Process Item Code: mealplanAgreement - Active - ALL - On-Campus Student *** --->
		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.mealplan_contract_start) ge 0 and session.housingDeposit EQ '1')>
			<!--- This must be done for each step --->
			<cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'mealplanAgreement'>
			<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
				<cfset stepStruct.status = 'Complete'>
			<cfelse>
				<cfset stepStruct.status = 'Active'>
			</cfif>
			<cfset stepStruct.type = 'manual'>
			<cfset stepStruct.typeText = 'Select your meal plan to complete'>
			<cfset stepStruct.timeframe = '2016-07-01'>
			<cfset stepStruct.title = 'Select Your Meal Plan'>
			<cfsavecontent variable="stepStruct.body">
				<p><strong>Xavier Dining welcomes you to the class of 2020!</strong></p>
				<p>Xavier University Dining Services is your kitchen away from home, and we strive to be the place where hungry minds gather. The Hoff Dining Commons or "the caf" as you will learn during Manresa is in the heart of campus and will become your favorite place to eat, study, meet friends, or just hang out. This all-you-care-to-eat residential dining hall responds to the needs of any student diet preference such as vegetarian, vegan, avoiding gluten, and more. With multiple on-campus retail eatery options, your love of food will always be satisfied. If you have specific questions in regards to dietary needs or have food allergies, please contact our service staff at 513-745-4874. Need more help? View our <a href='http://www.dineoncampus.com/xu/show.cfm?cmd=_mealPlansFAQs' target="_blank">Q&A Fact Sheet</a> for further assistance with understanding your meal plan and our services.</p>
				<!---<p><a href="https://youtube.com/watch?v=Sf-sKB8iIzA" target="_blank">Learn more about the Hoff Dining Commons</a></p>--->
				
				<p>Please  be certain to select the right meal plan to meet your specific needs. If you need assistance, we will be happy to  help you through the process. For 2016-2017, your Resident Meal Plan options are:
				<ul class="inItem">
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">Xavier Blue plus $250 Dining Dollars, offering unlimited meals</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">Xavier Silver plus $100 Dining Dollars, offering unlimited meals</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">Xavier White plus $100 Dining Dollars, offering 225 meals per  semester</a></li>
				</ul></p>
				
				<p>You will select your meal plan via Xavier's housing & meal plan self-service system:
				<ol>
					<li>Access the <a href="http://xavier.edu/thd" target="_blank">housing & meal plan self-service system</a>.</li>
					<li>Sign in using your Road to Xavier username and password.</li>
					<li>From the Meal Plans menu, choose &quot;Select/Change My Plan.&quot;</li>
					<li>On the next screen, select "Fall 2016" for the term and press Submit. Note that at this point you only need to select your meal plan for Fall 2016 and it will automatically roll over to Spring 2017.</li>
					<li>On the next screen, press the "Select Dining Plan" button.</li>
					<li>Finally, you can select your meal plan. Note that if you are living on campus you must select the Xavier Blue plus $250 Dining Dollars, Xavier Silver plus $100 Dining Dollars, or Xavier White plus $100 Dining Dollars plan. If you choose a plan other than these it will be automatically switched before the semester begins.</li>
				</ol>
				
				<!---<p>Please follow Xavier Dining on <a href="http://www.facebook.com/pages/Xavier-Dining/169738566409092" target="_blank">Facebook</a> and <a href="http://www.twitter.com/XavierDining" target="_blank">Twitter (@XavierDining)</a> to stay  informed, or <a href="http://www.youtube.com/user/XavierDining" target=-"_blank">see what we're up to on YouTube</a>.</p>--->
				
				<cfif session.parentlogin is FALSE >
					<p><a href="http://www.xavier.edu/thd" target="_blank" class="button radius">Select Your Meal Plan Now</a></p>
				</cfif>
			</cfsavecontent>
			<cfset stepStruct.link = "http://www.xavier.edu/thd">
			<cfset stepStruct.image = 'meal-plan.jpg'>
			<cfset stepStruct.topic = 'ToDo'>
			
			<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>

		<!--- *** Process Item Code: mealplanAgreement - Active - ALL - Commuter *** --->
		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.mealplan_contract_start) ge 0 and session.housingDeposit NEQ '1')>
			<!--- This must be done for each step --->
			<cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'mealplanAgreement'>
			<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
				<cfset stepStruct.status = 'Complete'>
			<cfelse>
				<cfset stepStruct.status = 'Active'>
			</cfif>
			<cfset stepStruct.type = 'manual'>
			<cfset stepStruct.typeText = ''>
			<cfset stepStruct.timeframe = '2016-07-01'>
			<cfset stepStruct.title = 'Select Your Meal Plan'>
			<cfsavecontent variable="stepStruct.body">
				<p><strong>Xavier Dining welcomes you to the class of 2020!</strong></p>
				
				<p>Xavier University Dining Services is your kitchen away from home, and we strive to be the place where hungry minds gather. The Hoff Dining Commons or "the caf" as you will learn during Manresa is in the heart of campus and will become your favorite place to eat, study, meet friends, or just hang out. This all-you-care-to-eat dining hall responds to the needs of any student diet preference such as vegetarian, vegan, avoiding gluten, and more. With multiple on-campus retail eatery options, your love of food will always be satisfied. If you have specific questions in regards to dietary needs or have food allergies, please contact our service staff at 513-745-4874. Need more help? View our <a href='http://www.dineoncampus.com/xu/show.cfm?cmd=_mealPlansFAQs' target="_blank">Q&A Fact Sheet</a> for further assistance with understanding your meal plan and our services.</p>
				
				
				<p>Please  be certain to select the right meal plan to meet your specific needs. If you need assistance, we will be happy to  help you through the process. For  2016-2017, your Resident Meal Plan options are:
				<ul  class="inItem">
				
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">Xavier Blue plus $250 Dining Dollars, offering unlimited meals</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">Xavier Silver plus $100 Dining Dollars, offering unlimited meals</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">Xavier White plus $100 Dining Dollars, offering 225 meals per  semester</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">80 Block plus $150 Dining Dollars</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">40 Block plus $150 Dining Dollars</a></li>
					<li><a href="http://www.xavier.edu/auxiliary-services/documents/2016-17%20Dining%20Plan%20Information.pdf" target="_blank">25 Block plus $150 Dining Dollars</a></li>
				</ul>
				<p>You will select your meal plan via Xavier's housing & meal plan self-service system:
				<ol>
					<li>Access the <a href="http://xavier.edu/thd" target="_blank">housing & meal plan self-service system</a>.</li>
					<li>Sign in using your Road to Xavier username and password.</li>
					<li>From the Meal Plans menu, choose &quot;Select/Change My Plan.&quot;</li>
					<li>On the next screen, select "Fall 2016" for the term and press Submit. Note that at this point you only need to select your meal plan for Fall 2016 and it will automatically roll over to Spring 2017.</li>
					<li>On the next screen, press the "Select Dining Plan" button.</li>
					<li>Finally, you can select your meal plan.</li>
				</ol>
				
				<!---<p>Please follow Xavier Dining on <a href="http://www.facebook.com/pages/Xavier-Dining/169738566409092" target="_blank">Facebook</a> and <a href="http://www.twitter.com/XavierDining" target="_blank">Twitter (@XavierDining)</a> to stay  informed, or <a href="http://www.youtube.com/user/XavierDining" target=-"_blank">see what we're up to on YouTube</a>.</p>--->
				
				<cfif session.parentlogin is FALSE >
					<p><a href="http://www.xavier.edu/thd" target="_blank" class="button radius">Select Your Meal Plan Now</a></p>
				</cfif>
		</cfsavecontent>
		<cfset stepStruct.link = "http://xavier.edu/thd">
		<cfset stepStruct.image = 'meal-plan.jpg'>
		<cfset stepStruct.topic = 'ToDo'>
		
		<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>
		<!--- end mpAgreement section --->
		
		
		<!--- Housing Virtual Tour - removed in 2016 --->
		<!---<!--- *** Process Item Code: housingVirtualTour - trad, I *** --->
		<cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.housing_vt_start) ge 0 and session.housingDeposit EQ '1' and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
			<cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'housingVirtualTour'>
			<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
				<cfset stepStruct.status = 'Complete'>
			<cfelse>
				<cfset stepStruct.status = 'Active'>
			</cfif>
			<cfset stepStruct.type = 'manual'>
			<cfset stepStruct.typeText = ''>
			<cfset stepStruct.timeframe = '2016-05-01'>
			<cfset stepStruct.title = "View the Virtual Tour of Xavier's Residence Halls">
			<cfsavecontent variable="stepStruct.body">
				<p>Xavier's residence halls are located in the heart of campus and offer features like 24-hour safety monitoring, wireless internet access, satellite TV and more. Take a virtual tour of the residence halls to see what they have to offer.</p>
				<p><a href="http://www.xavier.edu/residence-life/prospective/Virtual-Tour.cfm" class="button radius" target="_blank">View the Virtual Tour of Xavier's Residence Halls</a></p>
			</cfsavecontent>
			<cfset stepStruct.link = "http://www.xavier.edu/residence-life/prospective/Virtual-Tour.cfm">
			<cfset stepStruct.topic = 'Housing'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>
		<!--- end housing virtual tour ---> --->       
		
		
		<!--- NameCoach --->
		
		<!--- *** Process Item Code: nameCoach - Preview - ALL *** --->
		<cfif isdefined("url.showAll") OR (NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.nameCoach) lt 0)>
			<!--- This must be done for each step --->
			<cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'nameCoach'>
			<cfset stepStruct.status = 'Preview'>
			<cfset stepStruct.type = ''>
			<cfset stepStruct.typeText = ''>
			<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.namecoach_start)#'>
			<cfset stepStruct.title = "What's in a name?">
			<cfsavecontent variable="stepStruct.body">
				<p>Basically, it means everything - and we want to make sure we get yours right.</p>

				<p>So tell us how to pronounce it - so we know we're doing it correctly. Record your name using our pronunciation service, NameCoach, and it will be used throughout your time at Xavier.</p>

				<p>Example: Xavier. It's pronounced Zey-vyer. Get it?</p>
			</cfsavecontent>
			<cfset stepStruct.topic = 'ToDo'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>
		
		<!--- *** Process Item Code: nameCoach - ALL *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.namecoach_start) ge 0))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'nameCoach'>
            
			<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
            
			<cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
			<cfset stepStruct.title = "What's in a name?">
			
			<cfset namecoachLink = 'https://www.name-coach.com/record/D39BE?email=#trim(session.username)#%40xavier.edu&first_name=#trim(session.firstname)#&last_name=#trim(session.lastname)#'>
			
			<cfsavecontent variable="stepStruct.body">
				<p>Basically, it means everything - and we want to make sure we get yours right.</p>

				<p>So tell us how to pronounce it - so we know we're doing it correctly. Record your name using our pronunciation service, NameCoach, and it will be used throughout your time at Xavier.</p>

				<p>Example: Xavier. It's pronounced Zey-vyer. Get it?</p>
                    
				<cfif session.parentlogin is FALSE >
					<p><a href="#namecoachLink#" class="button radius">Record Your Name</a></p>
				</cfif>	
                    
            </cfsavecontent>
			<cfset stepStruct.link = namecoachLink >
			<cfset stepStruct.topic = 'ToDo'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end NameCoach --->
		
		
		<!--- Advising Plagiarism Tutorial --->
		
		<!--- *** Process Item Code: plagiarismTutorial - Preview - Trad *** --->
		<cfif isdefined("url.showAll") OR (NOT this.isProcessItemComplete(session.bannerid,'deposit,advisingSRStatement') OR datecompare(compDate, Application.plagiarism_start) lt 0 and session.studentType NEQ 'T' and NOT session.international)>
			<!--- This must be done for each step --->
			<cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'plagiarismQuiz'>
			<cfset stepStruct.status = 'Preview'>
			<cfset stepStruct.type = ''>
			<cfset stepStruct.typeText = ''>
			<cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.plagiarism_start)#'>
			<cfset stepStruct.title = 'Complete the Plagiarism Tutorial'>
			<cfsavecontent variable="stepStruct.body">
				<p>At Xavier, we have an expectation of academic honesty. To help students understand what plagiarism is and how to avoid it, we offer an online plagiarism tutorial.  You must complete the tutorial and quiz.</p>
			</cfsavecontent>
			<cfset stepStruct.topic = 'ToDo'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
		</cfif>
		
		<!--- *** Process Item Code: plagiarismTutorial - Trad *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingSRStatement') and datecompare(compDate, Application.plagiarism_start) ge 0) and session.studentType NEQ 'T' and NOT session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
			<cfset stepStruct.itemCode = 'plagiarismQuiz'>
            
			<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
            
			<cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = ''>
			<cfset stepStruct.timeframe = 'View the tutorial and take the quiz'>
			<cfset stepStruct.title = 'Complete the Plagiarism Tutorial'>
			<cfsavecontent variable="stepStruct.body">
             	<p>At Xavier, we have an expectation of academic honesty. To help students understand what plagiarism is and how to avoid it, we offer an online plagiarism tutorial.  You must complete the tutorial and quiz.</p>
                    
				<cfif session.parentlogin is FALSE >
					<p><a href="http://roadto.xavier.edu/plagiarism/index.cfm" class="button radius">Take the Preventing Plagiarism Tutorial</a></p>
				</cfif>	
                    
            </cfsavecontent>
			<cfset stepStruct.link = "http://roadto.xavier.edu/plagiarism/index.cfm">
			<cfset stepStruct.topic = 'ToDo'>
			<cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end advising plagiarism tutorial --->
		
		
    	<!--- IR Transition to College Survey --->
		<!--- *** Process Item Code: irSurvey - Trad *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.ir_survey_start) ge 0) and session.studentType NEQ 'T' and NOT session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'irSurvey'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Complete the Transition to College Survey'>
                    <cfsavecontent variable="stepStruct.body">
             <p>The Transition to College survey pertains to your expectations and readiness to begin your college experience at Xavier University. Your responses will provide advisors and other Xavier personnel with important information to assist you in your transition to college life. <b>This very brief survey should take less than a minute to complete.</b></p>
                    
                    	<cfif session.parentlogin is FALSE >	
							<p><a href="https://roadto.xavier.edu/your-road/transition-survey.cfm" class="button radius">Take the Survey Now</a></p>
                    	</cfif>	
							
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/transition-survey.cfm">
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end IR Transition to College Survey --->
    <!--- smooth transitions --->

		<!--- *** Process Item Code: stRegistration - Trad *** --->
        <cfif (isdefined("url.showAll") OR (datecompare(compDate, Application.st_start) ge 0 and (session.ethnicityID EQ '1' or session.ethnicityID EQ '2' or session.ethnicityID EQ '3' or session.ethnicityID EQ '4' or session.ethnicityID EQ '8') and this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.st_stop) lt 0 and session.studentType NEQ 'T' and not session.international))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'stRegistration'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = 'Register for Smooth Transitions to Complete'>
                    <cfset stepStruct.timeframe = '2016-07-01'>
                    <cfset stepStruct.title = 'Register For Smooth Transitions'>
                    <cfsavecontent variable="stepStruct.body">
            <p>In collaboration with Manresa, Xavier's new student orientation program, Smooth Transitions is the first-year student orientation program designed specifically for students of color. Incoming first-year students are given valuable information that can be put to use throughout their academic career. We'll show you how to access student resources such as health and counseling, student involvement, spiritual development, academic advising and more.</p>
           
           	<cfif session.parentlogin is FALSE >
            	<p><a href="https://roadto.xavier.edu/smooth-transitions/index.cfm" class="button radius">Register now for Smooth Transitions</a></p>
           	</cfif>
           	
           	
           		
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/smooth-transitions/index.cfm">
                    <cfset stepStruct.image = 'smooth-transitions.jpg'>
                    <cfset stepStruct.topic = 'Orientation'>
         	
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>     
<!--- Jesuit Identity Static Page & Quiz --->
		<!--- *** Process Item Code: jesuitIdentityStaticPage - Trad *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.jesuit_process_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'jesuitIdentityStaticPage'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-07-01'>
                    <cfset stepStruct.title = "Learn More About Xavier's Jesuit Identity">
                    <cfsavecontent variable="stepStruct.body">
             <p>Book smarts will only get you so far. At Xavier, you'll develop knowledge for sure. But you'll also develop values, spiritual growth, responsibility for others and a love for learning - the stuff that really prepares you to function as an active member of the global community.</p>
                      <p>Watch the faith and justice video to learn more about Xavier's Jesuit Identity.</p>
                    
                    <cfif session.parentlogin is FALSE >
                    <p><a href="https://roadto.xavier.edu/about/jesuit-identity.cfm" class="button radius">View the Jesuit Identity Page Now</a></p>
                    </cfif>
                    
            </cfsavecontent>
                    <cfset stepStruct.link = "/about/jesuit-identity.cfm">
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Jesuit Identity Page --->    
		<!--- *** Process Item Code: jesuitQuiz - Preview -Trad, I *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and not this.isProcessItemComplete(session.bannerid,'jesuitIdentityStaticPage') and datecompare(compDate, Application.jesuit_process_start) ge 0) and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'jesuitQuiz'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Take the Jesuit Identity Quiz'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Once you have reviewed the Jesuit Identity page and watched the faith and justice video a short quiz will be available to help review what you have learned.</p>
            </cfsavecontent>
                    <cfset stepStruct.topic = 'AboutXavier'>                         <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
            <!--- *** Process Item Code: jesuitQuiz - Trad, I *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,jesuitIdentityStaticPage') and datecompare(compDate, Application.jesuit_process_start) ge 0) and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'jesuitQuiz'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Take the quiz to complete'>
                    <cfset stepStruct.timeframe = '2016-07-15'>
                    <cfset stepStruct.title = 'Take the Jesuit Identity Quiz'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Now that you have watched the faith and justice video and reviewed the Jesuit Identity page, take this short quiz to help review what you have learned.</p>
            
            <cfif session.parentlogin is FALSE >
            	<p><a href="https://roadto.xavier.edu/your-road/jesuit-quiz.cfm" class="button radius">Take the Jesuit Identity Quiz Now</a></p>
            </cfif>
            
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/jesuit-quiz.cfm">
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>  
     

 <!--- *** Process Item Code: Student Commitment *** --->
        <cfif isdefined("url.showAll")  OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.student_commitment_start) ge 0) >
    			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'studentCommitment'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Sign the Student Commitment'>
                    <cfset stepStruct.timeframe = '2016-08-01'>
                    <cfset stepStruct.title = 'Sign the Student Commitment'>
                    <cfsavecontent variable="stepStruct.body">
            <p>As a Xavier student, you are joining a large community that cares for and supports each other. In the spring of 2014, Xavier students captured our community ideals in the Xavier Student Commitment.</p>
            <p>
           		 <cfif stepStruct.status is 'active' and  session.parentlogin is FALSE >
		   		 	<a href="https://roadto.xavier.edu/your-road/student-commitment.cfm" class="button radius">Sign the Student Commitment</a>
            	</cfif>
            </p>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/student-commitment.cfm">
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>  


 
 





       
<!--- Financial Literacy Static Page & Quiz --->
		<!--- *** Process Item Code: financialLiteracyPage - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.financial_literacy_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'financialLiteracyPage'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-06-01'>
                    <cfset stepStruct.title = "Learn More About Financial Literacy">
                    <cfsavecontent variable="stepStruct.body">
                      <p>Watch the videos and review the content provided by the Bursar's Office and the Office of Student Financial Assistance to learn more about paying for your Xavier education.</p>
                    <p><a href="https://roadto.xavier.edu/your-road/financial-literacy.cfm" class="button radius">View the Financial Literacy Page Now</a></p>
            </cfsavecontent>
                    <cfset stepStruct.link = "/your-road/financial-literacy.cfm">
                    <cfset stepStruct.topic = 'Financial'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Financial Literacy Page --->
            <!--- *** Process Item Code: financialLiteracyQuiz - Preview - Trad, I *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and not this.isProcessItemComplete(session.bannerid,'financialLiteracyPage') and datecompare(compDate, Application.financial_literacy_start) ge 0) and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'financialLiteracyQuiz'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Take the Financial Literacy Quiz'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Once you have reviewed the Financial Literacy page and watched the videos a short quiz will be available to help review what you have learned.</p>
            </cfsavecontent> 
                    <cfset stepStruct.topic = 'Financial'>                         <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
            <!--- *** Process Item Code: financialLiteracyQuiz - Trad, I *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,financialLiteracyPage') and datecompare(compDate, Application.financial_literacy_start) ge 0) and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'financialLiteracyQuiz'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Take the quiz to complete'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Take the Financial Literacy Quiz'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Now that you have watched the videos and reviewed the Financial Literacy page, take this short quiz to help review what you have learned.</p>
            
            <cfif session.parentlogin is FALSE >
            <p><a href="https://roadto.xavier.edu/your-road/financial-literacy-quiz.cfm" class="button radius">Take the Financial Literacy Quiz Now</a></p>
            </cfif>
            
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/financial-literacy-quiz.cfm">
                    <cfset stepStruct.topic = 'Financial'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif> 

<!--- transfer orientation --->            <!--- *** Process Item Code: TransferOrientation - Tran *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') AND datecompare(compDate, Application.manresa_transfer_reg_start) ge 0 AND session.studentType EQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'transferOrientation'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-10'>
                    <cfset stepStruct.title = 'Register for Transfer Orientation'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Transfer orientation is a program designed especially for transfer students. At transfer orientation you will meet current transfer students, new transfer students, become oriented with campus and campus services, and more. The goal of transfer orientation is to make your transition to life at Xavier easier while recognizing your previous experience at a college or university. Transfer orientation serves to welcome you as a member of the Xavier family and address any questions, concerns or curiosities you might have about the Xavier experience!</p>
                          
                          <cfif session.parentlogin is FALSE >
                          		<p><a href="https://roadto.xavier.edu/manresa/transfer-registration.cfm" class="button radius">Register Now</a></p>
                          </cfif>
                          
            </cfsavecontent>
                    <cfset stepStruct.image = 'manresa.jpg'>
                    <cfset stepStruct.link = "/manresa/transfer-registration.cfm">
                    <cfset stepStruct.topic = 'Orientation'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Transfer Orientation section ---> 
    <!--- Finaid Promisory Notes 
		<!--- *** Process Item Code: perkProm *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingApproved') and datecompare(compDate, Application.perkins_prom_start) ge 0) and hasPerk)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'perkProm'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = 'Complete Your Perkins Master Promissory Note'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Complete Your Perkins Promissory Note'>
                    <cfsavecontent variable="stepStruct.body">
                    <cfoutput>
                    <p> As a student who has been awarded the Federal Perkins Loan as part of their financial aid package, you must complete a Perkins Master Promissory Note (MPN)
  			to accept the loan. The MPN should be completed after you register for fall semester classes. </p>
            <p> The MPN is completed online through a company called ECSI. You should receive an email from <a href="mailto:webmaster@ecsi.net">webmaster@ecsi.net</a> with
              instructions when the MPN is available for you to complete online. You may complete the MPN at <a href="http://www.ecsi.net/prom2a/">http://www.ecsi.net/prom2a/</a> when the MPN becomes available. Before you begin you should have the PIN that the
              Department of Education has issued to you. The PIN may be retrieved at <a href="http://www.pin.ed.gov/">www.pin.ed.gov</a>. </p>
            <p> If you want to decline the loan then please notify your financial aid counselor, #finaidCounselor.name#, at #finaidcounselor.phone# or
              #finaidcounselor.email#. </p>
            <p> If you have questions regarding the Federal Perkins Loan Master Promissory Note, please contact Debbie Schneider at 513-745-4833 or <a href="mailto:schneid@xavier.edu">schneid@xavier.edu</a>. </p>
                    <p><a href="http://www.ecsi.net/prom2a/" target="_blank" class="button radius">Complete Your Perkins Master Promissory Note Now</a></p>
            </cfoutput>

            </cfsavecontent>
                    <cfset stepStruct.link = "http://www.ecsi.net/prom2a/">
                    <cfset stepStruct.topic = 'Financial'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>--->
<!---     Finaid Promisory Notes (Stafford Loan) --->
		<!--- *** Process Item Code: staffProm *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit,advisingApproved') and datecompare(compDate, Application.staff_prom_start) ge 0) and hasStaff)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'staffProm'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = 'Complete Your Direct Master Promissory Note'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Complete Your Direct Promissory Note'>
                    <cfsavecontent variable="stepStruct.body">
            <p>As a student who has been awarded a Federal Direct Loan (subsidizied and/or unsubsidized) as part of their financial aid package, you must complete the items below to accept the loan(s).</p>
            <ol style="margin-left: 1.5em; list-style: decimal;">
            <li style="margin-bottom: .5em;">Entrance Counseling will review the rights and responsibilities of borrowing from the federal loan program.</li>
            <li style="margin-bottom: .5em;">The Master Promissory Note (MPN) is a legal document required by the Department of Education (from which you will borrow the loan money).</li>
            </ol>
			<p>Both items can be completed online at <a href="http://www.studentloans.gov" target="_blank">www.studentloans.gov</a>. Before you begin you should have an FSA ID created for you by the Department of Education. Information about your FSID can be found at: <a href="https://studentaid.ed.gov/sa/fafsa/filling-out/fsaid" target="_blank">https://studentaid.ed.gov/sa/fafsa/filling-out/fsaid</a>.</p>
			
            <cfoutput>
            <p>If you want to decline the loan then please notify the Office of Student Financial Assistance at <a href="mailto: xufinaid@xavier.edu">xufinaid@xavier.edu</a> or 513-745-3142</p>
            </cfoutput>
                    <p><a href="http://www.studentloans.gov" target="_blank" class="button radius">Complete Your Direct Master Promissory Note Now</a></p>
            </cfsavecontent>
                    <cfset stepStruct.link = "http://www.studentloans.gov">
                    <cfset stepStruct.topic = 'Financial'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>

<!--- Wellness Medical History --->            
	<!--- *** Process Item Code: wellnessMedicalHistory - ALL ***  --->
	<cfset thisStep = 'advisingCoursesRegistered'>
	<cfif this.isProcessItemComplete(session.bannerid,thisStep )>
		<cfset regStatus = 'Complete'>
	<cfelse>
		<cfset regStatus = 'Active'>
	</cfif>
	<cfif isdefined("url.showAll") OR  (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.wellness_general_start) ge 0) >
		<!--- This must be done for each step --->
		<cfset stepStruct = {}>
		<cfset stepStruct.itemCode = 'wellnessMedicalHistory'>
		
		<cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
			<cfset stepStruct.status = 'Complete'>
		<cfelse>
			<cfset stepStruct.status = 'Active'>
		</cfif>
		
		<cfset stepStruct.type = 'manual'>
		<cfset stepStruct.typeText = 'Submit your medical history to complete'>
		<cfset stepStruct.timeframe = '2016-08-01'>
		<cfset stepStruct.title = 'Submit your Immunization and Medical History'>
		<cfsavecontent variable="stepStruct.body">
			<p>Wellness Services will provide resources for a healthy and safe educational experience.</p>
			<p>To provide a safe and healthy campus, Xavier requires students to provide proof of immunization against Measles, Mumps, Rubella and Meningitis.</p>
			
			<cfif session.parentlogin is FALSE >
				<p><a href="https://roadto.xavier.edu/your-road/wellness-medical-history.cfm" class="button radius">Submit the required Immunization Information Now.</a></p>
			</cfif>
		
		</cfsavecontent>
		<cfset stepStruct.link = "https://roadto.xavier.edu/your-road/wellness-medical-history.cfm">
		<cfset stepStruct.topic = 'ToDo'>
		<cfset arrayAppend(nextStepsArray,stepStruct)>
	</cfif>            
            <!--- Auxiliary Services - Banking --->
		<!--- *** Process Item Code: auxServBanking - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.banking_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'auxServBanking'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-06-01'>
                    <cfset stepStruct.title = 'Learn About Xavier Consumer Banking Services'>
                    <cfsavecontent variable="stepStruct.body">
                            <p>Welcome to Xavier Consumer Banking Services! As part of the Xavier community for the past 20 years, our staff at U.S. Bank at Xavier University is devoted to making sure 					you have the best experience possible. We have a staff of experienced banking industry professionals located right here on campus to assist you with all of your financial management needs.
 
<p>We have a convenient on-campus branch location inside the Gallagher Student Center and value added services such as integration to the Xavier ALL Card program as well as Financial Wellness seminars that are offered throughout the academic year.</p>
 
<p>Also, for added convenience and around the clock access to all of our services please visit our new online <a href="http://usbank.com/xu" target="_blank">Xavier University Campus Banking Center</a>.</p>
 
<p>Please feel free to contact me directly if you have any questions regarding the services we proudly provide to the Xavier community.</p>
 				
                <p>
 
				Best Regards,
 				<br><br>
 				
				Barb Suguitan <br>
				Xavier Branch, Branch Manager  <br>
				Gallagher Student Center, 2nd Floor  <br>
				513-745-3798  <br>
                <a href="mailto:banking@xavier.edu">banking@xavier.edu</a> </p>
                           <div class="flex-video">
               <iframe width="560" height="315" src="https://www.youtube.com/embed/LEfog8PbeCQ?rel=0" frameborder="0" allowfullscreen></iframe> 
               </div>
                       </cfsavecontent>
                    <cfset stepStruct.link = "https://www.usbank.com/student-banking/xavier-university/index.html">
                    <cfset stepStruct.image = 'banking.jpg'>
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Banking section --->
    <!--- Auxiliary Services - Bookstore --->
		<!--- *** Process Item Code: auxServBookstore - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.bookstore_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'auxServBookstore'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-01'>
                    <cfset stepStruct.title = 'Learn About  The Xavier All For One Shops'>
                    <cfsavecontent variable="stepStruct.body">
                <p> Welcome to the The Xavier All For One Shops! We are here to provide you with one stop shopping for all of your textbook, school supply, and Xavier merchandise needs. </p>
                <p><a href="https://roadto.xavier.edu/documents/bookstore.pdf" target="_blank"> &raquo; General Bookstore Information</a> </p>
                <p><a href="http://www.xavier.edu/undergraduate-admission/life-at-xavier/Musketeer-Chats.cfm" target="_blank"> &raquo; View Archived Bookstore Webinar</a> </p>
                <p><a href="http://www.bkstr.com/webapp/wcs/stores/servlet/StoreCatalogDisplay?langId=-1&amp;storeId=10476&amp;demoKey=d&amp;catalogId=10001" target="_blank"> &raquo; Purchase Your Textbooks and Xavier Merchandise/Apparel Online </a> </p>
                            <p> Sincerely, </p>
                <p> Michael Hubbard <br/>
                  Xavier University Bookstore, Director <br/>
                  Gallagher Student Center, 1st floor <br/>
                  513-745-3311 <br/>
                  <a href="mailto:hubbardm1@xavier.edu">hubbardm1@xavier.edu</a> </p>

            </cfsavecontent>
                    <cfset stepStruct.link = "http://www.xavier.edu/auxiliary-services/xavier-bookstore.cfm">
                    <cfset stepStruct.image = 'bookstore.jpg'>
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Bookstore section --->
    <!--- Auxiliary Services - Parking --->
		<!--- *** Process Item Code: auxServParking - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.parking_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'auxServParking'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-07-01'>
                    <cfset stepStruct.title = 'Learn About Xavier Parking Services'>
                    <cfsavecontent variable="stepStruct.body">
                <p> Welcome to Xavier University Parking Services! We are the primary source for any parking related needs on Xavier's campus. As a division of Auxiliary Services, we manage the majority of parking on campus and are in partnership with the Xavier Police to provide a convenient and reliable experience for all of our students, faculty, and staff. </p>
                <p> For your convenience, the majority of services that we provide are web based and can be accessed anytime, anywhere, through the <a href="http://www.xavier.edu/students/systems.cfm" target="_blank">Student Hub</a>. These services include, but are not limited to, the purchasing of your parking permit, paying a citation and updating your vehicle information. </p>
                <p> Our office is located across from Hailstones Hall in the Musketeer Mezzanine of Fenwick Place. </p>
                <p> For any questions and more detailed information, please feel free to visit our <a href="http://www.xavier.edu/parking">Xavier University Parking Services Website</a> for more information. We look forward to serving you! </p>
                <p>Xavier University Parking Services <br>
                  Musketeer Mezzanine, Fenwick Place <br>
                  513-745-1050 <br>
                  <a href="mailto:parkingservices@xavier.edu">parkingservices@xavier.edu</a> </p>


            </cfsavecontent>
                    <cfset stepStruct.link = "http://www.xavier.edu/parking">
                    <cfset stepStruct.image = 'parking.jpg'>
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Parking Info section --->
    <!--- Wellness - Health Insurance Waiver --->
		<!--- *** Process Item Code: wellnessWaiver - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.wellness_waiver_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'wellnessWaiver'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-09-30'>
                    <cfset stepStruct.title = 'Submit Your Student Health Insurance Waiver'>
                    <cfsavecontent variable="stepStruct.body">
                <p>All full time undergraduate students are required to have health insurance coverage. Students are automatically charged for and enrolled in Xavier's student health insurance plan. If you have a comparable insurance plan you may waive the Xavier health insurance plan and the charge.</p>
                <ol class="inItem">
                    <li>Go to <a href="https://www.gallagherstudent.com/xavier">www.gallagherstudent.com/xavier</a></li>
                    <li>Click on Enroll/Waive and follow the instructions. Your Student ID Number is : <cfoutput>#session.bannerid#</cfoutput></li>
                    <li>The waiver period opens <strong>July 1, 2016</strong>.</li>
                    <li>The waiver period closes on<strong> September 15, 2016</strong>.</li>
                    <li>Waiver requests will not be accepted after <strong>September 30, 2016</strong>.</li>
                </ol>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://www.gallagherstudent.com/xavier">
                    <cfset stepStruct.topic = 'ToDo'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Wellness Health Insurance Waiver section ---> 
                <!---Communications Survey --->

		<!--- *** Process Item Code: communicationsSurvey - ALL *** --->
    		  <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.comm_survey_start) ge 0)>
    			<!--- This must be done for each step --->
                    <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'communicationsSurvey'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-06-15'>
                    <cfset stepStruct.title = 'Complete The Communications Survey'>
                    <cfsavecontent variable="stepStruct.body">
                <p>Now that you can look back on your path to making your college decision, we'd love to hear from you about your experience with communications from Xavier along the way. What did you like? What did we miss? What can we improve on for the Class of 2021? </p>

				<cfif session.parentlogin is FALSE >
					<p><a href="https://roadto.xavier.edu/your-road/communicationSurvey.cfm" class="button radius">Take The Survey Now</a></p>
				</cfif>	
					
            </cfsavecontent>
                    <cfset stepStruct.link = "/your-road/communicationSurvey.cfm">
                    <cfset stepStruct.topic = 'ToDo'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Communications Survey ---> 
        
            <!--- Auxiliary Services - Purchase Your Parking Permit --->
		<!--- *** Process Item Code: parkingPermit - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.parking_permit_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'parkingPermit'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-01'>
                    <cfset stepStruct.title = 'Purchase Your Parking Permit'>
                    <cfsavecontent variable="stepStruct.body">
                <p> The Office of Auxiliary Services is now offering the 2015-2016 Xavier Parking Permits online. </p>
				<p> Any questions can be directed to Parking Services at (513) 745-1050 or <a href="mailto:parkingservices@xavier.edu">parkingservices@xavier.edu</a>. We look forward to serving you soon! </p>
				
				<cfif session.parentlogin is FALSE >
					<p><a href="https://roadto.xavier.edu/your-road/parking-permit.cfm" class="button radius">Purchase Your Parking Permit Now</a></p>
				</cfif>
            
            </cfsavecontent>
                    <cfset stepStruct.link = "/your-road/parking-permit.cfm">
                    <cfset stepStruct.topic = 'ToDo'>
                    <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Wellness Health Insurance Waiver section ---> 
    <!--- Retention Countdown --->
		<!--- *** Process Item Code: retentionCountdown - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.retention_countdown_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'retentionCountdown'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-06-01'>
                    <cfset stepStruct.title = 'Review Our Summer Tips and Advice'>
                    <cfsavecontent variable="stepStruct.body">
                <p>As you prepare for your transition to Xavier, you will find the summer to be a flurry of activity.  You may also find this to be a time of mixed emotions.  The following words of advice may help you make the most of your summer months as you prepare for your transition to being a college student at Xavier University.</p>
                         
                         
                         <cfif session.parentlogin is FALSE >
                            <p><a href="https://roadto.xavier.edu/your-road/countdown.cfm" class="button radius">View the Summer Tips & Advice</a></p>
                         </cfif> 
                            
                            
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/countdown.cfm">
                    <cfset stepStruct.topic = 'ToDo'>
            <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Retention Countdown section --->                <!--- Common Reading ---> 
<!---            		<!--- *** Process Item Code: crUploaded - Preview - Trad *** --->
        <cfif isdefined("url.showAll") OR ((NOT this.isProcessItemComplete(session.bannerid,'deposit') OR datecompare(compDate, Application.common_reading_start) lt 0) and not session.international and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'cuUploaded'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Approximate Start:</span> #this.generalMonth(application.common_reading_start)#'>
                    <cfset stepStruct.title = 'Submit Your Common Reading Experience Essay'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Each summer the Xavier faculty, as part of the Manresa orientation program, selects a common book for the entering first-year class to read together. Later this summer you will be asked to submit your thoughts on the book in response to questions posted on Road to Xavier. During orientation students will have an opportunity to discuss their reactions to the book with Xavier faculty, who will have read the writing assignments submitted electronically.</p>
			<p>Look for more details on the Common Reading Experience program in May.</p>
            </cfsavecontent>
                    <cfset stepStruct.topic = 'Orientation'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end crUploaded section ---> 
        		<!--- *** Process Item Code: crUploaded - Trad *** --->
<!---
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.common_reading_start) ge 0) and session.studentType EQ 'N' and not session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'crUploaded'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Due:</span> August 1, 2014'>
                    <cfset stepStruct.title = 'Submit Your Common Reading Experience Essay'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Each summer the Xavier faculty, as part of the Manresa orientation program, selects a common book for the entering first-year class to read together.</p>
                    <p>We are very pleased to announce the book selection for the Xavier common reading experience for first-year students.  The selection for the 2014 common reading is <i>Tattoos on the Heart</i> by Gregory Boyle.  All incoming first-year students are required to read it and respond in writing, via <b>The Road to Xavier</b>, to one of three essay questions.  Essay submissions are due by August 1, 2014. </p>
                            <p><a href="https://roadto.xavier.edu/common-reading/index.cfm" class="button radius">View the Common Reading Site Now</a></p>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/common-reading/index.cfm">
                    <cfset stepStruct.topic = 'Orientation'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
--->
            <!--- *** Process Item Code: crUploaded - Tran *** --->
        <!---<cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.common_reading_start) ge 0) and session.studentType EQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'crUploaded'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = 'Upload your Common Reading document to complete'>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Due:</span> August 1, 2014'>
                    <cfset stepStruct.title = 'The Common Reading Experience Program'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Please Note: This only applies to students who will be attending Manresa and/or transferring at the freshman level. If you do not need to participate, you can mark the item complete.</p>
                    <p>Each summer the Xavier faculty, as part of the Manresa orientation program, selects a common book for the entering first-year class to read together.</p>
                    <p>We are very pleased to announce the book selection for the Xavier common reading experience for first-year students.  The selection for the 2014 common reading is <i>The Immortal Life of Henrietta Lacks</i> by Rebecca Skloot.  All incoming first-year students are required to read it and respond in writing, via <b>The Road to Xavier</b>, to one of three essay questions.  Essay submissions are due by August 1, 2014. </p>
                            <p><a href="/common-reading/index.cfm" class="button radius">View the Common Reading Site Now</a></p>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/common-reading/index.cfm">
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>--->
    		<!--- *** Process Item Code: crUploaded - Intl *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.common_reading_start) ge 0) and session.international and session.studentType NEQ 'T')>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'crUploaded'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = 'Upload your Common Reading document to complete'>
                    <cfset stepStruct.timeframe = '<span class="timeframe-label">Due:</span> August 1, 2014'>
                    <cfset stepStruct.title = 'Submit Your Common Reading Experience Essay'>
                    <cfsavecontent variable="stepStruct.body">                    <p>Each summer the Xavier faculty, as part of the Manresa orientation program, selects a common book for the entering first-year class to read together.</p>
                    <p>We are very pleased to announce the book selection for the Xavier common reading experience for first-year students.  The selection for the 2014 common reading is <i>Tattoos on the Heart</i> by Gregory Boyle.  All incoming first-year students are required to read it and respond in writing, via <b>The Road to Xavier</b>, to one of three essay questions.  Essay submissions are due by August 1, 2014. </p>
                            <p><a href="https://roadto.xavier.edu/common-reading/index.cfm" class="button radius">View the Common Reading Site Now</a></p>
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/common-reading/index.cfm">
                    <cfset stepStruct.topic = 'Orientation'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif> 
		
		--->
            <!--- *** Process Item Code: getInvolved - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.get_involved_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'getInvolved'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-01'>
                    <cfset stepStruct.title = 'Get Involved - Explore Clubs!'>
                    <cfsavecontent variable="stepStruct.body">                    <p>Getting involved by joining one of our 160 student organizations helps you discover your passions, develop skills for your future, and form lasting friendships.</p>
                        
                          <cfif session.parentlogin is FALSE >
                            <p><a href="https://roadto.xavier.edu/your-road/get-involved.cfm" class="button radius">Get Involved Now!</a></p>
                          </cfif>
                            
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/get-involved.cfm">
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
    		<!--- *** Process Item Code: advisingStudentHandbook - ALL *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.handbook_start) ge 0))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'handbookAgreement'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Review the handbook and Submit the student handbook agreement to complete'>
                    <cfset stepStruct.timeframe = '2016-08-01'>
                    <cfset stepStruct.title = 'Review the Student Handbook'>
                    <cfsavecontent variable="stepStruct.body">
             <p> We are pleased to welcome you to Xavier University! You've made the choice to join the Xavier community and in doing so you will begin an educational experience that will engage you in exciting and challenging opportunities to become your best self. Our community is one characterized by respect and genuine concern for each other and we look forward to learning how your unique talents, interests and gifts will enhance our campus environment. </p>
            <p> Your decision to become an XU student is just one of many opportunities that you'll have to choose your path and make your way in the world. We want you to know that the Xavier community is invested in your success and will support you as you to continue to make important choices and decisions in the days and years to come. </p>
            <p> One important resource to help guide your choices in the Xavier community is the Student Handbook. This document provides detailed information regarding your rights and responsibilities as a Xavier student. It is the obligation of every Xavier University student to know, understand and comply with the policies, guidelines and procedures within the handbook. </p>
            <p> We think you'll find that the policies and procedures articulated in our Student Handbook are clear guideposts that help us all live Xavier's mission and vision daily. Please take some time to familiarize yourself with the Student Handbook and please let us know if you have any questions. </p>
            <p> You'll find the Student Handbook at the following link: <a href="http://www.xavier.edu/studenthandbook" target="_blank">http://www.xavier.edu/studenthandbook</a> </p>
            <p> We look forward to welcoming you, supporting your journey and celebrating your success along the way! </p>
            <p> Sincerely,<br>
            David Johnson<br>
            Associate Provost, Student Affairs </p>
            <p> Jean Griffin <br>
            Director, Office of Student Integrity </p>

					<cfif session.parentlogin is FALSE >
                    <p><a href="https://roadto.xavier.edu/your-road/handbook-agreement.cfm" class="button radius">Submit the Student Handbook Agreement Now</a></p>
					</cfif>
					
					
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/handbook-agreement.cfm">
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
           <!--- Think About It --->
		<!--- *** Process Item Code: thinkAboutIt - Trad, I *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.thinkAboutIt_start) ge 0))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'thinkAboutit'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-15'>
                    <cfset stepStruct.title = "Complete 'Think About It'">
                    <cfsavecontent variable="stepStruct.body">
                     <p>Xavier is committed to providing a safe and nurturing college environment where students can grow and learn. As part of this commitment, all incoming first-year students will complete Think About It, a thoughtful, interactive and educational program aimed at preparing you for the unique challenges and responsibilities of college life. Think About It focuses on minimizing risks associated with alcohol, drugs, and sexual violence by taking a harm-reduction approach.</p>
            <p>Think About It is administered as an online course that will take approximately 2.5 hours to complete. You can complete the course in your own time with the ability to save and exit at any time. Remember, you must complete this course prior to your arrival at Xavier. As you complete the course, there will be a series of confidential questions to assist Xavier in our programming efforts. The information collected is strictly confidential—we will not receive any personally identifiable information about you.</p>
                    <p>Next steps:</p>
                  <ol>
           <li>Click <a href="http://campusclarity.com/" target="_blank">HERE</a> to access the Think About It course.</li>
		   <li>Click the blue box in the upper right corner of the screen that says “Login to Training.”</li>
		   <li>You will use your Xavier University email to access your account. Your Xavier University email is your Road to Xavier username + "@xavier.edu" , <cfoutput>#session.username#</cfoutput>@xavier.edu.</li>
		    <li>You will then receive an authentication email at your Xavier email address. To access your Xavier email, go to <a href="http://www.xavier.edu/students" target="_blank">www.xavier.edu/students</a> and click the email button. Enter your username, <cfoutput>#session.username#</cfoutput>, and password (previously used during the registration process). Please refer to the "Create Your Xavier Account" step if you need assistance with your username and/or password.</li>
          <li>Once you authenticate your account, you will be able to set a password that will allow you access for one year to your Think About It account.</li>
           </ol>
              <!---            <ol>
                <li>Click <a href="http://campusclarity.com/">HERE</a> to access the Think About It course.</li>
                <li>Click the blue box that says &ldquo;Get Started.&quot;</li>
                <li>You will use your Xavier University email to access your account. Your Xavier University email is your Road to Xavier username + "@xavier.edu" , <cfoutput>#session.username#</cfoutput>@xavier.edu. </li>
                <li>You will then receive an authentication email at your Xavier email address. To access your Xavier email, go to <a href="http://mail.xavier.edu">http://mail.xavier.edu</a>. Then enter your username, <cfoutput>#session.username#</cfoutput>, and password (previously used during the registration process). Please refer to the "Your Xavier Account" step if you need assistance with your username and/or password.</li>
                <li>Once you authenticate your account, you will be able to set a password that will allow you access for one year to your Think About It account.</li>
            </ol>--->
                                                    <p>&nbsp;</p>
            <p>You will receive regular reminders from Campus Clarity in your Xavier email account as you progress through the course, so be on the lookout for those messages.</p>
            <p>We hope that you enjoy the course!</p>
                    <p>If you have questions or need assistance, please contact Kate Lawson, Title IX Coordinator, at 513-745-3046 or <a href="mailto:lawsonk1@xavier.edu">lawsonk1@xavier.edu</a>.</p>
                   
                   <cfif session.parentlogin is FALSE >
                    	<p><a href="http://campusclarity.com/" class="button radius">Continue to "Think About It" Now</a></p>
                   </cfif>
                    
            </cfsavecontent>
                    <cfset stepStruct.link = "http://campusclarity.com/">
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Think About It --->
            <!--- *** Process Item Code: studentFERPA - ALL *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.ferpa_form_start) ge 0))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'studentFERPA'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'auto'>
            <cfset stepStruct.typeText = 'Submit Your FERPA'>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'Learn About Sharing Information with Your Parents'>
                    <cfsavecontent variable="stepStruct.body">
             <p>The Office of Student Success and Parent/Family Outreach serves as an advocate for both students and parents in the Xavier family. We are here to serve you and your parents as you progress through your Xavier career. One way in which we work to keep parents informed of their student&rsquo;s success is by sharing information pertaining to academic progress.</p>
             <p>As a college student, you are considered an adult upon turning 18, and at this point certain information may not be shared with any third party without your written permission. This federal protection is provided to you through the Family Educational Rights and Privacy Act (FERPA). By submitting the FERPA form, this allows Xavier to send your mid-term grades home to your parents, during your freshman year, so they may support you in your academic progress. </p>
			<p>Please submit the FERPA form to allow Xavier to share your mid-term grades and with your parents.</p>

					<cfif session.parentlogin is FALSE >
                    	<p><a href="https://roadto.xavier.edu/your-road/student-ferpa.cfm" class="button radius">Submit Your FERPA Now</a></p>
					</cfif>
						
            </cfsavecontent>
                    <cfset stepStruct.link = "https://roadto.xavier.edu/your-road/student-ferpa.cfm">
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>

        <!--- *** Process Item Code: bursarFERPA - ALL *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.ferpa_form_start) ge 0))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'bursarFERPA'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-01'>
                    <cfset stepStruct.title = 'Submit Your Bursar FERPA Release'>
                    <cfsavecontent variable="stepStruct.body">
            	<p>The Family Educational Rights and Privacy Act (FERPA), passed in 1974, is a federal law that protects the privacy of student education records. This law gives students 18 years of age or older, or students of any age if enrolled in any postsecondary educational institution, the right to privacy of their education records. For a comprehensive discussion of FERPA at Xavier please visit <a href="http://www.xavier.edu/registrar/ferpa.cfm">http://www.xavier.edu/registrar/ferpa.cfm</a>.</p>
                            <p>The Bursar release is available as a separate form. This allows families access to billing information relating to charges, payment information, eBills, and collections.</p>
                            <p>Students are encouraged to complete Part A of the FERPA form and return it to the Office of the Bursar. If the student does complete Part A, then Part B does not have to be completed. However, if the student decides not to sign the FERPA form, the parent or guardian can complete <a href="http://www.xavier.edu/bursar/documents/ferpa_form.pdf"  target="_blank">Part B of this form</a> and attach a signed copy of their 2014 Federal Income Tax Return to certify that the student is their dependent according to Section 152 of the Internal Revenue Code. Part B is valid for only the current academic year. Since IRS dependency can change annually, you must submit copies of your Federal Income Tax Return each year along with this form to continue access to your student&rsquo;s financial and education records.</p>
                <p><a href="http://www.xavier.edu/bursar/documents/ferpa_form.pdf" target="_blank">&raquo; Download the FERPA form</a></p>
                            <p>Your Student ID (or Banner ID, as it is sometimes called) is:  <strong><cfoutput>#session.bannerid#</cfoutput></strong></p>
                            <p><strong>Return the completed form by scanning it to:</strong></p>
                <p><a href="mailto:xubursar@xavier.edu">xubursar@xavier.edu</a></p>
                <p><strong>OR faxing the completed form to:</strong></p>
                <p>1-513-745-2926</p>
                <p><strong>OR mail the completed form to:<br />
                </strong></p>
                <p>The Office of the Bursar<br />
                Xavier University<br />
                3800 Victory Parkway<br />
                Cincinnati, OH 45207-3361<br />
                &nbsp;</p>
							<cfif session.parentlogin is FALSE >
								<p><a href="http://www.xavier.edu/bursar/documents/ferpa_form.pdf" class="button radius">Access the Bursar FERPA Release Now</a></p>
							</cfif>
            
            </cfsavecontent>
                    <cfset stepStruct.link = "http://www.xavier.edu/bursar/documents/ferpa_form.pdf">
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
    <!--- Safety --->
		<!--- *** Process Item Code: safetyInfo - ALL *** --->
        <cfif isdefined("url.showAll") OR ((this.isProcessItemComplete(session.bannerid,'deposit') and datecompare(compDate, Application.safety_start) ge 0))>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'safetyInfo'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-07-01'>
                    <cfset stepStruct.title = "Learn About Campus Safety">
                    <cfsavecontent variable="stepStruct.body">
                     <p>Families and students are always concerned about safety and want to know &ldquo;How safe is the Xavier campus?&rdquo; simply and directly, <strong>Very Safe</strong>.  Campus crimes decreased by 27% during the 2009-2010 academic year as  compared to the previous year, even though the residential population on  campus grew by 17%. In fact, personal property crime has declined 30%  over the last four years. However, it is important to note Xavier is  part of a larger urban community and we make the personal safety and  security of all students, faculty, staff and visitors a top priority.</p>

			<p>The University provides a voice, text message, and email system, XU ALERT ME. This communication system contacts members of the campus community through     voice, text messages and emails in the event of an urgent situation. Students may sign up for the service through the MyXU campus portal.</p>

			<p>The way in which the University contacts members of the campus community about safety issues differs depending on the nature of the incident.</p>
			
					<cfif session.parentlogin is FALSE >
                    	<p><a href="https://roadto.xavier.edu/your-road/safety.cfm" class="button radius">Learn More About Campus Safety</a></p>
					</cfif>
					
            </cfsavecontent>
                    <cfset stepStruct.link = "/your-road/safety.cfm">
                    <cfset stepStruct.topic = 'AboutXavier'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Safety --->
<!--- international orientation --->
		<!--- *** Process Item Code: intOrientation - Intl *** --->
        <cfif isdefined("url.showAll") OR (session.international)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'intlOrientation'>
                    <cfif this.isProcessItemComplete(session.bannerid,stepStruct.itemCode)>
                <cfset stepStruct.status = 'Complete'>
            <cfelse>
            	<cfset stepStruct.status = 'Active'>
            </cfif>
                    <cfset stepStruct.type = 'manual'>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = ''>
                    <cfset stepStruct.title = 'International Student Orientation'>
                    <cfsavecontent variable="stepStruct.body">
            <p>New international students (Undergraduates, Graduates, Intensive English and Exchange) must attend the mandatory International Student Orientation. The orientation takes place the Thursday and Friday before classes begin each semester. Students who will be living on campus and have made their housing deposits may move in the day prior to the mandatory International Student Orientation. However, students must notify the Office of Residence Life at <a href="mailto:reslife@xavier.edu">reslife@xavier.edu</a> to request it. Students who arrive and want to move in two days prior to the orientation will be assessed a USD $30 per night fee. More detailed information can be found at the <a href="http://www.xavier.edu/international-students/Orientation-Information.cfm" target="_blank">International Student Orientation website</a>.</p>
            </cfsavecontent>
                    <cfset stepstruct.link = 'http://www.xavier.edu/international-students/Arrival-Information.cfm'>
                    <cfset stepStruct.topic = 'Orientation'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end intlOrientation section --->	
	
    <!--- Manresa --->             		<!--- *** Process Item Code: manresa - Preview - Trad, Intl *** --->
        <cfif isdefined("url.showAll") OR session.studentType NEQ 'T'>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'manresa'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-18'>
                    <cfset stepStruct.title = 'Attend Manresa Orientation'>
                    <cfsavecontent variable="stepStruct.body">
            <p>Manresa is a four-day program designed especially for new students. It's an opportunity to meet the people with whom you will be spending the next few years, to figure out where your classes are, to experience the fun of college before classes start and to meet upper-class students who will show you the ropes. The primary goal of Manresa is for students to make the transition to life at Xavier. New students and their 
            families are introduced to the campus, Xavier's programs, faculty, administrators, and other students and families. Most importantly, Manresa welcomes you as a member of the Xavier family and addresses any questions, concerns or curiosities you might have about the experiences Xavier has to offer.</p>
            </cfsavecontent>
                    <cfset stepStruct.image = 'manresa.jpg'>
                    <cfset stepStruct.topic = 'Orientation'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end Manresa section --->
        
		
		<!--- Student Employment --->
		<!--- *** Process Item Code: stuEmployment - Preview - ALL *** --->
        <cfif isdefined("url.showAll") OR (this.isProcessItemComplete(session.bannerid,'deposit') AND checkFWS.recordcount gt 0  and datecompare(compDate, Application.university_employment_start) ge 0)>
			<!--- This must be done for each step --->
            <cfset stepStruct = {}>
                    <cfset stepStruct.itemCode = 'stuEmployment'>
                    <cfset stepStruct.status = 'Preview'>
                    <cfset stepStruct.type = ''>
            <cfset stepStruct.typeText = ''>
                    <cfset stepStruct.timeframe = '2016-08-22'>

                    <cfset stepStruct.title = 'Attend On-Campus Employment Fair'>
                    <cfsavecontent variable="stepStruct.body">
                        <p> Attending the On-Campus Employment Fair is the best opportunity to interview for student worker positions. At the fair, you will meet and discuss positions with Xavier departmental supervisors and off-campus community service supervisors.  Positions are not guaranteed.</p>
                            <h3>About the Fair</h3>
                           <p>
               <strong>When:</strong> August 24, 2015 - 3:00-5:00 p.m. <br>
			   <strong>Where:</strong> Xavier University - Cintas Center <br>
               </p>

				<ul>
                <li>Come Prepared to Interview at the Fair</li>
                <li>Attire is business casual (khaki pants and nice polo shirt or blouse)</li>
                <li>Only work study or university unlimited awarded students may attend.</li>
                </ul>
                            <h3>Bring with you:</h3>
                            <ul>
                	<li>Your ALL Card
					<li>Copies of your resume
					<li>Copies of your class schedule 
                    <li>Copies of your completed <a href="/documents/career/Student-Employee-Availability.pdf" target="_blank">student availability form</a>
                    <li><a href="/documents/career/required-documents.pdf" target="_blank">Proper identification for the I-9 form</a>** and Direct Deposit Information <br>
                    <strong>NO COPIES CAN BE USED, ORIGINAL DOCUMENTATION IS REQUIRED!</strong>  </li>

                </ul>
                            <p>If a position is offered and accepted, you must complete all Federal and University new hire forms before you can begin work.   These forms include:</p>
                			<ul>
                    		<li>State and Federal tax forms.  You will need to know the number of exemptions to claim for both of these forms.</li>

							<li>Federal  I-9 form - proper <a href="/documents/career/required-documents.pdf" target="_blank">identification for the I-9 form</a>.** <br />
                            <strong>NO COPIES CAN BE USED, ORIGINAL DOCUMENTATION IS REQUIRED! </strong></li>

							<li>Direct deposit form - A voided check or deposit slip is preferred, however, if that isn't available, you may write on the form the Routing ## and Account ## for checking or savings account.</li>

                                                    </ul>
        			
                   <p>For more information regarding student employment visit the <a href="http://www.xavier.edu/career/students/Students.cfm" target="_blank">Career Development Office website</a>.</p> 
                                               <p style="font-size:9pt">
                 **All employees (student workers) hired after November 6, 1986, and working in the United States must complete the I-9 Form as required by the Department of Homeland Security - U. S. Citizenship and Immigration Services prior to the start of work. Please review the <a href="/documents/career/required-documents.pdf" target="_blank">list of acceptable documents</a> to determine the simplest means to fulfil this requirement. The office of Career Development must verify all hiring documents prior to start of work.  <strong>NO COPIES CAN BE USED, ORIGINAL DOCUMENTATION IS REQUIRED!</strong></p>
                                          </cfsavecontent>
                    <cfset stepStruct.topic = 'ToDo'>
                          <cfset arrayAppend(nextStepsArray,stepStruct)>
        </cfif>
        <!--- end stuEmployment section --->	
    	<cfreturn nextStepsArray>
    </cffunction>
   
    <!--- RETURN: html for single next step --->
    <cffunction name="getSingleStep"  returntype="String">
            <!--- Scholarship RSVP--->
		<!---<cfif datecompare(now(),Application.schol_invite_start) gt 0 and datecompare(now(),Application.schol_invite_end) lt 0 and session.scholarshipEligible EQ '1' and session.scholarshipComplete NEQ '1'>
            <cfreturn '<div id="interior-nextSteps"><h2><a href="https://roadto.xavier.edu/about/scholarship-rsvp.cfm">Scholarship RSVP</a></h2></div>'>
        </cfif>--->
        
		<cfif session.parentlogin>
			<cfreturn ''>
		</cfif>
		
		<!--- Submit Your Deposit --->
        <cfif not this.isProcessItemComplete(session.bannerid, 'deposit')>
            <cfreturn  '<a class="button text-left Financial" href="/about/deposit.cfm"><div class="row">' &
            		   '<div class="small-2 columns"><p><i class="fa fa-arrow-circle-o-down fa-2x"></i></p></div>' &
            		   '<div class="small-10 columns"><p style="font-weight:bold">Submit Your Deposit</p></div></div></a>'>
        </cfif>
    		<!--- determine their next active Step --->
        <cfset nextStepsArray = this.getNextSteps()>
        <cfset singleNextStep = ''>
            <cfloop index="i" from="1" to="#arrayLen(nextstepsArray)#">
	            
          <cfif nextStepsArray[i].status EQ 'active' and not listFindNoCase('visit,fafsa,genplacement,intlVisa,intlHousing,intlRegister,housing', nextStepsArray[i].itemCode)>
          	<cfif structKeyExists(nextStepsArray[i],'link')>
          		<cfreturn '<a class="button text-left #nextStepsArray[i].topic#" href="#nextStepsArray[i].link#"><div class="row">' &
            		   '<div class="small-2 columns"><p><i class="#nextStepsArray[i].topic#"></i></p></div>' &
            		   '<div class="small-10 columns"><p>#nextStepsArray[i].title#</p></div></div></a>'>  
            <cfelse>
            	<cfmail from="lieslandr@xavier.edu" to="sparkse1@xavier.edu,lieslandr@xavier.edu" subject="Missing Link Quick Email" type="html">
                    IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                    <p>#session.username#</p>
                    <cfdump var="#nextStepsArray#">
                    <cfdump var="#CGI#" label="CGI">
                </cfmail>
                <cfbreak>
            </cfif>
          </cfif>
        </cfloop> 
            <cfreturn '<a class="button secondary text-left" href="/profile/update.cfm">' &
        		  '<div class="row"><div class="small-2 columns"><p><i class="fa fa-edit fa-2x"></i></p></div>' &
        		  '<div class="small-10 columns"><p>Update Your Profile</p></div></div></a>'>
    </cffunction>
<!--- *** 
Parental Access Section
*** --->

<cffunction name="getParentAccessList" returntype="query">
	<cfargument name="idIn">
    <!--- get the parents --->
    <cfquery name="getAccessors" datasource="#application.roadtoDB#">
    select parent_email, date_added
    from processParentAccess
    where bannerid  = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
      and date_deleted is null
   	</cfquery>
    <cfreturn getAccessors>
</cffunction>

<!--- ***
Advising 
*** --->

<cffunction name="isAdvisingActive">
	<cfargument name="idIn">
    <cfquery name="checkAppt" datasource="#application.roadtoDB#">
    select ID
    from advising
    where bannerid  = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
      and date_deleted is null
      and advising_start < <cfqueryparam value="#createODBCDateTime(dateAdd('n',5,now()))#" cfsqltype="cf_sql_timestamp">
    </cfquery>    <cfreturn checkAppt.recordCount GT 0>
</cffunction>

<cffunction name="advisingApptOut" returntype="string">
	<cfargument name="idIn">
    <cfquery name="checkAppt" datasource="#application.roadtoDB#">
    select max(advising_start) as a_start
    from advising
    where bannerid  = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
      and date_deleted is null
    </cfquery>
    <cfif checkAppt.recordCount EQ 0>
    	<cfreturn 'unknown'>
    <cfelse>
    	<cfreturn "#dateFormat(checkAppt.a_start,'long')# at #timeFormat(checkAppt.a_start,'short')# EDT">
    </cfif>
</cffunction>

<cffunction name="getAdvisingPhone" returntype="string">
	<cfargument name="idIn">

	<!--- see if we can find the advising phone number in the form manager --->
    <cfquery name="getSubmission" datasource="FB-2">
    select max(submissionID) as submission
    from form1097
    where value = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
    </cfquery>  
    <cfif getSubmission.recordCount Eq 0>
    	<cfreturn 'not on file'>
    <cfelse>
    	<cfquery name="getPhone" datasource="FB-2">
        select value
        from form1097 
        where submissionID = <cfqueryparam value="#getSubmission.submission#" cfsqltype="cf_sql_integer"> 
          and fieldID = <cfqueryparam value="14456" cfsqltype="cf_sql_integer">
    	</cfquery>
            <cfif getPhone.recordcount EQ 0>
        	<cfreturn 'not on file'>
        <cfelse>
        	<cfreturn getPhone.value>
        </cfif>
	</cfif> 	
    </cffunction>


<cffunction name="advisingStatus" returntype="string">
	<cfargument name="idIn">
    <!--- see if they are no where --->
    <cfquery name="checkNotStarted" datasource="#application.roadtoDB#">
    select max(ID) as sid from advisingSchedules
    where BannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif checkNotStarted.sid LE 0>
    	<cfreturn 'notStarted'>
    </cfif>
    <!--- see if they have submitted their schedule and are awaiting review --->
    <cfquery name="checkWaitingReview" datasource="#application.roadtoDB#">
    select ID from advisingSchedules
    where BannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
      and advisorDate is null
      and id = <cfqueryparam value="#checkNotStarted.sid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif checkWaitingReview.recordCount GT 0>
    	<cfreturn 'waitingReview'>
    </cfif>
    <!--- see if they have submitted their schedule and were rejected --->
    <cfquery name="checkRejected" datasource="#application.roadtoDB#">
    select ID from advisingSchedules
    where BannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
      and advisorStatus = <cfqueryparam value="reject" cfsqltype="cf_sql_varchar">
      and id = <cfqueryparam value="#checkNotStarted.sid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif checkRejected.recordCount GT 0>
    	<cfreturn 'rejected'>
    </cfif>
    <!--- see if they have submitted their schedule and were approved --->
    <cfquery name="checkApproved" datasource="#application.roadtoDB#">
    select ID from advisingSchedules
    where BannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
      and advisorStatus = <cfqueryparam value="approve" cfsqltype="cf_sql_varchar">
      and id = <cfqueryparam value="#checkNotStarted.sid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif checkApproved.recordCount GT 0>
    	<cfreturn 'approved'>
    </cfif>
    <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="Advising Status Quick Email" type="html">
    	<p>The advisingStatus function should never make it this far.</p>
        <cfdump var="#session#" label="session">
        <cfdump var="#variables#" label="variables">
        <cfdump var="#cgi#" label="CGI">
    </cfmail>
</cffunction>


</cfcomponent>
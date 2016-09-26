<cfcomponent name="R2Xmessages2014" hint="adds a level of abstraction for web,mobile to use the same code">   

        
    <!--- ***
	Get the next steps for the student
	*** --->
    <cffunction name="setMessages" returntype="void">
		
        <cfoutput>
        
		<!--- Get the Counselor Info --->
        <cfquery name="getCounselor" datasource="#application.RoadtoDB#">
        Select name, title, phone,email, Counselor.Counselorcode
        from Counselor
        inner join bannerstudent on left(bannerstudent.CounselorCode,3) = left(Counselor.CounselorCode,3)
        where bannerstudent.bannerID = <cfqueryparam value='#session.BannerID#' cfsqltype="cf_sql_varchar">
		</cfquery>
        
        <cfquery name="getFinaidCounselor" datasource="#Application.XavierWeb#">
        Select name, title, phone,email, counselorcode
        from FinaidCounselor
        where counselorCode = <cfqueryparam value='#session.finaidCounselor#' cfsqltype="cf_sql_varchar">
		</cfquery>
        
        <cfquery name="getFinaid" datasource="#application.RoadtoDB#">
        Select fundtype, FAFSA, ethnicityID, housing, Deposited, prep, HousingDeposit, housingcomplete, srDocUploaded, student.mathplacement, student.langplacement, Bannerfunds.ftyp_code, BannerFunds.FUND_CODE, cast(OFFER_AMT as float) offer_amt, packaged, FUND_TITLE, FSRC_CODE, FUND_TEXT 
        from bannerstudent
        left join Bannerfinance on bannerfinance.bannerID = bannerstudent.bannerID
        left join BannerFunds on bannerfunds.FUND_CODE = bannerfinance.FUND_CODE
        inner join student on student.bannerid = bannerstudent.bannerid
        where bannerstudent.bannerID = <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
        </cfquery>	
        
        <!--- Check Perkins & Stafford --->
		<cfset hasPerk = 0>
        <cfset hasStaff = 0>
		<cfset hasFWS = 0>
        
		<cfquery name="GetCount" dbtype="query">select * from getfinaid where fund_code = 'FPERK'</cfquery>
        <cfif getcount.recordcount gt 0 >
            <cfset hasPerk = 1>
        </cfif>
        
		<cfquery name="GetCount" dbtype="query">select * from getfinaid where fund_code in ('FSTAFF','FUNSUB')</cfquery>
        <cfif getcount.recordcount gt 0>
            <cfset hasStaff = 1>
        </cfif>
		
		<cfquery name="GetCount" dbtype="query">select * from getfinaid where fund_code in ('FWS','UNIEMP')</cfquery>
        <cfif getcount.recordcount gt 0>
            <cfset hasFWS = 1>
        </cfif>
		
        
        <cfquery name="checkManresa" datasource="#application.RoadtoDB#">
		SELECT GroupID 
        FROM manresaassignments 
        WHERE bannerid = <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
        </cfquery>	
		
		<!--- Main message holder for the site --->
		<cfset session.messages = structNew()>
            
		<!--- Message 1 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "President's Message">
        
        <cfset messageStruct.from = 'Michael J. Graham, S.J. - President'>
        <cfset messageStruct.subject = "President's Message">
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = '/images/administration/frGraham.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>Congratulations on your offer of admission to Xavier. I truly hope to welcome you as one of the members of <cfif session.studentType NEQ 'T'>Xavier's Class of 2020<cfelse>our student body</cfif>.</p>
            
            <p>Xavier University is a place where relationships are built, between and among the students, faculty, administrators and our successful alumni. Xavier's commitment to you and your personal success will highlight the education you receive should you choose to enroll here. While you browse through this special web site, my hope is that you will start to get a feeling for the uniqueness of the Xavier experience. <a href="https://roadto.xavier.edu/about/twitter.cfm">Follow along with our current students</a> and <a href="/profile/matches.cfm">meet your future classmates</a>, begin to build the friendships that will last a lifetime, and I'm confident you'll see that here at Xavier, we're All for One and One for All!</p>
            
            <p>Congratulations again, #session.firstName#. Please do not hesitate to contact our Office of Admission if we can provide further assistance.</p>
            
            <p>Sincerely,<br />
            Michael J. Graham, S.J.</p>        
        </cfsavecontent>
		<cfset messageStruct.display = TRUE>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,'1',messageStruct,TRUE)>
        
        <!--- Message 2 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Meet Your Counselor">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Meet Your Counselor'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>Congratulations on your acceptance to Xavier. As the admission counselor for students from your school, my job is to serve as a resource to you as you consider enrolling at Xavier. I look forward to getting to know you better and helping you become a Musketeer next fall.</p>
            
            <p>If you have any questions, feel free to give me a call or send me an email.</p>
            
            <p>Best wishes,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = TRUE>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,2,messageStruct,'TRUE')>
        
        <!--- Message 3 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Your Scholarship">
        
        <cfset messageStruct.from = '#getCounselor.name#, #getCounselor.title#'>
        <cfset messageStruct.subject = 'Your Scholarship'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.Counselorcode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>I am pleased to hear of your acceptance to Xavier University<cfif session.studentType EQ 'T'><cfelse>'s Class of 2020</cfif>. I would like to offer you my personal congratulations.</p>
            <p>Your academic accomplishments indicate you are well prepared for a challenging college experience.  In recognition of your accomplishments, you have been awarded a merit award to assist you in financing your Xavier education.  Details can be found in your personal financial aid package in the "Money Matters" section of Road to Xavier. <a href="/moneymatters/">Click here to view your financial aid package now</a>.</p>
            <p>Please contact me should you have any questions concerning this award.  I do hope you will join the Xavier family, with more than 50,000 alumni throughout the country and around the world.</p>
            <p>Sincerely,<br />
              #getCounselor.name#<br />
              #getCounselor.title#</p>
        </cfsavecontent>
		<cfquery name="GetCount" dbtype="query"> 
        select * 
        from getFinaid 
        where ftyp_code in ('SCHL','MERI') AND FundType = 'xavier' 
        </cfquery>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.finaid_start) gt 0 AND GetCount.recordCount GT 0>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,3,messageStruct,'TRUE')>
        
        <!--- Message 4 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "File FAFSA by Feb. 15">
        
        <cfset messageStruct.from = '#getCounselor.name#, #getCounselor.title#'>
        <cfset messageStruct.subject = 'File FAFSA by Feb. 15'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.Counselorcode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">       
            <p> If you haven't already done so, be sure to complete the Free Application for Federal Student Aid (FAFSA) in order to be considered for financial aid.  You may qualify for federal, state and/or institutional grants, as well as attractive loan programs and student employment opportunities.</p>
            <p>You can submit the FAFSA online at <a href="http://www.fafsa.ed.gov" target="_new">www.fafsa.ed.gov</a>.</p>
            <p>Be sure to list Xavier University, and complete all sections about you, your school plans and financial information.  Our school code is 003144.</p>
            <p>After you file the FAFSA, you will receive a student aid report. Xavier will also receive the information; in early March we will prepare your financial aid package and notify you via email (and through this website).</p>
            <p>Please contact me if you have any questions about the financial aid process.</p>
            <p>Sincerely,<br />
              #getCounselor.name#<br />
              #getCounselor.title#</p>
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.fafsa_start) gt 0 AND datecompare(now(), Application.fafsa_stop) lt 0 AND session.fafsa neq 1 and NOT session.international >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,4,messageStruct,'TRUE')>
        
        <!--- Message 5 --->
        
        <!--- depending on which list they are in, they see a different message --->
        
        <cfif listFind(application.sfxWinners, session.BannerID) or session.bannerid eq '000300001'>
			<cfset messageStruct = structNew()>
			<cfset messageStruct.title = "St. Francis Xavier Scholarship Winner">
            
            <cfset messageStruct.from = 'Dr. Marco Fatuzzo and Lauren Cobble'>
            <cfset messageStruct.subject = "St. Francis Xavier Scholarship Competition">
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">


			<p>Congratulations! It is our pleasure to inform you that the Xavier University Scholarship Committee has awarded you a full tuition <strong>St. Francis Xavier Scholarship</strong>.
			You were chosen from a group of outstanding candidates. The committee was very impressed with your excellent academic record, your essay, your leadership accomplishments and the manner in which 			you interviewed.</p>

			<p>Your scholarship will cover the full cost of your tuition annually for up to 18 credit hours per semester and will be worth $36,150 for the 2016-17 academic year. The scholarship will be honored for eight consecutive undergraduate semesters provided you maintain full-time status and a minimum cumulative grade point average of 3.00 in your freshman year, and 3.25 cumulative average thereafter. It is applicable to tuition costs during the fall and spring semesters only. Should you receive any other tuition-restricted scholarships or grants, your scholarship amount will be adjusted accordingly. This award replaces the merit-based scholarship you were awarded previously.</p>

<p><strong>Please inform us whether you plan to accept your scholarship by contacting Christine Sisson at <a href="mailto:sisson@xavier.edu">sisson@xavier.edu</a> , or 513 745-2989. A prompt answer will be much appreciated since there are alternates anxiously awaiting word. In any event, we look forward to hearing from you no later than May 1, 2016.</strong></p>

<p>We offer our congratulations on your outstanding achievements and look forward to hearing from you soon.</p>

            <p>Sincerely,<br>
            Dr. Marco Fatuzzo and Lauren Cobble <br />
           </p>
    
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            
			<cfset messageStruct.display = TRUE>
            
            <cfset messageStruct.mobileDisplay = TRUE>
        
            <cfset structInsert(session.messages,5,messageStruct,'TRUE')>   
                 
        <cfelseif listFind(application.sfxAlternates, session.BannerID)>
			<cfset messageStruct = structNew()>
			<cfset messageStruct.title = "St. Francis Xavier Scholarship Notification">
            
            <cfset messageStruct.from = 'Dr. Marco Fatuzzo  and Lauren Cobble<br>Co-chairs of the Scholarship Committee'>
            <cfset messageStruct.subject = "St. Francis Xavier Scholarship Competition">
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            <p> Thank you for competing for our St. Francis Xavier Scholarship for the 2016-17 academic year. The Xavier University Scholarship Committee was extremely impressed with the candidates who joined us for the competition this year. </p>
<p>
We are writing to inform you that while you have not been chosen as a St. Francis Xavier Scholarship recipient, you have been selected as an alternate for the award. In the event that one of the candidates initially selected for the scholarship declines this award, it will be offered to an alternate candidate. Should you be awarded the St. Francis Xavier Scholarship, you will be notified immediately. 
</p>
            
<p>If you have any questions, please feel free to contact Christine Sisson at <a href="mailto: sisson@xavier.edu">sisson@xavier.edu</a> , or 513 745-2989. 

<p>#session.firstname#, we hope that we will be able to welcome you as a member of the Xavier family this fall. We sincerely appreciate your interest in Xavier University and wish you the best as you complete your senior year.            
</p>

            <p>Sincerely,<br>
            Dr. Marco Fatuzzo and Lauren Cobble <br />
            </p>
    
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            
            <cfset messageStruct.display = TRUE>
            
            <cfset messageStruct.mobileDisplay = TRUE>
    
            <cfset structInsert(session.messages,5,messageStruct,'TRUE')>        
        <cfelse>
			<cfset messageStruct = structNew()>
            <cfset messageStruct.title = "">
            
            <cfset messageStruct.from = ''>
            <cfset messageStruct.subject = ''>
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            <cfset messageStruct.mobileDisplay = TRUE>
    
            <cfset structInsert(session.messages,5,messageStruct,'TRUE')>
        </cfif>
        
        <!--- Message 6 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Financial Aid Update">
        
        <cfset messageStruct.from = '#getCounselor.name#, #getCounselor.title#'>
        <cfset messageStruct.subject = 'Financial Aid Update'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.Counselorcode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            
            <!--- time to let them know the awards have been updated --->
            <cfif datecompare(now(), Application.fafsa_updated_start) gt 0>
            	<p> Our office of financial aid has received your institutional student aid report, your financial aid eligibility has been determined and your <a href="/moneymatters/">personal financial aid package</a> has been updated. <a href="/moneymatters/">Click here to view your financial aid package</a>.</p>
            <!--- time to let them know we have received their fafsa, but not processed it --->
            <cfelse>
            	<p>We have received your FAFSA information. We will begin to prepare financial aid awards in late February. Financial aid packages will be posted on this site at that time.</p>
                <!---<p>We have received your FAFSA information.</p>
				
                <p>We know that like us, you’re aware of the news coming out of Washington, D.C., about the sequestering - or withholding - of funds across the agencies and functions of the U.S. government, starting on March 1.</p>  
 
				<p>Because this situation will likely impact some of our student financial aid programs, we are required to delay the production and release of Xavier’s financial aid packages until we can determine the implications of sequester.</p>  
 
				<p>Please know that we hope to prepare financial aid packages as soon as we receive resolution from the Department of Education and the federal government.  We hope to prepare financial aid packages within the next 5 to 10 business days, at which time they will be posted on this site. Thank you for your patience.</p>--->
 
            </cfif>
            <p> Please <a href="mailto:#getFinaidCounselor.email#">contact me</a> if you have questions. </p>
            <p>Sincerely,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.fafsa_received_start) gt 0 and session.fafsa eq 1>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,6,messageStruct,'TRUE')>
        
        <!--- Message 7 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Living at Xavier">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Living at Xavier'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>Living on campus at Xavier offers conveniences and amenities which will help you to feel a part of the Xavier community from the first day of arriving on campus.  All first year residential options are conveniently located close to classroom buildings, the dining hall and the Gallagher Student Center…as well as the Cintas Center for basketball games.  Additionally, you will have access to high-speed internet connections, wi-fi and satellite/cable, individually controlled heat and air conditioning and more.</p>
            
<!---             <p>As an incoming student you can request which residence hall you would prefer to live in. <strong>Priority consideration is given to students based on the date of their tuition and housing deposit.</strong></p> --->
            
             <p>As an incoming student you can request which residence hall you would prefer to live in. <strong>Priority consideration is given to students based on the date of their tuition and housing deposit.</strong></p>
            
          
            
            <p><strong>The deadline to submit your deposit is May 1, 2016!</strong> <br><br>
	            
	            <a class="button radius" href="/about/deposit.cfm"
	            
		    onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X-Inbox','eventAction' : 'Deposit Link', 'eventLabel' : '#session.BannerID#' });" >
			    <strong>Submit Your Deposit Now!</strong></a></p>
			    
			    
            <p>Learn more about each residence hall:</p>
            <ul>
                <li><a href="http://www.xavier.edu/residence-life/prospective/brockman.cfm" target="_blank">Brockman Hall <cfif session.studentType EQ 'T'>(freshmen only)<cfelse></cfif></a></li>
                <li><a href="http://www.xavier.edu/residence-life/prospective/buenger.cfm" target="_blank">Buenger Hall</a> </li>
                <li><a href="http://www.xavier.edu/residence-life/prospective/husman.cfm" target="_blank">Husman Hall <cfif session.studentType EQ 'T'>(freshmen only)<cfelse></cfif></a> </li>
                <li><a href="http://www.xavier.edu/residence-life/prospective/kuhlman.cfm" target="_blank">Kuhlman Hall</a></li>
            
                <cfif session.studentType EQ 'T'>
                    <li><a href="http://www.xavier.edu/residence-life/current/fenwick.cfm" target="_blank">Fenwick Place</a> </li>
                    <li><a href="http://www.xavier.edu/residence-life/current/commons.cfm" target="_blank">Commons Apartments</a> </li>
                    <li><a href="http://www.xavier.edu/residence-life/current/village.cfm" target="_blank">Xavier Village</a> </li>
                    <li><a href="http://www.xavier.edu/residence-life/current/ua.cfm" target="_blank">University Apartments</a> </li>
                </cfif>        
            </ul>
            
            <p>Sincerely,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.housing_info_start) gt 0>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,7,messageStruct,'TRUE')>
        
        <!--- Message 8 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "">
        
        <cfset messageStruct.from = ''>
        <cfset messageStruct.subject = ''>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
      
        <cfsavecontent variable="messageStruct.body">    
        </cfsavecontent>
        <cfset messageStruct.display = FALSE>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,8,messageStruct,'TRUE')>
        
        <!--- Message 9 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Still Deciding?">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Still Deciding?'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
			<p>Do you still have questions about Xavier University?  I realize making that final decision of where to attend college isn't easy, so consider doing the following:</p>
            <p>Visit campus: We'd love to have you as our guest this spring!  Tour campus, meet a professor or even sit in on a class. Register online at <a href="http://www.xavier.edu/visit/" target="_blank">www.xavier.edu/visit</a> or call us toll  free at 877-982-3648 or locally at 513-745-3301.</p>
            <p>Talk with current Xavier students: You can connect with current students in <a href="/profile/matches.cfm">Your Space</a>. Feel free to e-mail them at any time, day or night, with any of your questions.</p>
            
            <p>Ask me: What other information do you need about Xavier to make your final decision? Call or e-mail me and I'm happy to talk through any of your questions with you.</p>
            
            <p>On a final note, all of us in the admission office realize you need to make the best decision for yourself in terms of where to attend college. However, based on what I know about you from your application, I sincerely believe Xavier would be a great match for you.  I hope you'll join the Xavier family.</p>
            <p>I wish you the best,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.still_deciding_start) gt 0 AND not session.studentProcess.isProcessItemComplete(session.bannerid,'deposit')>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,9,messageStruct,'TRUE')>
        
        <!--- Message 10 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Orientation">
        
        <cfset messageStruct.from = 'Molly Dugan'>
        <cfset messageStruct.subject = "Manresa: Xavier's New Student Orientation">
        
        <cfset messageStruct.cameoHeader = 'Student Involvement'>
        <cfset messageStruct.cameoName = 'Molly Dugan'>
        <cfset messageStruct.cameoTitle = 'Assistant Director for Leadership & Orientation'>
        <cfset messageStruct.cameoPhone = '513-745-3754'>
        <cfset messageStruct.cameoEmail = 'duganm@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/administration/duganm.jpg'>
        
		
        <cfsavecontent variable="messageStruct.body">         
            <p>Manresa, Xavier's New Student Orientation, is a four-day program designed especially for you and your fellow new students. Manresa refers to the town in Spain where St. Ignatius Loyola, the founder of the Jesuits, took time to reflect on his past, present and most important, his future. Our orientation program is designed to help you have a similar experience while interacting with new friends and classmates and preparing for your time at Xavier.</p>
            <p>Manresa is an opportunity to meet the people who will help shape the next few years of your life. In addition to fun large group programs like illusionist Craig Karges, you will participate in small-group activities with other new students and experienced upperclass leaders. These four days are filled with a lot of excitement and energy as well as time for personal reflection and growth. Please mark your calendar now for Manresa 2016:</p>
          
          <ul>
          	<li>New Student Move-in Day: Thursday, August 18, 2016</li>
			<li>Manresa: Thursday, August 18 – Sunday, August 21, 2016</li>
			<li>Classes Begin: Monday, August 22, 2016 at 8:00am</li>
         </ul> 
         
      <p> You will receive more information about Manresa throughout the summer via the Road to Xavier as well as in the mail. We hope you make the most of this experience and look forward to seeing you in August! </p>
            
            <p><a href="http://www.xavier.edu/student-involvement/orientation/" target="_new">Find out more about Manresa &raquo;</a></p>
            <p>Sincerely,<br />
            Molly Dugan<br />
            Assistant Director for Leadership & Orientation</p>
            
                    
        </cfsavecontent>
            
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.manresa_info_start) gt 0 and session.studenttype NEQ 'T'>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>        
        
        <cfset structInsert(session.messages,10,messageStruct,'TRUE')>
        
        <!--- Message 11 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Not too late to file FAFSA">
        
        <cfset messageStruct.from = '#getCounselor.name#, #getCounselor.title#'>
        <cfset messageStruct.subject = 'Not too late to file FAFSA'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.Counselorcode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>If you have not already done so, it is not too late to file your 2016-2017 Free Application for Federal Student Aid (FAFSA). You may qualify for  federal, state and/or institutional grants, as well as attractive loan  programs. The FAFSA can be submitted online at&nbsp;<a href="http://www.fafsa.ed.gov/" target="_new">www.fafsa.ed.gov</a>. Be sure to  complete all sections about you and your parent(s). Xavier's school code is 003144.</p>
			<p>Xavier will receive the results of your FAFSA electronically. We will update your  financial aid package and notify you via e-mail and through this site.</p>
			<p>Please contact me if you have any questions about the financial  aid process. You can also view&nbsp;<a href="https://roadto.xavier.edu/moneymatters/index.cfm">your pre-FAFSA  financial aid package</a>.</p>
            <p>Sincerely,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.fafsa_ntl_start) gt 0 AND session.fafsa neq 1 and NOT session.international >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,11,messageStruct,'TRUE')>
        
        <!--- Message 12 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Thanks for Your Deposit">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Thanks for Your Deposit'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>We have received your deposit confirming your intention to enroll at Xavier University for the Fall 2016 semester.  That's great news!  I am pleased you have decided to accept our offer of admission.</p>
    <p>You will be joining a community of students, faculty and staff who are committed to upholding the tradition of Jesuit education for which Xavier is renowned. </p>
    <p><cfoutput>#session.FirstName#</cfoutput>, enjoy the remainder of the school year, and I look forward to welcoming you to campus in August.</p>
            <p>I wish you the best,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif session.studentProcess.isProcessItemComplete(session.bannerid,'deposit')>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,12,messageStruct,'TRUE')>
        
        <!--- Message 13 --->
        
        
        <cfset saName = 'Laura Frazier'>
        <cfset saUsername = 'frazier'>
        
        
        
<!---
        <cfswitch expression="#left(session.lastname,1)#">
        	<cfcase value="A,B,C,D,E,F,G,H,I">
            	<cfset saName = 'Laura Frazier'>
                <cfset saUsername = 'frazier'>
            </cfcase>
            
            <cfcase value="J,K,L,M,N,O,P,Q,R">
            	<cfset saName = 'Molly McDaniel'>
                <cfset saUsername = 'maher'>
            </cfcase>
            
            <cfcase value="S,T,U,V,W,X,Y,Z">
            	<cfset saName = 'Luther Smith'>
                <cfset saUsername = 'smith'>
            </cfcase>
            
            <cfdefaultcase>           
            	<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Student Success Coach Missing" type="html">
                    <cfdump var="#session#" label="session">
                    <cfdump var="#cgi#" label="CGI">
                </cfmail>
            
            	<cfset saName = 'Luther Smith'>
                <cfset saUsername = 'smith'>
            </cfdefaultcase>
        
        </cfswitch>
--->
        
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Your Student Success Coach">
        
        <cfset messageStruct.from = '#saName#'>
        <cfset messageStruct.subject = 'Your Student Success Coach'>
        
        <cfset messageStruct.cameoHeader = 'Student Success and Parent/Family Outreach'>
        <cfset messageStruct.cameoName = '#saName#'>
        <cfset messageStruct.cameoTitle = 'Student Success Coach'>
        <cfset messageStruct.cameoPhone = '513-745-3036'>
        <cfset messageStruct.cameoEmail = '#saUsername#@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/administration/#saUsername#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">   
            <p>Congratulations on your choice to attend Xavier University! As you look forward to the beginning of your Xavier career, know that the Office of Student Success and Parent/Family Outreach is here to serve you. The start of college brings new and exciting experiences, as well as some uncertainties and challenges. This is where our office is here to act as your advocate and support system.</p>
            <p> As your Student Success Coach, I am here to act as your first point of contact when you find you are in need of support. Whether it is academic or social, whether you are falling behind in a class, or find that you are homesick, or you need help with creating a financial plan that works for you. I am here for you. </p>
            <p> Once you arrive on-campus I will reach out to you to see how you are adjusting to life at Xavier. You will hear from me from time to time to be sure your transition to Xavier is a smooth one. In the meantime, if I can help in any way, please reach out to our office at 513-745-3036. </p>
            <p> I look forward to meeting you on campus in a few short weeks!</p>
            
            <p>Sincerely,<br />
            <cfoutput>#saName#</cfoutput></p>   
		  
		  <h3>Some things I can help with. . . </h3>
		  
		  <ol style="margin-left: 0;">
		  
		  	<li>My professor told me to come visit her during ‘office hours’, but I’m not sure what that means and I don’t know what to say to her.</li>
			<li>I talked to my roommate about her loud music, but she still plays it while I’m trying to sleep.</li>
			<li>My parents really want me to study business and I’m afraid to tell them it’s not what I want.</li>
			<li>High school was a breeze for me, but I’m feeling overwhelmed now and am not sure what to do.</li>
			<li> I like my classes, but don’t feel like I’m fitting in socially.</li>
			<li>The guys in my dorm invite me to play video games with them late into the night; I love doing it, but then have trouble sleeping and can’t get up for class.</li>
			<li>My professor doesn’t grade on a curve and I was shocked at how low my first test grade was.</li>
			<li>Organization has never been my thing, and now more than ever I can’t keep track of anything.</li>
			<li>I never thought I’d be homesick, but I am.  I’m embarrassed to tell anyone.</li>
			<li>The credit card I just opened is almost maxed out and I’m shocked at the interest I need to pay.</li>
		  </ol> 
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.success_advisor_start) gt 0>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay =FALSE>

        <cfset structInsert(session.messages,13,messageStruct,'TRUE')>
        
        <!--- Message 14 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Transfer Orientation">
        
        <cfset messageStruct.from = 'Molly Dugan'>
        <cfset messageStruct.subject = "Transfer Orientation">
        
        <cfset messageStruct.cameoHeader = 'Student Involvement'>
        <cfset messageStruct.cameoName = 'Molly Dugan'>
        <cfset messageStruct.cameoTitle = 'Assistant Director for Leadership & Orientation'>
        <cfset messageStruct.cameoPhone = '513-745-3754'>
        <cfset messageStruct.cameoEmail = 'duganm@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/administration/duganm.jpg'>
        
		
        <cfsavecontent variable="messageStruct.body">         
            <p>Welcome to the Xavier family! We are excited that you will be joining us in the fall and hope to make your transition as smooth as possible. All transfer students are required to attend a transfer orientation on <strong>Sunday, August 21, 2016 from 10am-3pm.</strong></p>
            <p>At transfer orientation you will meet current students and new transfer students, become oriented with Xavier&rsquo;s campus, learn about campus services, and much more! Additional information, including the schedule of events, will be emailed to you by mid-July. There is a $55 transfer orientation fee that will be automatically placed on your Bursar bill to accommodate for the cost of the program. Breakfast and lunch will be provided.</p>
            <p>We ask that you confirm your attendance at transfer orientation by registering for the program by August 15, 2016. The link to register is below.</p>
            <p><a href="https://roadto.xavier.edu/manresa/transfer-registration.cfm">&raquo; Register Now</a></p>
            <p>Don&rsquo;t hesitate to contact the Office of Student Involvement with any questions or concerns at <a href="xuinvolvement@xavier.edu">xuinvolvement@xavier.edu</a>. We look forward to seeing you in August!</p>
            <p><a href="http://www.xavier.edu/student-involvement/orientation/Transfer-Student.cfm">&raquo; Click here to find out more about transfer orientation</a></p>
            <p>Sincerely, <br />
              Molly Dugan&nbsp;<br />
              Assistant Director for Leadership &amp; Orientation<br />
              Office of Student Involvement</p>         
        </cfsavecontent>
            
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.manresa_transfer_reg_start) gt 0 and datecompare(now(), Application.manresa_tab_start) gt 0 and session.studenttype EQ 'T'>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE> 

        <cfset structInsert(session.messages,14,messageStruct,'TRUE')>
        
        <!--- Message 15 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Find an On-Campus Job">
        
        <cfset messageStruct.from = 'Vicki Clary'>
        <cfset messageStruct.subject = 'Find an On-Campus Job'>
        
        <cfset messageStruct.cameoHeader = 'Career Development Office'>
        <cfset messageStruct.cameoName = 'Vicki Clary'>
        <cfset messageStruct.cameoTitle = 'Student Employment Coordinator'>
        <cfset messageStruct.cameoPhone = '513-745-4880'>
        <cfset messageStruct.cameoEmail = 'claryv@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/administration/claryv.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p> Still looking for an On-Campus Job? Attend the upcoming On-Campus Student Employment Fair to be held on Monday, August 22, 3:00 - 5:00 at the Xavier Cintas Center. You will attend this Fair in person and should be prepared to interview with department supervisors. </p>
            <p> » <a href="http://www.xavier.edu/career/students/Employment-Fair.cfm" target="_blank">Learn more about the on-campus fair</a> including
            <ul>
              <li> Preparing for the Fair </li>
              <li> Quick Tips </li>
              <li> What to bring with you to the Fair </li>
              <li> View a list of employers participating and positions available </li>
            </ul>
            </p>

			<p>For additional information or questions, contact me directly or the Career Development Office at 513-745-3141 or email <a href="mailto:cdo@xavier.edu">cdo@xavier.edu</a>.</p>
			<p>Sincerely,<br />
            Vicki Clary</p>
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif (datecompare(now(), Application.university_employment_start) gt 0) AND hasFWS >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,15,messageStruct,'TRUE')>
        
        <!--- Message 16 --->
        
        <!--- depending on which list they are in, they see a different message --->
        
        <cfif listFind(application.CEFNon, session.BannerID)>
			<cfset messageStruct = structNew()>
			<cfset messageStruct.title = "Community-Engaged Scholarship Status Update">
            
            <cfset messageStruct.from = 'Sean Rhiney, Director, Eigel Center for Community-Engaged Learning'>
            <cfset messageStruct.subject = "Community-Engaged Scholarship Status Update">
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            <p>Thank you for participating in Xavier’s Community Engaged Fellowship competition.  It was a pleasure having you with us, and we hope that you enjoyed the visit as much as we did. </p>
			<p>Each year we interview many outstanding students for our scholarships and this year was no exception.  While your resume of activities and involvement was impressive, you were not chosen to receive the Community Engaged Fellowship.  However, your commitment to service is apparent, and I hope that you will join us on campus this fall and become involved in the many community-based opportunities that we offer.</p>
			<p>I offer my personal congratulations on your outstanding achievements.</p>

            <p>Sincerely,<br>
            Sean Rhiney<br>
			Director<br>
			Eigel Center for Community-Engaged Learning</p>
    
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            
			<cfset messageStruct.display = TRUE>
            
            <cfset messageStruct.mobileDisplay = TRUE>
        
            <cfset structInsert(session.messages,16,messageStruct,'TRUE')>              
        <cfelse>
			<cfset messageStruct = structNew()>
            <cfset messageStruct.title = "">
            
            <cfset messageStruct.from = ''>
            <cfset messageStruct.subject = ''>
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            <cfset messageStruct.mobileDisplay = TRUE>
    
            <cfset structInsert(session.messages,16,messageStruct,'TRUE')>
        </cfif>
        
        <!--- Message 17 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Manresa 2016">
        
        <cfset messageStruct.from = 'Manresa Core'>
        <cfset messageStruct.subject = 'Manresa 2016'>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
            <cfquery name="GetGroup" datasource="#application.RoadToDB#">
            select *
            from manresaAssignments join ManresaLeaders on GroupID = GroupNumber
            where bannerid = <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
            </cfquery>
            
            <cfif getGroup.recordCount GT 0>
                <div class="featured-person" style="float: right; width:250px; padding-left: 1.5em;">
                    <H4>Your Small Group Leaders</H4>
                    <img src="https://roadto.xavier.edu/images/manresa/2016/group-<cfif getGroup.groupID LT 10>0</cfif>#getGroup.GroupID#.jpg"  class="imageleft-border" width="240"><br />
                    <h6>#getGroup.leader1# & #getGroup.leader2#</h6>
                </div>           
            </cfif>
            
            <p><cfif session.studentType EQ 'T'><cfelse>Hey, Class of 2020!!!</cfif> Guess what is right around the corner. . . <a href='/manresa/'>MANRESA 2016!</a> That's right, you are about to start life at your new home with our New Student Orientation. Manresa Core has been planning this week since January and we can't wait to welcome you home! We have placed you in your small group and assigned you two upper-class group leaders.</p>
			<p> So, time to get excited!! We present to you, your fabulous group leaders (hint: they are the two people in the picture). To see the rest of the awesome students in your small group check out the <cfif cgi.http_host Eq 'roadto.xavier.edu'><a href="https://roadto.xavier.edu/profile/matches.cfm" target="_blank" ><cfelse><a href="https://r2.xavier.edu/profile/matches.cfm" > </cfif> Your People</a> page of your profile. We hope this information makes you even more excited about making Xavier your new home. Enjoy the rest of your summer and get ready to have the best week of your life!! </p>
            
            <p>Manresa Core, 2016<br />
            <a href="mailto:Manresa@xavier.edu">Manresa@xavier.edu</a><br />
            513-745-3662</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif (datecompare(now(), Application.manresa_groups_start) gt 0) AND checkManresa.recordcount GT 0 >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,17,messageStruct,'TRUE')>
        
        <!--- Message 18 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Receptions for admitted students">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Receptions for admitted students'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>We will be hosting receptions in selected cities around the country for admitted students and their families. It's a great opportunity to meet other admitted students from your hometown who are considering Xavier, and learn more about what comes next for you. Whether you are "headed to Xavier" or "still in decision mode," we hope you can join us as we discuss submitting your deposit, choosing housing on campus, the Manresa Orientation Program, and more.</p>
            
            <p><a href="https://roadto.xavier.edu/visit/receptions.cfm">See if Xavier is coming to a town near you!</a></p>
            <p>I wish you the best,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.spring_rec_start) gt 0 AND datecompare(now(), Application.spring_rec_end) lt 0>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,18,messageStruct,'TRUE')>
        
        <!--- Message 19 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Smooth Transitions">
        
        <cfset messageStruct.from = 'Center for Diversity & Inclusion '>
        <cfset messageStruct.subject = 'Smooth Transitions'>
        
        <cfset messageStruct.cameoHeader = 'Center for Diversity & Inclusion '>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = '513-745-3181'>
        <cfset messageStruct.cameoEmail = 'smoothtransitions@xavier.edu'>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">

 
        <p>
        Congratulations and welcome to Xavier University! We are excited to have you as a part of our community. The Center for Diversity & Inclusion invites you to participate in the 2015 Smooth Transitions Program scheduled for <strong>Monday, August 17</strong> - <strong>Wednesday, August 19, 2015</strong>. The program is also a precursor to Manresa. 
        </p>
<p>        
<strong>Smooth Transitions, is an optional pre-orientation and year-long mentoring program,</strong> that is designed to help you become acclimated to Xavier while giving you a jumpstart on the high expectations of this community. While college is challenging for all new students, the program acknowledges that SOME students who are the first in their families to attend college (regardless of racial identity) and SOME students of color (i.e. African Americans, Hispanic/Latino Americans, Asian Americans, & Native Americans) might need additional support to navigate Xavier, and develop into scholars. </p>

<p>Students who are accepted into the program will:</p>

<ul>
<li>	Be more likely to maintain a good GPA through developing a strong work ethic that turns failure into a strength by creating a desire to persist</li>
<li>	Develop positive friendships and peer support groups</li>
<li>	Better understand the costs of college and where to find scholarships or internships</li>
<li>	Identify valuable campus resources (i.e. Psych Services, TRiO, Center for Career Development, Writing Center)</li>
<li>	Make meaningful connections with students, faculty, staff, alumni and Cincinnati community leaders</li>
<li>	Appreciate other people’s cultures and life experiences</li>
</ul>

<p>
During the year-long mentoring program of Smooth Transitions, students will be mentored by a peer (i.e. sophomore, junior or senior), faculty/staff and/or alum. These mentors will help hold you accountable, and ensure that you are aware of monthly workshops and activities that address team-building, leadership development and community service. 
There are only 60 spaces available for Smooth Transitions! This is a competitive, yet FREE college readiness program. Your application must be submitted by Wednesday, July 1, 2015 for full consideration. You will be sent an email by July 20, 2015 to confirm your acceptance into the program. » Register Now
        </p>


            
            <p><a href="https://roadto.xavier.edu/smooth-transitions/index.cfm">&raquo; Register Now</a></p>
            <p>Sincerely, <br />
            Sincerely, 
			Taj Smith, Director<br />
			Center for Diversity & Inclusion 
        </p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), application.st_start) ge 0 and (session.ethnicityID EQ '1' or session.ethnicityID EQ '2' or session.ethnicityID EQ '3' or session.ethnicityID EQ '4' or session.ethnicityID EQ '8') and session.studentProcess.isProcessItemComplete(session.bannerid,'deposit') and session.studentType NEQ 'T' and NOT session.international >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,19,messageStruct,'TRUE')>
        
        <!--- Message 20 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Music Ensemble Auditions">
        
        <cfset messageStruct.from = 'Dr. Tom Merrill'>
        <cfset messageStruct.subject = 'Music Ensemble Auditions'>
        
        <cfset messageStruct.cameoHeader = 'Music Department'>
        <cfset messageStruct.cameoName = 'Dr. Tom Merrill'>
        <cfset messageStruct.cameoTitle = 'Chair'>
        <cfset messageStruct.cameoPhone = '513-745-3135'>
        <cfset messageStruct.cameoEmail = 'merrillt@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/faculty/merrillt.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p> Congratulations on your decision to attend Xavier University. The faculty in the Department of Music and Theatre would like for you to know that we welcome all students, regardless of their major, into our ensembles and shows. If you are interested in auditioning for an ensemble, we will hold auditions during the first week of classes. If you are interested in auditioning for one of our theatre shows, audition information will be posted several months prior to the beginning of each show. Please watch your Xavier email for an announcement about audition location and times. </p>
            <p> Music Department ensembles are: </p>
            <ul>
              <li> Chamber Orchestra </li>
              <li> Concert Choir </li>
              <li> Gospel Choir</li>
              <li> Jazz Band </li>
              <li> Men's Chorus </li>
              <li> Pep Band </li>
              <li> Symphonic Wind Ensemble </li>
              <li> Women's Chorus </li>
            </ul>
            <p> For the audition, singers should have one song prepared, and be ready to sight-read. Instrumentalists should have one piece prepared and be ready to play some basic scales and sightread. Please visit our department website <a href="http://www.xavier.edu/music-and-theatre/" target="_blank">http://www.xavier.edu/music-and-theatre/</a> for further information. </p>
            <p> On behalf of the Department of Music and Theater, I would like to wish you every success as you begin your undergraduate study. Please do not hesitate to contact me if you require further information. </p>
            <p> Sincerely, <br/>
              Dr. Tom Merrill <br/>
              Chair of the Music Department<br>
              <a href="mailto:merrillt@xavier.edu">merrillt@xavier.edu</a> </p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.ensemble_start) gt 0 AND session.studentProcess.isProcessItemComplete(session.bannerid,'deposit') and session.studentType NEQ 'T' >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,20,messageStruct,'TRUE')>
        
        <!--- Message 21 --->
        <!--- depending on which list they are in, they see a different message --->
        
        <cfif listFind(application.SFXNon, session.BannerID) or session.bannerid EQ '000300001'>
			<cfset messageStruct = structNew()>
			<cfset messageStruct.title = "St. Francis Xavier Scholarship Competition">
            
            <cfset messageStruct.from = 'Dr. Marco Fatuzzo and Lauren Cobble'>
            <cfset messageStruct.subject = "St. Francis Xavier Scholarship Competition">
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">


<p>Thank you for participating in Xavier’s St. Francis Xavier Scholarship competition. It was a pleasure having you with us, and we hope you enjoyed your visit.</p>

<p>Each year, many outstanding students compete for our scholarship and this year was no exception. Unfortunately you have not been selected as a recipient of the St. Francis Xavier Scholarship. However, your outstanding academic record is very impressive and we hope that you will see Xavier as a great choice for you to spend the next four years of your life. We believe Xavier to be the most valuable educational investment, offering the highest quality, and well-rounded educational experience to be well worth it.</p>

<p>You too have much to offer and we are certain that you will bring your many talents to develop and share during your time as a Xavier student. We hope that we will be able to welcome you as a member of the Xavier family this fall. We sincerely appreciate your interest in Xavier University and wish you the best as you complete your senior year.</p>
		
            <p>Sincerely,<br>
			Dr. Marco Fatuzzo and Lauren Cobble <br />
    		</p>
    
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            
			<cfset messageStruct.display = TRUE>
            
            <cfset messageStruct.mobileDisplay = TRUE>
        
            <cfset structInsert(session.messages,21,messageStruct,'TRUE')>              
        <cfelse>
			<cfset messageStruct = structNew()>
            <cfset messageStruct.title = "">
            
            <cfset messageStruct.from = ''>
            <cfset messageStruct.subject = ''>
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            <cfset messageStruct.mobileDisplay = TRUE>
    
            <cfset structInsert(session.messages,21,messageStruct,'TRUE')>
        </cfif>
        
        <!--- Message 22 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Housing Selection">
        
        <cfset messageStruct.from = 'Lori Lambert, Senior Director for Student Affairs'>
        <cfset messageStruct.subject = 'Housing Selection'>
        
        <cfset messageStruct.cameoHeader = 'Residence Life'>
        <cfset messageStruct.cameoName = 'Lori Lambert'>
        <cfset messageStruct.cameoTitle = 'Senior Director for Student Affairs'>
        <cfset messageStruct.cameoPhone = '513-745-3203'>
        <cfset messageStruct.cameoEmail = 'lambert@xavier.edu'>
        <cfset messageStruct.cameoPicture = ''>
        
        
        <cfsavecontent variable="messageStruct.body">
			<p>Thanks for your patience as we have been working hard to prepare the Housing Selection Process for you. The final information that you need is now available via the <a href="/housing/">housing section</a> of the Road to Xavier.</p>	
			<p>If you encounter problems during the process, please make sure you are following the instructions.  If something is still not working, please call 513-745-3203 or email <a href="mailto:protherok@xavier.edu">Kevin Prothero</a> or <a href="mailto:lambert@xavier.edu">me</a>.  We will do our best to assist you in a timely manner.</p> 
			<p>We hope you find the housing selection system to be easy to use and we hope you each get your preferred housing option!</p>
			<p>Sincerely,<br>
			Lori</p>      
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif (datecompare(now(),Application.housing_room_selection_info_start) gt 0) AND session.housingdeposit eq 1 and session.studentType NEQ 'T' >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,22,messageStruct,'TRUE')>
        
        <!--- Message 23 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.from = 'Dr. Marco Fatuzzo and Lauren Cobble<br>Co-chairs of the Scholarship Committee'>
        <cfset messageStruct.subject = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
        <p>The Xavier University Scholarship Committee has completed its review of the applicants for the 2016 Competitive Scholarships. The committee was very pleased with the high caliber of our applicants.</p>
        
    <p>The Scholarship Committee invites you to participate in the St. Francis Xavier Scholarship Competition. Your outstanding academic record is very impressive. The Saint Francis Xavier Scholarship <strong>covers full tuition for four years</strong>, and supersedes any other Xavier scholarship(s) you have previously been offered.</p>
    
    <p>The competition is scheduled for Saturday, March 19, 2016.
     <strong>Please RSVP and tell us the number guests by Tuesday, March 8, 2016.</strong></p>
      
	 <div align="center">
       <a class="button small radius" style="text-transform: uppercase; font-weight: bold;" href="https://admissions.xavier.edu/register/?id=fb187ee2-a64a-442e-bbcb-c3abeec91ed7" target="_blank"
	       onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X-Inbox','eventAction' : 'Scholarship RSVP', 'eventLabel' : '#session.BannerID#' });"
		       
			       >
	      RSVP for the 2016 Scholarship Competition</a>
	 </div>
       
       <p><strong>More details will be provided in your confirmation email.</strong></p>
      
      
    <p>We have much to offer you. We are confident that you will bring your many talents to share and develop during your time as a Xavier student. We sincerely appreciate your interest in Xavier University, and wish you the best as you complete your senior year.</p>
    <p>Sincerely,<br>
    Dr. Marco Fatuzzo and Lauren Cobble <br />
    Co-chairs of the Scholarship Committee</p>

        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif datecompare(now(),Application.schol_invite_start) gt 0 and datecompare(now(),Application.schol_invite_end) lt 0 and listFind(application.scholGenInvite, session.BannerID)>
        	<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,23,messageStruct,'TRUE')>
        
        <!--- Message 24 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.from = 'Dr. Marco Fatuzzo and Lauren Cobble<br>Co-chairs of the Scholarship Committee'>
        <cfset messageStruct.subject = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
        <p>The Xavier University Scholarship Committee has completed its review of the applicants for the 2016 St. Francis Xavier Scholarship. The committee was very pleased with the high caliber of our applicants.</p>
        <p>Unfortunately the Scholarship Committee did not select you as a candidate to compete for the St. Francis Xavier Scholarship. There were many highly qualified students who applied this year.  We hope that Xavier remains a strong college option for you.</p>
        <p>We have much to offer you. We are also confident that you will bring your many talents to share and develop if you choose to enroll as a Xavier student. We sincerely appreciate your interest in Xavier University, and wish you the best as you complete your senior year.</p>
        <p>Sincerely,<br />
        Dr. Marco Fatuzzo and Lauren Cobble<br />
        Co-chairs of the Scholarship Committee</p>

        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif datecompare(now(),Application.schol_invite_start) gt 0 and datecompare(now(),Application.schol_invite_end) lt 0 and listFind(application.scholGenNonInvite, session.BannerID)>
        	<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,24,messageStruct,'TRUE')>
        
        <!--- Message 25 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.from = 'Lauren Cobble<br>Dean of Undergraduate Admission'>
        <cfset messageStruct.subject = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
        <p>The review of applications for the Francis X. Weninger/Miguel Pro Scholarship is now complete. We were very pleased with the high caliber of our applicants.</p>
	<p>You have been selected as a recipient of a Francis X. Weninger/Miguel Pro Scholarship. Your academic record and talents make you a worthy recipient of this award. This scholarship is valued at $3,000 per year, and will be honored for up to eight consecutive semesters of undergraduate studies provided you maintain full-time status and a minimum cumulative grade point average of 2.5. This amount will be added to any scholarships or awards you were previously offered. It is applicable to tuition costs for the fall and spring semesters only. Visit the Money Matters tab of your Road to Xavier account to view this as a part of your financial aid package. Congratulations on your accomplishments that have led to this honor.</p>
	<p>We have much to offer you and I am certain that you will bring your many talents to develop and share during your time as a Xavier student. We sincerely appreciate your interest in Xavier University, and wish you the best as you complete your senior year.</p>
	<p>Sincerely,<br />
Lauren Cobble <br />
Dean of Undergraduate Admission</p>

        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif datecompare(now(),Application.schol_invite_start) gt 0 and datecompare(now(),Application.schol_invite_end) lt 0 and listFind(application.scholWenWinners, session.BannerID)>
        	<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,25,messageStruct,'TRUE')>
        
        <!--- Message 26 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Manresa: Early Move-In Registration">
        
        <cfset messageStruct.from = 'Molly Dugan'>
        <cfset messageStruct.subject = 'Manresa: Early Move-In Registration'>
        
        <cfset messageStruct.cameoHeader = 'Student Involvement'>
        <cfset messageStruct.cameoName = 'Molly Dugan'>
        <cfset messageStruct.cameoTitle = 'Assistant Director for Leadership & Orientation'>
        <cfset messageStruct.cameoPhone = '513-745-3754'>
        <cfset messageStruct.cameoEmail = 'duganm@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/administration/duganm.jpg'>        
        
        <cfsavecontent variable="messageStruct.body">
        
        
        <p>
	        We have a special opportunity for the Class of 2020!! On Wednesday, August 17, 2016, we will have an <a href="https://roadto.xavier.edu/manresa/early-move-in/">online only</a> early move-in option available .  <a href="https://roadto.xavier.edu/manresa/early-move-in/">Sign up now</a> because this is available on a first come, first serve basis <strong>for the first 250 students</strong> and space is limited by hall. For students who register to move in early, volunteers will be available to assist with move in from 6:00 pm - 8:00 pm Wednesday evening.</p>
	        <p>
Early Move-In Registration is due by <strong>Friday, August 5, but remember space is limited</strong> to the first 250 students and sign-ups will close when space is full. Once registered, please look for the confirmation email with instructions. We look forward to seeing you in August and if you have any questions, please contact the Office of Student Involvement at 513-745-3662
	        
        </p>
        
        
<!---
            <p>We have a special opportunity for new students of the Class of 2020!! On Wednesday, August 17, 2016, we will have an early move-in option available by registration only. <a href="https://roadto.xavier.edu/manresa/early-move-in/">Sign up now</a> because this is available on a first come, first serve basis for the first 250 students to register, though space is limited by hall. For students who register to move in early, volunteers will be available to assist with move in from 6:00 pm - 8:00 pm Wednesday evening.  </p>
<p>Early Move-In Registration is due by Friday, August 7th, but remember space is limited to the first 250 students. Please look for the Confirmation Response and Instructions in your email. We look forward to seeing you in August and if you have any questions, please contact the Office of Student Involvement at 513-745-3662 or the Office of Residence Life at 513-745-3203.</p>
--->
           
           
            <p><a href="https://roadto.xavier.edu/manresa/early-move-in/">Register Now &raquo;</a></p>
            <p>Sincerely,<br />
              Molly Dugan<br />
              Assistant Director for Leadership & Orientation</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif datecompare(now(), Application.emi_start) gt 0 and session.housingdeposit eq 1 and session.studentType NEQ 'T' >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,26,messageStruct,'TRUE')>
        
        <!--- Message 27 --->
        <!--- depending on which list they are in, they see a different message --->
        
        <cfif listFind(application.scholChanWinners, session.BannerID)>
			<cfset messageStruct = structNew()>
			<cfset messageStruct.title = "St. Francis Xavier Scholarship Competition">
            
            <cfset messageStruct.from = 'Dr. Tamara Giluk and Lauren Cobble<br>Co-chairs of the Scholarship Committee'>
            <cfset messageStruct.subject = "St. Francis Xavier Scholarship Competition">
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            <p>Thank you for participating in Xavier’s Scholarship Competition Day recently. It was a pleasure having you with us, and we hope that you enjoyed the visit as much as we did.</p>
			<p> The Xavier University Scholarship Committee was extremely impressed with the group of candidates who interviewed with us this year, and although you were not awarded a St. Francis Xavier Scholarship, we congratulate you on your selection as a Chancellor Scholar.</p>
			<p> Named in honor of Xavier’s late Chancellor, James E. Hoff, S.J., the Chancellor Scholarship will be worth $22,000 for the academic year or $11,000 per semester. It will be honored at the same amount for eight consecutive undergraduate semesters beginning in the fall of 2015, provided you maintain full-time status and a minimum cumulative grade point average of 3.00. It is applicable to the cost of tuition during the fall and spring semesters only. This award replaces the merit-based scholarship you were awarded previously.</p>
            <p> If you have any questions, please feel free to contact Christine Sisson at 513 745-2989 or email <a href="mailto:sisson@xavier.edu">sisson@xavier.edu</a>.</p>
			<p> We offer our  congratulations on your outstanding achievements, and look forward to hearing from you soon.</p>


            <p>Sincerely,<br>
    		Dr. Tamara Giluk and Lauren Cobble <br />
    		Co-chairs of the Scholarship Committee</p>
    
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            
			<cfset messageStruct.display = TRUE>
            
            <cfset messageStruct.mobileDisplay = TRUE>
        
            <cfset structInsert(session.messages,27,messageStruct,'TRUE')>              
        <cfelse>
			<cfset messageStruct = structNew()>
            <cfset messageStruct.title = "">
            
            <cfset messageStruct.from = ''>
            <cfset messageStruct.subject = ''>
            
            <cfset messageStruct.cameoHeader = ''>
            <cfset messageStruct.cameoName = ''>
            <cfset messageStruct.cameoTitle = ''>
            <cfset messageStruct.cameoPhone = ''>
            <cfset messageStruct.cameoEmail = ''>
            <cfset messageStruct.cameoPicture = ''>
            
            <cfsavecontent variable="messageStruct.body">
            </cfsavecontent>
            <cfset messageStruct.display = FALSE>
            <cfset messageStruct.mobileDisplay = TRUE>
    
            <cfset structInsert(session.messages,27,messageStruct,'TRUE')>
        </cfif>
        
        <!--- Message 28 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Xavier Preview Day">
        
        <cfset messageStruct.from = 'Lauren Cobble, Dean of Admission and Financial Aid'>
        <cfset messageStruct.subject = 'Xavier Preview Day'>
        
        <cfset messageStruct.cameoHeader = 'Undergraduate Admission'>
        <cfset messageStruct.cameoName = 'Lauren Cobble'>
        <cfset messageStruct.cameoTitle = 'Dean of Admission and Financial Aid'>
        <cfset messageStruct.cameoPhone = '513-745-3301'>
        <cfset messageStruct.cameoEmail = 'cobblel@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/counselors/ulc.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>As an admitted student, we invite you and your parents to join us at Xavier Preview Day on <strong>Sunday, March 20</strong> or <strong>Sunday, April 10</strong>. The day is designed to help you get a feel for what it would be like to be a student on our campus. You will have the chance to meet and interact with faculty members in your area of interest. You will spend the day experiencing life as a Xavier student and have the chance to meet current Xavier students and other future Muskie classmates. 
            </p>
            
            <p><a href="https://roadto.xavier.edu/visit/" target="_blank">&raquo; Learn more on the Visit tab</a></p>
            
            <p>Lauren Cobble<br />
              Dean, Undergraduate Admission</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif datecompare(now(), Application.preview_start) gt 0 and datecompare(now(), Application.preview_stop) le 0>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,28,messageStruct,'TRUE')>
        
        <!--- Message 29 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Destination X">
        
        <cfset messageStruct.from = 'Lauren Cobble, Dean of Admission and Financial Aid'>
        <cfset messageStruct.subject = 'Destination X'>
        
        <cfset messageStruct.cameoHeader = 'Undergraduate Admission'>
        <cfset messageStruct.cameoName = 'Lauren Cobble'>
        <cfset messageStruct.cameoTitle = 'Dean of Admission and Financial Aid'>
        <cfset messageStruct.cameoPhone = '513-745-3301'>
        <cfset messageStruct.cameoEmail = 'cobblel@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/counselors/ulc.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p> Interested in experiencing what life would be like as a student on Xavier's campus? Sign up to attend Destination X, an overnight experience for diverse students. Destination X is a great opportunity for you to mingle with the University's community, and get a first-hand look at Xavier's social scene. You'll eat dinner on campus, meet other current and prospective Xavier students and spend the night on campus in one of the residence halls.</p>
            <p>This year we are offering two Destination X dates, held on Sunday, March 29th and Sunday, April 19th. Both start at 5:00 p.m. after Xavier Preview Day and will end on Monday morning after you and your parents join us for breakfast in the Hoff Dining Commons. Space is limited, so reserve your spot and register now for <a href="https://roadto.xavier.edu/visit/" target="_blank">register  now for Destination X</a>.</p>
            <p>We look forward  to seeing you!</p>
            
            <p>Lauren<br />
              Dean, Undergraduate Admission</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif 1 eq 2 and datecompare(now(), Application.preview_start) gt 0 and datecompare(now(), Application.preview_stop) le 0 and 
			(session.ethnicityID EQ 1 OR session.ethnicityID EQ 2 OR session.ethnicityID EQ 3 OR session.ethnicityID EQ 4) and (session.studentType NEQ 'T')>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,29,messageStruct,'TRUE')>
        
        <!--- Message 30 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.from = 'Lauren Cobble<br>Dean of Undergraduate Admission'>
        <cfset messageStruct.subject = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
		<p>The review of applications for the Francis X. Weninger/Miguel Pro Scholarship is now complete. We were very pleased with the high caliber of our applicants. </p>
		<p>Unfortunately you have not been selected this year as a recipient of the Francis X. Weninger/Miguel Pro Scholarship. There were many highly qualified students who applied this year.  We hope that Xavier remains a strong college option for you.</p>
		<p>We have much to offer you. We are also confident that you will bring your many talents to share and develop if you choose to enroll as a Xavier student. Xavier would not be the same without you and we wish you the best as you complete your senior year. </p>
		<p>Sincerely,<br />
  		Lauren Cobble <br />
  		Dean of Undergraduate Admission</p>
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
        <cfif datecompare(now(),Application.schol_invite_start) gt 0 and datecompare(now(),Application.schol_invite_end) lt 0 and listFind(application.scholWenNonWinners, session.BannerID)>
        	<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,30,messageStruct,'TRUE')>
        
        <!--- Message 31 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Common Reading Program Reminder">
        
        <cfset messageStruct.from = 'Dr. David Mengel, Assistant Dean, College of Arts &amp; Sciences<br />
              Alison Morgan, Assistant Director of Access Services, University Library'>
        <cfset messageStruct.subject = 'Common Reading Program Reminder'>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = '/images/common-reading/cover.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>We hope you are having  a wonderful summer. We would like to remind you that the due date for your  Common Reading Experience essay was August 1st. Please read <em>Tattoos on the Heart</em> and respond in  writing to one of three essay questions. The reading and essay will help prepare  you for small group discussions that are scheduled to take place during Manresa.</p>
            
            <p>We strongly encourage  you to use the common reading experience to begin an integrated and fulfilling  learning experience at Xavier. You can find more information at the <a href="https://roadto.xavier.edu/common-reading/">Common Reading  Program website</a> including the writing project and due date. Let us  know if we can be of assistance to you.</p>
            
            <p>Best Wishes,<br />
              Dr. David Mengel, Assistant Dean, College of Arts &amp; Sciences<br />
              Alison Morgan, Assistant Director of Access Services, University Library<br />
              Co-Chairs of the Common Reading Experience Program</p>
            
            <p><a href="https://roadto.xavier.edu/common-reading/">&raquo; Visit the Common Reading Program web site now</a></p>       
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		

<!---
		<cfif not session.studentProcess.isProcessItemComplete(session.bannerid,'crUploaded') and datecompare(now(), Application.common_reading_reminder_start) gt 0 and session.dateCreated lt dateAdd('d','-3',now())  and session.studentType NEQ 'T' >
			<cfset messageStruct.display = TRUE>
		</cfif>
--->

		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,31,messageStruct,'TRUE')>
        
        <!--- Message 32 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Your Student ID">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Your Student ID'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>With only a few short weeks left until Manresa begins, we hope that you are excited and ready to come to Xavier!</p>
            <p>Your Xavier Student ID is a 9 digit number that will be physically located on your ALL Card, which will be available at Manresa. You’ll need your Student ID for several things on campus – from creating your Xavier account to registering for your courses. For your convenience, we are including your Student ID below in case you may need it throughout the rest of the summer.</p>
            <p><b>Your Xavier Student ID is <cfoutput>#session.bannerid#</cfoutput>.</b></p>
            <p>Should you have any questions about your next steps, please contact me!</p>
            
            <p>Best wishes,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
        <cfset messageStruct.display = FALSE>
        <cfif (datecompare(now(),Application.student_id_start) gt 0) AND session.studentProcess.isProcessItemComplete(session.bannerid,'deposit')>
			<cfset messageStruct.display = TRUE>
        </cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,32,messageStruct,'TRUE')>
        
        <!--- Message 33 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Get to Know Other XU Students">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Get to Know Other XU Students'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <cfquery name="getAmbassador" datasource="#application.RoadToDB#">
            SELECT *
            from bannerstudent 
            join ambassadorsia on bannerstudent.bannerid = ambassadorsia.bannerid
            where ambassador = 'Y'
              and studentType = 'T'
            order by lastname, firstname
            </cfquery>
            
            <p>As you're considering transferring schools, there are often a lot of questions running through your mind.  We know that sometimes it helps to ask questions of someone who's been in your shoes and as you're working to finalize your plans for the fall, I encourage you to get to know some current Xavier students that were once in your position as they were considering a transfer to Xavier.</p>
            
            <p>When you log on to the Road to Xavier, the homepage features a space for you to connect with Current Xavier Students.  All of these students have successfully transferred to Xavier and have settled into their life as a member of the Xavier community.  These students are available to answer any questions you may have about transferring to Xavier, transitioning to the Xavier community, student life and more.  I encourage you to get to know them now and start building connections that will help you as you transition to the Xavier community later this year.</p> 
            
            <h2>Current Students</h2>
            <table id="ambTable">
            <tr>
            <cfset counter = 0>
            <cfloop query="getAmbassador">
                <td><a href="/profile/index.cfm?id=#encryptID(getambassador.bannerid)#"><img src="/images/ambassadors/#getAmbassador.username#.jpg" /></a></td>
                <td><h3>#getAmbassador.FirstName# #getAmbassador.LastName#</h3><br />
                <a href="/profile/index.cfm?id=#encryptID(getambassador.bannerid)#">View full profile &raquo;</a></td>
                
                <cfset counter += 1>
                
                <cfif counter mod 2 eq 0>
                </tr><tr>
                </tr></cfif>
            </cfloop> 
            
            </table>
            <p>#trim(session.FirstName)#, I wish you the best of luck as you finalize your plans for the fall.  If you have any questions, or if there is anything else I can do to help, please call or email me.
            </p>
            
            <p>Best wishes,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif session.studentType EQ 'T' >
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,33,messageStruct,'TRUE')>
        
        <!--- Message 34 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Your Xavier eBill">
        
        <cfset messageStruct.from = 'Henry Saas'>
        <cfset messageStruct.subject = 'Your Xavier eBill'>
        
        <cfset messageStruct.cameoHeader = 'Office of the Bursar'>
        <cfset messageStruct.cameoName = 'Henry Saas'>
        <cfset messageStruct.cameoTitle = 'Bursar'>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = 'xubursar@xavier.edu'>
        <cfset messageStruct.cameoPicture = '/images/administration/saas.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p> As of July 15th, your fall semester eBill is ready for you to view and pay. <strong>The first payment due date is Saturday, August 1, 2016.</strong> You can
              access and pay your bill via the 'Pay Bill' link on the <a href="http://www.xavier.edu/students/">Student Hub</a>. </p>
              
              
            <p> 1. <strong>Access Your eBill:</strong> Once you are logged into ‘Pay Bill’, you will be redirected to Xavier's ePayment site where you can access your eBill, make online payments, enroll and review payment plans and have the ability to add Authorized Users.</p>
              
            <p> 2. <strong>Enroll in the X-Flex Payment Plan: </strong>Students who plan to pay their bill in monthly installments are required to enroll in a payment
              plan for each semester they want to pay in installments. There is a $50.00 enrollment fee each semester that is due upon enrollment. By doing so, you will see when the payments are due and your monthly
              installment amount. If it is your intention to pay your balance in full, then pay your balance (if a balance exists) in full each month on or before the
              Due Date of the 1<sup>st</sup> of every month. Keep in mind that miscellaneous charges can post to your account throughout the semester i.e. library fine, parking fine, etc., so be sure to review your eBill every month.</p>
              
              
            <p> 3. <strong>Add Authorized Users:</strong> You may add a parent, guardian or anyone else as an Authorized User on your bursar account. You can do this on the ePayment site. Instructions on how to get to the site are listed in ##1 above: Access Your eBill.</p>
            
            
            <p> For more information about your eBill account, instructions on setting up a payment plan and adding authorized users, and other helpful hints, visit the <a href="http://www.xavier.edu/bursar/for-new-students.cfm">New Student page</a> on the Bursar’s website, <a href="https://xavier.zoom.us/webinar/register/96205d5e83b610bb66858a512be5123a" target="_blank" onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X-MuskieChat','eventAction' : 'InboxClick', 'eventLabel' : 'Muskie-Chat-July-12-2016' });"> or join us for a Muskie Chat July 12.</a> </p>
            <p> If have questions about your eBill statement, your student account, or payment plan options, please contact the Office of the Bursar at <a href="mailto:xubursar@xavier.edu">xubursar@xavier.edu</a> or by calling 513-745-3435. Our hours are Monday - Friday, 8:30am-5:00pm. </p>
            
            
            <p>Best wishes, <br/>
              Henry Saas <br/>
              Bursar </p>  
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif (datecompare(now(),Application.ebill_start) gt 0) AND session.studentProcess.isProcessItemComplete(session.bannerid,'deposit')>
			<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,34,messageStruct,'TRUE')>
        
        <!--- Message 35 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Summer Send Offs">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Summer Send Offs'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body">
            <p>Getting excited about meeting your classmates? Well, you could have the chance to put a face to the names you see on Facebook and Road to Xavier, before you step foot on campus. Xavier parents and alumni across the country are hosting Summer Send Offs as a way to say "Congratulations, Good Luck and Welcome to the Xavier Family!" Send Offs are being hosted around the country so be sure to check for one near you. </p>
            
            <p><a href="https://admissions.xavier.edu/portal/summer_send_offs" target="_blank">&raquo; See if Xavier is coming to a town near you!</a></p> 
            
            <p>Best wishes,<br />
            #getCounselor.name#</p>        
        </cfsavecontent>
		<cfset messageStruct.display = FALSE>
		<cfif (datecompare(now(),Application.sendoff_start) gt 0) and session.studentProcess.isProcessItemComplete(session.bannerid,'deposit') >
			<cfset messageStruct.display = TRUE>
		</cfif>
        
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,35,messageStruct,'TRUE')>
        
        <!--- Message 36 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Your First Semester Schedule">
        
        <cfset messageStruct.from = 'Kim Powers Hoyt'>
        <cfset messageStruct.subject = "Your First Semester Schedule">
        
        <cfset messageStruct.cameoHeader = 'Student-Athlete Academic Support Services'>
        <cfset messageStruct.cameoName = 'Kim Powers Hoyt'>
        <cfset messageStruct.cameoTitle = 'Director'>
        <cfset messageStruct.cameoPhone = '513-745-3708'>
        <cfset messageStruct.cameoEmail = 'powers@xavier.edu'>
        <cfset messageStruct.cameoPicture = ''>
        
		
        <cfsavecontent variable="messageStruct.body">         
            <p>Welcome to Xavier!  We are thrilled that you have chosen to come to Xavier as a varsity student-athlete.  The Student-Athlete Academic Support Services Office looks forward to empowering and supporting you as you navigate your academic path at Xavier. Due to both NCAA and Xavier academic eligibility requirements, one of the Athletic Academic Advisors in the SAASS Office will be drafting a Fall 2016 course schedule for you.  We will then reach out to you via email or phone to discuss this schedule with you and make any necessary changes.</p>  
            
            <p>Please note that there are still certain steps that need to be taken in order for us to build your schedule. Please refer to the '<a href="https://roadto.xavier.edu/your-road/index.cfm">Your Road to Xavier</a>' section for more details.</p>

			<p>Enjoy the rest of your Senior Year and we will talk with you soon.</p>

			<p>Sincerely,<br>
			Kim Powers Hoyt<br>
			Director, Student-Athlete Academic Support Services</p>
        </cfsavecontent>
            
		<cfset messageStruct.display = FALSE>
		<!---<cfif session.athlete and datecompare(now(), Application.adv_start) gt 0 and session.studenttype NEQ 'T'>
			<cfset messageStruct.display = TRUE>
		</cfif>--->
		<cfset messageStruct.mobileDisplay = TRUE>        
        
        <cfset structInsert(session.messages,36,messageStruct,'TRUE')>
		
		<!--- Message 37 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Advising Update">
        
        <cfset messageStruct.from = 'Academic Advising'>
        <cfset messageStruct.subject = 'Advising Update'>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfswitch expression="#session.studentProcess.advisingStatus(session.bannerid)#">
        
        	<cfcase value="notStarted">       
                <cfset messageStruct.title = "Advising Update">
                <cfset messageStruct.subject = 'Advising Update'>
                
                <cfsavecontent variable="messageStruct.body">
                </cfsavecontent>
                <cfset messageStruct.display = FALSE>
            </cfcase>
            
            <cfcase value="waitingReview">       
                <cfset messageStruct.title = "Your First Semester Schedule">
                <cfset messageStruct.subject = messageStruct.title>
                
                <cfsavecontent variable="messageStruct.body">
                	<cfinclude template="../registration/includes/email-to-student-on-schedule-submit.cfm">
                </cfsavecontent>
                
                <cfset messageStruct.body = replaceNoCase(messageStruct.body,'<p>Dear #trim(session.firstname)#,</p>','','ALL')>
                
                <cfset messageStruct.display = TRUE>
            </cfcase>
            
            <cfcase value="rejected">       
                <cfset messageStruct.title = "Your First Semester Schedule">
                <cfset messageStruct.subject = messageStruct.title>
                
                
                <cfset request.firstname = session.firstname>
                <!--- get the comments --->
                <cfquery name="getComments" datasource="#application.roadtoDB#">
                select advisorComments
                from advisingSchedules
                where BannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">
                  and id = (select max(ID) from advisingSchedules where BannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">)
                </cfquery>
                <cfset request.adjustments = getComments.advisorComments>
                
                <cfsavecontent variable="messageStruct.body">
                	<cfinclude template="../registration/includes/email-to-student-on-schedule-reject-1.cfm">
                </cfsavecontent>
                
                <cfset messageStruct.body = replaceNoCase(messageStruct.body,'<p>Dear #trim(session.firstname)#,</p>','','ALL')>
                
                <cfset messageStruct.display = TRUE>
            </cfcase>
            
            <cfcase value="approved">       
                <cfset messageStruct.title = "Your First Semester Schedule">
                <cfset messageStruct.subject = messageStruct.title>
                
                
                <cfset request.firstname = session.firstname>
                <!--- get the comments --->
                <cfquery name="getComments" datasource="#application.roadtoDB#">
                select advisorComments
                from advisingSchedules
                where BannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">
                  and id = (select max(ID) from advisingSchedules where BannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">)
                </cfquery>
                
                
                <cfset request.adjustments = getComments.advisorComments>
                
                <cfsavecontent variable="messageStruct.body">
                	<cfinclude template="../registration/includes/email-to-student-on-schedule-approve.cfm">
                </cfsavecontent>
                
                <cfset messageStruct.body = replaceNoCase(messageStruct.body,'<p>Dear #trim(session.firstname)#,</p>','','ALL')>
                
                <cfset messageStruct.display = TRUE>
            </cfcase>
            
            <cfdefaultcase>
            	<cfset messageStruct.display = FALSE>
            </cfdefaultcase>
            
            
        </cfswitch>
        
        <cfset messageStruct.display = FALSE>    
            
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,37,messageStruct,'TRUE')>
        
        <!--- Message 38 - Peer Mentor WCB --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Xavier Peer Leader Program">
        
        <cfset messageStruct.from = 'Laura Frazier & Ann Schmidt<br>Peer Leader Program Coordinators'>
        <cfset messageStruct.subject = 'Xavier Peer Leader Program'>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
        
        <p>Welcome to Xavier&rsquo;s Williams College of Business!  We look forward to meeting you in August and helping you get acquainted with our college.  Part of that process involves the University <strong>Peer Leader</strong> <strong>Program</strong>.</p>
        <p>Every first year student in the WCB (you&rsquo;ll get to know this acronym quickly – it stands for Williams College of Business, as opposed to Xavier&rsquo;s other two colleges, College of Arts &amp; Sciences and College of Social Sciences, Health and Education) is grouped with a Peer Leader who is also a business major.   You will meet your Peer Leader during Manresa.  Having a Peer Leader in the WCB allows you to connect with an upperclassman from the get-go, one who has answers to questions you might have about finding a tutor, signing up for a Business Professions workshop, or getting involved in the trading room.  Watch for an email from your Peer Leader later this summer – he or she just may become the first business professional you connect with once you graduate!</p>
        <p> If you have questions about the Peer Leader Program, you can email <a href="mailto:wcbpeerleader@xavier.edu">wcbpeerleader@xavier.edu</a> .</p>
        <p> You should also save the date for the Peer Leader Meet and Greet during Manresa, when you&rsquo;ll meet your Peer Leader in person. The Meet and Greet will take place on <b>Sunday, August 24 from 2-3pm in Cintas</b>.</p>
        <p> Enjoy the rest of your summer and we&rsquo;ll see you then!</p>
        <p> Laura Frazier &amp; Ann Schmidt<br />
          Peer Leader Program Coordinators/Williams College of Business</p>
        </cfsavecontent>
        
		<cfset messageStruct.display = FALSE>
        
        <!---<cfif (datecompare(now(),Application.peer_mentor_start) gt 0) and session.college EQ 'WCB' >
			<cfset messageStruct.display = TRUE>
		</cfif>--->
        
		<cfset messageStruct.mobileDisplay = true>

         <cfset structInsert(session.messages,38,messageStruct,'TRUE')>
        
        <!--- Message 39 - Peer Mentor CAS & CSS --->
        
        <cfquery name="finduser" datasource="#application.roadtoDB#">
        SELECT PLGroup FROM PeerLeaderAssignments WHERE  bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
       <cfif finduser.recordCount GT 0 and finduser.PLGroup is not "ST" and session.deposited is 1 >
        	<cfset session.hasPL = TRUE>
        <cfelse>
        	<cfset session.hasPL = FALSE>
        </cfif>
        
     <cfquery name="getPeerLeader" datasource="#application.roadtoDB#">
        SELECT PeerLeaderLeaders.firstName,PeerLeaderLeaders.LastName,PeerLeaderLeaders.email,PeerLeaderLeaders.groupID,PeerLeaderAssignments.bannerID
		FROM PeerLeaderLeaders
		INNER JOIN PeerLeaderAssignments
		ON PeerLeaderLeaders.groupID=PeerLeaderAssignments.PLGroup  WHERE  bannerid = <cfqueryparam value="#session.bannerid#" cfsqltype="cf_sql_varchar">
	 </cfquery>
        
        
     <cfif  session.hasPL and  getPeerLeader.recordcount is 0  > 
     
        <cfset session.hasPL = FALSE>
        
        <cfmail from="sparkse1@xavier.edu" to="sparkse1@xavier.edu" subject="Student Missing PL Assignment" type="html">
		#session.bannerid# does not have a PL assigned to them
   		</cfmail>
        
     </cfif>   
        
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Xavier Peer Mentor Program">
        
        <cfset messageStruct.from = '<a href="mailto:#getPeerLeader.email#">#getPeerLeader.firstName# #getPeerLeader.LastName# - #getPeerLeader.email# </a>'  >
        <cfset messageStruct.subject = 'Xavier Peer Mentor Program'>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
       
       <cfif session.hasPL >
        
        <cfsavecontent variable="messageStruct.body">

        <img src="/images/peerLeaderPhotos/#getPeerLeader.groupid#.jpg" align='right' style=" padding-left:10px;" >
   
        <p>Hi, my name is #getPeerLeader.firstName# #getPeerLeader.Lastname#! I hope your summer is going well and that you are getting excited to become part of the Xavier Family.</p>
        
        
        <p>I will be your Peer Mentor this year and am excited to help guide you through your first year. We will talk and meet informally throughout the year to ensure that you have the tools you need to make a smooth and successful transition to college. I can help answer simple questions, connect you to offices on campus that can help academically, and provide you with support to get involved and become a part of the larger Xavier community.</p>
        
        
        <p>I am looking forward to meeting you for the first time on <strong>Sunday, August 21</strong> during <a href='/manresa/'>Manresa</a>, when we will make plans for future meetings!</p>
          
     <p>
     If you have any questions about the <a href="http://www.xavier.edu/peerleader/" target="_blank">Peer Mentor Program</a>, you can <a href="mailto:#getPeerLeader.email#">email</a> me or <a href="mailto:peerleader@xavier.edu">email the program coordinators</a> and we will be happy to help you. For more information about the Peer Mentor Program <a href="http://www.xavier.edu/peerleader/" target="_blank">visit our web page</a>. 
     </p>     
          
          
        <p>
        	<strong>Welcome to Xavier!</strong><br>
        	#getPeerLeader.firstName# <br> 
	   </p>
       
       
        </cfsavecontent>
        
        <cfelse>
        
        <cfsavecontent variable="messageStruct.body">
        </cfsavecontent>
        
        </cfif>
        
		<cfset messageStruct.display = FALSE>
        <cfif (datecompare(now(),Application.peer_mentor_start) gt 0) and session.hasPL >
			<cfset messageStruct.display = TRUE>
		</cfif>
        
		<cfset messageStruct.mobileDisplay = false>

        <cfset structInsert(session.messages,39,messageStruct,'TRUE')>
        
        
        
        
        
        <!--- Message 40 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Your Transfer Credit - Inactive">
        
        <cfset messageStruct.from = '#getCounselor.name#'>
        <cfset messageStruct.subject = 'Your Transfer Credit'>
        
        <cfset messageStruct.cameoHeader = 'Your Admission Counselor'>
        <cfset messageStruct.cameoName = '#getCounselor.name#'>
        <cfset messageStruct.cameoTitle = '#getCounselor.title#'>
        <cfset messageStruct.cameoPhone = '#getCounselor.phone#'>
        <cfset messageStruct.cameoEmail = '#getCounselor.email#'>
        <cfset messageStruct.cameoPicture = '/images/counselors/#getCounselor.counselorCode#.jpg'>
        
        <cfsavecontent variable="messageStruct.body"> 
        </cfsavecontent>
        
        
		<cfset messageStruct.display = FALSE>
		
<!---
		<cfif 1 eq 2 and datecompare(now(), Application.credit_eval_start) gt 0 and session.studentType EQ 'T' and filePresent >
			<cfset messageStruct.display = TRUE>
		</cfif>
--->
		
		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,40,messageStruct,'TRUE')>
         
        
        
               
         <!--- Message 41 --->
        <cfset messageStruct = structNew()>
        <cfset messageStruct.title = "Still Deciding?">
        
        <cfset messageStruct.from = '<a href="mailto:#getCounselor.email#">#getCounselor.name#</a>'>
        <cfset messageStruct.subject = ' "Undecided" Major is Now "Exploratory" '>
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
		
		
		<p>Not sure which major to choose? We understand. It’s a big decision. But you’re not undecided, and we won’t call you that. <strong>You’re exploring your options. You’re Exploratory.</strong> </p>

		<p> <img src="/images/inbox/inbox41Photo.png" align="right" style=" padding-left: 10px;"> Rachel Phelan, a 19-year-old freshman from St. Charles, Ill.  is exploring several specific majors at Xavier to maximize her opportunities.
		“I’ve always wanted to work at a corporation either in marketing or advertising because I enjoy the creativity and working with a team to accomplish a goal,” Rachel says. “Thus far I have taken three 			business courses. After discovering my love for economics, I’m thinking of either marketing or economics.” </p>
		
		<p>It’s an important decision -  one that needs to be weighed carefully – and one that Xavier faculty and staff are helping her to decide.
		“I want to make sure I’m making the wisest decision,” she says. <strong>“It’s okay that you don’t know what exactly you want to do. Take the time to take several different courses that interest you so that you can get an inkling for what you might like.”</strong></p>
		

		<p>Just like Rachel, you can stay on track to graduate as you explore your options.</p>

		<p><a href='www.xavier.edu/exploratory/'  
			onclick="dataLayer.push({'event' : 'customEvent','eventCategory' : 'R2X-Inbox','eventAction' : 'Exploratory Link', 'eventLabel' : '#session.BannerID#' });" target="_blank"
			>Exploratory at X.</a></p>
		
		<p>Sincerely,<br>
			#getCounselor.name#<br>
			#getCounselor.Title#</p>
		    
        </cfsavecontent>
        
         
		<cfset messageStruct.display = FALSE>
		
		  <cfif session.bannermajorcode is "EXPL" or  session.bannermajorcode is "UDEC" >
	        <cfset messageStruct.display = TRUE >
        </cfif> 
		

		<cfset messageStruct.mobileDisplay = TRUE>

        <cfset structInsert(session.messages,41,messageStruct,'TRUE')>
        
        
          <!--- Message 42 --->
        <cfset messageStruct = structNew()>
        
        <cfset messageStruct.title = "Update on Xavier's Competitive Scholarships">
        <cfset messageStruct.from = 'Lauren Cobble<br>Dean of Undergraduate Admission'>
        <cfset messageStruct.subject = "Update on Xavier's Competitive Scholarships">
        
        <cfset messageStruct.cameoHeader = ''>
        <cfset messageStruct.cameoName = ''>
        <cfset messageStruct.cameoTitle = ''>
        <cfset messageStruct.cameoPhone = ''>
        <cfset messageStruct.cameoEmail = ''>
        <cfset messageStruct.cameoPicture = ''>
        
        <cfsavecontent variable="messageStruct.body">
		
		
		<p>The review of applications for the Francis X. Weninger/Miguel Pro Scholarship is now complete. We were very pleased with the high caliber of our applicants.</p>
		
<p>You have been selected as an alternate recipient of a Francis X. Weninger/Miguel Pro Scholarship. This scholarship is valued at $3,000 per year, and would be honored for up to eight consecutive semesters of undergraduate studies provided you maintain full-time status and a minimum cumulative grade point average of 2.5.</p> 

<p>If you are awarded a Francis X. Weninger/Miguel Pro Scholarship, you will be notified on or before May 1, 2016. If awarded, this amount would be added to any scholarships or awards you were previously offered on the Money Matters tab on the Road to Xavier. It would be applicable to tuition costs for the fall and spring semesters only.</p> 

<p>We have much to offer you and I am certain that you will bring your many talents to develop and share during your time as a Xavier student. Xavier wouldn’t be the same without you and we wish you the best as you complete your senior year.</p>
		
		
			<p>Sincerely,<br />
				Lauren Cobble <br />
				Dean of Undergraduate Admission</p>
		    
        </cfsavecontent>
        
        
        <cfset messageStruct.display = FALSE>
        <cfif datecompare(now(),Application.schol_invite_start) gt 0 and datecompare(now(),Application.schol_invite_end) lt 0 and listFind(application.scholWenAlternates, session.BannerID)>
        	<cfset messageStruct.display = TRUE>
		</cfif>
		<cfset messageStruct.mobileDisplay = TRUE>
        <cfset structInsert(session.messages,42,messageStruct,'TRUE')>
        
        
        
        
        
        
        
        </cfoutput>
        
        
        
        
    </cffunction>

	<cffunction name="encryptID" returntype="string"><cfargument name="incomingID" type="numeric"><cfset newID = 999999 - incomingID><cfreturn newID></cffunction>
    
</cfcomponent>

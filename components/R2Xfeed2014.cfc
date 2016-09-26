<cfcomponent name="R2Xfeed2014" hint="adds a level of abstraction for web,mobile to use the same code">
    
    <!--- feed functions --->
    <cffunction name="getInitialFeed" access="public" returntype="string">
    	<cfargument name="itemsIn" required="no" type="numeric" default="10">
        <cfargument name="lastIDIn" required="no" type="numeric" default="0">
        
        <cfoutput>
        
        <cfquery name="FeedBaseQry" datasource="#Application.RoadtoDB#">
        select top(#arguments.itemsIn#) *
        from mainfeed
        <cfif arguments.lastIDIn NEQ 0>
        	where ID < <cfqueryparam value="#arguments.lastIDIn#" cfsqltype="cf_sql_integer">
        </cfif>
        order by ID desc
        </cfquery>
        
        <!--- we have the initial feed data. Let's loop through to save off the content --->
        <cfsavecontent variable="feedHTML">
        
        	<cfset oldProfileID = ''>
        
        	<cfloop query="FeedBaseQry">
            
            	<cfif feedBaseQry.updateType EQ 'profile'>
                	<cfif feedBaseQry.BannerID EQ oldProfileID>
                    	<cfcontinue>
                    <cfelse>
                    	<cfset oldProfileID = feedBaseQry.BannerID>
                    </cfif>
            	<cfelse>
                	<cfset oldProfileID = ''>
                </cfif>	
            
            	<cfswitch expression="#feedBaseQry.updateType#">
            		<cfcase value="badge">
            			#this.generateBadgeFeed(feedBaseQry.ID, feedBaseQry.BannerID, feedBaseQry.updateStamp, feedBaseQry.notes)#
                    </cfcase>
                    
                    <cfcase value="profile">
            			#this.generateProfileFeed(feedBaseQry.ID, feedBaseQry.BannerID, feedBaseQry.updateStamp)#
                    </cfcase>
                    
                    <cfcase value="twitter">
            			#this.generateTwitterFeed(feedBaseQry.ID, feedBaseQry.updateID)#
                    </cfcase>
            
            		<cfdefaultcase>
                    </cfdefaultcase>
            	</cfswitch>    
            </cfloop>
        </cfsavecontent>
        
        <cfreturn feedHTML>
        
        </cfoutput>

    </cffunction>
    
<!--- ***
Badge Section
*** --->
    <cffunction name="generateBadgeFeed" returntype="string">
    	<cfargument name="IDIn">
        <cfargument name="BannerIDIn">
        <cfargument name="updateStampIn">
        <cfargument name="badgeIn">
        
        <cfoutput>
        
        <!-- generating badge -->
        
        <!--- make sure the user still has the badge --->
        <cfquery name="checkBadge" datasource="#Application.RoadtoDB#">
        select *
        from bannerstudent join gameStudentBadges on bannerstudent.bannerid = gamestudentbadges.bannerid
        join gameBadges on gameStudentBadges.badge = gameBadges.code
        where dateDeleted is null
          and bannerStudent.bannerid = <cfqueryparam value="#arguments.bannerIDin#" cfsqltype="cf_sql_varchar">
          and gameStudentBadges.badge = <cfqueryparam value="#arguments.badgeIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfsavecontent variable="badgeHTML">
			<cfif checkBadge.recordCount GT 0>
            	<div class="update badge" ID="#arguments.IDin#">
                    <cfif arguments.badgeIn EQ 'ambassador'>
                    	<a href="/game-center/badge-legend.cfm###arguments.badgeIn#">
                        <img src="#application.appimagepath#images/badges/#arguments.badgeIn#-#trim(checkBadge.state)#.png" alt="#arguments.badgeIn# badge" />
                        </a>
                	<cfelse>
                    	<a href="/game-center/badge-legend.cfm###arguments.badgeIn#">
                        <img src="#application.appimagepath#images/badges/#arguments.badgeIn#.png" alt="#arguments.badgeIn# badge"  />
                        </a>
                    </cfif>
					<p class="name">#this.formatBadgeCopy(arguments.bannerIDin,checkBadge)#</p>
                    
                    <!--- Come up with 3-4 random things to display here --->
					<p class="content">Compare <a href="/game-center/">your badges</a> with #checkBadge.firstName#'s.</p>
				</div>
				<div class="update-author">
					<p>
						<span class="name"><a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">#checkBadge.firstName# #checkBadge.lastName#</a></span> &mdash; 
						<span class="time">#this.formatTime(arguments.updateStampIn)#</span>
					</p>
				</div>
            <cfelse>
            	<!-- badge not found -->
            </cfif>
        </cfsavecontent>
        
        </cfoutput>
        
        <cfreturn badgeHTML>
    </cffunction>

	<cffunction name="formatBadgeCopy" returntype="string">
    	<cfargument name="BannerIDIn">
        <cfargument name="badgeQueryIn">
        
        <cfset workingString = badgeQueryIn.feedCopy>
        
        <cfset workingString = rereplaceNoCase(workingString,'%First_Name_Link%','<a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">#checkBadge.firstName#</a>','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%Full_Name_Link%','<a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">#checkBadge.firstName# #checkBadge.lastName#</a>','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%Possessive_Profile_Link%','<a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">#this.getPronoun(arguments.bannerIDIn,'his')# profile</a>','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%Pronoun_He%','#this.getPronoun(arguments.bannerIDIn,'he')#','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%Pronoun_His%','#this.getPronoun(arguments.bannerIDIn,'his')#','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%Pronoun_Him%','#this.getPronoun(arguments.bannerIDIn,'him')#','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%First_Name%','#checkBadge.firstName#','ALL')>
        
        <cfset workingString = rereplaceNoCase(workingString,'%Full_State%','#this.GetFullState(checkBadge.state)#','ALL')>
        
        <cfreturn workingString>
        
    </cffunction>
    
    <cffunction name="getFullState" returntype="string">
    	<cfargument name="stateIn">
        
        <cfquery name="getState" datasource="#application.XavierWeb#">
        select display
        from state_select
        where value=<cfqueryparam value="#arguments.stateIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfreturn getState.display>
        
    </cffunction>
    
<!--- ***
Profile Section
*** --->    
    <cffunction name="generateProfileFeed" returntype="string">
    	<cfargument name="IDIn">
        <cfargument name="BannerIDIn">
        <cfargument name="updateStampIn">
        
        <cfoutput>
        
        <!-- generating profile -->
        
        <!--- get their data --->
        <cfquery name="profileQry" datasource="#Application.RoadtoDB#">
        select bannerstudent.bannerid, firstName, lastName, city, state
        from student join bannerstudent on student.bannerid = bannerstudent.bannerid
        where bannerstudent.bannerid = <cfqueryparam value="#Arguments.banneridIn#" cfsqltype="cf_sql_varchar">
          <!---and student.dtLastUpdated = <cfqueryparam value="#arguments.updateStampIn#" cfsqltype="cf_sql_timestamp">--->
        </cfquery>
        
        <cfsavecontent variable="profileHTML">
			<cfif profileQry.recordCount GT 0>
                <!--- open the container --->
                <div class="update profile" ID="#arguments.IDin#">
                	
                    <!--- grab the image --->
                    <cfset absolutePath = #expandPath('/')# & "/imagespoc/profilepics-thm\">
					<a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">
                    <cfif FileExists(absolutePath & "thm-#encryptID(arguments.banneridIn)#-1.jpg")>
                        <img src="/imagespoc/profilepics-thm/thm-#encryptID(arguments.banneridIn)#-1.jpg" alt="Profile Picture" class="feedProfilePic" />
                    <cfelse>	
                        <!--- placeholder image --->
                        <img src="/imagespoc/profilepics-thm/thm-000000-1.jpg" alt="Profile Picture" class="feedProfilePic" />
                    </cfif>
					</a>
                    
					<p class="name">#profileQry.firstName# updated #this.getPronoun(arguments.banneridIn,'his')# profile. <a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">Check it out!</a></p>
					<p class="content">#profileQry.city#, #profileQry.state#</p>
				</div>
				<div class="update-author">
					<p>
						<span class="name"><a href="/profile/index.cfm?id=#encryptID(arguments.banneridIn)#">#profileQry.firstName# #profileQry.lastName#</a></span> &mdash; 
						<span class="time">#this.formatTime(arguments.updateStampIn)#</span>
					</p>
				</div>
            <cfelse>
            	<!-- not most recent profile update -->
            </cfif>
        </cfsavecontent>
        
        </cfoutput>
        
        <cfreturn profileHTML>
    </cffunction>

<!--- ***
Twitter Section
*** --->    
    <cffunction name="generateTwitterFeed" returntype="string">
    	<cfargument name="IDIn">
        <cfargument name="updateIDIn">
        
        <cfoutput>
        
        <!-- generating tweet -->
        
        <!--- get their data --->
        <cfquery name="tweetQry" datasource="#application.roadtoDB#">
        select *
        from twittercache
        where hide is null or hide = 0
          and ID = <cfqueryparam value="#arguments.updateIDIn#" cfsqltype="cf_sql_bigint" >
        </cfquery>	
        
        <cfsavecontent variable="twitterHTML">
			<cfif tweetQry.recordCount GT 0>
            
            	<cfquery name="getR2XUsername" datasource="#application.roadtoDB#">
                select username, firstName, bannerstudent.bannerid
                from bannerstudent join ambassadorsia on bannerstudent.bannerid = ambassadorsia.bannerid
                where iaTwitterName = <cfqueryparam value='#tweetQry.username#' cfsqltype="cf_sql_varchar">
                </cfquery>
                
                <!--- manipulate the content --->
                <cfset postList = tweetQry.PostContent>
				<cfset postOut = tweetQry.PostContent>
                
                <!--- link the links --->
                <cfset linkStart = findNoCase('http://',postOut)>
        
                <cfif linkStart>
                    <cfset linkEnd = findNoCase(' ',postOut,linkStart)>
                    
                    <cfif linkEnd EQ 0>
                        <cfset linkEnd = len(postOut)>
                    </cfif>
                    
                    <cfset linkURL = mid(postOut,linkStart,linkEnd - linkStart + 1)>                           
                    <cfset postOut = replaceNoCase(postOut, linkURL, '<a href="#linkURL#" target="_blank">#linkURL#</a>')>
                    
                </cfif>
                
                <!--- link the references --->
                <cfloop list="#postList#" delimiters=" ,:" index="token">
                    <cfif left(token,1) EQ '@'>
                        <cfset postOut = replaceNoCase(postOut,token,'<a href="http://twitter.com/#replace(token,"@","")#" target="_blank">#token#</a>')>
                    </cfif>
                </cfloop>
                
                <!--- link the hashes --->
                <cfloop list="#postList#" delimiters=" ,:" index="token">
                    <cfif left(token,1) EQ '##'>
                        <cfset postOut = replaceNoCase(postOut,token,'<a href="http://twitter.com/search?q=#replace(token,"##","%23")#&src=hash" target="_blank">#token#</a>')>
                    </cfif>
                </cfloop>

            
                <!--- open the container --->
                <div class="update tweet" ID="#arguments.IDin#">
					<a href="/about/twitter.cfm###getR2XUsername.username#">
					
					<cfset absolutePath = #expandPath('/')# & "/imagespoc/profilepics-thm\">
					<cfif FileExists(absolutePath & "thm-#encryptID(getR2XUsername.bannerid)#-1.jpg")>
                        <img src="/imagespoc/profilepics-thm/thm-#encryptID(getR2XUsername.bannerid)#-1.jpg" alt="Profile Picture" class="feedProfilePic" />
                    <cfelse>	
                        <!--- placeholder image --->
                        <img src="/imagespoc/profilepics-thm/thm-000000-1.jpg" alt="Profile Picture" class="feedProfilePic" />
                    </cfif>
					</a>
					<p class="content">#postOut#</p>
				</div>
				<div class="update-author">
					<p>
					<span class="name"><a href="/about/twitter.cfm###getR2XUsername.username#">#getR2XUsername.firstname# (@#tweetQry.username#)</a></span> &mdash;
					<span class="time">#this.formatTime(dateAdd('h',5,tweetQry.timestamp))#</span>
					</p>
				</div>
            <cfelse>
            	<!-- tweet not found -->
            </cfif>
        </cfsavecontent>
        
        </cfoutput>
        
        <cfreturn twitterHTML>
    </cffunction>

<!--- ***
Helper Functions 
*** --->    
    <cffunction name="getPronoun" returntype="string">
    	<cfargument name="BannerIDIn">
        <cfargument name="pronounIn">
        
        <cfquery name="getGender" datasource="#application.roadtoDB#">
        select gender from bannerstudent
        where bannerid = <cfqueryparam value="#arguments.banneridIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getGender.recordCount EQ 0>
        	<cfreturn pronounIn>
        <cfelseif getGender.gender EQ 'M'>
        	<cfreturn arguments.pronounIn>
        <cfelse>
        	<cfswitch expression="#arguments.pronounin#">
            	<cfcase value="he"><cfreturn 'she'></cfcase>
                
                <cfcase value="him,his"><cfreturn 'her'></cfcase>
            </cfswitch>
        </cfif>
    </cffunction>
    
    <cffunction name="formatTime" returntype="string">
    	<cfargument name="timeIn">
        
		<cfif datediff('n',arguments.timeIn, now()) EQ 0>
        	<cfreturn "right now">
        <cfelseif datediff('n',arguments.timeIn, now()) EQ 1>
        	<cfreturn "#datediff('n',arguments.timeIn, now())# minute ago">
        <cfelseif datediff('n',arguments.timeIn, now()) LT 60>
        	<cfreturn "#datediff('n',arguments.timeIn, now())# minutes ago">
        <cfelseif datediff('h',arguments.timeIn,now()) LE 1>
        	<cfreturn "#datediff('h',arguments.timeIn, now())# hour ago">
        <cfelseif datediff('h',arguments.timeIn, now()) LT 24>
        	<cfreturn "#datediff('h',arguments.timeIn, now())# hours ago">
        <cfelse>
        	<cfreturn dateFormat(arguments.timeIn,'long')>
        </cfif>
    </cffunction>
    
    <cffunction name="encryptID" returntype="string"><cfargument name="incomingID" type="numeric"><cfset newID = 999999 - incomingID><cfreturn newID></cffunction>
    <cffunction name="decryptID" returntype="string"><cfargument name="incomingID" type="numeric"><cfset newID = 999999 - incomingID><cfset newID = "000" & newID><cfreturn trim(newID)></cffunction>  

</cfcomponent>
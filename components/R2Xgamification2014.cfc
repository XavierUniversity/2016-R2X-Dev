<cfcomponent name="R2Xgamification2014" >    

	<!--- 
	*** Creates ***
	--->
    
    <cffunction name="insertLeader">
    	<cfargument name="columnIn">
        <cfargument name="valueIn">
        
        <cfquery datasource="#application.roadtoDB#">
        update gameLeaders
        set #arguments.columnIn# = <cfqueryparam value="#arguments.valueIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
    </cffunction>    
    
    <cffunction name="setGamificationLeaders" returntype="void">
    
    	<cfset local = {}>
    
    	<cflock scope="application" timeout="60">
  
  		<!--- set the top 10 overall leaders --->
        <cfquery name="local.gameLeaders" datasource="#application.roadtoDB#">
        SELECT     TOP (10) GameStudent.BannerID, SUM(GameItems.PrimaryValue) AS total
        FROM         GameStudent INNER JOIN
                              GameItems ON GameStudent.ItemCode = GameItems.Code
        where gamestudent.bannerid in (select bannerid from bannerstudent where entryTerm = '#application.defaultTerm#')
          and gamestudent.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp">
        <!--- Game Exclude --->
        GROUP BY GameStudent.BannerID
        ORDER BY total DESC
        </cfquery>
        
        <cfset this.insertLeader('overall',serializeJSON(local.gameLeaders))>
        
        <!--- set the top 10 overall leaders for last month --->
        <cfquery name="local.gameLeaders30" datasource="#application.roadtoDB#">
        SELECT     TOP (10) GameStudent.BannerID, SUM(GameItems.PrimaryValue) AS total
        FROM         GameStudent INNER JOIN
                              GameItems ON GameStudent.ItemCode = GameItems.Code
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('m',-1,now()))#" cfsqltype="cf_sql_timestamp">
          and gamestudent.bannerid in (select bannerid from bannerstudent where entryTerm = '#application.defaultTerm#')
        <!--- Game Exclude --->
        GROUP BY GameStudent.BannerID
        ORDER BY total DESC
        </cfquery>
        <cfset this.insertLeader('overall30',serializeJSON(local.gameLeaders30))>
        
        <!--- set the top 10 overall leaders for last 14 days --->
        <cfquery name="local.gameLeaders14" datasource="#application.roadtoDB#">
        SELECT     TOP (10) GameStudent.BannerID, SUM(GameItems.PrimaryValue) AS total
        FROM         GameStudent INNER JOIN
                              GameItems ON GameStudent.ItemCode = GameItems.Code
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('ww',-2,now()))#" cfsqltype="cf_sql_timestamp">
          and gamestudent.bannerid in (select bannerid from bannerstudent where entryTerm = '#application.defaultTerm#')
        <!--- Game Exclude --->
        GROUP BY GameStudent.BannerID
        ORDER BY total DESC
        </cfquery>
        <cfset this.insertLeader('overall14',serializeJSON(local.gameLeaders14))>
        
        <!--- set the top 10 overall losers --->
        <cfquery name="local.gameLosers" datasource="#application.roadtoDB#">
        SELECT     TOP (10) GameStudent.BannerID, SUM(GameItems.PrimaryValue) AS total
        FROM         GameStudent INNER JOIN
                              GameItems ON GameStudent.ItemCode = GameItems.Code
        where gameStudent.bannerid in (select bannerid from student where lastVisit > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp"> and dtLastUpdated is not null) and gamestudent.bannerid in (select bannerid from bannerstudent where entryTerm = '#application.defaultTerm#')
        <!--- Game Exclude --->
        GROUP BY GameStudent.BannerID
        ORDER BY total ASC
        </cfquery>
        <cfset this.insertLeader('overallLosers',serializeJSON(local.gameLosers))>
        
        <cfset holderStruct = {}>
		<!---<cfset stateList = 'AK,AL,AR,AZ,CA,CO,CT,DC,DE,FL,GA,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VA,VT,WA,WI,WV,WY'>--->
		
        <cfloop list="#application.stateList#" index="state">
        
        	<!--- run the query for each state --->
            <cfquery name="getState" datasource="#application.roadtoDB#">
            SELECT     MAX(total) AS highTotal, BannerID
FROM         (SELECT     BannerStudent.State, GameStudent.BannerID, SUM(GameItems.PrimaryValue) AS total
                       FROM          GameStudent INNER JOIN
                                              GameItems ON GameStudent.ItemCode = GameItems.Code INNER JOIN
                                              BannerStudent ON GameStudent.BannerID = BannerStudent.BannerID
                       WHERE      (BannerStudent.State = <cfqueryparam value="#state#" cfsqltype="cf_sql_varchar">
                         and gamestudent.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp">)
                       GROUP BY GameStudent.BannerID, BannerStudent.State) AS derivedtbl_1h
WHERE     (total =
                          (SELECT     MAX(total) AS Expr1
                            FROM          (SELECT     BannerStudent_1.State, GameStudent_1.BannerID, SUM(GameItems_1.PrimaryValue) AS total
                                                    FROM          GameStudent AS GameStudent_1 INNER JOIN
                                                                           GameItems AS GameItems_1 ON GameStudent_1.ItemCode = GameItems_1.Code INNER JOIN
                                                                           BannerStudent AS BannerStudent_1 ON GameStudent_1.BannerID = BannerStudent_1.BannerID
                                                    WHERE      (BannerStudent_1.State = <cfqueryparam value="#state#" cfsqltype="cf_sql_varchar">)
                                                      and gamestudent_1.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp"> 
                                                      AND (GameStudent_1.BannerID NOT IN
                                                                               (SELECT     BannerID
                                                                                 FROM          GameStudentBadges
                                                                                 WHERE      (Badge IN ('dartagnan', 'blueblob')) AND (dateDeleted IS NULL)))
                                                    GROUP BY GameStudent_1.BannerID, BannerStudent_1.State) AS derivedtbl_1))
GROUP BY BannerID
            </cfquery>
            
            <cfif getState.recordCount GT 0>
            	<cfset structInsert(holderStruct,state,"#getState.highTotal#,#getState.bannerid#",'TRUE')>
            </cfif>
        </cfloop>
        
        <cfset this.insertLeader('state',serializeJSON(holderStruct))>
        
        <!--- set the points totals --->
        <cfquery name="getGenderScores" datasource="#application.roadtoDB#">
        select gender, sum(gameItems.primaryValue) as score
        from gameStudent join gameItems on gameStudent.itemCode = gameItems.code
        join bannerstudent on gameStudent.bannerid = bannerstudent.bannerid
        where gamestudent.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp">
        group by gender
        order by score desc
        </cfquery>
        
        <cfset local.totalScore = 0>
        <cfloop query="getGenderScores">
            <cfset local.totalScore += getGenderScores.score>
               
            <cfswitch expression="#getGenderScores.gender#">
                <cfcase value="M">
					<cfset local.maleTotal = getGenderScores.score>
					<cfset this.insertLeader('maleTotal',getGenderScores.score)>
                </cfcase>
                <cfcase value="F">
					<cfset local.femaleTotal = getGenderScores.score>
                    <cfset this.insertLeader('femaleTotal',getGenderScores.score)>
               	</cfcase>
            </cfswitch>
        </cfloop>
        
        <cfset this.insertLeader('totalScore',local.totalScore)>
        
        <cfquery name="getGenderScores30" datasource="#application.roadtoDB#">
        select sum(gameItems.primaryValue) as score
        from gameStudent join gameItems on gameStudent.itemCode = gameItems.code
        join bannerstudent on gameStudent.bannerid = bannerstudent.bannerid
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('m',-1,now()))#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        <cfset this.insertLeader('totalScore30',getGenderScores30.score)>
        
        <cfquery name="getGenderScores14" datasource="#application.roadtoDB#">
        select sum(gameItems.primaryValue) as score
        from gameStudent join gameItems on gameStudent.itemCode = gameItems.code
        join bannerstudent on gameStudent.bannerid = bannerstudent.bannerid
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('ww',-2,now()))#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        <cfset this.insertLeader('totalScore14',getGenderScores14.score)>
        
        <!--- set the total number of users playing the game --->
        <cfquery name="getPlayers" datasource="#application.roadtodb#">
        select distinct bannerid
        from gameStudent
        where bannerid in (select bannerid from bannerstudent)
          and gamestudent.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        <cfset this.insertLeader('totalPlayers',getPlayers.recordCount)>
        
        <!--- set the contest leaders --->
        <cfset this.setGamificationLeadersCustomArray('januaryLeaders',Application.x_challenge_jan_start,Application.x_challenge_jan_end,'challenge_jan')>
        <cfset this.setGamificationLeadersCustomArray('februaryLeaders',Application.x_challenge_feb_start,Application.x_challenge_feb_end,'challenge_feb')>
        <cfset this.setGamificationLeadersCustomArray('marchLeaders',Application.x_challenge_mar_start,Application.x_challenge_mar_end,'challenge_mar')>
        <cfset this.setGamificationLeadersCustomArray('aprilLeaders',Application.x_challenge_apr_start,Application.x_challenge_apr_end,'challenge_apr')>       
    
		<cfset application.gameSet = true>
        
        </cflock>
    </cffunction> 
    
    <cffunction name="setGamificationLeadersCustomArray">
    	<cfargument name="customName">
        <cfargument name="dateStart">
        <cfargument name="dateEnd">
        <cfargument name="qBadge">
        
        <!--- first, get all of the people with that badge --->
        <cfquery name="getPop" datasource="#application.roadtoDB#">
        select BannerID, dateAdded
        from GameStudentBadges
        where badge = <cfqueryparam value="#arguments.qBadge#" cfsqltype="cf_sql_varchar">
          and dateDeleted is null
          and BannerID not in ('000300001')
          and bannerid in (select bannerid from bannerstudent where entryTerm = '#application.defaultTerm#')
        order by BannerID
        </cfquery>
        
        <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="getPop Quick Email" type="html">
            IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
            <cfdump var="#getPop#">
            <cfdump var="#CGI#" label="CGI">
        </cfmail>--->

        
        <!--- Now loop through and calculate their points --->
        <cfset workingStruct = {}>
        <cfloop query="getPop">
			<!--- get the points --->
            <cfquery name="getPoints" datasource="#application.roadtoDB#">
            SELECT     SUM(GameItems.PrimaryValue) AS total
            FROM         GameStudent INNER JOIN
                                  GameItems ON GameStudent.ItemCode = GameItems.Code
            where itemDate > <cfqueryparam value="#createODBCDateTime(arguments.dateStart)#" cfsqltype="cf_sql_timestamp">
              and itemDate < <cfqueryparam value="#createODBCDateTime(arguments.dateEnd)#" cfsqltype="cf_sql_timestamp">
              and itemDate >= <cfqueryparam value="#createODBCDateTime(getPop.dateAdded)#" cfsqltype="cf_sql_timestamp">
			  and bannerid = <cfqueryparam value="#getPop.BannerID#" cfsqltype="cf_sql_varchar">
            </cfquery>
            
            <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="getPoints Quick Email" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#getPoints#">
                <cfdump var="#CGI#" label="CGI">
            </cfmail>--->
            
            <cfif isvalid('integer',getPoints.total)>
            	<cfset structInsert(workingStruct,getpop.bannerid,getPoints.total)>
            </cfif>
        
        </cfloop>	
        
		<!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="workingStruct Quick Email" type="html">
            IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
            <cfdump var="#workingStruct#">
            <cfdump var="#CGI#" label="CGI">
        </cfmail>--->
        
        <cfset stop = 10>
        <cfif structCount(workingStruct) LT stop>
        	<cfset stop = structCount(workingStruct)>
        </cfif>
        
        <cfset keyArray = structSort(workingStruct,'numeric','desc')>
        
        <cfset sortedArray = []>
        
        <cfloop from="1" to="#stop#" index="i">
        	
            <cfset workingStruct2 = {}>
            
            <cfset workingStruct2.bannerid = keyArray[i]>
            <cfset workingStruct2.points = structFind(workingStruct,keyArray[i])>
        
        	<cfset arrayAppend(sortedArray,workingStruct2)  >
        </cfloop>
        
        <cfset structInsert(Application,arguments.customName,sortedArray,'TRUE')>
        <cfset this.insertLeader(arguments.customName,serializeJSON(sortedArray))>


            
    </cffunction>
    
    <cffunction name="getLeaderData">
    	<cfargument name="columnIn">
        
        <!--- get the leaders --->
        <cfquery name="getLeaders" datasource="#application.roadtoDB#">
        select #arguments.columnIn# as data from gameLeaders
        </cfquery>
        
        <cfreturn deserializeJSON(getLeaders.data)>
        
   	</cffunction>
    
    <cffunction name="getPointData">
    	<cfargument name="columnIn">
        
        <!--- get the leaders --->
        <cfquery name="getLeaders" datasource="#application.roadtoDB#">
        select #arguments.columnIn# as data from gameLeaders
        </cfquery>
        
        <cfreturn getLeaders.data>
        
   	</cffunction>
    
    <cffunction name="setStudentBadge" returntype="boolean">
    	<cfargument name="idIn">
        <cfargument name="badgeIn">
        
        <!--- make sure they don't already have it --->
        <cfset badgeQuery = this.getStudentBadges(arguments.idIn)>
        
        <cfquery dbtype="query" name="checkBadge">
        select badge from badgeQuery where badge='#arguments.badgeIn#'
        </cfquery>
        
        <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="Set Student Badges" type="html">
            IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
            <cfdump var="#badgeQuery#" label="badgeQuery">
            <cfdump var="#checkBadge#" label="checkBadge">
            <cfdump var="#CGI#" label="CGI">
         </cfmail>--->

        
        <cfif checkBadge.recordCount GT 0>
        	<cfreturn false>
        <cfelse>
        
        	<cftry>
        
            <cfquery datasource="#application.roadtoDB#" name="insertBadge">
            insert into gameStudentBadges(bannerid,badge,dateAdded)
            Output Inserted.ID
            values(
                <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.badgeIn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
            )
            </cfquery>
            
            <!--- save it to the main feed table --->
            <cfquery datasource="#application.RoadToDB#">
            insert into mainFeed(bannerid,updateStamp,updateType,updateID,notes)
            values(
                <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                'badge',
                <cfqueryparam value="#insertBadge.ID#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#arguments.badgeIn#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>
            
            <cfcatch>
                <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="Insert Badge Error" type="html">
                    <cfdump var="#cfcatch#" label="cfcatch">
                    <cfdump var="#arguments#" label="arguments">
                    <cfdump var="#cgi#" label="CGI">
                </cfmail>
            </cfcatch>
            </cftry>
            
            <cfreturn true>
    	</cfif>     
    </cffunction>
    
    <cffunction name="deleteStudentBadge" returntype="boolean">
    	<cfargument name="idIn">
        <cfargument name="badgeIn">
        
        <cfquery datasource="#application.roadtoDB#">
        update gameStudentBadges
        set dateDeleted = <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and badge = <cfqueryparam value="#arguments.badgeIn#" cfsqltype="cf_sql_varchar">
          and dateDeleted is NULL
        </cfquery>
        
        <cfreturn true>
    </cffunction>      
    

	<!--- ***  adds ***  --->
        
    
    <!--- add points/badges --->
    
    <cffunction name="addItem" returntype="boolean">
    	<cfargument name="BannerID" required="yes">
        <cfargument name="code" required="yes">
        <cfargument name="detail" required="no" default="">
        
        <cfset var local = {}>
        
        <cftry>
        
        <cflock scope="session" timeout="60">
        
        
        <cfparam name="session.entryTerm" default="000000"> 
        
        <!--- kick them out if they are in the wrong term or a parent login --->
        <cfif session.entryTerm NEQ application.defaultTerm or session.parentlogin is TRUE >
        	<cfreturn false>
        </cfif>
        
        <!--- Add the to the badge queue --->
        <cfset this.addToGameQueue(arguments.bannerID)>
        
        <!--- grab the item record --->
        <cfquery name="local.getItem" datasource="#application.roadtoDB#">
        select *
        from GameItems
        where code = <cfqueryparam value="#arguments.code#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <!--- send error email if code not found --->
		<cfif local.getItem.recordCount EQ 0>
        	 <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Gamification: Code Not Found" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#arguments#" label="arguments">
                <cfdump var="#CGI#" label="CGI">
             </cfmail>
             <cfreturn false>
       	</cfif>
        
		<!--- see if there are already any items in the database for this code and student --->
        <cfquery name="local.getStudentHistory" datasource="#application.roadtoDB#">
        select *
        from GameStudent
        where bannerid = <cfqueryparam value="#arguments.BannerID#" cfsqltype="cf_sql_varchar">
          and itemCode = <cfqueryparam value="#arguments.code#" cfsqltype="cf_sql_varchar">
          <cfif getItem.detailPresent EQ '1'>
            and detail = <cfqueryparam value="#arguments.detail#" cfsqltype="cf_sql_varchar">
          </cfif>
        order by ID desc
        </cfquery>               
        
        <!--- now use some logic to see what we are inserting ---> 
        <cfswitch expression="#trim(local.getItem.type)#">
		
            <!--- handle the limited items --->
            <cfcase value="1">
                <cfif getStudentHistory.recordCount EQ 0 and session.parentlogin is FALSE >
                    <cfquery datasource="#application.roadtoDB#">
                    insert into GameStudent (BannerID, itemCode, Detail, itemDate, debug)
                    values(
                        <cfqueryparam value="#arguments.bannerID#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.code#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.detail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,
                        '1'
                    )
                    </cfquery>
                    
                    <!--- I am getting duplicates sometimes, and I need to figure out why --->
                    <!---<cfquery name="checkGameDupes" datasource="#application.RoadToDB#">
                    SELECT ItemCode, BannerID, occur
                    FROM	(SELECT ItemCode, BannerID, COUNT(ID) AS occur
                             FROM GameStudent
                             WHERE ItemCode IN	(SELECT Code
                                                 FROM GameItems
                                                 WHERE type='1' AND DetailPresent = 0)
                             GROUP BY ItemCode, BannerID) AS derivedtbl_1
                    WHERE occur > 1
                    ORDER BY BannerID
                    </cfquery>
                    
                    
                    <cfif checkGameDupes.recordcount GT 0>
                    	 <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X: Game Dupes Instant" type="html">
                            IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                            <cfdump var="#checkGameDupes#" label="checkGameDupes">
                            <cfdump var="#getStudentHistory#" label="getStudent">
                            <cfdump var="#CGI#" label="CGI">
                         </cfmail>
                    </cfif>--->
                    
                    <cfreturn true>
                <cfelse>
                	<cfreturn false>
                </cfif>
            </cfcase>
            
            <!--- handle the items that can have multiple entries --->
            <cfcase value="n">
            
        		<!--- there is no frequency limit OR the student doesn't have this yet, so just insert the record --->
				<cfif local.getItem.frequency eq '' or local.getStudentHistory.recordCount EQ 0 and session.parentlogin is FALSE>	
                	<cfquery datasource="#application.roadtoDB#">
                    insert into GameStudent (BannerID, itemCode, Detail, itemDate, debug)
                    values(
                        <cfqueryparam value="#arguments.bannerID#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.code#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.detail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,
                        'n1'
                    )
                    </cfquery>
                    
                    <cfreturn true>	
                
                <!--- There is a limit, so check it first before inserting --->
                <cfelse>
                	<cfif dateDiff(listFirst(local.getItem.frequency),local.getStudentHistory.itemdate,now()) GT listGetAt(local.getItem.frequency,2) and session.parentlogin is FALSE>
                    
                    	<cfset debug = 'n2|#local.getItem.code#|#local.getItem.type#'>
                    
                    	<cfquery datasource="#application.roadtoDB#">
                        insert into GameStudent (BannerID, itemCode, Detail, itemDate,debug)
                        values(
                            <cfqueryparam value="#arguments.bannerID#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.code#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.detail#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#debug#" cfsqltype="cf_sql_varchar">
                        )
                        </cfquery>
                        
                        <cfreturn true>
                    
                    <cfelse>
                    	<cfreturn false>
                    </cfif>
                </cfif>
			</cfcase>        
    
    	</cfswitch>
        
        </cflock>
        
        <cfcatch>
            <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu,sparkse1@xavier.edu" subject="R2X Gamification Add Item Error" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#cfcatch#" label="Catch">
                <cfdump var="#arguments#" label="Arguments">
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
    
    
    
    
    <cffunction name="addToGameQueue" returntype="boolean">
    	<cfargument name="idIn">
        
        <cfquery datasource="#application.roadtoDB#">
        insert into gameQueue (bannerID)
        values(<cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">) 
        </cfquery>
        
        <cfreturn true>
    </cffunction>
    
    
    <!--- 
	
	*** Calculators ***
	
	--->
    
    <!--- calculate points for a user --->
    <cffunction name="getPointsTotal" returntype="numeric">
    	<cfargument name="idIn">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and gamestudent.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    <cffunction name="getPointsTotal30" returntype="numeric">
    	<cfargument name="idIn">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('m',-1,now()))#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    <cffunction name="getPointsTotal14" returntype="numeric">
    	<cfargument name="idIn">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('ww',-2,now()))#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    <cffunction name="getPointsTotalCustom" returntype="numeric">
    	<cfargument name="idIn">
        <cfargument name="dateStart">
        <cfargument name="dateEnd">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and itemDate > <cfqueryparam value="#createODBCDateTime(arguments.dateStart)#" cfsqltype="cf_sql_timestamp">
          and itemDate < <cfqueryparam value="#createODBCDateTime(arguments.dateEnd)#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    
       <cffunction name="getPointsTotalChallengeDate" returntype="numeric">
    	<cfargument name="idIn">
        <cfargument name="dateStart">
        <cfargument name="dateEnd">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and itemDate > <cfqueryparam value="#createODBCDateTime(arguments.dateStart)#" cfsqltype="cf_sql_timestamp">
          and itemDate < <cfqueryparam value="#createODBCDateTime(arguments.dateEnd)#" cfsqltype="cf_sql_timestamp">
          and itemDate > (  select min(dateAdded) from gameStudentBadges 
          					where dateDeleted is null
                              and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
                             )
        </cfquery>
        
        
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    
    
    
    
     <cffunction name="getPointsTotalChallengeMarch" returntype="numeric">
    	<cfargument name="idIn">
        <cfargument name="dateStart">
        <cfargument name="dateEnd">
        <cfargument name="badgeIn">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and itemDate > <cfqueryparam value="#createODBCDateTime(arguments.dateStart)#" cfsqltype="cf_sql_timestamp">
          and itemDate < <cfqueryparam value="#createODBCDateTime(arguments.dateEnd)#" cfsqltype="cf_sql_timestamp">
          and itemDate > (  select min(dateAdded) from gameStudentBadges 
          					where  bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
                              and badge = <cfqueryparam value="#arguments.badgeIn#" cfsqltype="cf_sql_varchar">)
        </cfquery>
        
        
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    
    
    
    
    <cffunction name="getPointsTotalChallenge" returntype="numeric">
    	<cfargument name="idIn">
        <cfargument name="dateStart">
        <cfargument name="dateEnd">
        <cfargument name="badgeIn">
        
    	<cfquery name="getPointsTotalQuery" datasource="#application.roadtoDB#">
        select sum(primaryValue) as total
        from gameStudent join gameItems on itemCode = code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and itemDate > <cfqueryparam value="#createODBCDateTime(arguments.dateStart)#" cfsqltype="cf_sql_timestamp">
          and itemDate < <cfqueryparam value="#createODBCDateTime(arguments.dateEnd)#" cfsqltype="cf_sql_timestamp">
          and itemDate > (  select min(dateAdded) from gameStudentBadges 
          					where dateDeleted is null
                              and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
                              and badge = <cfqueryparam value="#arguments.badgeIn#" cfsqltype="cf_sql_varchar">)
        </cfquery>
        
        
        
        <cfif isValid('integer',getPointsTotalQuery.total)>
        	<cfreturn getPointsTotalQuery.total>
        <cfelse>
        	<cfreturn 0>
        </cfif>
    </cffunction>
    
    <!--- get query of student badges --->
    <cffunction name="getStudentBadges" returntype="query">
    	<cfargument name="idIn">
        
        <cfquery name="getBadges" datasource="roadtoDB">
        select badge, dateAdded, name, description, type
        from gameStudentBadges join gameBadges on gameStudentBadges.badge = gamebadges.code
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and dateDeleted is null
        order by dateAdded
        </cfquery>
        
        
        <cfreturn getBadges>
    </cffunction>
    
    
    <!--- get query of student items --->
    <cffunction name="getStudentItems" returntype="query">
    	<cfargument name="idIn">
        
        <cfquery name="getItems" datasource="roadtoDB">
        select distinct itemCode
        from gameStudent
        where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
          and gamestudent.itemDate > <cfqueryparam value="#application.game_start#" cfsqltype="cf_sql_timestamp">
        </cfquery>
        
        <cfreturn getItems>
    </cffunction>
    
    <!--- return the top header badge, if they have one --->
    
    <cffunction name="getHeaderBadge" returntype="string">
    	<cfargument name="idIn">
        
        <cfset headerOrder = 'currentStudent,dartagnan,blueblob,minidartagnan,miniblueblob,microdartagnan,microblueblob,nanodartagnan,nanoblueblob,ambassador'>
        
        <cfset currentbadges = getStudentbadges(arguments.idIn)>
        
        <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="Quick Email" type="html">
            IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
            <cfdump var="#arguments#">
            <cfdump var="#currentBadges#">
            <cfdump var="#CGI#" label="CGI">
        </cfmail>--->

        
        <cfloop list="#headerOrder#" index="badger">
        
        	<!--- see if they have the current badge --->
            <cfloop query="currentBadges">
           		<cfif left(currentBadges.badge,6) EQ left(badger,6)>
                	<cfreturn badger>
                </cfif>
           	</cfloop>
        </cfloop>
        
        <cfreturn 'none'>
    
    </cffunction>
    
    <!--- set leader badges --->
    <cffunction name="setLeaderBadges" returntype="void">
    	
        <cftry>
        
        <cfset overallLeadersArray = this.getLeaderData('overall').data>
		<cfset overallLeaders30Array = this.getLeaderData('overall30').data>
        <cfset overallLeaders14Array = this.getLeaderData('overall14').data>
        <cfset overallLosersArray = this.getLeaderData('overallLosers').data>
		<cfset stateStruct = this.getLeaderData('state')>
        
        <!--- These are done in order, so we can check related badges --->
        
        <!--- *** set d'artagnan *** --->
        <!--- get the current dartagnan --->
        <cfquery name="currentDart" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='dartagnan' and dateDeleted is null
        </cfquery>
        
        <cftry>
			<cfset newDart = overallLeadersArray[1][1]>
		<cfcatch>
			<cfset newDart = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentDart.recordCount GT 0>
        	<cfif currentDart.bannerID NEQ newDart>
            	<cfset this.setStudentBadge(newDart,'dartagnan')>
                <cfset this.deleteStudentBadge(currentDart.bannerID,'dartagnan')>
                
                <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X: Dart Change Email" type="html">
                    IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                    <p>Old Dart: #currentDart.bannerID#</p>
                    <p>New Dart: #newDart#</p>
                    <cfdump var="#CGI#" label="CGI">
                </cfmail>

            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newDart,'dartagnan')>
        </cfif>
        
        <!--- *** Set Blue Blob *** --->
        <cfquery name="currentBlob" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='blueblob' and dateDeleted is null
        </cfquery>
        
        <cftry>
			<cfset newBlob = overallLeadersArray[2][1]>
		<cfcatch>
			<cfset newBlob = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentBlob.recordCount GT 0>
        	<cfif currentBlob.bannerID NEQ newBlob>
            	<cfset this.setStudentBadge(newBlob,'blueblob')>
                <cfset this.deleteStudentBadge(currentBlob.bannerID,'blueblob')>
                
                <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X: Blob Change Email" type="html">
                    IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                    <p>Old Blob: #currentBlob.bannerID#</p>
                    <p>New Blob: #newBlob#</p>
                    <cfdump var="#CGI#" label="CGI">
                </cfmail>

            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newBlob,'blueblob')>
        </cfif>
        
        <!--- *** Set the Mini Dart *** --->
        <!--- get the current dartagnan --->
        <cfquery name="currentDart" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='minidartagnan' and dateDeleted is null
        </cfquery>
        
        <!--- get the current excludes --->
        <cfquery name="getExcludes" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge in ('dartagnan','blueblob') and dateDeleted is null
        </cfquery>
        
        <cftry>
			<cfloop from="1" to="10" index="i">
				<!--- see if the newDart is in the exclude list --->
				<cfquery name="checkExclude" dbtype="query">
				select bannerid from getExcludes where bannerID = '#overallLeaders30Array[i][1]#'
				</cfquery>
				
				<cfif checkExclude.recordCount EQ 0>
					<cfset newDart = overallLeaders30Array[i][1]>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfcatch>
			<cfset newDart = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentDart.recordCount GT 0>
        	<cfif currentDart.bannerID NEQ newDart>
            	<cfset this.setStudentBadge(newDart,'minidartagnan')>
				<cfset this.deleteStudentBadge(currentDart.bannerID,'minidartagnan')>
            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newDart,'minidartagnan')>
        </cfif>
        
        <!--- *** Set the Micro Dart *** --->
        <!--- get the current dartagnan --->
        <cfquery name="currentDart" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='microdartagnan' and dateDeleted is null
        </cfquery>
        
        <!--- get the current excludes --->
        <cfquery name="getExcludes" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge in ('dartagnan','blueblob','minidartagnan') and dateDeleted is null
        </cfquery>
        
		<cftry>
			<cfloop from="1" to="10" index="i">
				<!--- see if the newDart is in the exclude list --->
				<cfquery name="checkExclude" dbtype="query">
				select bannerid from getExcludes where bannerID = '#overallLeaders14Array[i][1]#'
				</cfquery>
				
				<cfif checkExclude.recordCount EQ 0>
					<cfset newDart = overallLeaders14Array[i][1]>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfcatch>
			<cfset newDart = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentDart.recordCount GT 0>
        	<cfif currentDart.bannerID NEQ newDart>
            	<cfset this.setStudentBadge(newDart,'microdartagnan')>
                <cfset this.deleteStudentBadge(currentDart.bannerID,'microdartagnan')>
            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newDart,'microdartagnan')>
        </cfif>
        
        <!--- *** Set the Mini Blob *** --->
        <!--- get the current blueblob --->
        <cfquery name="currentBlob" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='miniblueblob' and dateDeleted is null
        </cfquery>
        
        <!--- get the current excludes --->
        <cfquery name="getExcludes" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge in ('dartagnan','blueblob','minidartagnan','microdartagnan') and dateDeleted is null
        </cfquery>

		<cftry>        
			<cfloop from="1" to="10" index="i">
				<!--- see if the newBlob is in the exclude list --->
				<cfquery name="checkExclude" dbtype="query">
				select bannerid from getExcludes where bannerID = '#overallLeaders30Array[i][1]#'
				</cfquery>
	
				
				<cfif checkExclude.recordCount EQ 0>
					<cfset newBlob = overallLeaders30Array[i][1]>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfcatch>
			<cfset newBlob = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentBlob.recordCount GT 0>
        	<cfif currentBlob.bannerID NEQ newBlob>
            	<cfset this.setStudentBadge(newBlob,'miniblueblob')>
                <cfset this.deleteStudentBadge(currentBlob.bannerID,'miniblueblob')>
            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newBlob,'miniblueblob')>
        </cfif>
        
        <!--- *** Set the Micro Blob *** --->
        <!--- get the current blueblob --->
        <cfquery name="currentBlob" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='microblueblob' and dateDeleted is null
        </cfquery>
        
        <!--- get the current excludes --->
        <cfquery name="getExcludes" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge in ('dartagnan','blueblob','minidartagnan','microdartagnan','miniblueblob') and dateDeleted is null
        </cfquery>
        
		<cftry>
			<cfloop from="1" to="10" index="i">
				<!--- see if the newBlob is in the exclude list --->
				<cfquery name="checkExclude" dbtype="query">
				select bannerid from getExcludes where bannerID = '#overallLeaders14Array[i][1]#'
				</cfquery>
				
				<cfif checkExclude.recordCount EQ 0>
					<cfset newBlob = overallLeaders14Array[i][1]>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfcatch>
			<cfset newBlob = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentBlob.recordCount GT 0>
        	<cfif currentBlob.bannerID NEQ newBlob>
            	<cfset this.setStudentBadge(newBlob,'microblueblob')>
                <cfset this.deleteStudentBadge(currentBlob.bannerID,'microblueblob')>
            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newBlob,'microblueblob')>
        </cfif>
        
        <!--- *** Set the Nano Dart *** --->
        <!--- get the current nanodartagnan --->
        <cfquery name="currentDart" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='nanodartagnan' and dateDeleted is null
        </cfquery>
        
        <cftry>
			<cfset newDart = overallLosersArray[1][1]>
		<cfcatch>
			<cfset newDart = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentDart.recordCount GT 0>
        	<cfif currentDart.bannerID NEQ newDart>
            	<cfset this.setStudentBadge(newDart,'nanodartagnan')>
                <cfset this.deleteStudentBadge(currentDart.bannerID,'nanodartagnan')>
            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newDart,'nanodartagnan')>
        </cfif>
        
        <!--- *** Set the Nano Blob *** --->
        <!--- get the current nanoblueblob --->
        <cfquery name="currentBlob" datasource="#application.roadtoDB#">
        select bannerid from gameStudentBadges where badge='nanoblueblob' and dateDeleted is null
        </cfquery>
        
        <cftry>
			<cfset newBlob = overallLosersArray[2][1]>
		<cfcatch>
			<cfset newBlob = '000300001'>
		</cfcatch>
		</cftry>
        
        <cfif currentBlob.recordCount GT 0>
        	<cfif currentBlob.bannerID NEQ newBlob>
            	<cfset this.setStudentBadge(newBlob,'nanoblueblob')>
                <cfset this.deleteStudentBadge(currentBlob.bannerID,'nanoblueblob')>
            </cfif>
        <cfelse>
        	<cfset this.setStudentBadge(newBlob,'nanoblueblob')>
        </cfif>
        
        <!--- *** set ambasador *** --->
        <!---<cfset stateList = 'AK,AL,AR,AZ,CA,CO,CT,DC,DE,FL,GA,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VA,VT,WA,WI,WV,WY'>--->
        <cfset ambassadorList = ''>
        
        <cfloop list="#application.stateList#" index="singleState">
        	
            <!--- get the ID of the new ambassador --->
            <cfif structKeyExists(stateStruct,singleState)>
            	<cfset stateValue = structFind(stateStruct,singleState)>
                
                <!--- add the ID to the ambassador list --->
                <cfset ambassadorList = listAppend(ambassadorList,listGetAt(stateValue,2))>
                
                <!--- see if the current student has the ambassdor badge --->
                <cfset currentBadges = this.getStudentBadges(listGetAt(stateValue,2))>
                
                <cfset hasAmbassador = false>
                
                <cfloop query="currentBadges">
                	<cfif currentbadges.badge EQ 'ambassador'>
                    	<cfset hasAmbassador = true>
                   	</cfif>
                </cfloop>
                
                <!--- if they don't have ambassador, give it to them --->
                <cfif not hasAmbassador>
                	<cfset this.setStudentBadge(listGetAt(stateValue,2),'ambassador')>
                </cfif>
        	</cfif>        
        </cfloop>
        
        
        <!--- now clear out the old badges --->
        <!--- first, grab the people who will be removed --->
        <cfquery name="getOld" datasource="#application.roadtoDB#">
        select bannerid
        from gameStudentBadges
        where badge = 'ambassador'
          and bannerid not in ('a',<cfloop list="#ambassadorList#" index="amb">'#amb#',</cfloop>'b')
          and dateDeleted is null
        </cfquery>
        
        <cfif getOld.recordCount GT 0>
            
            <!--- remove the old ones --->
            <cfloop query="getOld">
            	<cfset this.deleteStudentBadge(getOld.bannerID,'ambassador')>
            </cfloop>	
            
        </cfif>
        
        <cfcatch>
        	<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X: Set Game Leaders Error" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#cfcatch#" label="Catch">
                <cfdump var="#variables#" label="Variables">
                <cfdump var="#session#" label="Session">
                <cfdump var="#application#" label="Application">
                <cfdump var="#form#" label="Form">
                <cfdump var="#cgi#" label="CGI">
            </cfmail>
        </cfcatch>
        </cftry>
         
        
   	</cffunction>
        
    <!--- set individual badges --->
    <cffunction name="setBadges" returntype="void">
    	<cfargument name="idIn">    
        
        <cftry>
        
        <!--- *** Get Some Basics *** ---> 
        <cfset currentBadges = this.getStudentBadges(arguments.idIn)>
        <cfset currentPoints = this.getPointsTotal(arguments.idIn)>
        <cfset currentItems = this.getStudentItems(arguments.idIn)>
        
        <cfquery name="getStudentInfo" datasource="#application.roadtoDB#">
        select *
        from bannerstudent left join student on bannerstudent.bannerid = student.bannerid
        where bannerstudent.bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        
        <!--- *** set the experience level badges *** --->
        <cfquery name="getLevelBadge" dbtype="query">
        select badge from currentBadges where type='level'
        </cfquery>
        
        <cfif getLevelBadge.recordCount EQ 0>
        	<cfset this.setStudentBadge(arguments.idIn,'novice')>
        <cfelse>
        	<cfif getLevelBadge.badge EQ 'novice' and currentPoints GE application.experiencedPoints and currentPoints LE application.expertPoints>
            	<cfset this.setStudentBadge(arguments.idIn,'experienced')>
                <cfset this.deleteStudentBadge(arguments.idIn,'novice')>
            <cfelseif getLevelBadge.badge EQ 'experienced' and currentPoints GE application.expertPoints and currentPoints LE application.uberexpertPoints>
            	<cfset this.setStudentBadge(arguments.idIn,'expert')>
                <cfset this.deleteStudentBadge(arguments.idIn,'novice')>
                <cfset this.deleteStudentBadge(arguments.idIn,'experienced')>
            <cfelseif getLevelBadge.badge EQ 'expert' and currentPoints GE application.uberexpertPoints>
            	<cfset this.setStudentBadge(arguments.idIn,'uberexpert')>
                <cfset this.deleteStudentBadge(arguments.idIn,'novice')>
                <cfset this.deleteStudentBadge(arguments.idIn,'experienced')>
                <cfset this.deleteStudentBadge(arguments.idIn,'expert')>
            </cfif> 
        </cfif>	
        
        <!--- April Fools --->        
		<!--- look up each page in the database --->
	  
	  <cfif dateCompare(now(),application.april_fools_badge) GT 0>
        
<!---
        <cfquery name="checkView" datasource="#application.roadtodb#">
        select ID
        from gameStudent
        where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> 
          and detail = <cfqueryparam value="/about/x-men.cfm" cfsqltype="cf_sql_varchar">
        </cfquery>
--->
       
            
<!---         <cfif checkView.recordcount GT 0> --->
<!---             <cfset this.setStudentBadge(arguments.idIn,'AprilFools')> --->
<!---         </cfif> --->
        
	  </cfif>  
        
        <!--- bookworm --->
        <cfif dateCompare(now(),application.bookworm_start) GT 0>
            <cfquery name="getBooks" datasource="#application.roadtoDB#">
            select bannerID
            from favorites
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and favBooks1 <> ''
              and favBooks2 <> ''
              and favBooks3 <> ''
            </cfquery>      
            
            <cfif getBooks.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'bookworm')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'bookworm')>
            </cfif> 
        </cfif>
        
        <!--- challenge-feb --->
        <cfif now() GE application.x_challenge_feb_start and now() LE application.x_challenge_feb_end>
        
        	<cfparam name="hasphoto" default="false">
        
        		
        	<cfquery name="getStudent" datasource="#application.roadtoDB#">
            select biography, videoLink from student
            where  bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
            </cfquery>
        	
            <cfquery name="checkInterests" datasource="#application.roadtoDB#">
            select BannerID from student_interest
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
            </cfquery>
            
            <cfquery name="checkPageViews" datasource="#application.roadtoDB#">
             select count(id) as pageCount from GameStudent where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> and itemCode='Pview' and Detail != <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
            </cfquery>
            
        
        	<!--- look up each page in the database --->
            <!---<cfset pageList = 'academics,advantage,study-abroad,jesuit-identity,cincinnati'>--->
           	<!---<cfset counter = 0>--->
            
            
            <!---<cfloop list="#pageList#" index="page">
            	<cfquery name="checkView" datasource="#application.roadtodb#">
                select ID
                from gameStudent
                where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> 
                  and detail like <cfqueryparam value="%#page#%" cfsqltype="cf_sql_varchar">
                </cfquery>
           
           		<cfif checkView.recordCount GT 0>
                	<cfset counter += 1>
                </cfif>
            </cfloop>--->
            
            
            
            <cfloop index="i" from="1" to="4" >
                 <!--- Check to see if user's image exists --->
                <cfif FileExists("\\nocwebvfs\webcontent\roadto\Live\imagespoc\profilepics-lrg\lrg-#session.securityManager.encryptID(arguments.idIn)#-#i#.jpg")>
                    <cfset hasPhoto = true>
                    <cfset i=5>
                </cfif>
            </cfloop>
            
            
             <cfquery name="getFAFSA" datasource="#application.roadtoDB#">
			 	select count(bannerid) as count from GameStudent  where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
			 	and itemCode='FAFSA-Fact'
 			 </cfquery>
                
                
                
                
            <cfif len(trim(getStudent.biography)) GE 5 and checkInterests.recordCount GE 3 and checkPageViews.pageCount GE 3 and (isvalid('url',trim(getStudent.videoLink)) OR hasphoto) 
			and getFAFSA.count gt 0 >
            
              <cfset this.setStudentBadge(arguments.idIn,'challenge_feb')>
    
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'challenge_feb')>
            </cfif>
            
            
            
        </cfif>
        
        <!--- challenge-jan --->
        <cfif now() GE application.x_challenge_jan_start and now() LE application.x_challenge_jan_end>
        
        	<cfquery name="getStudent" datasource="#application.roadtoDB#">
            select biography, videoLink from student
            where  bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
            </cfquery>
            
            <cfquery name="checkInterests" datasource="#application.roadtoDB#">
            select BannerID from student_interest
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
            </cfquery>
                
            <cfif len(trim(getStudent.biography)) GE 5 and checkInterests.recordCount GE 3 and isvalid('url',trim(getStudent.videoLink))>
                <cfset this.setStudentBadge(arguments.idIn,'challenge_jan')>   
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'challenge_jan')>
            </cfif>
            
            
        </cfif>
        
        <!--- challenge-mar --->
        <cfif now() GE application.x_challenge_mar_start and now() LE application.x_challenge_mar_end>
           
           	<cfset inMarChallenge = FALSE >
           

			   <cfquery name="findChallengePic" datasource="#application.roadtoDB#" >
                 select * from RoadToXavier.dbo.GameStudent WHERE 
                BannerID= <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> 
                and itemDate >= '#application.x_challenge_mar_start#' and itemDate < '#application.x_challenge_mar_end#' 
                and ( ItemCode='PpicUpdatefirst' or ItemCode='PpicUpdateSubsequent') 
            </cfquery>

			 <cfquery name="findProfileUpdate" datasource="#application.roadtoDB#" >
                select * from RoadToXavier.dbo.GameStudent WHERE ( ItemCode='PupdateFirst' or ItemCode='PupdateSubsequent')  
                and BannerID= <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
                and itemDate >= '#application.x_challenge_mar_start#' and itemDate < '#application.x_challenge_mar_end#' 
            </cfquery>
            
            
             <cfquery name="checkPageViews" datasource="#application.roadtoDB#">
             select count(id) as pageCount from GameStudent where bannerID = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> and 
             itemCode='Pview' and Detail != <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">  
             and itemDate >= '#application.x_challenge_mar_start#' and itemDate < '#application.x_challenge_mar_end#'
            </cfquery>

			<cfquery name="checkInterests" datasource="#application.roadtoDB#">
            	select BannerID from student_interest
				where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
            </cfquery>


			<cfquery name="InterestLookup" datasource="#application.roadtoDB#" >
                select studentID from RoadToXavier.dbo.StudentTracker WHERE 
                studentID= <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> 
                and statDate >= '#application.x_challenge_mar_start#' and statDate < '#application.x_challenge_mar_end#' 
                and script_name = <cfqueryparam  CFSQLType="CF_SQL_VARCHAR" value="/profile/findmatches.cfm">
            </cfquery>


			
			<cfif isvalid('url',getStudentInfo.instagramLink) or isvalid('url',getStudentInfo.facebookLink) or isvalid('url',getStudentInfo.twitterLink) >
				<cfset socialLinks = TRUE >
				<cfelse>
				<cfset socialLinks = FALSE >
           	</cfif>   
	           
           <cfif findChallengePic.recordcount gt 0 AND findProfileUpdate.recordcount gt 0 AND checkPageViews.pageCount GTE 5
           		 AND checkInterests.recordcount GTE 5 AND InterestLookup.recordcount GT 0 AND socialLinks is TRUE > 
	           	
	           		<cfset inMarChallenge = TRUE >	
	           		 
           </cfif>
			
        
			<cfif inMarChallenge is TRUE >
				
				
                <cfset this.setStudentBadge(arguments.idIn,'challenge_mar')>
    
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'challenge_mar')>
            </cfif>

            
        </cfif>
        
        
        
        <!--- challenge-apr --->
        
        <cfif (now() GE application.x_challenge_apr_start and now() LE application.x_challenge_apr_end)>
        
        <!---  <cfquery name="checkTest" datasource="#application.roadtodb#">
            select ID
            from gameStudent
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> 
              and itemCode = <cfqueryparam value="processWebsiteNavigationTest" cfsqltype="cf_sql_varchar">
            </cfquery> --->


            <cfquery name="findChallengePic" datasource="#application.roadtoDB#" >
                select * from RoadToXavier.dbo.GameStudent WHERE 
                BannerID= <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar"> and itemDate >= '#application.x_challenge_apr_start#' and itemDate < '#application.x_challenge_apr_end#' and ( ItemCode='PpicUpdatefirst' or ItemCode='PpicUpdateSubsequent') 
            </cfquery>


        
			<cfif findChallengePic.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'challenge_apr')>
    
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'challenge_apr')>
            </cfif>
            
        </cfif>
        
        
        
         <!--- challenge-apr --->
           
<!---
         	<cfif (now() GE application.x_challenge_apr_start and now() LE application.x_challenge_apr_end)>




         	</cfif>
--->
        
        
        
        <!--- christmas --->
        <cfif dateCompare(now(),dateAdd('h',-6,application.christmas_badge)) GT 0 and dateCompare(now(),dateAdd('h',27,application.christmas_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'christmas')>
        </cfif>
       
        
        
        <!--- couch potato --->
        <cfif dateCompare(now(),structFind(application,'couch_potato_start')) GT 0>
            <cfquery name="getShows" datasource="#application.roadtoDB#">
            select bannerID
            from favorites
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and favShows1 <> ''
              and favShows2 <> ''
              and favShows3 <> ''
            </cfquery>      
            
            <cfif getShows.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'couch_potato')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'couch_potato')>
            </cfif>
        </cfif>
        
        <!--- currentStudent --->
        <cfif getStudentInfo.ambassador EQ 'Y'>
        	<cfset this.setStudentBadge(arguments.idIn,'currentStudent')>
            <cfset this.deleteStudentBadge(arguments.idIn,'headedToXavier')>
		<cfelse>
			<cfset this.deleteStudentBadge(arguments.idIn,'currentStudent')>
        </cfif>
        
        <!--- easter --->
        <cfif dateCompare(now(),application.easter_badge) GT 0 and dateCompare(now(),dateAdd('h',27,application.easter_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'easter')>
        </cfif>
        
        <!--- facebook --->
        <cfif dateCompare(now(),application.facebook_badge) GT 0>
			<cfif isvalid('url',getStudentInfo.facebookLink)>
                <cfset this.setStudentBadge(arguments.idIn,'facebook')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'facebook')>
            </cfif>
        </cfif> 
        
        <!--- frequent --->
        <!--- awarded to students who have visited at least once per week for the last three weeks --->
        <cfquery name="oneWeek" datasource="#application.roadtoDB#">
        select ID from gameStudent
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp">
          and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfquery name="twoWeek" datasource="#application.roadtoDB#">
        select ID from gameStudent
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-14,now()))#" cfsqltype="cf_sql_timestamp">
          and itemDate < <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp">
          and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfquery name="threeWeek" datasource="#application.roadtoDB#">
        select ID from gameStudent
        where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-21,now()))#" cfsqltype="cf_sql_timestamp">
          and itemDate < <cfqueryparam value="#createODBCDateTime(dateAdd('d',-14,now()))#" cfsqltype="cf_sql_timestamp">
          and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif oneWeek.recordCount GT 0 and twoWeek.recordCount GT 0 and threeWeek.recordCount GT 0>
			<cfset this.setStudentBadge(arguments.idIn,'frequent')>
        <cfelse>
			<!---<cfset this.deleteStudentBadge(arguments.idIn,'frequent')>--->
        </cfif>
        
        <!--- gamer --->
        <cfif dateCompare(now(),application.gamer_start) GT 0>
            <cfquery name="getGames" datasource="#application.roadtoDB#">
            select bannerID
            from favorites
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and favGames1 <> ''
              and favGames2 <> ''
              and favGames3 <> ''
            </cfquery>      
            
            <cfif getGames.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'gamer')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'gamer')>
            </cfif>
        </cfif>
        
        <!--- Groundhog Day --->
        <cfif dateCompare(now(),application.groundhog_start) GT 0 and dateCompare(now(),dateAdd('h',27,application.groundhog_start)) LT 0>
			<cfset badgeList = ''>
            <cfloop query="currentbadges"><cfset badgeList= listappend(badgeList,currentbadges.badge)></cfloop>
            
            <cfset badgeList = listSort(badgelist,'text','desc')>
			
            <cfloop list="#badgeList#" index="badge">
            	<cfif left(badge,12) EQ 'GroundhogDay'>
                	<cfif badge NEQ 'GroundhogDay6'>
                    	<cfif badge EQ 'GroundhogDay'>
                        	<cfset badgeNumber = 1>
                        <cfelse>
                        	<cfset badgeNumber = right(badge,1)>
                        </cfif>
						
						<!--- see when they got the groundhog day badge --->
                        <cfquery name="getGHDB" dbtype="query">
                        select dateAdded from currentBadges where badge = '#badge#'
                        </cfquery>
                        
                        <cfset base = 1>
                        <cfloop from="1" to="#badgeNumber#" index="i">
                        	<cfset base = base * 2>
                        </cfloop>
                            
                        <cfset minuteComp = badgeNumber * 1 * base>
                    
						<cfif dateDiff('n',getGHDB.dateAdded,now()) GT minuteComp>
							<cfset this.setStudentBadge(arguments.idIn,'GroundhogDay#badgeNumber + 1#')>
                        </cfif>
        			</cfif>
        		
					<cfbreak>
                
				<!--- initial assignment --->
                <cfelse>
                	<cfset this.setStudentBadge(arguments.idIn,'GroundhogDay')>
                </cfif>
        	</cfloop>
        </cfif>

        
        <!--- headedToXavier --->
        <cfif getStudentInfo.xstatus EQ '1' and getStudentInfo.ambassador NEQ 'Y'>
        	<cfset this.setStudentBadge(arguments.idIn,'headedToXavier')>
		<cfelse>
			<cfset this.deleteStudentBadge(arguments.idIn,'headedToXavier')>
        </cfif> 
        
        <!--- Independence Day --->
        <cfif dateCompare(now(),application.independenceDay_badge) GT 0 and dateCompare(now(),dateAdd('h',27,application.independenceDay_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'independenceDay')>
        </cfif>
       
        <!--- instagram --->
        <cfif dateCompare(now(),application.instagram_badge) GT 0>
			<cfif isvalid('url',getStudentInfo.instagramLink)>
                <cfset this.setStudentBadge(arguments.idIn,'instagram')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'instagram')>
            </cfif>
        </cfif>
        
        <!--- mobile --->
        <cfif dateCompare(now(),application.mobile_start) GT 0>
			<!--- awarded to students who have visited the mobile site at least once per week for the last two weeks --->
            <cfquery name="oneWeek" datasource="#application.roadtoDB#">
            select statDate from studentTracker
            where statDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp">
              and studentid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and site = 'mobile'
            </cfquery>
            
            <cfquery name="twoWeek" datasource="#application.roadtoDB#">
            select statDate from studentTracker
            where statDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-14,now()))#" cfsqltype="cf_sql_timestamp">
              and statDate < <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp">
              and studentid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and site = 'mobile'
            </cfquery>
            
            <cfif oneWeek.recordCount GT 0 and twoWeek.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'mobile')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'mobile')>
            </cfif>
        </cfif> 
        
        <!--- movie_lover --->
        <cfif dateCompare(now(),structFind(application,'movie_lover_start')) GT 0>
			<!--- awarded to students who have visited the mobile site at least once per week for the last two weeks --->
            <cfquery name="getMovies" datasource="#application.roadtoDB#">
            select bannerID
            from favorites
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and favMovies1 <> ''
              and favMovies2 <> ''
              and favMovies3 <> ''
            </cfquery>      
            
            <cfif getMovies.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'movie_lover')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'movie_lover')>
            </cfif>
        </cfif> 
        
        <!--- new year's --->
        <cfif dateCompare(now(),dateAdd('h',-6,application.newyears_badge)) GT 0 and dateCompare(now(),dateAdd('h',27,application.newyears_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'newyears')>
        </cfif>
        
        <!--- night owl --->
        <cfif dateCompare(now(),structFind(application,'night_owl_start')) GT 0>
			<!--- awarded to students who have visited late at night at least once per week for the last three weeks --->
            <cfquery name="oneWeek" datasource="#application.roadtoDB#">
            select ID from gameStudent
            where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp">
              and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              AND (DATEPART(hh, ItemDate) IN (23,0,1,2))
            </cfquery>
            
            <cfquery name="twoWeek" datasource="#application.roadtoDB#">
            select ID from gameStudent
            where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-14,now()))#" cfsqltype="cf_sql_timestamp">
              and itemDate < <cfqueryparam value="#createODBCDateTime(dateAdd('d',-7,now()))#" cfsqltype="cf_sql_timestamp">
              and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              AND (DATEPART(hh, ItemDate) IN (23,0,1,2))
            </cfquery>
            
            <cfquery name="threeWeek" datasource="#application.roadtoDB#">
            select ID from gameStudent
            where itemDate > <cfqueryparam value="#createODBCDateTime(dateAdd('d',-21,now()))#" cfsqltype="cf_sql_timestamp">
              and itemDate < <cfqueryparam value="#createODBCDateTime(dateAdd('d',-14,now()))#" cfsqltype="cf_sql_timestamp">
              and bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              AND (DATEPART(hh, ItemDate) IN (23,0,1,2))
            </cfquery>
            <cfif oneWeek.recordCount GT 0 and twoWeek.recordCount GT 0 and threeWeek.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'night_owl')>
            <cfelse>
                <!---<cfset this.deleteStudentBadge(arguments.idIn,'night_owl')>--->
            </cfif>
        </cfif>      
        
        
		<!--- photogenic --->
        <cfif dateCompare(now(),application.photogenic_start) GT 0>
			<cfset hasPhoto = false>
            <cfloop index="i" from="1" to="4" >
                <!--- Check to see if user's image exists --->
                <cfif FileExists("\\nocwebvfs\webcontent\roadto\Live\imagespoc\profilepics-lrg\lrg-#session.securityManager.encryptID(arguments.idIn)#-#i#.jpg")>
                    <cfset hasPhoto = true>
                    <cfset i=5>
                </cfif>
            </cfloop>
            <cfif hasPhoto><cfset this.setStudentBadge(arguments.idIn,'photogenic')><cfelse><cfset this.deleteStudentBadge(arguments.idIn,'photogenic')></cfif>
        </cfif>
        
        <!--- rock_on --->
        <cfif dateCompare(now(),structFind(application,'rock_on_start')) GT 0>
            <cfquery name="getBands" datasource="#application.roadtoDB#">
            select bannerID
            from favorites
            where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar">
              and favBands1 <> ''
              and favBands2 <> ''
              and favBands3 <> ''
            </cfquery>      
            
            <cfif getBands.recordCount GT 0>
                <cfset this.setStudentBadge(arguments.idIn,'rock_on')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'rock_on')>
            </cfif>
        </cfif>
        
        <!--- social --->
        <cfquery name="getFriends" datasource="#application.roadtodb#">
        select *
        from friend
        where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar" maxlength="9">
        </cfquery>
        <cfif getFriends.recordCount GE 5><cfset this.setStudentBadge(arguments.idIn,'social')><cfelse><cfset this.deleteStudentBadge(arguments.idIn,'social')></cfif>
        
        <!--- St. Patrick's Day --->
        <cfif dateCompare(now(),application.StPatrick_badge) GT 0 and dateCompare(now(),dateAdd('h',27,application.StPatrick_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'StPatricksDay')>
        </cfif>
        
        <!--- thanksgiving --->
        <cfif dateCompare(now(),application.thanksgiving_badge) GT 0 and dateCompare(now(),dateAdd('h',27,application.thanksgiving_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'thanksgiving')>
        </cfif>
        
        
           <!--- super bowl --->
        <cfif dateCompare(now(),application.SuperBowl_badge) GT 0 and dateCompare(now(),dateAdd('h',9,application.SuperBowl_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'SuperBowl')>
        </cfif>

            
         <!--- sweet16 --->
        <cfif dateCompare(now(),application.Sweet16_badge) GT 0 and dateCompare(now(),dateAdd('h',25,application.Sweet16_badge)) LT 0>
            <cfset this.setStudentBadge(arguments.idIn,'Sweet16')>
        </cfif>

        
        <!--- twitter --->
        <cfif dateCompare(now(),application.twitter_badge) GT 0>
	        
			<cfif isvalid('url',getStudentInfo.twitterLink)>
                <cfset this.setStudentBadge(arguments.idIn,'twitter')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'twitter')>
            </cfif>
            
        </cfif>
        
        <!--- valentines's day --->
        <cfif dateCompare(now(),application.valentines_badge) GT 0 and dateCompare(now(),dateAdd('h',27,application.valentines_badge)) LT 0>
			<cfset this.setStudentBadge(arguments.idIn,'ValentinesDay')>
        </cfif>
        
        
        <!--- video --->
        <cfif dateCompare(now(),application.video_start) GT 0>
			<cfif isvalid('url',getStudentInfo.videoLink)>
                <cfset this.setStudentBadge(arguments.idIn,'video')>
            <cfelse>
                <cfset this.deleteStudentBadge(arguments.idIn,'video')>
            </cfif>
        </cfif>         
        
        <cfcatch>
            <cfmail from="lieslandr@xavier.edu" to="sparkse1@xavier.edu" subject="R2X: Gamification Set Badges Error" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#cfcatch#" label="Catch">
                <cfdump var="#arguments#" label="Arguments">
                <cfdump var="#variables#" label="Variables">
                <cfdump var="#session#" label="Session">
                <cfdump var="#application#" label="Application">
                <cfdump var="#form#" label="Form">
                <cfdump var="#cgi#" label="CGI">
                <cfdump var="#server#" label="server">
            </cfmail>
        </cfcatch>
        </cftry>
        
    
    </cffunction>
    
    <!--- 
	
	*** Display Functions ***
	
	--->
    
    <cffunction name="displayBadgeNotes" returntype="string">
    	<cfargument name="idIn">
        <cfargument name="opening">
        <cfargument name="closing">
        
        <!--- get the notes for the person --->
        <cfquery name="getNotes" datasource="#application.roadtoDB#">
        select note
        from gameStudentBadges
        where bannerid = <cfqueryparam value="#arguments.idIn#" cfsqltype="cf_sql_varchar" maxlength="9">
          and note is not null and note <> ''
       	</cfquery>
        
        <cfif getNotes.recordCount EQ 0>
        	<cfreturn ''>
        <cfelse>
        	<cfsavecontent variable="returnString">
            	<cfoutput>
                #arguments.opening#
                
                <ul class="badegNotes">
                	<cfloop query="getNotes">
                    	<li>#getNotes.note#</li>
                    </cfloop>
                </ul>
                #arguments.closing#
            	</cfoutput>
            </cfsavecontent>
            <cfreturn returnString>
        </cfif>
	</cffunction>    
    
    
      
    

</cfcomponent>
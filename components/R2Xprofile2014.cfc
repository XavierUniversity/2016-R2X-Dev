<cfcomponent name="R2Xprofile2014" hint="adds a level of abstraction for web,mobile to use the same code">
	 
	<cffunction name="setID" returntype="string" >
        <cfif isdefined("url.id")>
            <cfset currentID = url.id>
            <cfset currentID = decryptID(currentID)>
        <cfelse>
            <cfset currentID = session.bannerid>
        </cfif> 
        
        <cfreturn currentID>
	</cffunction>       
     
     
        
    <!--- ***
	Get the next steps for the student
	*** --->
    <cffunction name="getInterests" returntype="void">
        <cfset this.setID()>
        
        
        <cfquery name="request.allInterests" dataSource="#application.RoadToDB#">
        	select interest.interestID as InterestID, InterestName, InterestCategory, interestorder
	        from Interest
	        inner join InterestCategory on InterestCategory.InterestCategoryID = Interest.InterestCategoryID
	         where InterestCategory.InterestCategoryID <> 5
	         order by interestorder, interestcategory, interestname
        </cfquery>
        
        <!--- interests they have already--->
        <cfif len(session.currentinterests) eq 0>
            <cfquery name="request.currentInterests" datasource="#application.RoadToDB#">
                select distinct interest.interestID as InterestID, BannerID, InterestName, InterestCategory
                FROM InterestCategory INNER JOIN (Interest INNER JOIN Student_Interest ON Interest.InterestID = Student_Interest.InterestID) ON InterestCategory.InterestCategoryID = Interest.InterestCategoryID
                where student_interest.bannerID = <cfqueryparam value='#currentID#' cfsqltype="cf_sql_varchar">
                order by interestcategory, interestname
            </cfquery>
            
            <cfset request.notthese= "">
        <cfelse>
            <cfset session.CURRENTINTERESTS = replace(attributes.CURRENTINTERESTS, "|", ",", "ALL")>
            
            <cfquery name="request.currentInterests" datasource="#application.RoadToDB#">
            select distinct interest.interestID as InterestID, InterestName, InterestCategory
            FROM InterestCategory INNER JOIN Interest on InterestCategory.InterestCategoryID = Interest.InterestCategoryID
            where interest.InterestID in (#session.currentinterests#)
            order by interestcategory, interestname
            </cfquery>
        
        </cfif>
        
        <!--- Turn that into a comma string so we can exclude them from the next one --->
        <cfif request.currentinterests.recordcount eq 0>
            <cfset request.notthese = 9999>
        <cfelse>
            <cfset request.notthese="">
        </cfif>
        
        <cfset request.notthese = request.notthese & valuelist(request.currentInterests.interestID, ",")>
        
        <!---<cfdump var="#notthese#">--->
        
        <cfquery name="request.unchosenInterests" datasource="#application.RoadToDB#">
        select interest.interestID as InterestID, InterestName, InterestCategory, interestorder
        from
        Interest
        inner join InterestCategory on InterestCategory.InterestCategoryID = Interest.InterestCategoryID
         where interestID not in (#request.notthese#)
           and InterestCategory.InterestCategoryID <> 5
         order by interestorder, interestcategory, interestname
        </cfquery>
        
        <cfquery name="request.currentInterestsList" datasource="#application.RoadToDB#">
        select interest.interestID as InterestID, BannerID, InterestName, InterestCategory
        FROM InterestCategory INNER JOIN (Interest INNER JOIN Student_Interest ON Interest.InterestID = Student_Interest.InterestID) ON InterestCategory.InterestCategoryID = Interest.InterestCategoryID
         where student_interest.bannerID = '#session.bannerid#'
          order by interestcategory, interestname
        </cfquery>

    </cffunction>
    
    <cffunction name="getInterestMatches" returntype="void">
    	<cfargument name="idIn">
    
        <cfquery name="request.interestmatch" datasource="#application.RoadToDB#">
        SELECT     COUNT(DISTINCT Student_Interest.BannerID) AS matches
        FROM Student_Interest
        JOIN Student ON Student_Interest.BannerID = Student.BannerID
        JOIN BannerStudent ON Student_Interest.BannerID = BannerStudent.BannerID
        WHERE Student_Interest.InterestID = <cfqueryparam value="#idIn#" cfsqltype="cf_sql_integer"> 
          AND Student_Interest.BannerID <> <cfqueryparam value='#session.bannerID#' cfsqltype="cf_sql_varchar"> 
          AND (Student.nevershow = 0 or student.nevershow is null)
          and ambassador = 'N'
          and entryTerm = <cfqueryparam value="#session.entryTerm#" cfsqltype="cf_sql_varchar">
        </cfquery>
    
    </cffunction>
    
    <cffunction name="getManresa" returntype="void">
    
        <cfquery name="request.checkManresa" datasource="#application.RoadToDB#">
        SELECT GroupID
        FROM manresaassignments
        WHERE bannerid = <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
        </cfquery>

    </cffunction>
    
    <cffunction name="getProfile" returntype="void">
    
    	<cfset this.setID()>
    
        <cfquery name="request.getstudentinfo" datasource="#application.RoadToDB#">
        select bannerstudent.bannerID, bannerstudent.username as username, highschool,nicknameactive, bioactive, firstname, lastname, middlename, bannerstudent.nickname as oldnickname, student.nickname as newnickname, city,state,zipcode, street1, street2, active, bannerstudent.emailaddress as orgemail, student.email as newemail, birthdate, interestsactive, xstatus,emailactive,biography, major, major.bannermajorcode as bannermajorcode, majordesc, url as majorURL, contact_name, contact_phone, contact_email, IMscreenname, IMsystem, IMactive, dtLastUpdated, Ambassador, 
        whyChoose, lookForward, uUnique, share, facebookLink, twitterLink, videoLink, instagramLink
        FROM Student 
        INNER JOIN BannerStudent ON Student.BannerID = BannerStudent.BannerID 
        LEFT OUTER JOIN Major ON BannerStudent.bannermajorcode = Major.bannermajorcode
        where bannerstudent.bannerID = <cfqueryparam value='#currentID#' cfsqltype="cf_sql_varchar">
        </cfquery>

    </cffunction>
    
    <cffunction name="getCurrentMatchCounts" returntype="void">
        <cfquery name="request.majormatch" datasource="#application.RoadToDB#">
        select count(bannerstudent.bannerID)  as matches 
        from bannerstudent left join student on bannerstudent.bannerid = student.bannerid
        where bannermajorcode = '#session.bannermajorcode#' 
          and bannerstudent.bannerID <> <cfqueryparam value='#session.bannerID#'  cfsqltype="cf_sql_varchar">
          and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
          and ambassador = 'N'
          and (nevershow = 0 or nevershow is null)
        </cfquery>
        
        <cfquery name="request.citymatches" datasource="#application.RoadToDB#">
        select bannerstudent.bannerID as bannerID, firstname, lastname
        from bannerstudent left join student on bannerstudent.bannerid = student.bannerid 
        where bannerstudent.bannerID <> <cfqueryparam value='#session.bannerID#'  cfsqltype="cf_sql_varchar">
          and city = <cfqueryparam value='#request.getstudentinfo.city#' cfsqltype="cf_sql_varchar">
          and state = <cfqueryparam value='#request.getstudentinfo.state#' cfsqltype="cf_sql_varchar">
          and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
          and ambassador = 'N'
          and (nevershow = 0 or nevershow is null)
        </cfquery>
        
        
        <cfquery name="request.statematches" datasource="#application.RoadToDB#">
        select bannerstudent.bannerID as bannerID, firstname, lastname
        from bannerstudent  left join student on bannerstudent.bannerid = student.bannerid 
        where bannerstudent.bannerID <> <cfqueryparam value='#session.bannerID#'  cfsqltype="cf_sql_varchar">
          and state = <cfqueryparam value='#request.getstudentinfo.state#' cfsqltype="cf_sql_varchar">
          and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
          and ambassador = 'N'
          and (nevershow = 0 or nevershow is null)
        </cfquery>
	</cffunction>
    
    <cffunction name="getFriends" returntype="void">
        <cfquery name="request.qryFriendList" datasource="#application.RoadToDB#">
        SELECT     Student.StudentID, Student.BannerID, Student.Nickname, Student.NicknameActive, Student.Email, Student.EmailActive, Student.XStatus, 
                              Student.IMScreenname, Student.IMsystem, Student.IMactive, Student.nevershow, Student.Active, BannerStudent.FirstName, BannerStudent.LastName, 
                              Major.Major, Friend.BannerID AS Expr1
        FROM         Student INNER JOIN
                              BannerStudent ON Student.BannerID = BannerStudent.BannerID INNER JOIN
                              Friend ON Student.BannerID = Friend.FriendBannerID LEFT OUTER JOIN
                              Major ON BannerStudent.BannerMajorCode = Major.BannerMajorCode
        WHERE   
        (Student.Active = 1) AND (isNull(Student.nevershow, 0) = 0)
        AND		(friend.BannerID = <cfqueryparam value='#session.bannerID#' cfsqltype="cf_sql_varchar">)
        ORDER BY BannerStudent.FirstName, BannerStudent.LastName
        </cfquery>    
    </cffunction>
    
    <cffunction name="getFavorites" returntype="void">
        <cfset this.setID()>
        
        <cfquery name="request.getFavorites" datasource="#application.RoadtoDB#">
		SELECT favMovies1, favMovies2, favMovies3, favBands1, favBands2, favBands3, favBooks1, favBooks2, favBooks3, favShows1, 
			favShows2, favShows3, favGames1, favGames2, favGames3, favFoods1, favFoods2, favFoods3
		FROM Favorites
		WHERE (BannerID = <cfqueryparam value='#currentID#' cfsqltype="cf_sql_varchar">)
        </cfquery>
    </cffunction>
    
    <cffunction name="checkFriend" returntype="void">
    	<cfquery name="request.checkFriend" datasource="#application.RoadtoDB#">
        select 1
        from friend
        where bannerID = <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
          and friendBannerID = <cfqueryparam value='#decryptID(url.id)#' cfsqltype="cf_sql_varchar">
        </cfquery>
    </cffunction>
    
    <cffunction name="addFriend" returntype="void">
    	<cfargument name="friendID">
        
        <cfquery datasource="#application.RoadtoDB#">
        INSERT INTO Friend (BannerID, FriendBannerID)
		VALUES	(
        	<cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">, 
            <cfqueryparam value='#trim(decryptID(arguments.friendID))#' cfsqltype="cf_sql_varchar">
        )
        </cfquery>
        
        <!--- Gamify! --->
		<cfset session.gamification.addItem(session.bannerid,'PaddFriend',arguments.friendID)>
        
	</cffunction>
    
    <cffunction name="deleteFriend" returntype="void">
    	<cfargument name="friendID">
        
        <cfquery datasource="#application.RoadtoDB#">
        delete from Friend 
        where BannerID = <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
          and friendBannerID = <cfqueryparam value='#trim(decryptID(arguments.friendID))#' cfsqltype="cf_sql_varchar">
        </cfquery>
	</cffunction>
    
    <cffunction name="saveUpdates" returntype="void">
        
        <cfloop index="frmItem" list="#form.fieldnames#"> 
            <CFSET RESULT = structUpdate(form,'#frmItem#', REReplace(Evaluate("form." & frmItem),'<[^>]*>','','all'))>
        </cfloop>
                    
        <cfparam name="form.xstatus" default="">
        <cfparam name="form.imagefile" default="">
        <cfparam name="form.whyChoose" default="">
        <cfparam name="form.lookForward" default="">
        <cfparam name="form.uUnique" default="">
        <cfparam name="form.share" default="">
        
        <!--- get swear list and put it in an array ---> 
        <cfquery name="getSwears" datasource="#application.RoadtoDB#">
        SELECT swear, replacement 
        FROM swear
        </cfquery>
        
        <cfset wordtemp = ArrayNew(1)>
        <cfset replacetemp = ArrayNew(1)>
        <cfloop query = "getswears">
           <cfset temp = ArrayAppend(wordtemp, "#swear#")>
        </cfloop>
        <cfloop query = "getswears">
           <cfset temp2 = ArrayAppend(replacetemp, "#replacement#")>
        </cfloop>
        
        <cfset form.nickname = noSwearing(form.nickname, wordtemp, replacetemp)>
        <cfset form.biography = noSwearing(form.biography, wordtemp, replacetemp)>
        <cfset form.whyChoose = noSwearing(form.whyChoose, wordtemp, replacetemp)>
        <cfset form.lookForward = noSwearing(form.lookForward, wordtemp, replacetemp)>
        <cfset form.uUnique = noSwearing(form.uUnique, wordtemp, replacetemp)>
        
        <cfset request.errorstring = ''>
        
       	<!--- social link cleanup --->
		
		<cfif form.twitterlink is not "" and not isValid("url", form.twitterlink )  >
			<cfset form.twitterlink = fixSocial(form.twitterlink,'twitter') >
		</cfif>
	
        
        
        <cfif form.instagramLink is not "" and not isValid("url", form.instagramLink )  >
	
		<cfset form.instagramLink  = fixSocial(form.instagramLink ,'instagram') >
	
		</cfif>
			
    
        
        <!--- Update student table --->
        <cftry>
        <cfquery datasource="#application.roadtodb#">
            UPDATE Student SET 
            email = <cfqueryparam value="#Mid(form.email,1,90)#" cfsqltype="cf_sql_varchar" maxlength="90">,
            emailactive = <cfqueryparam value="#Mid(form.emailactive,1,1)#" cfsqltype="cf_sql_bit" maxlength="1">,
            nickname = <cfqueryparam value="#Mid(form.nickname,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">,
            nicknameactive = <cfqueryparam value="#Mid(form.nicknameactive,1,1)#" cfsqltype="cf_sql_bit" maxlength="1">,
            biography = <cfqueryparam value="#trim(form.biography)#" cfsqltype="cf_sql_longvarchar">,
            facebookLink = <cfqueryparam value="#Mid(form.facebookLink,1,255)#" cfsqltype="cf_sql_varchar" maxlength="255">,
            twitterLink = <cfqueryparam value="#Mid(form.twitterLink,1,255)#" cfsqltype="cf_sql_varchar" maxlength="255">,
            instagramLink = <cfqueryparam value="#Mid(form.instagramLink,1,255)#" cfsqltype="cf_sql_varchar" maxlength="255">,
            videoLink = <cfqueryparam value="#Mid(form.videoLink,1,255)#" cfsqltype="cf_sql_varchar" maxlength="255">,
            <cfif form.share EQ 'Yes'>
                share = 1,
            <cfelse>
                share = 0,
            </cfif>
            bioactive = <cfif len(trim(form.biography)) GT 0>1<cfelse>0</cfif>,
            highschool = <cfqueryparam value="#Mid(replace(form.highschool, "#chr(39)#", "&acute;", "ALL"),1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">,
            interestsactive = <cfqueryparam value="#Mid(form.interestsactive,1,1)#" cfsqltype="cf_sql_bit" maxlength="1">,
            Active = 1,
            dtLastUpdated = #CreateODBCDateTime(Now())#
            WHERE bannerID = '#session.BannerID#'
        </cfquery>
        <cfcatch>
            <cfset result = sendError()>
            <cfset request.errorstring = request.errorstring & 'There was an error updating profile data.<br>\n'>
        </cfcatch>
        </cftry>
        
        
        
        <!--- update Xstatus if they picked one --->
        <cftry>
        <cfif form.xstatus eq 1 or form.xstatus eq 0>
            <cfquery datasource="#application.roadtodb#"> UPDATE Student SET xstatus = <cfqueryparam value="#Mid(form.xstatus,1,1)#" cfsqltype="cf_sql_bit" maxlength="1"> WHERE bannerID = '#session.BannerID#' </cfquery>
        </cfif>
        <cfcatch>
            <cfset result = sendError()>
            <cfset request.errorstring = request.errorstring & 'There was an error updating profile data: xstatus.<br>\n'>
        </cfcatch>
        </cftry>
        
        <!--- update interests --->
        <cftry>
        <!--- web --->
		<cfif isdefined("form.currentInterests")>
            <cftransaction>
                <cfquery datasource="#application.roadtodb#">DELETE FROM student_interest WHERE bannerID = '#session.BannerID#'</cfquery>
                <cfloop list="#form.currentinterests#" delimiters="|" index="p">
                    <cfquery datasource="#application.roadtodb#">INSERT INTO Student_interest (bannerID, InterestID) 
                    VALUES ('#session.BannerID#', #p#)</cfquery>
                </cfloop>
            </cftransaction>
        <!--- mobile --->
        <cfelse>
        	<cfset interestList = ''>
            <cfloop index="frmItem" list="#form.fieldnames#"> 
				<cfif left(frmItem,8) EQ 'interest' and listLen(frmItem,'_') EQ 2>
                	<cfset interestList = listAppend(interestList, listGetAt(frmItem,2,'_'))>
                </cfif>
            </cfloop>
            
            <cftransaction>
                <cfquery datasource="#application.roadtodb#">
                DELETE 
                FROM student_interest 
                WHERE bannerID = <cfqueryparam value='#session.BannerID#' cfsqltype="cf_sql_varchar">
                </cfquery>
                
                <cfloop list="#interestList#" index="p">
                    <cfquery datasource="#application.roadtodb#">
                    INSERT INTO Student_interest (bannerID, InterestID) 
                    VALUES (<cfqueryparam value='#session.BannerID#' cfsqltype="cf_sql_varchar">, <cfqueryparam value="#p#" cfsqltype="cf_sql_integer">)
                    </cfquery>
                </cfloop>
            </cftransaction>	
        
        </cfif>
        
        <cfcatch>
            <cfset result = sendError()>
            <cfset request.errorstring = request.errorstring & 'There was an error updating profile data: interests.<br>\n'>
        </cfcatch>
        </cftry>
        
        <!--- Update Favorites (New) --->
        <cftry>
        <cftransaction>
            <cfquery name="updatefavorites" datasource="#application.roadtodb#">
            SELECT BannerID 
            FROM Favorites 
            WHERE BannerID = '#session.BannerID#'
            </cfquery>
            
            <cfif updatefavorites.RecordCount eq 0>
                <cfquery datasource="#application.roadtodb#">
                INSERT INTO Favorites (BannerID) VALUES ('#session.BannerID#')
                </cfquery>
            </cfif>
        
            <cfquery datasource="#application.roadtodb#">
            UPDATE Favorites
            SET favMovies1 = <cfqueryparam value="#Mid(form.favMovies1,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favMovies2 = <cfqueryparam value="#Mid(form.favMovies2,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favMovies3 = <cfqueryparam value="#Mid(form.favMovies3,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favBands1 = <cfqueryparam value="#Mid(form.favBands1,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favBands2 = <cfqueryparam value="#Mid(form.favBands2,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favBands3 = <cfqueryparam value="#Mid(form.favBands3,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favBooks1 = <cfqueryparam value="#Mid(form.favBooks1,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favBooks2 = <cfqueryparam value="#Mid(form.favBooks2,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favBooks3 = <cfqueryparam value="#Mid(form.favBooks3,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favShows1 = <cfqueryparam value="#Mid(form.favShows1,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favShows2 = <cfqueryparam value="#Mid(form.favShows2,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favShows3 = <cfqueryparam value="#Mid(form.favShows3,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favGames1 = <cfqueryparam value="#Mid(form.favGames1,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favGames2 = <cfqueryparam value="#Mid(form.favGames2,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favGames3 = <cfqueryparam value="#Mid(form.favGames3,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favFoods1 = <cfqueryparam value="#Mid(form.favFoods1,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favFoods2 = <cfqueryparam value="#Mid(form.favFoods2,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">, 
                favFoods3 = <cfqueryparam value="#Mid(form.favFoods3,1,100)#" cfsqltype="cf_sql_varchar" maxlength="100">
            WHERE (BannerID = '#session.BannerID#')
            </cfquery>
        </cftransaction>
        
        <!--- Gamify! --->        
		<cfif NOT session.gamification.addItem(session.bannerid,'PupdateFirst')>
            <cfset session.gamification.addItem(session.bannerid,'PupdateSubsequent')>
        </cfif>
        
        <cfcatch>
            <cfset result = sendError()>
            <cfset request.errorstring = request.errorstring & 'There was an error updating profile data: favorites.<br>\n'>
        </cfcatch>
        </cftry>
    
    </cffunction>
    
    
     <cffunction name="fixSocial" returntype="string">
	     
	       <cfargument name="socialLink" required="true">
	       <cfargument name="type" required="yes">
	       
	    <cfset socialLink='#replace(socialLink,'@','')#'> 
		<cfset socialLink='#replace(socialLink,'/','')#'> 
		<cfset socialLink='#replace(socialLink,'http://','')#'> 
		<cfset socialLink='#replace(socialLink,'https://','')#'> 
		<cfset socialLink='#replace(socialLink,'www.','')#'>
		
		<cfif type is "twtitter">
		
		<cfset socialLink='#replace(socialLink,'twitter.com','')#'>
		<cfset socialLink='#replace(socialLink,'www.twitter.com','')#'>
		<cfset socialLink='https://www.twitter.com/#socialLink#'>

		
		<cfelse>
		
		<cfset socialLink='#replace(socialLink,'instagram.com','')#'>
		<cfset socialLink='#replace(socialLink,'www.instagram.com','')#'>
		<cfset socialLink='https://www.twitter.com/#socialLink#'>
		
		</cfif>
	       
	      <cfreturn socialLink >
      </cffunction>   
      
      
    
    <cffunction name="getMatches" returntype="query">
    	<cfargument name="typeIn">
    	
         <cfset orderBy = 'Lastname, Firstname'>
                
         <cfswitch expression="#arguments.typeIn#">
         
            <cfcase value="interest">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                SELECT DISTINCT bannerstudent.bannerID AS bannerID, firstname, lastname, dtLastUpdated
                FROM bannerstudent 
                INNER JOIN student_interest on student_interest.bannerID = bannerstudent.bannerID
                LEFT JOIN student on student.bannerID = bannerstudent.bannerID
                WHERE bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                  and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                  AND interestID = <cfqueryparam value="#Mid(url.id,1,4)#" cfsqltype="cf_sql_integer" maxlength="4">
                  AND Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                  AND(nevershow = 0 or nevershow is null)
                ORDER BY #orderBy#
                </cfquery>
            </cfcase>
        
        
            <cfcase value="city">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                select distinct bannerstudent.bannerID as bannerID, firstname, lastname, dtLastUpdated
                from bannerstudent 
                left join student on student.bannerID = bannerstudent.bannerID
                where bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                  and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                  and city = '#session.city#'
                  and state = '#session.state#'
                  AND Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                  AND (nevershow = 0 or nevershow is null)
                order by #orderBy#
                </cfquery>	
            </cfcase>
        
        
            <cfcase value="state">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                select distinct bannerstudent.bannerID as bannerID, firstname, lastname, dtLastUpdated
                from bannerstudent 
                left join student on student.bannerID = bannerstudent.bannerID
                where bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                  and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                  and state = <cfqueryparam value='#session.state#' cfsqltype="cf_sql_varchar">
                  AND Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                  AND (nevershow = 0 or nevershow is null)
                order by #orderBy#
                </cfquery>
            </cfcase>
            
            
            <cfcase value="most">
            
            </cfcase>
            
            <cfcase value="major">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                select distinct bannerstudent.bannerID as bannerID, firstname, lastname, dtLastUpdated
                 from bannerstudent
                 left join student on student.bannerID = bannerstudent.bannerID
                where bannermajorcode = <cfqueryparam value="#Mid(url.major,1,255)#" cfsqltype="cf_sql_varchar" maxlength="255">
                  AND bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                  and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                  AND Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                  AND (nevershow = 0 or nevershow is null)
                order by #orderBy#
                </cfquery>
            </cfcase>
            
            
            <cfcase value="status"> <!--- freshman/transfer --->
            </cfcase>
            
            
            <cfcase value="matchbest">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
        SELECT     top 20 FirstName, LastName, BannerID, max(dtLastUpdated) AS dtLastUpdated, SUM(interestmatch) + SUM(matchmajor) + SUM(matchcity) + SUM(matchstate) 
                              AS bigtotalmatch, SUM(interestmatch) AS Expr1
        FROM         (SELECT     BannerStudent.BannerID, BannerStudent.FirstName, BannerStudent.LastName, COUNT(Student_Interest.BannerID) AS interestmatch, 
                                                      1 AS dtLastUpdated, 0 AS matchmajor, 0 AS matchcity, 0 AS matchstate
                               FROM          Student_Interest INNER JOIN
                                                      BannerStudent ON BannerStudent.BannerID = Student_Interest.BannerID
                               WHERE      (Student_Interest.InterestID IN (#url.interestlist#)) 
                                 AND (BannerStudent.BannerID <> <cfqueryparam value="#Mid(url.bannerID,1,9)#" cfsqltype="cf_sql_varchar" maxlength="9">) 
                                 and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                                 AND (BannerStudent.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>)
                               GROUP BY BannerStudent.BannerID, BannerStudent.FirstName, BannerStudent.LastName
                               UNION
                               SELECT     BannerStudent_1.BannerID, BannerStudent_1.FirstName, BannerStudent_1.LastName, 0 AS interestmatch, Student.dtLastUpdated, 
                                                     CASE WHEN bannermajorcode = <cfqueryparam value="#url.bannermajorcode#" cfsqltype="cf_sql_varchar" maxlength="10"> THEN 1 ELSE 0 END AS matchmajor, 
                                                     CASE WHEN city = <cfqueryparam value="#Mid(url.city,1,20)#" cfsqltype="cf_sql_varchar" maxlength="20"> THEN 1 ELSE 0 END AS matchcity, CASE WHEN state = <cfqueryparam value="#Mid(url.state,1,3)#" cfsqltype="cf_sql_varchar" maxlength="3"> THEN 1 ELSE 0 END AS matchstate
                               FROM         BannerStudent AS BannerStudent_1 LEFT OUTER JOIN
                                                     Student ON Student.BannerID = BannerStudent_1.BannerID
                               WHERE entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                                 AND ((BannerStudent_1.City = <cfqueryparam value="#Mid(url.city,1,20)#" cfsqltype="cf_sql_varchar" maxlength="20">) 
                                 AND (BannerStudent_1.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>) 
                                 AND (BannerStudent_1.BannerID <> <cfqueryparam value="#Mid(url.bannerID,1,9)#" cfsqltype="cf_sql_varchar" maxlength="9">) 
                                  OR (BannerStudent_1.BannerID <> <cfqueryparam value="#Mid(url.bannerID,1,9)#" cfsqltype="cf_sql_varchar" maxlength="9">) 
                                 AND (BannerStudent_1.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>) 
                                 AND (BannerStudent_1.State = <cfqueryparam value="#Mid(url.state,1,3)#" cfsqltype="cf_sql_varchar" maxlength="3">) 
                                  OR (BannerStudent_1.BannerID <> <cfqueryparam value="#Mid(url.bannerID,1,9)#" cfsqltype="cf_sql_varchar" maxlength="9">) 
                                 AND (BannerStudent_1.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>) 
                                 AND (BannerStudent_1.BannerMajorCode = <cfqueryparam value="#Mid(url.bannermajorcode,1,10)#" cfsqltype="cf_sql_varchar" maxlength="10">))) AS A
        GROUP BY BannerID, FirstName, LastName
        ORDER BY bigtotalmatch DESC
        </cfquery>
            </cfcase>
            
            
            <cfcase value="find">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                    SELECT     BannerStudent.FirstName, BannerStudent.LastName, BannerStudent.bannerID, Student.dtLastUpdated
                    FROM         BannerStudent LEFT OUTER JOIN
                                          Student ON BannerStudent.BannerID = Student.BannerID
                    WHERE     BannerStudent.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif> AND (nevershow = 0 or nevershow is null)
                    <cfif url.lastname neq "">AND (BannerStudent.LastName LIKE <cfqueryparam value="#Mid(url.lastname,1,59)#%" cfsqltype="cf_sql_varchar" maxlength="60">)</cfif>
                    <cfif url.firstname neq "">AND (BannerStudent.FirstName LIKE <cfqueryparam value="#Mid(url.firstname,1,14)#%" cfsqltype="cf_sql_varchar" maxlength="15">)</cfif>
                    <cfif url.nickname neq "">AND (BannerStudent.Nickname LIKE <cfqueryparam value="#Mid(url.nickname,1,14)#%" cfsqltype="cf_sql_varchar" maxlength="15">)</cfif>
                    <cfif url.highschool neq "">AND (Student.Highschool LIKE <cfqueryparam value="#Mid(url.highschool,1,99)#%" cfsqltype="cf_sql_varchar" maxlength="100">)</cfif>
                    <cfif url.city neq "">AND (BannerStudent.City LIKE <cfqueryparam value="#Mid(url.city,1,19)#%" cfsqltype="cf_sql_varchar" maxlength="20">)</cfif>
                    <cfif url.state neq "">AND (BannerStudent.State = <cfqueryparam value="#Mid(url.state,1,2)#" cfsqltype="cf_sql_varchar" maxlength="3">)</cfif>
                    <cfif url.major neq "">AND (BannerStudent.DegreeSought = '<cfqueryparam value="#Mid(url.major,1,9)#" cfsqltype="cf_sql_varchar" maxlength="10">')</cfif>
                    order by #orderBy#
                </cfquery>
            </cfcase>
            
            
            <cfcase value="recent">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                    SELECT  top 50   BannerStudent.FirstName, BannerStudent.LastName, BannerStudent.BannerID, Student.dtLastUpdated
                    FROM         BannerStudent INNER JOIN Student ON BannerStudent.BannerID = Student.BannerID
                    WHERE bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                      and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                      AND BannerStudent.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                    order by dtLastUpdated desc
                </cfquery>
            </cfcase>
            
            <cfcase value="confirmed">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                    SELECT     BannerStudent.FirstName, BannerStudent.LastName, BannerStudent.BannerID, Student.dtLastUpdated
                    FROM         BannerStudent INNER JOIN Student ON BannerStudent.BannerID = Student.BannerID
                    WHERE bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                      and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                      and (Student.XStatus = 1)
                      AND BannerStudent.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                </cfquery>
            </cfcase>
            
            <cfcase value="manresa">
                <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                    SELECT  BannerStudent.FirstName, BannerStudent.LastName, BannerStudent.BannerID, Student.dtLastUpdated
                    FROM    BannerStudent INNER JOIN
                            Student ON BannerStudent.BannerID = Student.BannerID INNER JOIN
                            ManresaAssignments ON Student.BannerID = ManresaAssignments.BannerID
                    WHERE bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                      and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                      and ManresaAssignments.GroupID = (SELECT GroupID FROM manresaassignments WHERE      bannerid = '#session.bannerid#')
                      AND BannerStudent.Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                </cfquery>
            </cfcase>
            
            <cfcase value="badge">
            
            	<cfif url.badge EQ 'dartagnan' or url.badge EQ 'blueblob'>            
                    <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                    select distinct bannerstudent.bannerID as bannerID, firstname, lastname, dtLastUpdated
                    from bannerstudent 
                    left join student on student.bannerID = bannerstudent.bannerID
                    where bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                      and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                      and bannerstudent.bannerid in (select bannerid from gameStudentBadges where dateDeleted is NULL and badge like <cfqueryparam value="%#url.badge#%" cfsqltype="cf_sql_varchar">)
                      AND Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                      AND (nevershow = 0 or nevershow is null)
                    order by #orderBy#
                    </cfquery>
            	<cfelse>
                    <cfquery name="getmatches" datasource="#application.RoadtoDB#">
                    select distinct bannerstudent.bannerID as bannerID, firstname, lastname, dtLastUpdated
                    from bannerstudent 
                    left join student on student.bannerID = bannerstudent.bannerID
                    where bannerstudent.bannerID <> <cfqueryparam value='#session.bannerid#' cfsqltype="cf_sql_varchar">
                      and entryTerm = <cfqueryparam value='#session.entryTerm#' cfsqltype="cf_sql_varchar">
                      and bannerstudent.bannerid in (select bannerid from gameStudentBadges where dateDeleted is NULL and badge = <cfqueryparam value="#url.badge#" cfsqltype="cf_sql_varchar">)
                      AND Ambassador <cfif url.ambassador eq 0> = 'N'<cfelse>= 'Y'</cfif>
                      AND (nevershow = 0 or nevershow is null)
                    order by #orderBy#
                    </cfquery>
            	</cfif>                   
            </cfcase>	
        
            
            <cfdefaultcase>
                <cfoutput>type=#url.type#&z=#getmatches.recordcount#&#session.bannerid#=No Results Found</cfoutput>
            </cfdefaultcase>
            
            
        </cfswitch> 
        
        <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="getmatches Quick Email" type="html">
            <cfdump var="#getmatches#" label="getmatches">
            <cfdump var="#cgi#" label="CGI">
        </cfmail>--->
        
        <cfreturn getMatches>
           
    </cffunction>
    
    <!--- error catching function for insert errors --->
    <cffunction name="sendError">
    
        <cfmail to="lieslandr@xavier.edu" from="webmaster@xavier.edu" subject="R2X: Error Inserting Profile Data" type="html">
            <cfif isdefined("cfcatch")>Catch:<cfdump var="#cfcatch#"></cfif>
            Session:<cfdump var="#session#">
            Form:<cfdump var="#form#">
            CGI:<cfdump var="#cgi#">
        </cfmail>
    </cffunction>
    
	<cfscript>
    function noSwearing(checkstring, words, replacements) {
        for(sl = 1; sl LTE arrayLen(words); sl = sl + 1){
         checkstring = REReplaceNoCase(checkstring,words[sl],replacements[sl],"ALL");
        // writeoutput (#checkstring# &  "  checked for: " & words[sl] & "<br>");
        }
    //	writeoutput('I like this');
     return checkstring ;
    }
    </cfscript>
    
    <cffunction name="decryptID" returntype="string"><cfargument name="incomingID" type="numeric"><cfset newID = 999999 - incomingID><cfset newID = "000" & newID><cfreturn trim(newID)></cffunction>    
    
</cfcomponent>
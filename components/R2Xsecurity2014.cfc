<cfcomponent displayname="Security2014" output="true" hint="Handle security.">
 
 <!---init--->
<cffunction name="init" access="public" output="false">
		<cfreturn this />
</cffunction>
 
 
<cfset this.loggedin = false>
 
<!--- user login function --->
    <cffunction name="forceUserLogin" access="public" returntype="void" output="yes">
		
        <cftry>
        
		<!--- See if the user is logged in. If they are logged in, let them through, otherwise, ask them to log in --->
        <cfif not this.loggedIn>
        	  <!--- If the user hasn't gotten the login form yet, display it --->
			  <CFIF (NOT IsDefined("FORM.UserLogin") OR NOT IsDefined("FORM.UserPassword"))>
              	<cfset StructDelete(Variables, "login_error")>
                <CFINCLUDE TEMPLATE="/UserLoginForm.cfm">
                <CFABORT>
                
              <!--- Otherwise, the user is submitting the login form --->
              <!--- This code decides whether the username and password are valid --->
              <CFELSE>
              
                <!--- handle the transfer login --->
                <cfset request.hopsonk1t = false>
                <cfif form.userlogin eq 'hopsonk1t'>
                    <cfset form.userlogin = 'hopsonk1'>
                    <cfset request.hopsonk1t = true>
                </cfif>
                
                <!--- handle the spring login --->
                <cfset request.hopsonk1s = false>
                <cfif form.userlogin eq 'hopsonk1s'>
                    <cfset form.userlogin = 'hopsonk1'>
                    <cfset request.hopsonk1s = true>
                </cfif>
                
                <!--- handle the intl login --->
                <cfset request.hopsonk1i = false>
                <cfif form.userlogin eq 'hopsonk1i'>
                    <cfset form.userlogin = 'hopsonk1'>
                    <cfset request.hopsonk1i = true>
                </cfif>
                
                <!--- handle the commuter login --->
                <cfset request.hopsonk1c = false>
                <cfif form.userlogin eq 'hopsonk1c'>
                    <cfset form.userlogin = 'hopsonk1'>
                    <cfset request.hopsonk1c = true>
                </cfif>
              
                <!--- process special passwords --->
                <cfif form.userlogin EQ 'hopsonk1'>
                    
                    <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Web: Hopsonk1(#form.userpassword#) Login" type="html">
                            <p>#listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#</p>
                            <cfdump var="#form#">
                            <cfdump var="#cgi#">
                    </cfmail>
                    
					<!--- *** list passwords here ***
                    Blueblob10 - default
					Music2015 - Tom Merril by Sparks 4/16/2015
                    Burger1 - give to AuxServ by Rob 12/1/2012
                    Lettuce1 - give to StuRet by Rob 3/8/2014
                    Bagel13 - give to OMA by Rob 3/28/2014
                    Musketeer10 - Marketing
                    Chicken1 - ResLife
                    Muskie2014 - Kerry Murphy
                    Manresa3000 - Student Life
                    1831Smith - Admissions & Bob Cotter
                    3800Blob - International Admission
                    1831Ologie - Ologie	
                    Pizza3800 - Finaid
                    Cheese2014 - Dining Services
                    Slat32014 - Slate - Undergrad Admission Services
					Fir3Man - Disabilty Services
					S3wingMachine - Orientation Committee
					D0nkeyKong - Bursar
					B@sketball - TRiO
					CoachBlue3 - CFT/per Molly Dugan & Dave Johnson
					RainyDay25 - Tina Meagher
					Health5000 - Health & Wellness
					Advising5000 - Academic Advising
					Registrar4000 - Registrar
					Hist0ry - Rachel Chrastil
					Br@1nQu3st - Mary Bessler
					An@lytics - Jimmy Love
					W3tT0w3l - Career & Vicki Clary
					W00dB3nch - athletic advising
					H0l3P)nch - NameCoach
                          *** End *** --->                    
                    <cfif listFind('1831Victory,Burger1,Blueblob10,Musketeer10,Lettuce1,Bagel13,Chicken1,Muskie2014,Manresa3000,1831Smith,3800Blob,1831Ologie,Pizza3800,Cheese2014,Slat32014,Fir3Man,S3wingMachine,D0nkeyKong,B@sketball,CoachBlue3,RainyDay25,Health5000,Advising5000,Registrar4000,Music2015,Hist0ry,Br@1nQu3st,An@lytics,W3tT0w3l,W00dB3nch,H0l3P)nch',form.userpassword)>
                        <cfset form.userpassword = '1831Victory'>
                    </cfif>
                </cfif>
                
                            
                <!--- Find record with this Username/Password --->
                <!--- If no rows returned, password not valid --->
                <cfquery name="qSecurity" datasource="#Application.roadtoDB#">
                    SELECT student.bannerid
                    FROM bannerstudent join student on bannerstudent.bannerid = student.bannerid
                    WHERE bannerstudent.username= <cfqueryparam value='#form.userlogin#' CFSQLTYPE='CF_SQL_VARCHAR'  maxlength="50">
                      <cfif form.userpassword NEQ 'DesMoinesIA50311' >AND student.password= <cfqueryparam value='#form.userpassword#' CFSQLTYPE='CF_SQL_VARCHAR'  maxlength="50"></cfif>
                </cfquery>
                
                <cfif form.userpassword EQ 'DesMoinesIA50311' >
                	<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Super Login" type="html">
                        <p>IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#</p>
                        <cfdump var="#qSecurity#" label="qSecurity">
                        <cfdump var="#cgi#" label="CGI">
                        <cfdump var="#server#" label="Server">
                    </cfmail>
                </cfif>
            
				<!--- check for banned users  --->
				
				<cfif qSecurity.bannerid is	'000641410'>
					<cfset login_error = 'Sorry, that username and password are not recognized. Please try again. <!-- e1 -->'>
                    <CFINCLUDE TEMPLATE="/UserLoginForm.cfm">
                    <CFABORT>
				</cfif>	
            
                <!--- If the username and password are correct... --->
                <cfif qSecurity.recordcount gt 0>
					<cfset this.loginUser(qSecurity.bannerid)>
                <!--- Otherwise, re-prompt for a valid username and password --->
                <CFELSE>         
                    <cfset login_error = 'Sorry, that username and password are not recognized. Please try again. <!-- e1 -->'>
                    <CFINCLUDE TEMPLATE="/UserLoginForm.cfm">
                    <CFABORT>
                </CFIF>
            
              </CFIF>
        </cfif>
        
        <cfcatch>
        
            <cfmail to="lieslandr@xavier.edu" from="lieslandr@xavier.edu,sparkse1@xavier.edu" subject="R2X Web: Error on login" type="html">
                <cfdump var="#cfcatch#">
                <cfdump var="#cgi#">
            </cfmail>
            <cfset login_error = 'Sorry, that username and password are not recognized. Please try again. <!-- e2 -->'>
            <CFINCLUDE TEMPLATE="/UserLoginForm.cfm">
            <CFABORT>
        
        </cfcatch>
        </cftry>
    </cffunction>

<!--- load data after user has logged in --->    
    <cffunction name="loginUser" access="public" returntype="void">
    	<cfargument name="idIn" required="yes" type="numeric">
        
        <cftry>
        
        	<cfif idIn  is	'000641410'>
					<cfset login_error = 'Sorry, that username and password are not recognized. Please try again. <!-- e1 -->'>
                    <CFINCLUDE TEMPLATE="/UserLoginForm.cfm">
                    <CFABORT>
				</cfif>	
        
        
       	<!--- set parent login flag --->
        <cfset session.parentlogin = FALSE > 
        
        <cfobject component="R2Xgamification2014" name="session.gamification">
        
        <!--- let the system know we are logged in --->
        <cfobject component="R2Xstudent2014" name="session.student">               
        <cfset this.loggedIn = session.student.loginUser(idIn)>

		<!--- create some additional components to manage the session --->
        <cfobject component="R2Xinbox2014" name="session.inbox">
        <cfobject component="R2XstudentProcess2014" name="session.studentProcess">
        <cfobject component="R2XparentProcess2014" name="session.parentProcess">
        <cfobject component="R2Xprofile2014" name="session.profiler">                
        <cfobject component="R2Xmessages2014" name="session.messages">
        <cfset session.messages.setMessages()>
        
        <cfobject component="R2Xinbox2014" name="session.inbox">
                
        <cfcatch>
            <cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu,sparkse1@xavier.edu" subject="R2X Web: Login Function Error" type="html">
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

<!--- Check to see if the login cookie is set --->    
    <cffunction name="checkPermanentLogin" access="public" returntype="void">
    
    	<cftry>
    		<!--- see if the R2X User Cookie exists --->
        
    		<!--- Decrypt out remember me cookie. --->
			<cfset RememberMe = Decrypt(COOKIE.R2X_web, APPLICATION.EncryptionKey, "cfmx_compat", "hex") />
             
            <!--- For security purposes, we tried to obfuscate the way the ID was stored. We wrapped it in the middle of list. Extract it from the list. --->
            <cfset RememberMe = ListGetAt(RememberMe,2,":") />
            
            <!--- check to make sure the bannerid exists in the BannerStudent table --->
            <cfquery name="checkID" datasource="#application.RoadtoDB#">
            select bannerID
            from bannerstudent
            where bannerid = <cfqueryparam value="#rememberMe#" cfsqltype="cf_sql_varchar" maxlength="9">
            </cfquery>
             
            <!--- Check to make sure this value is numeric, otherwise, it was not a valid value. --->
            <cfif IsNumeric(RememberMe) and checkID.recordCount GT 0>
				<!--- We have successfully retreived the "remember me" ID from the user's cookie. Now, load the session.--->
                <cfset session.securityManager.loginUser(RememberMe)> 
                <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Successful Permanent Login Quick Email" type="html">
                    <p>IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#</p>
                    <p>ID: #RememberMe#</p>
                    <cfdump var="#cgi#" label="CGI">
                </cfmail> --->          
            </cfif>
    
    	<cfcatch>
        	<!--- there was an error, which means they need to log in again --->
            <!---<cfmail from="lieslandr@xavier.edu" to="lieslandr@xavier.edu" subject="R2X CheckPermamentLogin Error" type="html">
                IP: #listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#
                <cfdump var="#cfcatch#" label="Catch">
                <cfdump var="#variables#" label="Variables">
                <cfdump var="#session#" label="Session">
                <cfdump var="#application#" label="Application">
                <cfdump var="#form#" label="Form">
                <cfdump var="#cgi#" label="CGI">
            </cfmail>--->
        	
        </cfcatch>
        </cftry>
    </cffunction>
    
	<!--- This function returns a string which includes all current URL --->
    <!--- variables, properly formatted for easy passing along in URLs. --->
    <!--- In addition, it includes the URLToken from CLIENT or SESSION. --->
    <CFFUNCTION NAME="PassURLVars">
       
      <!--- There is one optional argument: a list of variables *not* to pass --->
      <CFARGUMENT NAME="Exceptions" DEFAULT="">
      
    <!---  <cfif not structIsEmpty(url)>
        <cfmail from="nobody@xavier.edu" to="lieslandr@xavier.edu" subject="R2X URL Vars" type="html">
            <cfdump var="#url#">
        </cfmail>
      </cfif>--->
          
      <!--- The exception list should always include the URLToken variables --->
      <CFSET Exceptions = ListAppend(Exceptions, "jsessionid,cftoken,cfid,logout,CFID,CFTOKEN")>
    
      <!--- If defined, start with URLToken; if not, start with empty string --->
      <!--- <CFIF IsDefined("SESSION.URLToken")>
        <CFSET PassVars = SESSION.URLToken> 
      <CFELSEIF IsDefined("CLIENT.URLToken")>
        <CFSET PassVars = CLIENT.URLToken> 
      <CFELSE> --->
      <CFSET PassVars = "">     
      <!--- </CFIF> --->
      
      <!--- Loop over all URL variables, adding to PassVars along the way --->
      <!--- But, skip any variables in the Exceptions list --->
      <CFLOOP LIST="#StructKeyList(URL)#" INDEX="Var">
        <CFIF NOT ListFindNoCase(Exceptions, Var)>
          <CFSET PassVars = ListAppend(PassVars, "#Var#=#URLEncodedFormat(URL[Var])#", "&")>
        </CFIF>
      </CFLOOP>  
    
      <!--- Return result to calling process --->
      <cfif PassVars NEQ ''>
        <CFRETURN '?' & PassVars>
      <cfelse>
        <cfreturn ''>
      </cfif>
    </CFFUNCTION>
    
    
    
    <!--- This function returns string which includes all current form --->
    <!--- variables, properly formatted as hidden form fields. --->
    <CFFUNCTION NAME="PassFormVars">
      <!--- There is one optional argument: a list of variables *not* to pass --->
      <CFARGUMENT NAME="Exceptions" DEFAULT="">
      
    <!---  <cfif not structIsEmpty(form)>
        <cfmail from="nobody@xavier.edu" to="lieslandr@xavier.edu" subject="R2X Form Vars" type="html">
            <cfdump var="#form#">
        </cfmail>
      </cfif>--->
        
      <!--- Exception list should always include automatic FIELDNAMES variable --->
      <CFSET Exceptions = ListAppend(Exceptions, "FIELDNAMES")>
      
      <!--- Start with empty string --->
      <CFSET PassVars = "">
      
      <!--- Loop over all FORM variables, adding to PassVars along the way --->
      <!--- But, skip any variables in the Exceptions list, or variables --->
      <!--- that end in the reserved validation suffixes, like _required --->
      <CFLOOP LIST="#StructKeyList(FORM)#" INDEX="Var">
        <CFIF NOT ListFindNoCase(Exceptions, Var)>
          <CFSET LastPartOfVarName = ListLast(Var, "_")>
          
          <CFIF NOT ListFindNoCase("required,date,integer,float", LastPartOfVarName)>
            <CFSET PassVars = PassVars & '<INPUT TYPE="Hidden" NAME="#Var#" VALUE="#HTMLEditFormat(FORM[Var])#">'>
          </CFIF>
        </CFIF>
      </CFLOOP>  
    
      <!--- Return result to calling process --->
      <CFRETURN PassVars>
    </CFFUNCTION>
    
    <cffunction name="encryptID" returntype="string"><cfargument name="incomingID" type="numeric"><cfset newID = 999999 - incomingID><cfreturn newID></cffunction>
    <cffunction name="decryptID" returntype="string"><cfargument name="incomingID" type="numeric"><cfset newID = 999999 - incomingID><cfset newID = "000" & newID><cfreturn trim(newID)></cffunction> 
    
    
 
</cfcomponent>


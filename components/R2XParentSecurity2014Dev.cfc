L<cfcomponent displayname="parentSecurity2014" output="true" hint="Handle security.">
 
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
			  <CFIF (NOT IsDefined("FORM.UserEmail") OR NOT IsDefined("FORM.UserLogin") OR NOT IsDefined("FORM.UserPassword"))>
                <CFINCLUDE TEMPLATE="/parent/UserLoginForm.cfm">
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
                    
                    <cfmail from="sparkse1@xavier.edu" to="sparkse1@xavier.edu" subject="R2X Parent Web: Hopsonk1(#form.userpassword#) Login" type="html">
                            <p>#listGetAt(structFind(GetHttpRequestData().headers,'X-forwarded-for'),1)#</p>
                            <cfdump var="#form#">
                            <cfdump var="#cgi#">
                    </cfmail>
                    
					<!--- *** list passwords here ***
                    Blueblob10 - default
                    Burger1 - give to AuxServ by Rob 12/1/2012
                    Lettuce1 - give to StuRet by Rob 3/8/2014
                    Bagel13 - give to OMA by Rob 3/28/2014
                    Musketeer10 - Marketing
                    Chicken1 - ResLife
                    Muskie2014 - Kerry Murphy
                    Manresa3000 - Student Life
                    1831Smith - Admissions
                    3800Blob - International Admissions
                    1831Ologie - Ologie	
                    Pizza3800 - Finaid
                    Cheese2014 - Dining Services
                    Slat32014 - Slate - Undergrad Admission Services
					Parent2014
					Health5000 - Health & Wellness
                          *** End *** --->                    
                    <cfif listFind('1831Victory,Blueblob10,Burger1,Musketeer10,Lettuce1,Bagel13,Chicken1,Muskie2014,Manresa3000,1831Smith,3800Blob,1831Ologie,Pizza3800,Cheese2014,Slat32014,Parent2014,Health5000',form.userpassword)>
                        <cfset form.userpassword = '1831Victory'>
                    </cfif>
                </cfif>
                            
                <!--- Find record with this Username/Password --->
                <!--- If no rows returned, password not valid --->
                <cfquery name="qSecurity" datasource="#application.RoadToDB#">
                SELECT parent.bannerid, parent.parentID, parent.parentEmail, parent.dismissWelcome
                FROM bannerstudent join parent on bannerstudent.bannerid = parent.bannerid
                WHERE parent.parentEmail = <cfqueryparam value='#form.useremail#' CFSQLTYPE='CF_SQL_VARCHAR'  maxlength="50">
                  AND bannerstudent.username = <cfqueryparam value='#form.userlogin#' CFSQLTYPE='CF_SQL_VARCHAR'  maxlength="50">
                  AND parent.password = <cfqueryparam value='#form.userpassword#' CFSQLTYPE='CF_SQL_VARCHAR'  maxlength="50">
                </cfquery>
                
                <!---<cfmail from="sparkse1@xavier.edu" to="sparkse1@xavier.edu" subject="Quick Email" type="html">
                  <cfdump var="#qSecurity#" label="qSecurity">
                  <cfdump var="#cgi#" label="CGI">
                </cfmail>--->
            
                <!--- If the username and password are correct... --->
                <cfif qSecurity.recordcount gt 0>   
                	<cfset session.parentID = qSecurity.parentID> 
                    <cfset session.parentEmail = qSecurity.parentEmail>  
					<cfset session.dismissWelcome = qSecurity.dismissWelcome>  
					<cfset this.loginUser(qSecurity.parentID, qSecurity.bannerid)>
					
						<!--- 	<cflocation url="/lazy.cfm" addToken="no"> --->
					
					
                <!--- Otherwise, re-prompt for a valid username and password --->
                <CFELSE>         
                    <cfset login_error = 'Sorry, that username and password are not recognized. Please try again. <!-- pe1 -->'>
                    <CFINCLUDE TEMPLATE="/parent/UserLoginForm.cfm">
                    <CFABORT>
                </CFIF>
            
              </CFIF>
        </cfif>
        
        <cfcatch>
        
            <cfmail to="sparkse1@xavier.edu" from="sparkse1@xavier.edu" subject="R2X Parent Web: Error on login" type="html">
                <cfdump var="#cfcatch#">
                <cfdump var="#form#">
                <cfdump var="#cgi#">
            </cfmail>
            <cfset login_error = 'Sorry, that username and password are not recognized. Please try again. <!-- pe2 -->'>
            <CFINCLUDE TEMPLATE="/parent/UserLoginForm.cfm">
            <CFABORT>
        
        </cfcatch>
        </cftry>
    </cffunction>


	<!--- load data after user has logged in --->    
    <cffunction name="loginUser" access="public" returntype="void">
    	<cfargument name="parentidIn" required="yes" type="numeric">
        <cfargument name="studentidIn" required="yes" type="numeric">
        
        <cftry>
        
        <!--- let the system know we are logged in --->
        <cfobject component="R2Xparent2014" name="session.parent">
        <cfobject component="R2XparentProcess2014" name="session.parentProcess">
        <cfobject component="R2XstudentProcess2014" name="session.studentProcess">               
        <cfset this.loggedIn = session.parent.loginUser(arguments.parentidIn, arguments.studentidIn)>
                
        <cfcatch>
            <cfmail from="sparkse1@xavier.edu" to="sparkse1@xavier.edu" subject="R2X Parent Web: Login Function Error" type="html">
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
        
	<!--- This function returns a string which includes all current URL --->
    <!--- variables, properly formatted for easy passing along in URLs. --->
    <!--- In addition, it includes the URLToken from CLIENT or SESSION. --->
    <CFFUNCTION NAME="PassURLVars">
       
      <!--- There is one optional argument: a list of variables *not* to pass --->
      <CFARGUMENT NAME="Exceptions" DEFAULT="">
      
    <!---  <cfif not structIsEmpty(url)>
        <cfmail from="nobody@xavier.edu" to="sparkse1@xavier.edu" subject="R2X URL Vars" type="html">
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
        <cfmail from="nobody@xavier.edu" to="sparkse1@xavier.edu" subject="R2X Form Vars" type="html">
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


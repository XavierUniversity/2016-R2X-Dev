<cfcomponent displayname="Security2014" output="true" hint="Handle security.">
 
 <!---init--->
<cffunction name="init" access="public" output="false">
		<cfreturn this />
</cffunction>
 
 
<cfset this.loggedin = false>
 


<!--- load data after user has logged in --->    
    <cffunction name="loginUser" access="public" returntype="void">
    	<cfargument name="idIn" required="yes" type="numeric">
        
        <cftry>
        
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


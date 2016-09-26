<cfcomponent>
	<cffunction name="unreadCount" access="public" returntype="numeric">
		
        <cfset inboxUnread = 0>
        <cfloop from="1" to="#structCount(session.messages)#" index="w">
            <cfif evaluate("session.messages.#w#.display")>
                <cfset thislet = "session.letter" & w & "read">
                <!---<cfif evaluate(thislet) neq 1>--->
			 <cfif not structKeyExists(session.inboxRead,w)>
                	<cfset inboxUnread += 1>
                </cfif>
            </cfif>
        </cfloop>
        
        <cfreturn inboxUnread>
        
	</cffunction>
    
    <cffunction name="listMessages" returntype="void">
    	<cfoutput>
        <cfparam name="url.letter" default="0">
        <h5 class="title"><i class="fa fa-inbox fa-lg"></i> Inbox
        <cfset unreadCount = session.inbox.unreadCount()>
		<cfif unreadCount GT 0>
        (#unreadCount#)
        </cfif>
        </h5>

        
        <cfset typeList = 'Unread,Favorite,Read'>
        
        <cfloop list="#typeList#" index="type">
        
            <p class="inbox" id="#Type#">
            	<cfif Type EQ 'Unread'>
            		<i class="fa fa-envelope fa-lg"></i>
            	<cfelseif Type EQ 'Favorite'>
            		<i class="fa fa-star fa-lg"></i>
            	<cfelseif Type EQ 'Read'>
            		<i class="fa fa-envelope-o"></i>
            	</cfif>
					#type#
            </p>
            
            <div class="contentIndent">
            <ul class="email">
                <!--- Welcome letters ---> 
                <!--- ASAP --->
                #showMessage(1,type)#
                #showMessage(2,type)#
                #showMessage(3,type)#
                #showMessage(4,type)#
                
                
                <!--- Feb-ish --->
                #showMessage(6,type)#
                #showMessage(7,type)#
                #showMessage(12,type)#
                
                <!--- March --->
                #showMessage(28,type)#
                #showMessage(24,type)#
                #showMessage(25,type)#
                #showMessage(30,type)#
                #showMessage(41,type)#
                #showMessage(42,type)#
                #showMessage(11,type)# 
                #showMessage(18,type)#	
                #showMessage(8,type)#
                
                <!--- April --->
                #showMessage(5,type)#
                #showMessage(9,type)#
                #showMessage(10,type)#
                #showMessage(21,type)#
                #showMessage(27,type)#
                
                #showMessage(33,type)#
                
                <!--- May --->  
                #showMessage(20,type)#
                #showMessage(16,type)#
                #showMessage(22,type)#
                #showMessage(19,type)#
                
                #showMessage(37,type)#
                
                <!--- June --->
                #showMessage(15,type)#
				#showMessage(23,type)#
                
                <!--- July --->
                #showMessage(35,type)#
                                 
                #showMessage(34,type)#
                #showMessage(14,type)#
                #showMessage(26,type)#                
                #showMessage(31,type)# 
                #showMessage(17,type)#
                
                #showMessage(38,type)#
                #showMessage(39,type)#
                #showMessage(32,type)#
                #showMessage(13,type)#
                
                <!--- August --->  
                #showMessage(36,type)#      
                
                 <!--- transient --->
                #showMessage(29,type)# <!--- transient --->
                
                
            </ul>
            </div>   
    	</cfloop>
        </cfoutput>
    </cffunction>
    
    <cffunction name="showMessage">
        <cfargument name="numberIn" required="yes" type="numeric">
        <cfargument name="typeIn" required="yes">
        
        <cfset local={}>
        
        <!---<cfif evaluate('session.letter' & #numberIn# & 'read') eq '1'>--->
	   <cfif structKeyExists(session.inboxRead, numberIn)>
			<cfset letterRead = true>
        <cfelse>
        	<cfset letterRead = false>
        </cfif> 
        
        <cfquery name="local.checkFavorite" datasource="#application.roadtoDB#">
        select ID from inboxFavorites
        where bannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">
          and letter = <cfqueryparam value="#arguments.numberIn#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfif local.checkFavorite.recordCount GT 0>
			<cfset local.checkFavorite = true>
        <cfelse>
			<cfset local.checkFavorite = false>
        </cfif>
        
        <cfoutput>
		<cfif evaluate("session.messages.#numberIn#.display") or isdefined("url.showAll")>
			<cfif (typeIn EQ 'Read' and letterRead and not checkFavorite) OR (typeIn EQ 'Unread' and not letterRead) OR (typeIn EQ 'Favorite' and checkFavorite)>
                <li class="<cfif not letterRead>unread<cfelseif numberIn eq url.letter>reading<cfelse>read</cfif>"> 
                    <a href="/inbox/?letter=#numberIn#" class="<cfif not LetterRead>unread<cfelseif numberIn eq url.letter>reading<cfelse>read</cfif>"> 
                        #evaluate("session.messages.#numberIn#.title")# 
                    </a> 
                </li>
        	</cfif>
        </cfif>
        </cfoutput>
        
	</cffunction>
    
    <cffunction name="listMobileMessages" returntype="void">
    	<cfoutput>
        
        <cfset typeList = 'Unread,Favorite,Read'>
        
        <cfloop list="#typeList#" index="type">
        
            <li data-role="list-divider">#type#</li>
            
			<!--- Welcome letters ---> 
            <!--- ASAP --->
            #showMobileMessage(1,type)#
            #showMobileMessage(2,type)#
            #showMobileMessage(3,type)#
            #showMobileMessage(4,type)#
            
            
            <!--- Feb-ish --->
            #showMobileMessage(6,type)#
            #showMobileMessage(7,type)#
            #showMobileMessage(12,type)#
            
            <!--- March --->
            #showMobileMessage(28,type)#
            
            #showMobileMessage(24,type)# 
            #showMobileMessage(25,type)# 
            #showMobileMessage(30,type)# 
            #showMobileMessage(11,type)# 
            #showMobileMessage(18,type)#	
            #showMobileMessage(8,type)#
            
			<!--- April --->
            #showMobileMessage(5,type)#
            #showMobileMessage(9,type)#
            #showMobileMessage(10,type)#
            #showMobileMessage(21,type)#   
            #showMobileMessage(33,type)#
            
            <!--- May --->  
            #showMobileMessage(20,type)#
            #showMobileMessage(16,type)#
            #showMobileMessage(27,type)#
            #showMobileMessage(22,type)#
            #showMobileMessage(19,type)#
            
            #showMobileMessage(37,type)#
            
            <!--- June --->
            #showMobileMessage(15,type)#
			#showMobileMessage(23,type)# 
            
            <!--- July --->
            #showMobileMessage(35,type)#
            
            #showMobileMessage(34,type)#
            #showMobileMessage(14,type)#
            #showMobileMessage(26,type)# 
            #showMobileMessage(31,type)# 
            #showMobileMessage(17,type)#
            
            #showMobileMessage(38,type)#
            #showMobileMessage(39,type)#
            
            #showMobileMessage(32,type)#
            
            #showMobileMessage(13,type)#
            
            <!--- August --->  
            #showMobileMessage(36,type)#      
            
            #showMobileMessage(28,type)#  <!--- transient --->
            #showMobileMessage(29,type)# <!--- transient --->        
		</cfloop>
		</cfoutput>
    
    </cffunction>
    
    <!---
    <cffunction name="showMobileMessage">
        <cfargument name="numberIn" required="yes" type="numeric">
        <cfargument name="typeIn" required="yes">
        
        <cfif evaluate('session.letter' & #numberIn# & 'read') eq '1'>
			<cfset letterRead = true>
        <cfelse>
        	<cfset letterRead = false>
        </cfif> 
        
        <cfquery name="checkFavorite" datasource="#application.roadtoDB#">
        select ID from inboxFavorites
        where bannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">
          and letter = <cfqueryparam value="#arguments.numberIn#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif checkFavorite.recordCount GT 0><cfset checkFavorite = true><cfelse><cfset checkFavorite = false></cfif>
        
        <cfoutput>
		<cfif evaluate("session.messages.#numberIn#.display") or isdefined("url.showAll")>
        	<cfif (typeIn EQ 'Read' and letterRead and not checkFavorite) OR (typeIn EQ 'Unread' and not letterRead) OR (typeIn EQ 'Favorite' and checkFavorite)>
        	
                <li>
                    <a 	href="/inbox/read.cfm?letter=#numberIn#" 
                        class="<cfif evaluate('session.letter' & #numberIn # & 'read') neq 1>
                                unread
                               <cfelse>
                                read
                               </cfif>">#evaluate("session.messages.#numberIn#.title")#</a>
                </li>
        	</cfif>
        </cfif>
        </cfoutput>
        
	</cffunction>
	--->
    
    <cffunction name="isFavorite" returntype="boolean">
    	<cfargument name="letterIn" required="yes" type="numeric">
        
        <cfquery name="checkFavorite" datasource="#application.roadtoDB#">
        select ID from inboxFavorites
        where bannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">
          and letter = <cfqueryparam value="#arguments.letterIn#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif checkFavorite.recordCount GT 0><cfset checkFavorite = true><cfelse><cfset checkFavorite = false></cfif>
        
        <cfreturn checkFavorite>
	</cffunction>
    
    <cffunction name="addFavorite" returntype="void">
    	<cfargument name="letterIn" required="yes" type="numeric">
        
        <cfquery datasource="#application.roadtoDB#">
        insert into inboxFavorites(BannerID,letter)
        values(	<cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">,
         		<cfqueryparam value="#arguments.letterIn#" cfsqltype="cf_sql_integer">)
        </cfquery>

	</cffunction>
    
    <cffunction name="remFavorite" returntype="void">
    	<cfargument name="letterIn" required="yes" type="numeric">
        
        <cfquery datasource="#application.roadtoDB#">
        delete from inboxFavorites
        where bannerID = <cfqueryparam value="#session.bannerID#" cfsqltype="cf_sql_varchar">
          and letter = <cfqueryparam value="#arguments.letterIn#" cfsqltype="cf_sql_integer">
        </cfquery>

	</cffunction>
        
    
</cfcomponent>
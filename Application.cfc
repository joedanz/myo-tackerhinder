<cfcomponent displayname="Application" output="false" hint="Handle the application.">

	<!--- set up the application --->
	<cfset this.name 				= right(REReplace(getDirectoryFromPath(getCurrentTemplatePath()),'[^A-Za-z0-9]','','all'),64) />
	<cfset this.applicationTimeout	= createTimeSpan(1,0,0,0) />
	<cfset this.clientManagement 	= true />
	<cfset this.clientStorage 		= "cookie" />
	<cfset this.loginStorage 		= "cookie" />
	<cfset this.sessionManagement 	= true />
	<cfset this.sessionTimeout 		= createTimeSpan(0,3,0,0) />
	<cfset this.setClientCookies 	= true />
	<cfset this.setDomainCookies 	= false />
	<cfset this.scriptProtect 		= true />

	<!--- define the page request properties --->
	<cfsetting requesttimeout="60" enablecfoutputonly="false" />

	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false">	
		<cfset application.image = createObject("component","com.image").init(dsn='tackerhinder')>
		<cfset application.transloadit = createObject("component","com.Transloadit").init(authKey='d5228680803111e4abfeb54b1b4a5f65',secretKey='434a80e5c1d73a8dfc6ca2549d24476183ad3a4c')>
		<cfset application.user = createObject("component","com.user").init(dsn='tackerhinder')>
		<cfreturn true />
	</cffunction>


	<cffunction name="onSessionStart" access="public" returntype="void" output="false">
		
		<cfreturn />
	</cffunction>

	<cffunction name="onRequestStart" access="public" returntype="boolean" output="false">
		<cfargument name="TargetPage" type="string" required="true" />
		<cfif StructKeyExists(url,'reinit')>
			<cfset onApplicationStart()>
		</cfif>
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestEnd" access="public" returntype="void" output="true" hint="fires after the page processing is complete.">		

		<cfreturn />
	</cffunction>

	<cffunction name="onSessionEnd" access="public" returntype="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="applicationScope" type="struct" required="false" default="#structNew()#" />
		<cfset structDelete(arguments.applicationScope.sessions, arguments.sessionScope.urltoken)>
		<cfreturn />
	</cffunction>


	<cffunction name="onApplicationEnd" access="public" returntype="void" output="false" hint="fires when the application is terminated.">
		<cfargument name="applicationScope" type="struct" required="false" default="#structNew()#" />
		<cfreturn />
	</cffunction>


	<!---<cffunction name="onError" access="public" returntype="void" output="true" hint="fires when an exception occures that is not caught by a try/catch.">
		<cfargument name="Exception" type="any" required="true" />
		<cfargument name="EventName" type="string" required="false" default="" />
		
		<cfoutput>
		<h2>Sorry - An error has occured!</h2>
		</cfoutput>
		
		<cfreturn />
	</cffunction>--->

</cfcomponent>

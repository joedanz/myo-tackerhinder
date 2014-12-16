<cfcomponent displayName="Users" hint="Methods dealing with users.">

	<cfset variables.dsn = "">

	<cffunction name="init" access="public" returntype="user" output="false"
				hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfargument name="dsn" type="string" required="true" hint="Data Source">

		<cfset variables.dsn = arguments.dsn>

		<cfreturn this>
	</cffunction>
	
	<cffunction name="get" access="public" returntype="query" output="false"
				hint="Returns data on user.">
		<cfargument name="phone" type="string" required="false" default="" hint="Phone Number">
		<cfset var qGet = "">

		<cfquery name="qGet" datasource="#variables.dsn#">
			SELECT phone,uname,intro,imageURL FROM users
			WHERE 0=0
			<cfif compare(arguments.phone,'')>
				AND phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">
			</cfif>
		</cfquery>

		<cfreturn qGet>
	</cffunction>
	
	<cffunction name="getForRate" access="public" returntype="query" output="false"
				hint="Returns data on user.">
		<cfargument name="phone" type="string" required="false" default="" hint="Phone Number">
		<cfset var qGetForRate = "">

		<cfquery name="qGetForRate" datasource="#variables.dsn#">
			SELECT phone,uname,intro,imageURL FROM users
			WHERE phone != <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">
				<!---AND phone NOT IN (SELECT phone2 FROM user_likes
					WHERE phone1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">)--->
			ORDER BY RAND()
		</cfquery>

		<cfreturn qGetForRate>
	</cffunction>
	
	<cffunction name="getLikes" access="public" returntype="query" output="false"
				hint="Returns likes for user.">
		<cfargument name="phone" type="string" required="false" default="" hint="Phone Number">
		<cfset var qGetLikes = "">

		<cfquery name="qGetLikes" datasource="#variables.dsn#">
			SELECT phone,uname,intro,imageURL FROM users
			WHERE phone in (SELECT phone2 FROM user_likes where positive = 1
				AND phone1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">)
		</cfquery>

		<cfreturn qGetLikes>
	</cffunction>

	<cffunction name="add" access="public" returntype="boolean" output="false"
				hint="Inserts user to database.">
		<cfargument name="uname" type="string" required="true" hint="Name">
		<cfargument name="phone" type="string" required="true" hint="Phone Number">
		<cfargument name="intro" type="string" required="true" hint="Intro">
		<cfargument name="imageURL" type="string" required="true" hint="Image URL">
		
		<cfquery datasource="#variables.dsn#">
			INSERT INTO users (uname,phone,intro,imageURL)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.uname#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.intro#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.imageURL#">
			)
		</cfquery>

		<cfreturn true>
	</cffunction>
	
	<cffunction name="addLike" access="public" returntype="boolean" output="false"
				hint="Inserts user like to database.">
		<cfargument name="phone1" type="string" required="true" hint="Phone Number 1">
		<cfargument name="phone2" type="string" required="true" hint="Phone Number 2">
		<cfargument name="positive" type="numeric" required="true" hint="Rating">
		
		<cfquery datasource="#variables.dsn#">
			INSERT INTO user_likes (phone1, phone2, positive)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone2#">,
				<cfqueryparam cfsqltype="cf_sql_tinyint" value="#arguments.positive#">
				
			)
		</cfquery>

		<cfreturn true>
	</cffunction>

</cfcomponent>
<cfcomponent displayName="Images" hint="Methods dealing with images.">

	<cfset variables.dsn = "">

	<cffunction name="init" access="public" returntype="any" output="false"
				hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfargument name="dsn" type="string" required="true" hint="Data Source">

		<cfset variables.dsn = arguments.dsn>

		<cfreturn this>
	</cffunction>
	
	<cffunction name="get" access="public" returntype="query" output="false"
				hint="Returns data on images.">
		<cfargument name="phone" type="string" required="false" default="" hint="Phone Number">
		<cfset var qGet = "">

		<cfquery name="qGet" datasource="#variables.dsn#">
			SELECT imageID,phone,imageURL FROM images
			WHERE 0=0
			<cfif compare(arguments.phone,'')>
				AND phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">
			</cfif>
		</cfquery>

		<cfreturn qGet>
	</cffunction>

	<cffunction name="add" access="public" returntype="boolean" output="false"
				hint="Inserts image to database.">
		<cfargument name="imageID" type="string" required="true" hint="Image ID">
		<cfargument name="phone" type="string" required="true" hint="Phone Number">
		<cfargument name="imageURL" type="string" required="true" hint="Image URL">
		
		<cfquery datasource="#variables.dsn#">
			INSERT INTO images (imageID,phone,imageURL)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.imageID#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.imageURL#">
			)
		</cfquery>

		<cfreturn true>
	</cffunction>

</cfcomponent>
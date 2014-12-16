<cfif isDefined('form')>
	<cfset getUser = application.user.get(phone=right(form.from,10))>
	<cfif getUser.recordCount>
		<!--- user already exists --->
		<cfsavecontent variable="OutXML"><?xml version="1.0" encoding="UTF-8" ?>
			<cfoutput>
			<Response>
			    <Message>Sorry, you can only sign up once!</Message>
			</Response>
			</cfoutput>
		</cfsavecontent>
	<cfelse>
		<cfif form.NumMedia eq 0 or form.body is ''>
			<!--- no images or no name --->
			<cfsavecontent variable="OutXML"><?xml version="1.0" encoding="UTF-8" ?>
				<cfoutput>
				<Response>
				    <Message>You must provide at least 1 image and your name.</Message>
				</Response>
				</cfoutput>
			</cfsavecontent>
		<cfelse>
			<!--- write data to database --->
			<cfset userName = listFirst(form.body,' ')>
			<cfset uNameLen = len(userName)>
			<cfset application.user.add(phone=right(form.from,10),uname=userName,intro=right(form.body,len(form.body)-(uNameLen+1)),imageURL=form.MediaUrl0)>
			<cfset mediaURLs = "">
			<cfloop from="0" to="#form.NumMedia-1#" index="i">
				<cfhttp url="#evaluate('form.MediaUrl'&i)#" result="result">
				</cfhttp>
				<cffile action="write" file="#ExpandPath('../work/')#media#i#.jpg" output="#result.FileContent#">
				<cfset application.image.add(imageID=createUUID(),phone=right(form.from,10),imageURL=evaluate('form.MediaUrl'&i))>
			</cfloop>
			<!---<cfscript>
				expirationDate = dateAdd('h',6,now()); 
				expirationDateFormatted = dateFormat( expirationDate, 'YYYY/MM/DD') & ' ' & 
					timeFormat(expirationDate, 'HH:mm:ss') & '+00:00'; 
				params = {
					auth = {
						expires = expirationDateFormatted,
						key = 'd5228680803111e4abfeb54b1b4a5f65'
					},
					steps = { 
						imported = {
							robot = "/http/import", 
							url = "#mediaURLs#",
							url_delimiter = ",",
							use = ":original"
						},
						resize = { 
							robot = "/image/resize", 
							width = 300, 
							height = 400,
							use = "imported"
						}
					}
				};
				stringToSign = replace(lcase(serializeJson(params)),'\/','/','all');
				signature = application.transloadit.signArray(params);
				files = arrayNew(1);
			</cfscript>
			<cfloop from="0" to="#form.NumMedia-1#" index="i">
				<cfset files[i] = expandPath('../work/' & 'media#i#.jpg')>
			</cfloop>
			<cfset application.transloadit.createAssembly(params=lcase(serializeJson(params)),signature=signature)>
			--->
			<cfsavecontent variable="OutXML"><?xml version="1.0" encoding="UTF-8" ?>
				<cfoutput>
				<Response>
				    <Message>Hello, thanks for joining #listFirst(form.body,' ')#.  Visit http://hack14.ticc.net to find like minded developers!</Message>
				</Response>
				</cfoutput>
			</cfsavecontent>
			<cfmail from="admin@ticc.net" to="joe@ticc.net" subject="Twilio Request" type="html">
				<cfdump var="#form#">
			</cfmail>
		</cfif>
	</cfif>

	<cfcontent type="text/xml" reset="true"><cfheader name="content-type" value="text/xml"><cfoutput>#OutXML#</cfoutput><cfabort>
</cfif>
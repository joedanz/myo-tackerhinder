<cfsavecontent variable="OutXML"><?xml version="1.0" encoding="UTF-8" ?>
	<Response>
		<Say>Please text a picture of yourself along with your first name followed by an intro sentence.</Say>
	</Response>
</cfsavecontent>

<cfcontent type="text/xml" reset="true"><cfheader name="content-type" value="text/xml"><cfoutput>#OutXML#</cfoutput><cfabort>
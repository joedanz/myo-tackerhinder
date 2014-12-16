<cfcomponent displayName="Transloadit" hint="Transloadit Base Methods.">
	
	<cfset variables.authKey = "">
	<cfset variables.secretKey = "">
	<cfset variables.encoding = "UTF-8">
	
	<cffunction name="init" access="public" returnType="Transloadit" output="false"
				hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfargument name="authKey" type="string" required="true" hint="Transloadit Auth Key.">
		<cfargument name="secretKey" type="string" required="true" hint="Transloadit Auth Key.">
		<cfargument name="encoding" type="string" required="false" default="UTF-8" hint="Transloadit Encoding.">

		<cfset variables.authKey = arguments.authKey>
		<cfset variables.secretKey = arguments.secretKey>
		<cfset variables.encoding = arguments.encoding>

		<cfreturn this>
	</cffunction>

	<cffunction name="createAssembly" access="public" output="false" return="struct"
		hint="Creates assembly with Transloadit API.">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfargument name="files" type="array" required="true">
		<cfset var result = "">
		<cfset var boredInstance = "">
		
		<cfhttp url="https://api2.transloadit.com/instances/bored" method="get" result="result"/>
		
		<cfset boredInstance = deserializeJSON(result.filecontent)>
		
		<cfhttp url="https://#boredInstance.api2_host#/assemblies" method="post" result="result">
			<cfhttpparam type="formfield" name="params" value="#arguments.params#">
			<cfhttpparam type="formfield" name="signature" value="#arguments.signature#">
			<cfloop array="#arguments.files#" index="f">
			    <cfhttpparam type="file" file="#f#" name="">
			</cfloop>
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="getAssembly" access="public" output="false" return="struct"
		hint="Get assembly status with Transloadit API.">
		<cfargument name="assemblyURL" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="#arguments.assemblyURL#" method="get" result="result">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>

	<cffunction name="deleteAssembly" access="public" output="false" return="struct"
		hint="Delete assembly with Transloadit API.">
		<cfargument name="assemblyURL" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="#arguments.assemblyURL#" method="delete" result="result">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="replayAssembly" access="public" output="false" return="struct"
		hint="Replay assembly with Transloadit API.">
		<cfargument name="assemblyID" type="string" required="true">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/assemblies/#arguments.assemblyID#/replay" method="post" result="result">
			<cfhttpparam type="formfield" name="params" value="#arguments.params#">
			<cfhttpparam type="formfield" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>

	<cffunction name="listAssemblies" access="public" output="false" return="struct"
		hint="List assemblies with Transloadit API.">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/assemblies" method="get" result="result">
			<cfhttpparam type="url" name="params" value="#arguments.params#">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>	
	</cffunction>
	
	<cffunction name="listAssemblyNotifications" access="public" output="false" return="struct"
		hint="List assembly notifications with Transloadit API.">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/assembly_notifications" method="get" result="result">
			<cfhttpparam type="url" name="params" value="#arguments.params#">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="replayAssemblyNotification" access="public" output="false" return="struct"
		hint="Replay assembly notification with Transloadit API.">
		<cfargument name="assemblyID" type="string" required="true">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/assembly_notifications/#arguments.assemblyID#/replay" method="post" result="result">
			<cfhttpparam type="formfield" name="params" value="#arguments.params#">
			<cfhttpparam type="formfield" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="createTemplate" access="public" output="false" return="struct"
		hint="Create template with Transloadit API.">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/templates" method="post" result="result">
			<cfhttpparam type="formfield" name="params" value="#arguments.params#">
			<cfhttpparam type="formfield" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="getTemplate" access="public" output="false" return="struct"
		hint="Get template details with Transloadit API.">
		<cfargument name="templateID" type="string" required="true">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/templates/#arguments.templateID#" method="get" result="result">
			<cfhttpparam type="url" name="PARAMS" value="#arguments.params#">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="editTemplate" access="public" output="false" return="struct"
		hint="Edit template with Transloadit API.">
		<cfargument name="templateID" type="string" required="true">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/templates/#arguments.templateID#" method="put" result="result">
			<cfhttpparam type="formfield" name="params" value="#arguments.params#">
			<cfhttpparam type="formfield" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="deleteTemplate" access="public" output="false" return="struct"
		hint="Delete template with Transloadit API.">
		<cfargument name="templateID" type="string" required="true">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/templates/#arguments.templateID#" method="delete" result="result">
			<cfhttpparam type="url" name="params" value="#arguments.params#">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="listTemplates" access="public" output="false" return="struct"
		hint="List templates with Transloadit API.">
		<cfargument name="params" type="string" required="true">
		<cfargument name="signature" type="string" required="true">
		<cfset var result = "">
		
		<cfhttp url="http://api2.transloadit.com/templates" method="get" result="result">
			<cfhttpparam type="url" name="params" value="#arguments.params#">
			<cfhttpparam type="url" name="signature" value="#arguments.signature#">
		</cfhttp>
 
 		<cfreturn deserializeJSON(result.filecontent)>
	</cffunction>
	
	<cffunction name="signArray" access="public" output="false" hint="Create signature for talking to Transloadit API.">
		<cfargument required="true" type="any" name="arrayToEncode">
		<cfargument required="false" type="string" name="algorithm" default="HMACSHA1">
		<cfargument required="false" type="string" name="encoding" default="#variables.encoding#">

		<cfreturn _hmac(replace(lcase(serializeJSON(arguments.arrayToEncode)),'\/','/','all'), variables.secretKey, 
			arguments.algorithm, arguments.encoding)>
	</cffunction>
	
	<cffunction name="_hmac" access="private" output="false" 
		hint="Creates Hash-based Message Authentication Code for the given string or byte 
		array based on the algorithm and encoding">
	
		<cfargument required="true" name="message" hint="can be string or byte array"/>
		<cfargument required="true" name="key" hint="can be string or byte array"/>
		<cfargument type="string" name="algorithm" default="HMACMD5" hint="HMACMD5, 
			HMACSHA1, HMACSHA256, HMACSHA384, HMACSHA512, HMACRIPEMD160, HMACSHA224"/>
		<cfargument type="string" name="encoding" default="#variables.encoding#" hint="encoding to use"/>
	
		<cfscript>
			var byteMessage = "";
			var byteKey = "";
			var javaKey = "";
			var javaMac = "";
			
			if (!isBinary(arguments.message)) {
				byteMessage = charsetDecode(arguments.message, arguments.encoding);
			} else {
				byteMessage = arguments.message;
			}
			
			if (!isBinary(arguments.key)) {
				byteKey = charsetDecode(arguments.key, arguments.encoding);
			} else {
				byteKey = arguments.key;
			}

			javaKey = createObject("java","javax.crypto.spec.SecretKeySpec").init(byteKey, arguments.algorithm);
			javaMac = createObject("java","javax.crypto.Mac").getInstance(arguments.algorithm);
			javaMac.init(javaKey);

			return binaryEncode(javaMac.doFinal(byteMessage), "hex");
		</cfscript>
	</cffunction>

</cfcomponent>
<cfif StructKeyExists(form,'phone')>
	<cfset session.phone = right(form.phone,10)>
<cfelseif StructKeyExists(form,'p')>
	<cftry>
		<cfset application.user.addLike(session.phone,form.p,form.pos)>
		<cfcatch></cfcatch>
	</cftry>
</cfif>

<cfif StructKeyExists(session,'phone')>
	<cfset user = application.user.getForRate(phone=session.phone)>
</cfif>

<!DOCTYPE html>
<html>
	<head>
		<title>Tacker Hinder</title>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<!-- CSS Reset --->
		<link rel="stylesheet" href="http://reset5.googlecode.com/hg/reset.min.css">
		<!-- bootstrap -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
		<!--- MYO.JS --->
		<script src="./js/myo.js"></script>
		<script type="text/javascript">
		   $(function() {
		     var myMyo = Myo.create();
		     myMyo.on('fingers_spread', function(edge){
			    if(!edge) return;
			    myMyo.vibrate();
			    window.location.href='favorites.cfm';
			 });
			 
			 <cfif isDefined("user") and StructKeyExists(user,'phone') and compare(user.phone,'')>
			 myMyo.on('wave_in', function(edge){
			    if(!edge) return;
			    myMyo.vibrate();
			    $.ajax({
				    url: "index.cfm", 
				    data: 'p=<cfoutput>#user.phone#</cfoutput>&pos=0',
				    type: 'post',
				    error: function(data){
						alert(data.statusText);
					},
				    success: function(data){
				    	window.location.href='index.cfm';
				    }
		    	});
			 });
			 
			myMyo.on('wave_out', function(edge){
			    if(!edge) return;
			    myMyo.vibrate();
			    $.ajax({
				    url: "index.cfm", 
				    data: 'p=<cfoutput>#user.phone#</cfoutput>&pos=1',
				    type: 'post',
				    error: function(data){
						alert(data.statusText);
					},
				    success: function(data){
				    	window.location.href='index.cfm';
				    }
		    	});
			 });
			 </cfif>
		   });
		</script>
		<style>
			body { padding:0 20px; }
		</style>
	</head>
	<body>
		<h1>Tacker Hinder - http://hack14.ticc.net</h1>
		<h4><div class="alert alert-info" role="alert">To participate, send a photo of yourself to (646) 362-6162 and include your first name followed by a short intro.</div></h4>
		<h3>Code or Not?</h3>
		<cfif not StructKeyExists(session,'phone')>
			<form method="post">
				Phone: <input type="text" name="phone">
				<input type="submit" value="Submit">
			</form>
		<cfelse>
			<cfif not user.recordCount>
				<h3>There are no more hackers to rate.</h3>
			<cfelse>
				<cfoutput><img src="#user.imageURL#" height="400" class="thumbnail"><h3><strong>#user.uname#</strong><br/>#user.intro#</cfoutput></h3>
				<div class="alert alert-info" role="alert"><h4>Swipe left to lose, right to keep.</h4></div>				
			</cfif>
		</cfif>
	</body>
</html>
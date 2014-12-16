<cfset users = application.user.getLikes(phone=session.phone)>

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
		     myMyo.on('fist', function(edge){
			    if(!edge) return;
			    myMyo.vibrate();
			    window.location.href='index.cfm';
			 });
		   });
		</script>
		<style>
			body { padding:0 20px; }
			li { list-style:none; }
		</style>
	</head>
	<body>
		<h1>Tacker Hinder - Your Favorites</h1>
		
		<cfif users.recordCount>
		
		<cfoutput query="users">
			<div style="padding:15px;float:left;"><img src="#imageURL#" height="200"><br/><strong>#uname#</strong><br/>#intro#</div>
		</cfoutput>
		
		<cfelse>
			<h3>You have not liked any users yet.</h3>
		</cfif>
	</body>
</html>
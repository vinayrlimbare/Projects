<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">

<html>
<head>
<title>Home</title>
<style type="text/css">
.sign_in { : white;
	
}
</style>
</head>
<body>
	<div id="fullscreen_bg" class="fullscreen_bg" />

	<div class="container">
		<div class="row">
			<div class="resize-signing"
				style="position:absolute; right:0px;">
				<form action="register"><button class="btn btn-lg" type="submit" value="Register">Sign up</button></form>
			</div></div>
		<form:form method="POST" commandName="user" class="form-signin">
			<h1 class="form-signin-heading text-muted">Northeastern Dating</h1>
			<div class="resize-signing" />
			<form:input path="username" class="form-control"
				placeholder="Username" required="" autofocus="" />
			<form:password path="password" class="form-control"
				placeholder="Password" required="" />
			<button class="btn btn-lg btn-primary btn-block" type="submit">
				Sign In</button>
			<div class="checkbox">
				<h4>
					<label><input type="checkbox" name="Remember" value="">Keep me signed in</label>
				</h4>
			</div>
		</form:form>
	</div>
</body>
</html>

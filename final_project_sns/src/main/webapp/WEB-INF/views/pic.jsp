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
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Upload Profile Picture</title>
<style type="text/css">
body {
	background-image: url('./resources/images/background/1234.jpg');
	background-repeat: repeat;
	background-position: fixed;
	background-size: cover;
}
</style>
</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-6">
					<h1>${msg }</h1>
					<h1>Upload your profile picture</h1>
					<div id="msg"></div>
					<div class="form-group">
						<form:form commandName="pPic" enctype="multipart/form-data"
							action="pic2" id="form">
 File: <form:input type="file" path="profilePic" name="file" id="file" />
							<br />
							<form:button type="submit" class="btn btn-primary" id="submit">Upload</form:button>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

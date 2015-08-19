<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Northeastern Dating Site</title>
<style type="text/css">
html, body {
	overflow: hidden;
}

body {
	background-image: url('./resources/images/background/1234.jpg');
	background-repeat: repeat;
	background-position: fixed;
	background-size: cover;
	margin: 0px;
}

.navbar {
	background: rgba(255, 255, 255, 0.4);
}

.navbar-brand {
	font-family: serif;
	font-size: 35px;
}
</style>
</head>
<body>
	<div class="navbar transparent navbar-inverse navbar-fixed-top">
		<nav class="navbar-inner">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand">Northeastern University Dating Site</a>
				</div>
				<div>
					<ul class="nav navbar-nav navbar-right">
					<li><a href="#">Welcome ${fname} ${lname}!!!</a></li>
						<li><a href="logout" target="_parent">Logout</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
</body>
</html>
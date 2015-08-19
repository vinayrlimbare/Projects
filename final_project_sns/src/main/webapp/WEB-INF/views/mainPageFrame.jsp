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
<style type="text/css">
body {
	background-image: url('./resources/images/background/1234.jpg');
	background-repeat: repeat;
	background-position: fixed;
	background-size: cover;
}
</style>
<script>
	$(document).ready(function() {
		$(".vinyviny").hide();
		$('#side-menu').click(function() {
			$(".vinyviny").toggle("slow");
		});
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Northeastern Dating Site</title>
<style type="text/css">
.container-fluid {
	padding: 0px;
}

.col-md-2 {
	padding-left: 1px;
	padding-right: 2px;
}

html, body {
	overflow: hidden;
}
</style>
<style type="text/css">
.vinyviny {
	padding-left: 25px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="sidebar">
			<div class="col-md-2" >
				<ul class="nav nav-pills nav-stacked clr" >
					<li class="active"><a href="#"
						onclick="location.reload(true);">Home</a></li>
					<li><a href="userProfile" target="test">My Profile</a></li>
					<li><a href="friendList" target="test">Friends</a></li>
					<li><a href="showMessages" target="test">Messages</a></li>
					<li><a href="search" target="test">Search</a></li>
					<li><a href="searchGroup" target="test">Search Group</a></li>
					<li><a href="#" id="side-menu">My Groups</a></li>
					<c:forEach var="list" items="${gList}">
						<li><div class="sub-menu-trans-style">
								<a href="showGroupMessages?gid=${list.group.gId}" target="test"
									class="vinyviny"><c:out value="${list.group.gName}"></c:out></a>
							</div></li>
					</c:forEach>
					<li><a href="createGroup" target="test">Create Group</a></li>
					<li><a href="test" target="test">Find a Date</a></li>
					<li><a href="changePassword" target="test">Change Password</a></li>
					<li><a href="pic" target="test">Picture</a></li>
					<li><a href="logout" target="_parent">Logout</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
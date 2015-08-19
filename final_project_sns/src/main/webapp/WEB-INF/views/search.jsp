<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">
	
</script>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
</head>
<body>
	<%-- <form:form method="POST" commandName="userProfile" action="search"> --%>
	<form:form method="POST" action="search">
		<div class="container">
			<h1>Search for People</h1>
			<div class="row">
				<div class="col-md-6 col-sm-offset-0">
					<div class="panel panel-default">
						<div class="panel-heading c-list"
							style="box-shadow: 20px 20px 50px #888888;">
							<span class="title">Search</span>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="input-group c-search"
									style="box-shadow: 20px 20px 50px #888888; background: rgba(255, 255, 255, 0.4);">
									<input type="text" name="name" class="form-control"
										id="contact-list-search"> <span
										class="input-group-btn">
										<button class="btn btn-default" type="submit">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>

					<c:if test="${not empty msg}">
						<div class="alert alert-info"
							style="box-shadow: 20px 20px 50px #888888; margin-bottom: 0px;">
							<c:out value="${msg}"></c:out>
						</div>
					</c:if>
					
					<ul class="list-group" id="contact-list">

						<c:forEach var="userProfile" items="${sList}">
							<li class="list-group-item"
								style="box-shadow: 20px 0px 50px #888888; background: rgba(255, 255, 255, 0.4);">
								<div class="col-xs-12 col-sm-3">
									<img class="img-responsive img-circle"
										src='/sns/resources/images/profilepic/<c:out value="${userProfile.image}"></c:out>.jpg' />
								</div>
								<div class="col-xs-12 col-sm-9">
									<span class="name"><c:out value="${userProfile.fname}" />
										<c:out value="${userProfile.lname}" /></span> <a
										href=addFriend?friendname=${userProfile.username}>
										<button type="button" class="btn btn-primary"
											style="float: right;">Add Friend</button>
									</a><br /> <span
										class="glyphicon glyphicon-map-marker text-muted c-info"
										data-toggle="tooltip"></span>
									<c:out value="${userProfile.city}, ${userProfile.state}" />
									<span class="visible-xs"><br /></span><br /> <span
										class="glyphicon glyphicon-earphone text-muted c-info"
										data-toggle="tooltip"></span>
									<c:out value="${userProfile.mobile}" />
									<span class="visible-xs"><br /></span><br /> <span
										class="glyphicon glyphicon-envelope text-muted c-info"
										data-toggle="tooltip"></span>
									<c:out value="${userProfile.email}" />
									<span class="visible-xs"><br /></span><br /> <span
										class="glyphicon glyphicon-user text-muted c-info"
										data-toggle="tooltip"></span> <a
										href=userPublicProfile?username=${userProfile.username}>
										View Profile</a> <span class="visible-xs"><br /></span>
								</div>
								<div class="clearfix"></div>
							</li>
							<br />
						</c:forEach>
					</ul>
					<!-- </div> -->
				</div>
			</div>
		</div>
	</form:form>
</body>
</html>
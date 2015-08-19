<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search for Groups</title>
</head>

<body>
	<form:form method="POST" action="searchGroup">
		<div class="container">
			<h1>Search for Group</h1>
			<div class="row">
				<div class="col-xs-12 col-sm-offset-0 col-sm-6">
					<div class="panel panel-default" style="box-shadow: 20px 20px 50px #888888; background:rgba(255,255,255,0.4);">
						<div class="panel-heading c-list">
							<span class="title">Search for Group</span>
						</div>

						<div class="row">
							<div class="col-xs-12">
								<div class="input-group c-search">
									<input type="text" name="gname" class="form-control"
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
					<ul class="list-group" id="contact-list">
						<c:forEach var="list" items="${gList}">
							<li class="list-group-item" style="box-shadow: 20px 20px 50px #888888; background:rgba(255,255,255,0.4);">
								<div class="col-xs-12 col-md-12">
									<span class="glyphicon glyphicon-list-alt text-muted c-info"
										data-toggle="tooltip"></span> <span class="name"><c:out
											value="${list.gName}" /></span> <a href="joinGroup?gid=${list.gId}">
										<button type="button" class="btn btn-primary"
											style="float: right;">Join Group</button>
									</a><br /> <span
										class="glyphicon glyphicon-align-justify text-muted c-info"
										data-toggle="tooltip"></span>
									<c:out value="${list.gDesc}" />
									<span class="visible-xs"><br /></span><br />
								</div>
								<div class="clearfix"></div>
							</li>
							<br/>
						</c:forEach>
					</ul>
					<!-- </div> -->

				</div>
			</div>
		</div>
	</form:form>
</body>
</html>
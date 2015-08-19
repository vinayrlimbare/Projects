<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<html>
<head>
<style type="text/css">
body {
	background-image:
		url('./resources/images/background/1234.jpg');
	background-repeat: repeat;
	background-position: fixed;
	background-size: cover;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Show Messages</title>
</head>
<body>
	<div class="container">
		<h1>Personal Messages</h1>
		<div class="row">
			<div class="col-md-6">
				<c:if test="${empty message}">
					<div class="alert alert-info">No Messages to Display</div>
				</c:if>
				<ul class="list-group" id="contact-list">

					<c:forEach var="list" items="${message}">
						<div class="panel panel-default" style="box-shadow: 20px 20px 50px #888888; background:rgba(255,255,255,0.4);">

							<div class="panel-heading c-list" >
								<span class="title"><c:out value="${list.messageId}"></c:out></span>
							</div>
							<div class="col-xs-12 col-sm-9">
								<br /> <span class="glyphicon glyphicon-user text-muted c-info"
									data-toggle="tooltip"></span> <span class="name"><c:out
										value="${list.fromUser}" /></span><br /> <br /> <span
									class="glyphicon glyphicon-envelope text-muted c-info"
									data-toggle="tooltip"></span>
								<c:out value="${list.message}" />
								<span class="visible-xs"><br /></span><br /> <br /> <a
									href='replyMessage?toUser=${list.fromUser}&mid=${list.messageId}'><span
									class="glyphicon glyphicon-repeat"></span>Reply</a> <a
									href="deleteMessage?mid=${list.messageId}"
									style="padding: 20px"> <span
									class="glyphicon glyphicon-trash"></span>Delete Message
								</a> <br />
							</div>
							<div class="clearfix"></div>
						</div>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	
</body>
</html>
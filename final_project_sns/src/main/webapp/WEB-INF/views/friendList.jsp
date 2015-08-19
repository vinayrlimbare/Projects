<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Friend List</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	$(function() {
		$('#pending').hide();
		$('#testmsg').hide();
	});
	$(document).ready(function() {
		$(".edit").click(function() {
			$("#pending").slideToggle();
		});
	});

	function reply(id) {
		var newid = id;
		var newmsg = $("#msg").val();
		$("#testmsg").slideDown();
		$("#main").slideUp();
		$("#username").attr("value", id);
	}

	function revoke() {
		$("#testmsg").slideUp();
		$("#main").slideDown();
	}
	/*function snd(){
	 var 
	 } */
</script>
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
	<!-- col-sm-offset-0 col-sm-6 -->
	<div class="container">
		<h1>Friend List</h1>
		<div id="main">
			<div class="row">
				<div class="col-xs-6">
					<div class="panel panel-default" id="mainList"
						style="box-shadow: 20px 20px 50px #888888; background: rgba(255, 255, 255, 0.4);">
						<div class="panel-heading c-list">
							<span class="title">Friend List</span>
						</div>

						<div class="row">
							<div class="col-xs-6"></div>
						</div>

						<ul class="list-group" id="contact-list">
							<c:forEach var="list" items="${fList}">
								<li class="list-group-item">
									<div class="col-xs-6 col-sm-3">
										<img class="img-responsive img-circle"
											src='/sns/resources/images/profilepic/<c:out value="${list.image}"></c:out>.jpg' />
									</div>
									<div class="col-xs-6 col-sm-9">
										<span class="name"><c:out value="${list.fname}" /> <c:out
												value="${list.lname}" /></span>
												<a href="deleteFriend?fName=${list.username}">
												<span class="glyphicon glyphicon-remove" style="float:right;"></span></a>
												<br /> <span
											class="glyphicon glyphicon-map-marker text-muted c-info"
											data-toggle="tooltip"></span>
										<c:out value="${list.city}, ${list.state}" />
										<span class="visible-xs"><br /></span><br /> <span
											class="glyphicon glyphicon-earphone text-muted c-info"
											data-toggle="tooltip"></span>
										<c:out value="${list.mobile}" />
										<span class="visible-xs"><br /></span><br /> <span
											class="glyphicon glyphicon-envelope text-muted c-info"
											data-toggle="tooltip"></span>
										<c:out value="${list.email}" />
										<span class="visible-xs"><br /></span><br /> <span
											class="glyphicon glyphicon-user text-muted c-info"
											data-toggle="tooltip"></span> <a
											href=userPublicProfile?username=${list.username}> View
											Profile</a> <span class="visible-xs"><br /></span><br />
										<button class="btn btn-primary" id="test"
											onclick="reply('${list.username}')">Send Message</button>

									</div>
									<div class="clearfix"></div>
								</li>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- Send msg form -->
		<div id="testmsg">
			<h1>New Message</h1>
			<div class="row">
				<div class="col-md-6">
					<form method="get" action="sendNewMessage">
						<textarea id="msg" rows="5" cols="50" name="msg" style="box-shadow: 20px 20px 50px #888888;"></textarea>
						<br /> <input type="hidden" name="username" id="username" value="">
						<button class="btn btn-primary" type="submit">Send
							message</button>
						<button class="btn btn-primary" type="button" id="rev"
							onclick="revoke()">Cancel</button>
					</form>
				</div>
			</div>
		</div>
		<br />
		<button class="edit btn btn-primary">Show/hide Pending
			Request</button>
	</div>

	<!-- pending request -->
	<div class="container">
		<div id="pending">

			<h1>Friend Request</h1>
			<div class="row">
				<div class="col-xs-6">
					<div class="panel panel-default">
						<div class="panel-heading c-list" style="box-shadow: 20px 0px 50px #888888;">
							<span class="title">Friend Requests</span>
						</div>
						<c:if test="${empty fpList}">
							<div class="alert alert-info" style="box-shadow: 20px 20px 50px #888888; margin-bottom: 0px;">No
								Friend Requests</div>
						</c:if>
						<div class="row">
							<div class="col-xs-12"></div>
						</div>

						<ul class="list-group" id="contact-list" >
							<c:forEach var="list" items="${fpList}">
								<li class="list-group-item" style="box-shadow: 20px 20px 50px #888888; background:rgba(255,255,255,0.4);">
									<div class="col-xs-12 col-sm-3">
										<img class="img-responsive img-circle"
											src='/sns/resources/images/profilepic/<c:out value="${list[9]}"></c:out>.jpg' />
									</div>
									<div class="col-xs-12 col-sm-9" >
										<span class="name"><c:out value="${list[1]}" /> <c:out
												value="${list[2]}" /></span><br /> <span
											class="glyphicon glyphicon-map-marker text-muted c-info"
											data-toggle="tooltip"></span>
										<c:out value="${list[6]}, ${list[7]}" />
										<span class="visible-xs"><br /></span><br /> <span
											class="glyphicon glyphicon-earphone text-muted c-info"
											data-toggle="tooltip"></span>
										<c:out value="${list[4]}" />
										<span class="visible-xs"><br /></span><br /> <span
											class="glyphicon glyphicon-envelope text-muted c-info"
											data-toggle="tooltip"></span>
										<c:out value="${list[5]}" />
										<span class="visible-xs"><br /></span><br /> <span
											class="glyphicon glyphicon-user text-muted c-info"
											data-toggle="tooltip"></span> <a
											href=userPublicProfile?username= <c:out value='${list[0]}'/>>
											View Profile</a><br /> <a href=confirmRequest?uname=${list[0]}>
											<button class="btn btn-primary" style="float: left">Accept
												Friend Request</button>
										</a> <a href=rejectRequest?uname=${list[0]}>
											<button class="btn btn-warning">Reject Request</button>
										</a>

									</div>
									<div class="clearfix"></div>
								</li>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
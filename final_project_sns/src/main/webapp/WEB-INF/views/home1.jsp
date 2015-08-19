<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Northeastern Dating Site</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link href="<c:url value="/resources/css/login1.css" />"
	rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-12">
					<div class="wrap">
						<p class="form-title">Sign In</p>
						<form:form class="login" commandName="user">
							<form:input type="text" path="username" placeholder="Username" />
							<form:errors path="username" cssStyle="color:#ff0000"></form:errors> 
							
							<form:input type="password" path="password" placeholder="Password" />
							<form:errors path="password" cssStyle="color:#ff0000"/>
							<div class="col-md-12">
								<input type="submit" value="Sign In"
									class="btn btn-success btn-sm" />
							</div>
							<div class="remember-forgot">
								<div class="row">
									<div class="col-md-6">
										<div class="checkbox">
											<label> <input type="checkbox" name="Remember" value=""/> Remember Me
											</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<label>Not registered? <a href="register">Click
												here</a> to Register now
										</label>
									</div>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
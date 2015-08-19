<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Northeastern Dating Site</title>
</head>
<div class="container">
	<div class="container-fluid" >
		<div class="row">
			<div class="col-md-6">
				<h2>Welcome to Northeastern Dating Site</h2>
				<h3>Have a Happy search !!!</h3>

				<form:form method="POST" commandName="userProfile" action="findMatch">
					<div class="col-md-4">
						<h4>I am looking for</h4>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<form:select path="gender" items="${genderList}"
								class="form-control"></form:select>
						</div>
					</div>
					<div class="col-md-4">
						<h4>Who is from</h4>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<form:select path="state" items="${stateList}"
								class="form-control"></form:select>
						</div>
					</div>
										<div class="col-md-4">
						<h4>Age</h4>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<input type="number" name="age1" value="18"
								class="form-control" required="required">
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<input type="number" name="age2" value="35"
								class="form-control" required="required">
						</div>
					</div>
					<div class="col-md-4">
						<h4>Who smokes</h4>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<form:select path="smoking"  class="form-control">
							<form:option value="---"></form:option>
							<form:option value="Yes">Yes</form:option>
							<form:option value="No">No</form:option>
							</form:select>
						</div>
					</div>
					<div class="col-md-4">
						<h4>Who Drinks</h4>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<form:select path="drinking"
								class="form-control">
								<form:option value="---"></form:option>
								<form:option value="Yes">Yes</form:option>
								<form:option value="No">No</form:option></form:select>
						</div>
					</div><br/>
					
					
					<div class="col-md-12">
					<br/>
					<button class="col-md-4 col-md-offset-3 btn btn-success">Find a match</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
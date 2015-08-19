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
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">
	
</script>

<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">
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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#submit").prop("disabled",true);
	$("#username").keyup(function(){
		var username = $("#username").val();
		$.ajax({
			type: 'GET',
			data: 'username='+username,
			url: 'checkAvailability',
			success: function(response){
				if(response=="0"){
					$("#msg").html("Username is available");
					$("#msg").css("color","green");
				}
				else {
					$("#msg").html("Username is not available");
					$("#msg").css("color","red");
					$("#submit").prop("disabled",true);
				}
			}
		});
	});
	
	$("#p2").keyup(function(){
		var p1 = $("#p1").val();
		var p2 = $("#p2").val();
		if(p1==p2){
			$("#cnfpwd").html("Password match");
			$("#cnfpwd").css("color","green");
			$("#submit").prop("disabled",false);
		}
		else{
			$("#cnfpwd").html("Password dont match !!!");
			$("#cnfpwd").css("color","red");
			$("#submit").prop("disabled",true);
		}
	})
});

function mycheck() {
	//alert("Alerting");
	var trimmedValue = jQuery.trim($('#username').val());
	if (trimmedValue.length > 0) {
		return true;
	}
/* 	$("#msg").html("Group name can't be blank!!!")
	$("#msg").css("color","red"); */
	alert("Name can't be blank spaces");
	return false;
}
</script>
<title>Registration</title>
</head>
<body>
	<div class="container-fluid">
		<section class="container">
			<div class="container-page">
				<div class="col-md-6">
					<form:form method="POST" commandName="userProfile"
						action="submitRegistration">
						<h1 class="dark-grey">Registration</h1>

						<div class="form-group col-md-12">
							<label>Username</label>
							<form:input type="text" path="username" id="username" class="form-control"
								placeholder="Username" />
						</div>
						
						<div class="form-group col-md-12" id="msg" ></div>
						
						<div class="form-group col-md-6">
							<label>Password</label> <input type="password" name="password"
								class="form-control" placeholder="Password" id="p1" />
						</div>

						<div class="form-group col-md-6">
							<label>Repeat Password</label> <input type="password"
								class="form-control" placeholder="Confirm Password" id="p2" />
						</div>
						
						<div class="form-group col-md-12" id="cnfpwd" ></div>
						<div class="form-group col-md-6">
							<label>First Name</label>
							<form:input type="text" path="fname" class="form-control"
								placeholder="First Name"/>
						</div>
						<div class="form-group col-md-6">
							<label>Last Name</label>
							<form:input type="text" path="lname" class="form-control"
								placeholder="Last Name" />
						</div>
						<div class="form-group col-md-4">
							<label>Birth Month</label>
							<form:select type="text" path="month" items="${monthList}" class="form-control"
								placeholder="Month" />
						</div>
						<div class="form-group col-md-4">
							<label>Birth Date</label>
							<form:input type="number" min="1" max="31" path="day" class="form-control"
								placeholder="Day" />
						</div>
						<div class="form-group col-md-4">
							<label>Birth year</label>
							<form:input type="number" path="year" class="form-control"
								placeholder="Year" />
						</div>
						<div class="form-group col-md-3">
							<label>Gender</label>
							<form:select type="text" path="gender" items="${genderList}" class="form-control"
								placeholder="Gender" />
						</div>
						<div class="form-group col-md-9">
							<label>Mobile Number</label>
							<form:input type="number" path="mobile" class="form-control"
								placeholder="Mobile" />
						</div>

						<div class="form-group col-md-12">
							<label>E-mail</label>
							<form:input type="email"  path="email" class="form-control"
								placeholder="E-mail" required="true" />
						</div>
						<div class="form-group col-md-3">
							<label>City</label>
							<form:input type="text" path="city" class="form-control"
								placeholder="City" />
						</div>
						<div class="form-group col-md-4">
							<label>State</label>
							<form:select type="text" path="state" items="${stateList}" class="form-control"
								placeholder="State" />
						</div>
						<div class="form-group col-md-5">
							<label>Country</label>
							<form:input type="text" path="country" class="form-control"
								placeholder="Country" />
						</div>
						
						<div class="form-group col-md-5">
							<label>Smoking?</label>
							<form:select type="text" path="smoking" class="form-control"
								placeholder="Country">
								<form:option value="Yes">Yes</form:option>
								<form:option value="No">No</form:option>
								</form:select>
						</div>
						
						<div class="form-group col-md-5">
							<label>Drinking?</label>
							<form:select type="text" path="drinking" class="form-control"
								placeholder="Country">
								<form:option value="Yes">Yes</form:option>
								<form:option value="No">No</form:option>
								</form:select>
						</div>
						
						<div class="form-group col-md-6">
							<button type="submit" class="btn btn-primary" id="submit" onclick="return(mycheck())">Submit</button>
						</div>
						<div class="form-group col-md-6" style="float:right;">
							<button type="reset" class="btn btn-primary">Clear</button>
						</div>
					</form:form>
				</div>
			</div>
		</section>
	</div>
</body>
</html>
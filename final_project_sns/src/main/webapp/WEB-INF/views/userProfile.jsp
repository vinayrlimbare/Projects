<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.min.css"
	rel="stylesheet">

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
<title>User Public Page</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	$(function() {
		$('#edit-profile').hide();
	});
	$(document).ready(function() {
		$(".edit").click(function() {
			$(".ep3").slideUp();
			$("#edit-profile").show("slow");
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<div class="ep3">
				<h1>Profile Page</h1>
				<div class="row-fluid">
					<div class="span2">
						<img
							src="<c:url value='/resources/images/profilepic/${userProfile.image}.jpg'/>"
							class="img-circle" width="200" height="200">
					</div>

					<div class="span8">
						<h3>
							<b>Name:</b> ${userProfile.fname } ${userProfile.lname }
						</h3>
						<h6>
							<b>Email:</b> ${userProfile.email }
						</h6>
						<h6>
							<b>Date of Birth:</b> ${userProfile.day }-${userProfile.month }-${userProfile.year }
						</h6>
						<h6>
							<b>Gender:</b> ${userProfile.gender }
						</h6>
						<h6>
							<b>Mobile:</b> ${userProfile.mobile }
						</h6>
						<h6>
							<b>City:</b> ${userProfile.city }
						</h6>
						<h6>
							<b>State:</b> ${userProfile.state }
						</h6>
						<h6>
							<b>Country:</b> ${userProfile.country }
						</h6>
						<h6>
							<b>Smoking:</b> ${userProfile.smoking }
						</h6>
						<h6>
							<b>Drinking:</b> ${userProfile.drinking }
						</h6>
					</div>
					<button type="button" class="edit btn btn-primary">Edit
						Profile</button>
				</div>
			</div>
		</div>
	</div>

	<form:form method="POST" commandName="userProfile" action="editProfile">
		<div class="container-fluid">

			<section class="container">
				<div class="container-page">
					<div class="col-md-6">
						<div id="edit-profile" class="edit-profile">
							<h1>Edit Profile</h1>
							<div class="form-group col-md-6">
								<label>First Name</label>
								<form:input type="text" path="fname" class="form-control"
									placeholder="First Name" />
							</div>
							<div class="form-group col-md-6">
								<label>Last Name</label>
								<form:input type="text" path="lname" class="form-control"
									placeholder="Last Name" />
							</div>
							<div class="form-group col-md-4">
								<label>Birth Month</label>
								<form:input type="text" path="month" class="form-control"
									placeholder="Month" />
							</div>
							<div class="form-group col-md-4">
								<label>Birth Date</label>
								<form:input type="text" path="day" class="form-control"
									placeholder="Day" />
							</div>
							<div class="form-group col-md-4">
								<label>Birth year</label>
								<form:input type="text" path="year" class="form-control"
									placeholder="Year" />
							</div>
							<div class="form-group col-md-3">
								<label>Gender</label>
								<form:input type="text" path="gender" class="form-control"
									placeholder="Gender" />
							</div>
							<div class="form-group col-md-9">
								<label>Mobile Number</label>
								<form:input type="text" path="mobile" class="form-control"
									placeholder="Mobile" />
							</div>

							<div class="form-group col-md-12">
								<label>E-mail</label>
								<form:input type="text" path="email" class="form-control"
									placeholder="E-mail" />
							</div>
							<div class="form-group col-md-4">
								<label>City</label>
								<form:input type="text" path="city" class="form-control"
									placeholder="City" />
							</div>
							<div class="form-group col-md-4">
								<label>State</label>
								<form:input type="text" path="state" class="form-control"
									placeholder="State" />
							</div>
							<div class="form-group col-md-4">
								<label>Country</label>
								<form:input type="text" path="country" class="form-control"
									placeholder="Country" />
							</div>
							<div class="form-group col-md-6">
								<label>Smoking</label>
								<form:input type="text" path="smoking" class="form-control"
									placeholder="Smoking" />
							</div>
							<div class="form-group col-md-6">
								<label>Drinking</label>
								<form:input type="text" path="drinking" class="form-control"
									placeholder="Drinking" />
							</div>
							<div class="form-group col-md-6">
								<button type="submit" class="btn btn-primary">Submit</button>
							</div>
							<div class="form-group col-md-6">
								<button type="reset" class="btn btn-primary">Reset</button>
							</div>
							<input type="hidden" name="password"
								value="<c:out value='${password}'/>" class="form-control"
								placeholder="Password" id="p1" />
							<form:input type="hidden" name="username" path="username"
								class="form-control" placeholder="Username" />
							<form:input type="hidden" name="image" path="image"
								class="form-control" placeholder="Username" />
						</div>
					</div>
				</div>
			</section>
		</div>
	</form:form>
</body>
</html>
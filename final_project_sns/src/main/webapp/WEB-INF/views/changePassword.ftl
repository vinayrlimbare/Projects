<head>
<title>Change Password</title>
<script>
	function validateForm() {
		var currentPassword = document.myForm.password.value;
		var oldPassword = document.myForm.oldPassword.value;
		var newPassword = document.myForm.newPassword.value;
		var newPassword2 = document.myForm.newPassword2.value;

		if (currentPassword != oldPassword) {
			document.getElementById("oldpasswordmismatch").innerHTML = "Password is incorrect."
			document.getElementById("newpasswordmismatch").innerHTML = ""

			return false;
		}
		if (newPassword != newPassword2) {
			document.getElementById("newpasswordmismatch").innerHTML = "Re-entered password doesn't match";
			document.getElementById("oldpasswordmismatch").innerHTML = "";
			return false;
		}
		return true;
	}

	function reload() {
		location.reload();
	}

	function mycheck() {
		//alert("Alerting");
		var trimmedValue = jQuery.trim($('#newPassword').val());
		if (trimmedValue.length > 0) {
			return true;
		}
		alert("Password can't be blank spaces");
		return false;
	}
</script>
<style type="text/css">
body {
	background-image: url('./resources/images/background/1234.jpg');
	background-repeat: repeat;
	background-position: fixed;
	background-size: cover;
}
</style>
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
</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-6">
					<h2>Password Change Form</h2>
					<div class="form-group">
						<form name="myForm" method="post"
							onsubmit="return(validateForm())" action="submitPasswordChange">
							<input type="hidden" name="password" value="${password}" />
							<table>
								<tr>
									<td>Please enter your password:</td>
									<td><input type="password" name="oldPassword"
										id="oldPassword" required="required" class="form-control" /></td>
									<td><div id="oldpasswordmismatch" style="color: red;"></div></td>
								</tr>
								<tr>
									<td>Enter New Password:</td>
									<td><input type="password" name="newPassword"
										id="newPassword" required="required" class="form-control" />
									</td>
								</tr>
								<tr>
									<td>Enter New Password again:</td>
									<td><input type="password" name="newPassword2"
										required="required" class="form-control" /></td>
									<td><div id="newpasswordmismatch" style="color: red;"></div></td>
								</tr>
							</table>
							<br />
							<button class="btn btn-success col-md-4" type="submit"
								value="Change Password" onclick="return(mycheck())">Change
								Password</button>
							<button type="button"
								class="btn btn-primary col-md-4 col-md-offset-1"
								onclick="reload()">Clear</button>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New Group</title>
</head>
<style type="text/css">
body {
	background-image: url('./resources/images/background/1234.jpg');
	background-repeat: repeat;
	background-position: fixed;
	background-size: cover;
}
</style>
<script>
	function mycheck() {
		//alert("Alerting");
		var trimmedValue = jQuery.trim($('#gname').val());
		if (trimmedValue.length > 0) {
			return true;
		}
		$("#msg").html("Group name can't be blank!!!")
		$("#msg").css("color","red");
		//alert("Name can't be blank spaces");
		return false;
	}
</script>
<body>

	<div class="container">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-6">
					<h1>Create New Group</h1>
					<div class="form-group">
						<form:form action="createGroup" commandName="group" method="POST" onsubmit="return(mycheck())">
							<table>
								<tr>

									<td>Enter Group name:</td>
									<td><form:input type="text" path="gName"
											class="form-control" id="gname" />
											<div id="msg"></div>
											</td>
								</tr>
								<br />
								<tr>
									<td>Enter Group Description:</td>
									<td><form:textarea rows="5" type="text" path="gDesc"
											class="form-control" /></td>
								</tr>

							</table>
							<form:button class="btn btn-primary" type="submit" value="submit">Submit</form:button>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
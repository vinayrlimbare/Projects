<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<div class="ep3">
				<h1>Public Profile Page</h1>
				<div class="row-fluid">
					<div class="span2">
						<img
							src="<c:url value='/resources/images/profilepic/${userProfile.image}.jpg'/>"
							class="img-circle" width="200" height="200">
					</div>
					<div class="span8">
						<h3>
							<b>Name:</b> ${userProfile.fname} ${userProfile.lname}
						</h3>
						<h6>
							<b>Email:</b> ${userProfile.email}
						</h6>
						<h6>
							<b>Date of Birth:</b> ${userProfile.day}-${userProfile.month}-${userProfile.year}
						</h6>
						<h6>
							<b>Gender:</b> ${userProfile.gender}
						</h6>
						<h6>
							<b>Mobile:</b> ${userProfile.mobile}
						</h6>
						<h6>
							<b>City:</b> ${userProfile.city}
						</h6>
						<h6>
							<b>State:</b> ${userProfile.state}
						</h6>
						<h6>
							<b>Country:</b> ${userProfile.country}
						</h6>
						<h6>
							<b>Smoking:</b> ${userProfile.smoking}
						</h6>
						<h6>
							<b>Drinking:</b> ${userProfile.drinking}
						</h6>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
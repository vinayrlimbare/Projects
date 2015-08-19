<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
</head>
<body>
	<h1>All User Profile</h1>
	<table border="2px">
		<b></b><tr>
			<td>USERNAME</td>
			<td>FIRSTNAME</td>
			<td>LASTNAME</td>
			<td>GENDER</td>
			<td>MOBILE</td>
			<td>E-MAIL</td>
			<td>CITY</td>
			<td>STATE</td>
			<td>COUNTRY</td>
			<td>DATE OF BIRTH</td>
			<td>SMOKING</td>
			<td>DRINKING</td>
			<td>DELETE?</td>
		</tr></b>
<c:forEach var="list" items="${userProfileList}">
<tr>
			<td><c:out value="${list.username}"></c:out></td>
			<td><c:out value="${list.fname }"></c:out></td>
			<td><c:out value="${list.lname }"></c:out></td>
			<td><c:out value="${list.gender }"></c:out></td>
			<td><c:out value="${list.mobile }"></c:out></td>
			<td><c:out value="${list.email }"></c:out></td>
			<td><c:out value="${list.city }"></c:out></td>
			<td><c:out value="${list.state }"></c:out></td>
			<td><c:out value="${list.country}"></c:out></td>
			<td><c:out value="${list.day}"></c:out>-<c:out value="${list.month}"></c:out>-<c:out value="${list.year}"></c:out></td>
			<td><c:out value="${list.smoking }"></c:out></td>
			<td><c:out value="${list.drinking }"></c:out></td>
			<td><a href="deleteProfile?username=${list.username}">Delete</a></td>
</tr>
</c:forEach>
	</table>

</body>
</html>
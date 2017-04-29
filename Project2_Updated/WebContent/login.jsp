<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="login">

<table>
<tr>Name<input type="text" name="email"></tr>
<tr> Password <input type="text" name="password"> </tr><br>
<tr> <input type ="submit" value="Login"></tr>
</table>
</form>
<%
if(request.getAttribute("error_message")!=null){
String error_message = request.getAttribute("error_message").toString(); 
if(error_message.length()!=0){
	out.println("Please enter the correct credentials");
}
}%>
</body>
</html>
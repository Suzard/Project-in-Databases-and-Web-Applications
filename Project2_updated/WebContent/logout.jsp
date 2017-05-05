<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="package_test.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

Logged out successfully.....!!!!
<%
HttpSession session123 = request.getSession(false);
session123.invalidate();
Declarations.star_firstname="";
Declarations.star_lastname="";
Declarations.year="";
Declarations.director="";
Declarations.title="";
%>
<meta HTTP-EQUIV="REFRESH" content="3; url=http://54.193.53.90:8080/Project2_101/">
</body>
</html>
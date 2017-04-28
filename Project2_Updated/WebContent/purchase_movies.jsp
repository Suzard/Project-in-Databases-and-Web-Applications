
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%//Reference https://www3.ntu.edu.sg/home/ehchua/programming/java/JSPByExample.html %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*" %>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1; %>
<%
	String encoded_movie_title = request.getParameter("titles"); //previously movie_title
// 	String movie_title = URLDecoder.decode(encoded_movie_title);
// 	System.out.println(movie_title);
	System.out.println(encoded_movie_title);
%>


		<table border=1 cellpadding=1>
		<th>Image</th>  
		<th>ID</th>
		<th>Title</th>
		<th>Year</th>
		<th>Director</th>
		<th>List of genres</th>
		<th>List of Stars</th>

        <tr>

		<tr>

        </table>
		
		

%>
</body>
</html>
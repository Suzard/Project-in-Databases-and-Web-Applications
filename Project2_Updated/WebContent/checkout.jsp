
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
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1; %>
<%
// id, title, year, director, a list of genres (hyperlinked), poster, a list of stars (hyperlinked), and a link to its preview trailer.
		
%>
	
		<table border=1 cellpadding=1>
		<th>ID</th>
		<th>Name</th>
		<th>DOB</th>
		<th>Picture</th>
		<th>Starred Movies</th>

		<tr>
        </table>
		

%>
</body>

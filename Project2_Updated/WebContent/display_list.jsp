
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
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%
String title = request.getParameter("title");
String year = request.getParameter("year");
String director = request.getParameter("director");
String star_firstname = request.getParameter("star_firstname");
String star_lastname = request.getParameter("star_lastname");
%>
<%
try {
	//PrintWriter out = response.getWriter();
	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");
	if (test_connection == null)
		out.println("Connection not successfull");
	else {
		Statement select = test_connection.createStatement();
		String query = "select stars.id,stars.first_name,stars.last_name,stars.dob,stars.photo_url,"
				+ "movies.title,movies.year,movies.director,movies.banner_url,movies.trailer_url "
				+ "from stars inner join movies on stars.id=movies.id" + " "
				+ "where ((stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%" + "' ) "
				+ "and (movies.director like '%" + director.toLowerCase() + "%" + "') "
				+ "and (movies.title like '%" + title.toLowerCase() + "%" + "')" + ")";
		System.out.println(query);
		ResultSet result = select.executeQuery(query);%>
		<table border=1 cellpadding=5>
		<th>ID</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Title</th>
		<th>Director</th>
		<th>List of genres</th>
		<th>List of Stars</th>
          <% while(result.next()){%>
		<%=result.getString(2)%>
		<%}%>
          </table>
		
		
	<%}}
catch (Exception e) {
	System.out.println(e.getMessage());
}
%>
</body>
</html>
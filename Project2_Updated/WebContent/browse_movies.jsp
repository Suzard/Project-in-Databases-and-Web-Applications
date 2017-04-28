
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
<%@page import="java.lang.Object.*"%>
<%@page import="java.net.URLEncoder"%>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%@page import="package_test.*" %>
<%int id=0,prev_id=1; %>
<%
String title = "";
String year = "";
String director = "";
String star_firstname = "";
String star_lastname = "";
%>
<%

//PrintWriter out = response.getWriter();
	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
		Statement select = test_connection.createStatement();
		ArrayList<String> x =  new ArrayList<String>();
		String query_genres = "select name from genres";
		ResultSet all_genres = select.executeQuery(query_genres);
		while(all_genres.next()){
			x.add(all_genres.getString(1));
		}
		
		Iterator <String> iterating = x.iterator(); 
		
		%>

		<table border=1 cellpadding=1>

		<th>List of genres</th>
        <% while(iterating.hasNext()){%>
        			<% String entry = iterating.next();%>
        <%id= 1;%>
        
        <%String encoded_entry = URLEncoder.encode(entry);%>
		<td><a href= "display_genres.jsp?button_clicked=<%=encoded_entry%>&page_number=1" ><%=entry%></a></td>


		<tr>
		<%}%>
        </table>
		
		

%>
</body>
</html>
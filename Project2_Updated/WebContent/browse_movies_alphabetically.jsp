
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

<form action="confirmation_page.jsp">
<input type="submit" value="checkout">
</form>

<form action="cart_authenticity_check.jsp">
<input type="submit" value="Proceed to Checkout">
</form>

<form action="logout.jsp">
<input type="submit" value="logout">
</form>


<table border=1 cellpadding=1>
<table border=1 cellpadding=1>

<th>ALPHABETICAL ORDER</th>
<% for(char alphabet = 'A'; alphabet <= 'Z';alphabet++) {%>
<%String str = String.valueOf(alphabet); %>
<td><a href= "display_list.jsp?button_clicked=<%=str%> " ><%=str%></a></td>
<%-- 		<td><a href= "movie_file.jsp?Movie=<%=movie_t%>" ><%=e.get(0).toString()%></a> --%>

<%id= 1;%>

<%}%>
<td><a href= "display_list.jsp?button_clicked_n=Number" >number_title_start</a></td>

</table>	
</table>
</body>
</html>


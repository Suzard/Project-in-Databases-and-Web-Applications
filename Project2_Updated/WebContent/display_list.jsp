
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

<!-- <select id="select_dropdown" name="select_dropdown">
  <option value="10">10</option></a>
 <a href="display_list.jsp?display_count=10"> <option value="20">20</option></a>
 <a href="display_list.jsp?display_count=10"><option value="25">25</option></a>
 <a href="display_list.jsp?display_count=10"><option value="30">30</option></a>
</select> -->



<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1,count=0;%>
<%
String title = request.getParameter("title");
String year = request.getParameter("year");
String director = request.getParameter("director");
String star_firstname = request.getParameter("star_firstname");
String star_lastname = request.getParameter("star_lastname");%>

<%out.print("Number of results to be displayed on Page"); %>
<a href="display_list.jsp?display_count=5">5</a>
<a href="display_list.jsp?display_count=10">10</a>
<a href="display_list.jsp?display_count=15">15</a>
<a href="display_list.jsp?display_count=20">20</a>
<a href="display_list.jsp?display_count=25">25</a>
<a href="display_list.jsp?display_count=30">30</a>
<%-- <%

String display_count1 = request.getParameter("display_count");
display_count = Integer.parseInt(display_count1);
System.out.println("opt" + display_count);%> --%>
<%-- <% 
try{
if(request.getParameter("display_count") != null){
display_count = Integer.parseInt(request.getParameter("display_count"));
}
else display_count =5;
}catch(NumberFormatException e){
e.printStackTrace();}%> --%>

<%
try {
	//PrintWriter out = response.getWriter();
	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");
	if (test_connection == null)
		out.println("Connection not successfull");
	else {
		int display_count=5,initial_display_count=0;
		Statement select = test_connection.createStatement();
 		String query = "select stars.id,stars.first_name,stars.last_name,stars.dob,stars.photo_url,"
				+ "movies.title,movies.year,movies.director,movies.banner_url,movies.trailer_url, genres_in_movies.genre_id, genres.name "
				+ ",movies.id" + " "
				+ "from (((stars inner join movies on stars.id=movies.id)"+
				  "inner join genres_in_movies on genres_in_movies.movies_id = movies.id)" + " "
				+ "inner join genres on genres.id = genres_in_movies.genre_id)"
				+ "where ((stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
						+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%" + "' ) "
				+ "and (movies.year like '%" + year + "%" + "' ) "
				+ "and (movies.director like '%" + director.toLowerCase() + "%" + "') "
				+ "and (movies.title like '%" + title.toLowerCase() + "%" + "')" + ") ";
 				/* + "limit display_count offset initial_display_count";   */
		
		System.out.println(query);
		ResultSet result = select.executeQuery(query);
		%>
		<table border=1 cellpadding=1>
		<th>Image</th>  
		<th>ID</th>
		<th>Title</th>
		<th>Year</th>
		<th>Director</th>
		<th>List of genres</th>
		<th>List of Stars</th>
		<%-- <% while(tmp_next.next()) {
		count++;
		}
		%> --%>
          <% while(result.next()){%>
          <% String image_url = result.getURL(9).toString();%>
          <%id= result.getInt(1);%>
          <tr>
        <td><img src=<%=image_url%> style="width:100px;height:100px;">
		<td><%=result.getInt(13)%></td>
		<td><%=result.getString(6)%></td>
		<td><%=result.getString(7)%></td>
		<td><%=result.getString(8)%></td>
		<td><%=result.getString(12)%></td>
		<td><%=result.getString(2) + result.getString(3)%></td>
		<tr>
		<%}%>
          </table>
		
		
	<%}}
catch (Exception e) {
	System.out.println(e.getMessage());
}
%>
</body>
</html>

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
<%@page import="package_test.*" %>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1; %>
<%
String title = "";
String year = "";
String director = "";
String star_firstname = "";
String star_lastname = "";
%>
<%
// id, title, year, director, a list of genres (hyperlinked), poster, a list of stars (hyperlinked), and a link to its preview trailer.


		Connection test_connection = DriverManager
		.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
		Map<Integer, ArrayList<Object>> data = new HashMap<Integer, ArrayList<Object>>();
		ArrayList<Object> list = new ArrayList<Object>();
		String encrypted_f = request.getParameter("Star");
		String encrypted_l = request.getParameter("Last");

		String name = java.net.URLDecoder.decode(encrypted_f, "UTF-8");
		String lname= java.net.URLDecoder.decode(encrypted_l, "UTF-8");
		String full_name = name += " ";
		full_name += lname;
		Statement select = test_connection.createStatement();
		Statement select2 = test_connection.createStatement();
		Statement select3 = test_connection.createStatement();
		Statement select4 = test_connection.createStatement();
		Statement select5 = test_connection.createStatement();
		Statement select6 = test_connection.createStatement();
		Statement select7 = test_connection.createStatement();
		Statement select8 = test_connection.createStatement();
		Statement select9 = test_connection.createStatement();
		Statement stardom = test_connection.createStatement();
		Statement stars_in_movies = test_connection.createStatement();
		//bullet point 7 from grading ***
		//after executing each query will exit to menu
		//thanks to continues
		// Prints "Hello, World" in the terminal window.
		 int s_id = 0;//ame, date of birth, picture of the star, 
		 String dob = "";
		 String star_url = "";
		 Map<String,String> stars_first_and_last = new HashMap<String, String>();
// 		 System.out.println("Hello?");

		 
		 String identifying_stars_command = "select id from stars where first_name =" + "\"" + name + "\"" + " and last_name = " + "\"" + lname + "\"";
// 		 System.out.println(identifying_stars_command);
// 		 System.out.println("End?");

		 ResultSet stars = stardom.executeQuery(identifying_stars_command);
		 while(stars.next()){
			 s_id = stars.getInt(1);
			 
		 }

		 String star_info_command = "select * from stars where id = " +s_id;
 		 ResultSet star_info = select.executeQuery(star_info_command);
 		 while(star_info.next()){
 	  			 dob = star_info.getString(4);
 	  			 star_url = star_info.getString(5);

 		 }
 		 list.add(dob);
 		 list.add(star_url);
		 String stars_in_movies_command = "select movie_id from  stars_in_movies where star_id = " + s_id;
		 ResultSet stars_in = stars_in_movies.executeQuery(stars_in_movies_command);
		 String all_movies = "";
		 ArrayList<String> movie_list  = new ArrayList<String>();
		 while(stars_in.next()){
		 	all_movies = "select title from movies where id = " +stars_in.getInt(1);

			 ResultSet all_movies_r = select2.executeQuery(all_movies);
			 while(all_movies_r.next()){
				 movie_list.add(all_movies_r.getString(1));
			 }
		 }
		 ResultSet all = select3.executeQuery(all_movies);
		 list.add(movie_list); 
		 data.put(s_id, list);
		Iterator <Map.Entry<Integer, ArrayList<Object>>> iterating =  data.entrySet().iterator();

		//System.out.println(data);
%>
	
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
		<th>ID</th>
		<th>Name</th>
		<th>DOB</th>
		<th>Picture</th>
		<th>Starred Movies</th>
        <% while(iterating.hasNext()){%>
        			<% Map.Entry<Integer, ArrayList<Object>> entry = iterating.next();%>
					<%ArrayList<Object> e = entry.getValue();%>
					<%ArrayList<String> movie_listing = (ArrayList<String>) e.get(2); %>
					<%Iterator <String> iterate_movie = movie_listing.iterator(); %>
        <% String image_url = e.get(1).toString();%>
        <%id= 1;%>
        <tr>
		<td><%=Integer.parseInt(entry.getKey().toString())%></td>
		<td><%=full_name%></td> <!-- name -->
		<td><%=e.get(0).toString()%></td> <!-- dob -->
		<td><img src=<%=image_url%> style="width:100px;height:100px;">
		<td><% while(iterate_movie.hasNext()){ %>
			<%String movie_name_v =  iterate_movie.next(); %>
			<%String encoded_movie = URLEncoder.encode(movie_name_v); %>
		<a href= "movie_file.jsp?Movie=<%=encoded_movie%> " ><%=movie_name_v%></a>
		<% }%>
		<tr>
		<%}%>
        </table>
		

%>
</body>
</html>
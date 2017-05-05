
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
<form method="post" action="purchase_movies">

<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.Object.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="package_test.*"%>;

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
// 		String movie_title_r = request.getParameter("Movie");
		String encrypted = request.getParameter("Movie");
//		System.out.println("encrypyed" + encrypted);
		String movie_title_r = java.net.URLDecoder.decode(encrypted, "UTF-8");
		
// 		String movie_title_r = "Starsky & Hutch";
		System.out.println("title" +movie_title_r);
		Statement select = test_connection.createStatement();
		Statement select2 = test_connection.createStatement();
		Statement select3 = test_connection.createStatement();
		Statement select4 = test_connection.createStatement();
		Statement select5 = test_connection.createStatement();
		Statement select6 = test_connection.createStatement();
		Statement select7 = test_connection.createStatement();
		Statement select8 = test_connection.createStatement();
		Statement select9 = test_connection.createStatement();
		Statement moviedom = test_connection.createStatement();
		Statement movies_l = test_connection.createStatement();
		//bullet point 7 from grading ***
		//after executing each query will exit to menu
		//thanks to continues
		// Prints "Hello, World" in the terminal window.		
		 int star_id;
		 Map<String,String> stars_first_and_last = new HashMap<String, String>();
		 String dob;
		 String photo_url;
		 String movie_title;
		 int movie_year;
		 String movie_director;
		 String banner_url;
		 String trailer_url;
		 ArrayList<String> genres;
		 int movie_id;
		 
		 String identifying_movies_command = "select id from movies where title  =" + "\"" + movie_title_r + "\"";
// 		 System.out.println("query is " + identifying_movies_command);
		 ResultSet movies = moviedom.executeQuery(identifying_movies_command);

		 while(movies.next()){
			 
			 

		 String all_movies = "select * from movies where id = " + movies.getInt(1);
		 
		 ResultSet all = select.executeQuery(all_movies);
		 while(all.next()){
			 movie_id = all.getInt(1);
		     ArrayList<Object> list = new ArrayList<Object>();
				 movie_title = all.getString(2);
				 movie_year = all.getInt(3);
				 movie_director = all.getString(4);
				 banner_url  = all.getString(5);
		         trailer_url  = all.getString(6);
		    	 list.add(movie_title);
		    	 list.add(movie_year);
		    	 list.add(movie_director);
		    	 list.add(banner_url);
		    	 list.add(trailer_url);
	 String star_details = "select star_id from stars_in_movies where movie_id = " +movie_id;
	 ResultSet star_details_r = select3.executeQuery(star_details);
	 ArrayList<String> star_list= new ArrayList<String>();
	 while(star_details_r.next()){
         star_id = star_details_r.getInt(1);
         String star_converted_f = "select first_name from stars where id =" + star_id;
         String star_converted_l = "select last_name from stars where id = " + star_id;
         String full_name = "";
         ResultSet star_result_f = select4.executeQuery(star_converted_f);
         while(star_result_f.next()){
        	 full_name += star_result_f.getString(1);
         }
         ResultSet star_result_l = select5.executeQuery(star_converted_l);
         full_name += "~";
         while(star_result_l.next()){
        	 full_name += star_result_l.getString(1);
         }
         star_list.add(full_name);
	 }
	 ArrayList<String> genre_list = new ArrayList<String>();
	 String genre_details = "select genre_id from genres_in_movies where movies_id = " +movie_id;
	 ResultSet genre_ids = select6.executeQuery(genre_details);
	 while(genre_ids.next()){
		 int genre_id = genre_ids.getInt(1);
		 String genre_name_command = "select name from genres where id = " + genre_id;
		 ResultSet genre_name = select7.executeQuery(genre_name_command);
		 while(genre_name.next()){
			 String genre = genre_name.getString(1);
    		 genre_list.add(genre);
		 }

	 }
   	 list.add(star_list);
   	 list.add(genre_list);
   	 data.put(movie_id, list);
	 }
	}
	Iterator <Map.Entry<Integer, ArrayList<Object>>> iterating =  data.entrySet().iterator();
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
		<th>Title</th>
		<th>Year</th>
		<th>Director</th>
		<th>List of genres</th>
		<th>Poster</th>
		<th>List of Stars</th>
		<th>Trailer</th>
		<th>Purchase Movies here</th>
        <% while(iterating.hasNext()){%>
       			<% Map.Entry<Integer, ArrayList<Object>> entry = iterating.next();%>
				<%ArrayList<Object> e = entry.getValue();%>
				<%ArrayList<String> star_listing = (ArrayList<String>) e.get(5); %>
				<%Iterator <String> iterate_star= star_listing.iterator(); %>
				<%ArrayList<String> genre_listing = (ArrayList<String>) e.get(6); %>
				<%Iterator <String> iterate_genre = genre_listing.iterator(); %>
<!-- 				    System.out.println("Key = " + entry.getKey() ); -->
        <% String image_url = e.get(3).toString();%> 
        <%id= 1;%>
        <tr>
		<td><%=Integer.parseInt(entry.getKey().toString())%></td> <!-- id -->
		<%String title_url = e.get(0).toString(); %>
		<td><%=title_url%></td> <!-- title -->
		<%String encoded_title_url= URLEncoder.encode(title_url); %>	
		
		<td><%=e.get(1).toString()%></td> <!-- year -->
		<td><%=e.get(2).toString()%></td> <!-- director -->
		<td><% while(iterate_genre.hasNext()){ %>
			<%String encoded_name_v = iterate_genre.next(); %>	
			<%String genre_name_v = URLEncoder.encode(encoded_name_v); %>
		
		<a href= "display_list.jsp?button_clicked_g=<%=genre_name_v%> " ><%=encoded_name_v%></a>
		<% }%>
        <td><img src=<%=image_url%> style="width:100px;height:100px;"> <!-- poster -->
		<td><% while(iterate_star.hasNext()){ %>
			<%String star_name_v = iterate_star.next(); %>
			<%String []splitting = star_name_v.split("~");%>
		<a href= "star_file.jsp?Star=<%=splitting[0]%>&Last=<%=splitting[1]%> " ><%=splitting[0]+" " +splitting[1]%></a>
		<% }%>
		<td><a href= <%=e.get(4).toString()%>><%=e.get(4).toString()%></a></td> <!-- trailer -->
		
		<tr>
		<%}%>
        </table>
		
		

%>
</body>
</html>
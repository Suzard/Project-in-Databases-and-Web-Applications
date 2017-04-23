
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
<%out.print("Number of results to be displayed on Page"); %>
<a href="display_list.jsp?display_count=5">5</a>
<a href="display_list.jsp?display_count=10">10</a>
<a href="display_list.jsp?display_count=15">15</a>
<a href="display_list.jsp?display_count=20">20</a>
<a href="display_list.jsp?display_count=25">25</a>
<a href="display_list.jsp?display_count=30">30</a>

<form method="post" action="display_list.jsp">
<table>
<tr>Title<input type="text" name="title"></tr><br>
<tr> Year <input type="text" name="year"> </tr><br>
<tr> Director <input type="text" name="director"> </tr><br>
<tr> Stars First Name <input type="text" name="star_firstname"> </tr><br>
<tr> Stars Last Name <input type="text" name="star_lastname"> </tr><br>
<tr> Movies Displayed per list <input type="text" name="display_count"> </tr><br>
<tr> <input type ="submit" value="submit"></tr><br>

</table>
</form>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
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

<%
try {
	//PrintWriter out = response.getWriter();
	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");
	if (test_connection == null)
		out.println("Connection not successfull");
	else {
		Map<Integer, ArrayList<Object>> data = new HashMap<Integer, ArrayList<Object>>();
		
		
		
		int display_count=5,initial_display_count=0;
		Statement select_movies = test_connection.createStatement();
		Statement select_stars = test_connection.createStatement();
		Statement select_genres = test_connection.createStatement();
		
		String query_movies = "select * from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
				+ "inner join stars on stars.id=stars_in_movies.star_id) "
				+ "where (movies.year like '%" + year + "%" + "' ) "
				+ "and (movies.director like '%" + director.toLowerCase() + "%" + "') "
				+ "and (movies.title like '%" + title.toLowerCase() + "%" + "') "
				+ "and (stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%' ) ";
				
		
		System.out.println("Query_movies : " + query_movies);
		ResultSet result_movies = select_movies.executeQuery(query_movies);
		
		while(result_movies.next())
		{
		ArrayList<String> genre_list = new ArrayList<String>();
		ArrayList<Object> final_list =  new ArrayList<Object>();
		ArrayList<Object> star_list = new ArrayList<Object>();
		String query_stars = "select * from (stars_in_movies inner join stars on  stars.id=stars_in_movies.star_id) "
				+ "where stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%' "
				+ "and stars_in_movies.movie_id = "+ result_movies.getInt("id");
		/* System.out.println("Query Stars:"+ query_stars);	 */	
		
		ResultSet result_stars = select_stars.executeQuery(query_stars);
	    while(result_stars.next()){
	    	String star_name = result_stars.getString("first_name") + " " + result_stars.getString("last_name"); 
	    	star_list.add(star_name);
	    }
	    /* System.out.println(star_list); */
	    System.out.println("Star_list :" + star_list);
		String query_genres = "select * from " 
					+"(genres inner join genres_in_movies on "
					+"genres.id=genres_in_movies.genre_id ) "
					+"where genres_in_movies.movies_id=" 
					+result_movies.getInt("id");
		/* System.out.println("Query_Genres" + query_genres);  */
		ResultSet result_genres = select_genres.executeQuery(query_genres);
		while(result_genres.next()){
			String name = result_genres.getString(2);
			
			genre_list.add(name);
		}	
		System.out.println("Genre List" + genre_list);
		System.out.println("Genre_list :" + genre_list);
		System.out.println("Director :" + result_movies.getString("director"));
				final_list.add(result_movies.getURL("banner_url"));
				final_list.add(result_movies.getString("title"));
				final_list.add(result_movies.getString("year"));
				final_list.add(result_movies.getString("director"));
				final_list.add(genre_list);
				final_list.add(star_list);
				
				data.put(result_movies.getInt("id"), final_list);
		}		
		Iterator <Map.Entry<Integer, ArrayList<Object>>> iterator_map = data.entrySet().iterator();
		%>
		<table border=1 cellpadding=1>
			<th>Image</th>  
			<th>ID</th>
			<th>Title</th>
			<th>Year</th>
			<th>Director</th>
			<th>List of genres</th>
			<th>List of Stars</th>
	    <%while (iterator_map.hasNext()) {
	        Map.Entry <Integer, ArrayList<Object>> entry_list = iterator_map.next();
	        ArrayList<Object> value_list = entry_list.getValue();%>
	        

	    <tr>
		<td><img src=<%=value_list.get(0).toString()%> style="width:100px;height:100px;"></td>
		<td><%=entry_list.getKey().toString()%></td>
		<td><%=value_list.get(1).toString()%></td>
		<td><%=value_list.get(2).toString()%></td>
		<td><%=value_list.get(3).toString()%></td>
		<td><%=value_list.get(4).toString()%></td>
		<td><%=value_list.get(5).toString()%></td>
	    <tr>
	
	     <% //iterator_map.remove(); 
	    }%>    </table>
	    
		
	<%}}
catch (Exception e) {
	System.out.println(e.getMessage());
}
%>
</body>
</html>
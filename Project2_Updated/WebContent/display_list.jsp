
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
<div><%out.print("Number of results to be displayed on Page"); %>&nbsp;	
<a href="display_list.jsp?display_count=5">5</a> &nbsp;
<a href="display_list.jsp?display_count=10">10</a> &nbsp;
<a href="display_list.jsp?display_count=15">15</a> &nbsp;
<a href="display_list.jsp?display_count=20">20</a> &nbsp;
<a href="display_list.jsp?display_count=25">25</a> &nbsp;
<a href="display_list.jsp?display_count=30">30</a> &nbsp;
</div>

<div>
<%out.println("&nbsp;Sort By :");%>
<a href="display_list.jsp?sort_by=year">YEAR</a>
<a href="display_list.jsp?sort_by=title">TITLE</a>
<a href="display_list.jsp?sort_by=id">ID</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="display_list.jsp?sort_order=asc">Ascending</a>
<a href="display_list.jsp?sort_order=desc">Descending</a>
</div>


<form method="post" action="display_list.jsp?display_count=10">
<table>
<tr>Title<input type="text" name="title"></tr><br>
<tr> Year <input type="text" name="year"> </tr><br>
<tr> Director <input type="text" name="director"> </tr><br>
<tr> Stars First Name <input type="text" name="star_firstname"> </tr><br>
<tr>Stars Last Name <input type="text" name="star_lastname"> </tr><br>
<tr> <input type ="submit" value="submit"></tr><br>

</table>
</form>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%> 
<%@page import="package_test.*" %>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1,count=0, counter=0,counter1=0;%>
<%
String title=Declarations.title, director=Declarations.director, star_firstname=Declarations.star_firstname, 
		star_lastname=Declarations.star_lastname, query_movies="", page_sort_by=Declarations.page_sort_by, 
		page_sort_order=Declarations.page_sort_order, year=Declarations.year;

int display_count = Declarations.display_count;

if(request.getParameter("year") != null){
	year = request.getParameter("year");
	Declarations.year = year;
	out.println("year in the box :" + year);
}else if (request.getParameter("year")==null){
	year= Declarations.year;
	out.println("year in the boxnull:" + year);
}
	if(request.getParameter("title") !=null){
	title = request.getParameter("title");
	Declarations.title=title;
	}else if(request.getParameter("title") ==null){
		title = Declarations.title;
	}
	
	if(request.getParameter("director") !=null){
	director = request.getParameter("director").toLowerCase();
	Declarations.director=director;
	}else if(request.getParameter("director") ==null){
		director = Declarations.director=director;
	}
	
	if(request.getParameter("star_firstname") !=null){
	star_firstname = request.getParameter("star_firstname").toLowerCase();
	Declarations.star_firstname=star_firstname;
	}else if(request.getParameter("star_firstname") ==null){
		star_lastname=Declarations.star_lastname;
	}
	
	if(request.getParameter("star_lastname") !=null){
	star_lastname = request.getParameter("star_lastname");
	Declarations.star_lastname=star_lastname;
	}else if(request.getParameter("star_lastname") ==null){
		star_lastname = Declarations.star_lastname;
	}
	
	if(request.getParameter("sort_by")!=null){
		page_sort_by = request.getParameter("sort_by");
		Declarations.page_sort_by=page_sort_by;
	}else if(request.getParameter("sort_by")==null){
		page_sort_by=Declarations.page_sort_by;
	}
	
	if(request.getParameter("sort_order")!=null){
		page_sort_order = request.getParameter("sort_order");
		Declarations.page_sort_order=page_sort_order;
	}else if(request.getParameter("sort_order")==null){
		page_sort_order=Declarations.page_sort_order;
	}
	
	/* if(request.getParameter("display_count")!=null){
	display_count= Declarations.display_count;
	Declarations.display_count = display_count;
	} */
	
try{
if(request.getParameter("display_count") != null){
	display_count = Integer.parseInt(request.getParameter("display_count"));
    Declarations.display_count = display_count;
} else if(request.getParameter("display_count")==null){
	display_count = Declarations.display_count;
}}
catch(NumberFormatException e){
/* 	e.printtrace(); */
}
out.println("Results Per page:" + "   " + display_count);%>&nbsp;&nbsp;
<%out.println("Results Sort By:" + "  " + page_sort_by);%>&nbsp; &nbsp;
<%out.println("Results Sort Order:" + "  " + page_sort_order);%>&nbsp; &nbsp;
<%out.println("Title:  " + title);%>

<%out.println("Director:  " + director);%>
<%out.println("First Name:  " + star_firstname);%>
<%out.println("Last Name:  " + star_lastname);%>
<%
try {

	//PrintWriter out = response.getWriter();
	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");
	if (test_connection == null){
		System.out.println("Not successful");
		out.println("Connection not successfull");}
	else {
		
		Map<Integer, ArrayList<Object>> data = new LinkedHashMap<Integer, ArrayList<Object>>();
		
		Statement select_movies = test_connection.createStatement();
		Statement select_movies_main = test_connection.createStatement();
		Statement select_stars = test_connection.createStatement();
		Statement select_genres = test_connection.createStatement();
		System.out.println("Year : " + year);
		//if(request.getParameter("year") !=null && year.length()!=0)
		if(request.getParameter("year")!= null && request.getParameter("year")!= "")
		{
		year = request.getParameter("year");
		Declarations.year = year;
		out.println("Year:  " + year);
		System.out.println("Hello 1");
		query_movies = "select movies.id from ((stars_in_movies inner join movies on stars_in_movies.movie_id=movies.id) "
				+ "inner join stars on stars.id=stars_in_movies.star_id) "
				+ "where movies.year = " + year +""
				 + " and movies.director like '%" + director + "%" + "' "
				+ "and (movies.title like '%" + title + "%" + "') "
				+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname + "%' ) "
				+ "group by movies.id "
				+ "order by movies." + page_sort_by+" "+page_sort_order
				+ " limit 0," + display_count ;
		System.out.println("Hello 2");
		}
		  else if(Declarations.year!=null && Declarations.year!="")
		{
			 year = Declarations.year;
			out.println("It went inside");
		
		out.println("Year:  " + year);
		System.out.println("Hello 1");
		query_movies = "select movies.id from ((stars_in_movies inner join movies on stars_in_movies.movie_id=movies.id) "
				+ "inner join stars on stars.id=stars_in_movies.star_id) "
				+ "where movies.year = " + year +""
				 + " and movies.director like '%" + director + "%" + "' "
				+ "and (movies.title like '%" + title + "%" + "') "
				+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname + "%' ) "
				+ "group by movies.id "
				+ "order by movies." + page_sort_by+" "+page_sort_order
				+ " limit 0," + display_count;
		System.out.println("Hello 2");
		}  else{
			System.out.println("Hello 3");
			query_movies = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
					+ "inner join stars on stars.id=stars_in_movies.star_id) "
				 	 + " where movies.director like '%" + director + "%" + "' "
					+ "and (movies.title like '%" + title + "%" + "') "
					+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
					+ "and stars.last_name like '%" + star_lastname + "%' ) "
					+ " group by movies.id"
					+ " order by movies." + page_sort_by+" "+page_sort_order
					+ " limit 0," + display_count ; 
			System.out.println("Hello 4");
		}
				
		System.out.println("Query_movies : " + query_movies);
		ResultSet result_movies = select_movies.executeQuery(query_movies);
		
		while(result_movies.next())
		{	

		ArrayList<String> genre_list = new ArrayList<String>();
		ArrayList<Object> final_list =  new ArrayList<Object>();
		ArrayList<Object> star_list = new ArrayList<Object>();
		
		String query_movies_main = "select * from movies where movies.id =" + result_movies.getInt("id");
		ResultSet result_movies_main = select_movies_main.executeQuery(query_movies_main);
		System.out.println("Query_movies_main : " + query_movies_main);
		while(result_movies_main.next()){
		String query_stars = "select * from (stars_in_movies inner join stars on  stars.id=stars_in_movies.star_id) "
				+ "where stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%' "
				+ "and stars_in_movies.movie_id = "+ result_movies_main.getInt("id");
		 System.out.println("Query Stars:"+ query_stars);	 	
		
		ResultSet result_stars = select_stars.executeQuery(query_stars);
	    while(result_stars.next()){
	    	String star_name = result_stars.getString("first_name") + " " + result_stars.getString("last_name"); 
	    	star_list.add(star_name);
	    }
	    /* System.out.println(star_list); */
	    // System.out.println("Star_list :" + star_list);
		String query_genres = "select * from " 
					+"(genres inner join genres_in_movies on "
					+"genres.id=genres_in_movies.genre_id ) "
					+"where genres_in_movies.movies_id=" 
					+result_movies_main.getInt("id");
		 System.out.println("Query_Genres" + query_genres);  
		ResultSet result_genres = select_genres.executeQuery(query_genres);
		while(result_genres.next()){
			String name = result_genres.getString(2);
			
			genre_list.add(name);
		}	
/* 		System.out.println("Genre List" + genre_list);
		System.out.println("Genre_list :" + genre_list);
		System.out.println("Director :" + result_movies.getString("director")); */
				final_list.add(result_movies_main.getURL("banner_url"));
				final_list.add(result_movies_main.getString("title"));
				final_list.add(result_movies_main.getString("year"));
				final_list.add(result_movies_main.getString("director"));
				final_list.add(genre_list);
				final_list.add(star_list);
				
				data.put(result_movies.getInt("id"), final_list);
		}}	
		//System.out.println("Final List" + data);
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
	    	//System.out.println("Counter "+counter++);
	    	counter++;
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
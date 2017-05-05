
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
<form action="confirmation_page.jsp" method="post">
<input type="submit" value="checkout">
</form>

<form action="cart_authenticity_check.jsp" method = "post">
<input type="submit" value="Proceed to Checkout">
</form>

<form action="logout.jsp" method ="post">
<input type="submit" value="logout">
</form>
<br><br><br><br>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
<%@page import="package_test.*" %>
<%@page import="java.text.*" %>
<%@page import="java.net.*" %>
<%@page import="java.util.Date" %>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1,count=0, counter=0,counter1=0;%>
<%
String title=Declarations.title, director=Declarations.director, star_firstname=Declarations.star_firstname,
		star_lastname=Declarations.star_lastname, query_movies="", query_movies_duplicate="",year="",
		page_sort_by=Declarations.page_sort_by,
		page_sort_order=Declarations.page_sort_order;//year=Declarations.year;

Integer display_count = Declarations.display_count;
Integer page_number=Declarations.page_number, page_tmp=Declarations.page_tmp;
int start=0;
String  button_clicked_g = request.getParameter("button_clicked_g");
String button_clicked = request.getParameter("button_clicked");
String button_clicked_n = request.getParameter("button_clicked_n");

if(request.getParameter("year")!=null){
year= request.getParameter("year");
} //replicating this for sorting%>
<%if(request.getParameter("button_clicked_g") != null){ %>
<div><%out.print("Number of results to be displayed on Page"); %>&nbsp;
<a href="display_list.jsp?display_count=5&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">5</a> &nbsp;
<a href="display_list.jsp?display_count=10&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">10</a> &nbsp;
<a href="display_list.jsp?display_count=15&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">15</a> &nbsp;
<a href="display_list.jsp?display_count=20&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">20</a> &nbsp;
<a href="display_list.jsp?display_count=25&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">25</a> &nbsp;
<a href="display_list.jsp?display_count=30&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">30</a> &nbsp;
</div>
<div>
<%out.println("&nbsp;Sort By :");%>
<a href="display_list.jsp?sort_by=year&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">YEAR</a>
<a href="display_list.jsp?sort_by=title&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">TITLE</a>
<a href="display_list.jsp?sort_by=id&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">ID</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="display_list.jsp?sort_order=asc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">Ascending</a>
<a href="display_list.jsp?sort_order=desc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_g=<%=button_clicked_g%>">Descending</a>
</div>
<%} %>
<%if(request.getParameter("button_clicked_n") != null){ %>
<div><%out.print("Number of results to be displayed on Page"); %>&nbsp;
<a href="display_list.jsp?display_count=5&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">5</a> &nbsp;
<a href="display_list.jsp?display_count=10&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">10</a> &nbsp;
<a href="display_list.jsp?display_count=15&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">15</a> &nbsp;
<a href="display_list.jsp?display_count=20&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">20</a> &nbsp;
<a href="display_list.jsp?display_count=25&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">25</a> &nbsp;
<a href="display_list.jsp?display_count=30&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">30</a> &nbsp;
</div>
<div>
<%out.println("&nbsp;Sort By :");%>
<a href="display_list.jsp?sort_by=year&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">YEAR</a>
<a href="display_list.jsp?sort_by=title&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">TITLE</a>
<a href="display_list.jsp?sort_by=id&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">ID</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="display_list.jsp?sort_order=asc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">Ascending</a>
<a href="display_list.jsp?sort_order=desc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked_n=<%=button_clicked_n%>">Descending</a>
</div>
<%} %>
<%if(request.getParameter("button_clicked") != null){ %>
<div><%out.print("Number of results to be displayed on Page"); %>&nbsp;
<a href="display_list.jsp?display_count=5&year=<%=year%>&button_clicked=<%=button_clicked%>">5</a> &nbsp;
<a href="display_list.jsp?display_count=10&year=<%=year%>&button_clicked=<%=button_clicked%>">10</a> &nbsp;
<a href="display_list.jsp?display_count=15&year=<%=year%>&button_clicked=<%=button_clicked%>">15</a> &nbsp;
<a href="display_list.jsp?display_count=20&year=<%=year%>&button_clicked=<%=button_clicked%>">20</a> &nbsp;
<a href="display_list.jsp?display_count=25&year=<%=year%>&button_clicked=<%=button_clicked%>">25</a> &nbsp;
<a href="display_list.jsp?display_count=30&year=<%=year%>&button_clicked=<%=button_clicked%>">30</a> &nbsp;
</div>
<div>
<%out.println("&nbsp;Sort By :");%>
<a href="display_list.jsp?sort_by=year&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked=<%=button_clicked%>">YEAR</a>
<a href="display_list.jsp?sort_by=title&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked=<%=button_clicked%>">TITLE</a>
<a href="display_list.jsp?sort_by=id&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked=<%=button_clicked%>">ID</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="display_list.jsp?sort_order=asc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked=<%=button_clicked%>">Ascending</a>
<a href="display_list.jsp?sort_order=desc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>&button_clicked=<%=button_clicked%>">Descending</a>
</div>
<%} %>
<%if(request.getParameter("button_clicked") == null && request.getParameter("button_clicked_g") == null && request.getParameter("button_clicked_n") == null){ %>
<div><%out.print("Number of results to be displayed on Page"); %>&nbsp;
<a href="display_list.jsp?display_count=5&year=<%=year%>">5</a> &nbsp;
<a href="display_list.jsp?display_count=10&year=<%=year%>">10</a> &nbsp;
<a href="display_list.jsp?display_count=15&year=<%=year%>">15</a> &nbsp;
<a href="display_list.jsp?display_count=20&year=<%=year%>">20</a> &nbsp;
<a href="display_list.jsp?display_count=25&year=<%=year%>">25</a> &nbsp;
<a href="display_list.jsp?display_count=30&year=<%=year%>">30</a> &nbsp;
</div>
<div>
<%out.println("&nbsp;Sort By :");%>
<a href="display_list.jsp?sort_by=year&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">YEAR</a>
<a href="display_list.jsp?sort_by=title&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">TITLE</a>
<a href="display_list.jsp?sort_by=id&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">ID</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="display_list.jsp?sort_order=asc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">Ascending</a>
<a href="display_list.jsp?sort_order=desc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">Descending</a>
</div>
<%} %>
<!-- <div> -->
<%-- <%out.println("&nbsp;Sort By :");%> --%>
<%-- <a href="display_list.jsp?sort_by=year&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">YEAR</a> --%>
<%-- <a href="display_list.jsp?sort_by=title&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">TITLE</a> --%>
<%-- <a href="display_list.jsp?sort_by=id&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">ID</a> --%>
<!-- &nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- <a href="display_list.jsp?sort_order=asc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">Ascending</a> --%>
<%-- <a href="display_list.jsp?sort_order=desc&page_tmp=<%=page_tmp%>&display_count=<%=display_count%>&year=<%=year%>">Descending</a> --%>
<!-- </div> -->


<form method="post" action="display_list.jsp?display_count=5&page_tmp=1">
<table>
<tr>Title<input type="text" name="title"></tr><br>
<tr> Year <input type="text" name="year"> </tr><br>
<tr> Director <input type="text" name="director"> </tr><br>
<tr> Stars First Name <input type="text" name="star_firstname"> </tr><br>
<tr>Stars Last Name <input type="text" name="star_lastname"> </tr><br>
<tr> <input type ="submit" value="submit"></tr><br>

</table>
</form>
<%-- <%out.println("Page Number Initial : "+ Declarations.page_number); %> --%>
<%//out.println("Display_count : "+ Declarations.display_count); %>
<%//out.println("Display Count Pagination : "+ Declarations.display_count_pagination); %>
<%//out.println("Start Pagination : "+ Declarations.start_pagination); %>

<%
/* if(request.getParameter("year") != null){
	year = request.getParameter("year");
	Declarations.year = year;
	out.println("year in the box :" + year);
}else if (request.getParameter("year")==null){
	year= Declarations.year;
	out.println("year in the boxnull:" + year);
} */
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

	if(request.getParameter("next")!=null){
		page_tmp=Integer.parseInt(request.getParameter("next"))+1;
		Declarations.page_tmp = page_tmp;
		page_number=(page_tmp-1)*display_count;
		Declarations.page_number=page_number;

	}
	 if(request.getParameter("prev")!=null){
		if(page_number-display_count>=0)
		{
		page_tmp=Integer.parseInt(request.getParameter("prev"))-1;
		Declarations.page_tmp = page_tmp;
		page_number=(page_tmp-1)*display_count;
		Declarations.page_number=page_number;
		}}

		if(request.getParameter("page_tmp")!=null){
			page_tmp=Integer.parseInt(request.getParameter("page_tmp"));
			Declarations.page_tmp = page_tmp;
			page_number=(page_tmp-1)*display_count;
			Declarations.page_number=page_number;

		}

//out.println("Results Per page:" + "   " + display_count);%>&nbsp;&nbsp;
<%out.println("Results Sort By:" + "  " + page_sort_by);%>&nbsp; &nbsp;
<%out.println("Results Sort Order:" + "  " + page_sort_order);%>&nbsp; &nbsp;
<%-- <%out.println("Title:  " + title);%> --%>

<%//out.println("Director:  " + director);%>
<%//out.println("First Name:  " + star_firstname);%>
<%//out.println("Last Name:  " + star_lastname);%>
<%
try {

	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
	if (test_connection == null){
		System.out.println("Not successful");
		out.println("Connection not successfull");}
	else {

		Map<Integer, ArrayList<Object>> data = new LinkedHashMap<Integer, ArrayList<Object>>();
		ArrayList<Integer> list_movies = new ArrayList<Integer>();
		ArrayList<Integer> list_movies_duplicate = new ArrayList<Integer>();

		Statement select_movies = test_connection.createStatement();
		Statement select_movies_duplicate = test_connection.createStatement();
		Statement select_movies_main = test_connection.createStatement();
		Statement select_stars = test_connection.createStatement();
		Statement select_genres = test_connection.createStatement();
		//modified
		Statement select_genre = test_connection.createStatement();
		if(request.getParameter("button_clicked") != null){  
			title = request.getParameter("button_clicked");
		}
// 		if(request.getParameter("button_clicked_g") != null ){
			
// 		}
//modified
		if(request.getParameter("year")!= null && request.getParameter("year")!= "")
		{
		year = request.getParameter("year");
		Declarations.year = year;
		//out.println("Year:  " + year);
		//System.out.println("Hello 1");
		query_movies = "select movies.id from ((stars_in_movies inner join movies on stars_in_movies.movie_id=movies.id) "
				+ "inner join stars on stars.id=stars_in_movies.star_id) "
				+ "where movies.year = " + year +""
				 + " and movies.director like '%" + director + "%" + "' "
				+ "and (movies.title like '%" + title + "%" + "') "
				+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname + "%' ) "
				+ "group by movies.id "
				+ "order by movies." + page_sort_by+" "+page_sort_order
			 	 + " limit " + page_number+","+display_count ;

		query_movies_duplicate = "select movies.id from ((stars_in_movies inner join movies on stars_in_movies.movie_id=movies.id) "
				+ "inner join stars on stars.id=stars_in_movies.star_id) "
				+ "where movies.year = " + year +""
				 + " and movies.director like '%" + director + "%" + "' "
				+ "and (movies.title like '%" + title + "%" + "') "
				+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname + "%' ) "
				+ "group by movies.id "
				+ "order by movies." + page_sort_by+" "+page_sort_order;
		//System.out.println("Hello 2");
		}
//modified from here
		    	 
		    	  else{
		  			query_movies = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
							+ "inner join stars on stars.id=stars_in_movies.star_id) "
						 	 + " where movies.director like '%" + director + "%" + "' "
							+ "and (movies.title like '%" + title + "%" + "') "
							+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
							+ "and stars.last_name like '%" + star_lastname + "%' ) "
							+ " group by movies.id"
							+ " order by movies." + page_sort_by+" "+page_sort_order
							+ " limit " + page_number +","+ display_count ;

					query_movies_duplicate = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
							+ "inner join stars on stars.id=stars_in_movies.star_id) "
						 	 + " where movies.director like '%" + director + "%" + "' "
							+ "and (movies.title like '%" + title + "%" + "') "
							+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
							+ "and stars.last_name like '%" + star_lastname + "%' ) "
							+ " group by movies.id"
							+ " order by movies." + page_sort_by+" "+page_sort_order;
				    	  
		    		  
		    	  }
			//System.out.println("Hello 4");

	    	  System.out.println("Query Movies" + query_movies);
			 //changed code
	    	  if(request.getParameter("button_clicked") != null){
				//System.out.println("Hello alpha");
	  			query_movies = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
						+ "inner join stars on stars.id=stars_in_movies.star_id) "
					 	 + " where movies.director like '%" + director + "%" + "' "
						+ "and (movies.title like '"+title +"%') "
						+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
						+ "and stars.last_name like '%" + star_lastname + "%' ) "
						+ " group by movies.id"
						+ " order by movies." + page_sort_by+" "+page_sort_order
						+ " limit " + page_number +","+ display_count ;

				query_movies_duplicate = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
						+ "inner join stars on stars.id=stars_in_movies.star_id) "
					 	 + " where movies.director like '%" + director + "%" + "' "
							+ "and (movies.title like '"+title +"%') "
						+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
						+ "and stars.last_name like '%" + star_lastname + "%' ) "
						+ " group by movies.id"
						+ " order by movies." + page_sort_by+" "+page_sort_order;
	    	  }
	    	  else if(request.getParameter("button_clicked_n") != null){
		    		 // System.out.println("Hello in beta");
						int demon = page_number-1;
						if(demon <=0 ){
							demon = 0;
						}
						query_movies = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
								+ "inner join stars on stars.id=stars_in_movies.star_id) "
							 	 + " where movies.director like '%" + director + "%" + "' "
								+ "and (movies.title regexp '^[0-9]+' ) "
								+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
								+ "and stars.last_name like '%" + star_lastname + "%' ) "
								+ " group by movies.id"
								+ " order by movies." + page_sort_by+" "+page_sort_order
								+ " limit " + demon +","+ display_count ;
// 						 query_movies = "select id from movies where title REGEXP '^[0-9]' ORDER by " + page_sort_by +" "+page_sort_order + " limit " + page_tmp +","+ (page_tmp+display_count);
									
					 
// 		  			query_movies_duplicate = "select id from movies where title REGEXP '^[0-9]' ORDER by " + page_sort_by +" "+page_sort_order;
							
						query_movies_duplicate = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
								+ "inner join stars on stars.id=stars_in_movies.star_id) "
							 	 + " where movies.director like '%" + director + "%" + "' "
									+ "and (movies.title regexp '^[0-9]+' ) "
								+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
								+ "and stars.last_name like '%" + star_lastname + "%' ) "
								+ " group by movies.id" 
								+ " order by movies." + page_sort_by+" "+page_sort_order;
		    	  }
	    	  else if(request.getParameter("button_clicked_g") != null){
	    		  String query_1 = "select id from genres where name =  " + "\"" +request.getParameter("button_clicked_g") + "\"";
				  ResultSet getting_genre = select_genre.executeQuery(query_1);
				  int actual_genre = 0;
				  while(getting_genre.next()){
					  actual_genre = getting_genre.getInt(1);
				  }
				 // System.out.println(query_1);
				  
// 					query_movies = "select movies.id from ((stars_in_movies inner join movies on  stars_in_movies.movie_id=movies.id) "
// 							+ "inner join stars on stars.id=stars_in_movies.star_id) "
// 						 	 + " where movies.director like '%" + director + "%" + "' "
// 							+ "and (movies.title REGEXP '^[0-9]' ) "
// 							+ "and (stars.first_name like '%" + star_firstname + "%" + "' "
// 							+ "and stars.last_name like '%" + star_lastname + "%' ) "
// 							+ " group by movies.id"
// 							+ " order by movies." + page_sort_by+" "+page_sort_order
// 							+ " limit " + page_number +","+ display_count ;
					if((page_number-1)<0){
						page_number =1;  
					}
					query_movies= "select movies.id from( genres_in_movies inner join movies on genres_in_movies.movies_id=movies.id)"
							+ "where genres_in_movies.genre_id  =" + actual_genre +  " group by movies.id"
									+ " order by movies." + page_sort_by+" "+page_sort_order
									+ " limit " + (page_number-1) +","+ display_count ;
					query_movies_duplicate= "select movies.id from( genres_in_movies inner join movies on genres_in_movies.movies_id=movies.id)"
							+ "where genres_in_movies.genre_id  =" + actual_genre +  " group by movies.id"
									+ " order by movies." + page_sort_by+" "+page_sort_order;
// 	    		  query_movies = "select id from (movies inner join genres_in_movies on genres_in_movies.movies_id = movies.id)where genres_in_movies.genre_id like " + actual_genre +  " order by " + page_sort_by + " " + page_sort_order + " limit " + (page_tmp-1) +","+ display_count;
// 	    		  query_movies_duplicate = "select id from (movies inner join genres_in_movies on genres_in_movies.movies_id = movies.id)where genres_in_movies.genre_id like " + actual_genre+  " order by " + page_sort_by + " " + page_sort_order;
	    	  }
	    	  //to here

		//System.out.println("Query_movies : " + query_movies);
		ResultSet result_movies = select_movies.executeQuery(query_movies);
		ResultSet result_movies_duplicate = select_movies_duplicate.executeQuery(query_movies_duplicate);

		while (result_movies.next()){
			list_movies.add(result_movies.getInt("id"));
		}
		while (result_movies_duplicate.next()){
			list_movies_duplicate.add(result_movies_duplicate.getInt("id"));
		}
		//System.out.println("List : " + list_movies);

		for(int movies_id:list_movies)
		{

		ArrayList<String> genre_list = new ArrayList<String>();
		ArrayList<Object> final_list =  new ArrayList<Object>();
		ArrayList<Object> star_list = new ArrayList<Object>();

		String query_movies_main = "select * from movies where movies.id =" + movies_id ;//result_movies.getInt("id");
		ResultSet result_movies_main = select_movies_main.executeQuery(query_movies_main);
		//System.out.println("Query_movies_main : " + query_movies_main);
		while(result_movies_main.next()){
		String query_stars = "select * from (stars_in_movies inner join stars on  stars.id=stars_in_movies.star_id) "
				+ "where stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
				+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%' "
				+ "and stars_in_movies.movie_id = "+ result_movies_main.getInt("id");
		 //System.out.println("Query Stars:"+ query_stars);

		ResultSet result_stars = select_stars.executeQuery(query_stars);
	    while(result_stars.next()){
	    	String star_name = result_stars.getString("first_name") + "~" + result_stars.getString("last_name");
	    	star_list.add(star_name);
	    }

		String query_genres = "select * from "
					+"(genres inner join genres_in_movies on "
					+"genres.id=genres_in_movies.genre_id ) "
					+"where genres_in_movies.movies_id="
					+result_movies_main.getInt("id");
		 //System.out.println("Query_Genres" + query_genres);
		ResultSet result_genres = select_genres.executeQuery(query_genres);
		while(result_genres.next()){
			String name = result_genres.getString(2);
			String genre_name =  URLEncoder.encode(name);


			genre_list.add(name);
		}

				final_list.add(result_movies_main.getURL("banner_url"));
				final_list.add(result_movies_main.getString("title"));
				final_list.add(result_movies_main.getString("year"));
				final_list.add(result_movies_main.getString("director"));
				final_list.add(genre_list);
				final_list.add(star_list);


				data.put(movies_id, final_list);
		}}

		Iterator <Map.Entry<Integer, ArrayList<Object>>> iterator_map = data.entrySet().iterator();
		%>
		<!-- <form method="post" action="confirmation_page.jsp">
		<input type="submit" name="submit" value="Checkout">
		</form> -->
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
	        ArrayList<Object> value_list = entry_list.getValue();
	        ArrayList<Object> get_genrelist = (ArrayList) value_list.get(4);
	        ArrayList<Object> get_starlist = (ArrayList) value_list.get(5);
	%>


	    <tr>
		<td><img src=<%=value_list.get(0).toString()%> style="width:100px;height:100px;"></td>
		<td><%=entry_list.getKey().toString()%></td>
		<td>
		<%String movie_name =  value_list.get(1).toString();
		String encoded_moviesname = URLEncoder.encode(movie_name);%>
		<a href="movie_file.jsp?Movie=<%=encoded_moviesname%>"><%=movie_name%></a>
		</td>
		<td><%=value_list.get(2).toString()%></td>
		<td><%=value_list.get(3).toString()%></td>
		<%-- <td><%=value_list.get(4).toString()%></td> --%>
		<td><%  for( Object genre_name_obj : get_genrelist){
				String genre_name_encode = genre_name_obj.toString();
				String genre_name = URLEncoder.encode(genre_name_encode, "UTF-8");

				%>
				<a href="display_list.jsp?button_clicked_g=<%=genre_name%>"><%=genre_name_encode%></a>


				<%
		}%>
	 </td>
		<td><%for(Object star_name_obj:get_starlist){

			 String star_fullname = star_name_obj.toString();
			String[] splitting = star_fullname.split("~");

			String encoded_firstname = URLEncoder.encode(splitting[0],"UTF-8");
			String encoded_lastname = URLEncoder.encode(splitting[1],"UTF-8");%>


	 <a href="star_file.jsp?Star=<%=encoded_firstname%>&Last=<%=encoded_lastname%>"><%=splitting[0]+" " +splitting[1]%></a>
		<%-- <%=value_list.get(5).toString()%> --%>
		<%} %></td>
    <td>

		<%
		String encoded_movie_name =   URLEncoder.encode(movie_name,"UTF-8");
		String encoded_title_name = URLEncoder.encode(title,"UTF-8");
		String encoded_director  = URLEncoder.encode(director,"UTF-8");
		String cart_url = "";
		String prev_url = "";
		if(request.getParameter("button_clicked") != null){
			button_clicked = request.getParameter("button_clicked") ;
			String encoded_b = URLEncoder.encode(button_clicked);
			cart_url="servlet_cart?cart_movie_id=" + entry_list.getKey().toString() + "&year=" + year +"&movie_name="+ encoded_movie_name+
					"&title=" + encoded_title_name + "&director=" + encoded_director + "&star_firstname=" + star_firstname +
					"&star_lastname=" + star_lastname + "&sort_by=" + page_sort_by + "&sort_order=" + page_sort_order +
					"&check=0" + "&button_clicked=" + encoded_b;

// 			prev_url = "display_list.jsp?display_count="+display_count +"&page_tmp=" + (page_tmp-1) + "&year=" +year + "&button_clicked=" + button_clicked;
		}
		else if(request.getParameter("button_clicked_n") != null){
			//no need to be encoded since it will just look for number
			
			button_clicked_n = request.getParameter("button_clicked_n") ;
			cart_url="servlet_cart?cart_movie_id=" + entry_list.getKey().toString() + "&year=" + year +"&movie_name="+ encoded_movie_name+
					"&title=" + encoded_title_name + "&director=" + encoded_director + "&star_firstname=" + star_firstname +
					"&star_lastname=" + star_lastname + "&sort_by=" + page_sort_by + "&sort_order=" + page_sort_order +
					"&check=0" + "&button_clicked_n=" +button_clicked_n;
// 			prev_url = "display_list.jsp?display_count="+display_count +"&page_tmp=" + (page_tmp-1) + "&year=" +year + "&button_clicked_n=" + button_clicked_n;

		}
		else if(request.getParameter("button_clicked_g") != null){
			button_clicked_g = request.getParameter("button_clicked_g") ;
			String encoded_g = URLEncoder.encode(button_clicked_g);
			cart_url="servlet_cart?cart_movie_id=" + entry_list.getKey().toString() + "&year=" + year +"&movie_name="+ encoded_movie_name+
					"&title=" + encoded_title_name + "&director=" + encoded_director + "&star_firstname=" + star_firstname +
					"&star_lastname=" + star_lastname + "&sort_by=" + page_sort_by + "&sort_order=" + page_sort_order +
					"&check=0" + "&button_clicked_g=" + encoded_g;
// 			prev_url = "display_list.jsp?display_count="+display_count +"&page_tmp=" + (page_tmp-1) + "&year=" +year + "&button_clicked_g=" + button_clicked_g;

		}
		else{
		cart_url="servlet_cart?cart_movie_id=" + entry_list.getKey().toString() + "&year=" + year +"&movie_name="+ encoded_movie_name+
							"&title=" + encoded_title_name + "&director=" + encoded_director + "&star_firstname=" + star_firstname +
							"&star_lastname=" + star_lastname + "&sort_by=" + page_sort_by + "&sort_order=" + page_sort_order +
							"&check=0";
// 			prev_url = "display_list.jsp?display_count="+display_count +"&page_tmp=" + (page_tmp-1) + "&year=" +year;

		}				
							%>

		<form method="post" action=<%=cart_url%>>
		<input type="number" name ="quantity">
		<input type="submit" value="Add to Cart">
		</form>
		</td>
	    <tr>

	     <%
	    }%>    </table>

	    <%
	    float size1 =list_movies.size()/display_count;
		//out.print("size =" + list_movies.size());
		//out.print("size1 =" + size1);

		int total_pagination_pages =  list_movies_duplicate.size()/display_count;
		if((list_movies_duplicate.size()%display_count)!=0) {total_pagination_pages=total_pagination_pages+1;}
		//out.println("Pagination Pages : " + total_pagination_pages);
		//out.println("List size : " + list_movies_duplicate.size());%>

		<%if(page_tmp>1) {%>
<%-- 		<%if(page_tmp>1) {%> --%>
		<%if(request.getParameter("button_clicked_g") != null) {%>
		<a href="display_list.jsp?display_count=<%=display_count%>&page_tmp=<%=page_tmp-1%>&year=<%=year%>&button_clicked_g=<%=request.getParameter("button_clicked_g")%>">PREV</a>&nbsp;&nbsp;
		
		<%} %>
		<%if(request.getParameter("button_clicked") != null) {%>
		<a href="display_list.jsp?display_count=<%=display_count%>&page_tmp=<%=page_tmp-1%>&year=<%=year%>&button_clicked=<%=request.getParameter("button_clicked")%>">PREV</a>&nbsp;&nbsp;
		
		<%} %>
		<%if(request.getParameter("button_clicked_n") != null) {%>
		<a href="display_list.jsp?display_count=<%=display_count%>&page_tmp=<%=page_tmp-1%>&year=<%=year%>&button_clicked_n=<%=request.getParameter("button_clicked_n")%>">PREV</a>&nbsp;&nbsp;
		<%//System.out.println("wtf riot?????????") ;%>
		<%} %>
		<%if(request.getParameter("button_clicked_g") == null && request.getParameter("button_clicked_n") == null && request.getParameter("button_clicked") == null){ %>
				<a href="display_list.jsp?display_count=<%=display_count%>&page_tmp=<%=page_tmp-1%>&year=<%=year%>">PREV</a>&nbsp;&nbsp;
		<%} %>
		<%} %>
		<%for(int m=1;m<=total_pagination_pages;m++){%>
			<a href="display_list.jsp?page_tmp=<%=m%>&display_count=<%=display_count%>&year=<%=year%>"><%=m%></a>
		<%}%>&nbsp;&nbsp;
		<%//out.println("Page Number" + page_tmp); %>
		<%//out.println("Page tmp*display_count" + page_tmp*display_count); %>
		<%//out.println("Page Number" + list_movies_duplicate.size()); %>
		<% if(page_tmp*display_count<list_movies_duplicate.size()){%>
		<%if(request.getParameter("button_clicked_g") != null) {%>
	     <a href="display_list.jsp?page_tmp=<%=page_tmp+1%>&display_count=<%=display_count %>&button_clicked_g=<%=request.getParameter("button_clicked_g")%>">NEXT</a>
		
		<%} %>
		<%if(request.getParameter("button_clicked") != null) {%>
	     <a href="display_list.jsp?page_tmp=<%=page_tmp+1%>&display_count=<%=display_count %>&button_clicked=<%=request.getParameter("button_clicked")%>">NEXT</a>
		
		<%} %>
		<%if(request.getParameter("button_clicked_n") != null) {%>
	     <a href="display_list.jsp?page_tmp=<%=page_tmp+1%>&display_count=<%=display_count %>&button_clicked_n=<%=request.getParameter("button_clicked_n")%>">NEXT</a>
		
		<%} %>
		<%if(request.getParameter("button_clicked_g") == null && request.getParameter("button_clicked_n") == null && request.getParameter("button_clicked") == null){ %>
	     <a href="display_list.jsp?page_tmp=<%=page_tmp+1%>&display_count=<%=display_count %>&year=<%=year%>">NEXT</a>
		<%} %>
	     <%} %>



<%}}
catch (Exception e) {
	System.out.println(e.getMessage());
}
%>
</body>
</html>

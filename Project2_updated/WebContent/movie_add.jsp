
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
<!-- <form action="confirmation_page.jsp" method="post"> -->
<!-- <input type="submit" value="checkout"> -->
<!-- </form> -->

<!-- <form action="cart_authenticity_check.jsp" method = "post"> -->
<!-- <input type="submit" value="Proceed to Checkout"> -->
<!-- </form> -->

<!-- <form action="logout.jsp" method ="post"> -->
<!-- <input type="submit" value="logout"> -->
<!-- </form> -->
<br><br><br><br>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
<%@page import="package_test.*" %>
<%@page import="java.text.*" %>
<%@page import="java.net.*" %>
<%@page import="java.util.Date" %>
<%-- <%@page import="java.net.URL;" %> --%>

<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1,count=0, counter=0,counter1=0;%>
<%
int movie_id = 0;
String title = Declarations.title,year = "2001", director = Declarations.director, banner_url = "https://images-na.ssl-images-amazon.com/images/M/MV5BMTExMDA0NDAyOTReQTJeQWpwZ15BbWU2MDM4ODg3OQ@@._V1_.jpg", trailer_url =
"https://www.youtube.com/watch?v=JdEFmGB--kQ",star_firstname=Declarations.star_firstname,
				star_lastname=Declarations.star_lastname, genre = Declarations.genre, star_url ="https://images-na.ssl-images-amazon.com/images/M/MV5BMjc4NDc3NDkzMl5BMl5BanBnXkFtZTcwMTAyNTQwMw@@._V1_.jpg";
int real_year = Integer.parseInt(year);
PrintWriter error_printing = response.getWriter();


%>

<form method="post" action="movie_add.jsp?display_count=5&page_tmp=1">
<table>
<tr> Title <input type="text" name="title"> </tr><br>
<tr> Year <input type="text" name="year"> </tr><br>
<tr>Director <input type="text" name="director"> </tr><br>
<tr> Banner url <input type="text" name="banner_url"> </tr><br>
<tr> Trailer url <input type="text" name="trailer_url"> </tr><br>
<tr> Stars First Name <input type="text" name="star_firstname"> </tr><br>
<tr>Stars Last Name <input type="text" name="star_lastname"> </tr><br>
<tr>Genre <input type="text" name="genre"> </tr><br>
<tr> <input type ="submit" value="submit"></tr><br>

</table>
</form>

<%	
if(request.getParameter("title") !=null){
	title = request.getParameter("title").toLowerCase();
	Declarations.title=title;
	}else if(request.getParameter("title") ==null){
// 		System.out.println("sdaas");
		title=Declarations.title;
	}
if(request.getParameter("year") !=null ){
	try{
		year = request.getParameter("year");
		real_year = Integer.parseInt(year);
	}
	catch (Exception e){
		error_printing.println("Please enter a valid year");
		real_year = -1;
		
	}
}
	if(request.getParameter("director") !=null){
	director = request.getParameter("director");
	Declarations.director=director;
	}else if(request.getParameter("director") ==null){
		director = Declarations.director;
	}
	
	if(request.getParameter("banner_url") !=null){
		if(request.getParameter("banner_url") != ""){
		banner_url = request.getParameter("banner_url");

		}
	Declarations.banner_url=banner_url;
	}else if(request.getParameter("banner_url") ==null){
		banner_url= "https://images-na.ssl-images-amazon.com/images/M/MV5BMTExMDA0NDAyOTReQTJeQWpwZ15BbWU2MDM4ODg3OQ@@._V1_.jpg";
	}
	if(request.getParameter("trailer_url") !=null){
		if(request.getParameter("trailer_url") != ""){
		trailer_url = request.getParameter("trailer_url");

		}
	Declarations.trailer_url=trailer_url;
	}else if(request.getParameter("trailer_url") ==null){
		trailer_url ="https://images-na.ssl-images-amazon.com/images/M/MV5BMTExMDA0NDAyOTReQTJeQWpwZ15BbWU2MDM4ODg3OQ@@._V1_.jpg";
	}
	if(request.getParameter("star_firstname") !=null){
		star_firstname = request.getParameter("star_firstname").toLowerCase();
		Declarations.star_firstname=star_firstname;
		}else if(request.getParameter("star_firstname") ==null){
//	 		System.out.println("sdaas");
			star_lastname=Declarations.star_lastname;
		}

		if(request.getParameter("star_lastname") !=null){
		star_lastname = request.getParameter("star_lastname");
		Declarations.star_lastname=star_lastname;
		}else if(request.getParameter("star_lastname") ==null){
			star_lastname = Declarations.star_lastname;
		}
		if(request.getParameter("genre") !=null){
		genre = request.getParameter("genre");
		Declarations.genre=genre;
		}else if(request.getParameter("genre") ==null){
			genre= Declarations.genre;
		}
		
	%>
<%
try {

	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
	if (test_connection == null){
		System.out.println("Not successful");
		out.println("Connection not successful");}
	else {

		Map<Integer, ArrayList<Object>> data = new LinkedHashMap<Integer, ArrayList<Object>>();
		ArrayList<Integer> list_movies = new ArrayList<Integer>();
		ArrayList<Integer> list_movies_duplicate = new ArrayList<Integer>();
		int update_movie_check = 0;

		Statement select_movies = test_connection.createStatement();
		Statement select_movies_duplicate = test_connection.createStatement();
		Statement select_movies_main = test_connection.createStatement();
		Statement select_stars = test_connection.createStatement();
		Statement select_genres = test_connection.createStatement();
		Statement checking = test_connection.createStatement();
		//modified
		Statement select_genre = test_connection.createStatement();
		System.out.println(request.getParameter("star_firstname") + "this is star first name");
		System.out.println(request.getParameter("star_lastname") + "this is star last name");
// 		if(movie_id != 0 && !title.equals("") && request.getParameter("year") != null && !director.equals("") && (request.getParameter("star_firstname") !=null && request.getParameter("star_lastname") !=null )){
		if(!title.equals("") && real_year != -1 && !director.equals("") && (!star_firstname.equals("") || !star_lastname.equals("") ) &&  !genre.equals("")){
	 		if(star_lastname.equals("")){
			star_lastname = star_firstname;
			star_firstname = "";
		}
		CallableStatement myStmt = test_connection.prepareCall("{call add_movie(?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?)}");
		//add all sql queries and then see if you can search it up then it works!
		myStmt.setInt(1, movie_id);
		myStmt.setString(2, title);
		myStmt.setString(3, year);
		myStmt.setString(4,director);
		myStmt.setString(5,banner_url);
		myStmt.setString(6,trailer_url);
		myStmt.setString(7,star_firstname);
		myStmt.setString(8,star_lastname);
		myStmt.setString(9,genre);
		myStmt.setString(10,star_url);
		myStmt.setInt(11,update_movie_check);

		myStmt.registerOutParameter(12, Types.INTEGER);
		myStmt.registerOutParameter(13, Types.INTEGER);
		myStmt.registerOutParameter(14, Types.VARCHAR);
		myStmt.registerOutParameter(15, Types.VARCHAR);

		System.out.println("Calling stored procedure right after checking");
		try{
	    URL url1 = new URL(trailer_url);
		URL url2 = new URL(banner_url);
		myStmt.execute();
		int theCount = myStmt.getInt(12);
		int theCount1 = myStmt.getInt(13);
		System.out.println("the count is " + theCount);


		System.out.println("the second count is " + theCount);

		}
        catch(MalformedURLException me)
        {
			error_printing.println("Entered url was not valid. Leave blank for default url");
        }
		catch (SQLIntegrityConstraintViolationException e) {
			error_printing.println("Movie already Exists. Query has NOT been added ");
		}
		catch(Exception e){
			error_printing.println(e.getMessage() + " Query has NOT been added");
		}
		String new_result = myStmt.getString(14);
		String new_result2 = myStmt.getString(15);
		error_printing.println(new_result);
		error_printing.println(new_result2);
		error_printing.println("Your query has been successfully processed");
		test_connection.close();
	
		myStmt.close();
		}
		else{

			error_printing.println("Make sure to enter a valid value for id, title,year, director, one value for star first name or last name, and genre");
		}
		
	}
	}
	catch (Exception e) {
		System.out.println(e.getMessage());
	}




%>

</body>
</html>

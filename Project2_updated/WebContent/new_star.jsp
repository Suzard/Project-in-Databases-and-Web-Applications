
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
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1,count=0, counter=0,counter1=0;%>
<%
int star_id = 0;
String star_firstname="",
		star_lastname="", dob = Declarations.dob, photo_url = "https://images-na.ssl-images-amazon.com/images/M/MV5BMjc4NDc3NDkzMl5BMl5BanBnXkFtZTcwMTAyNTQwMw@@._V1_.jpg";
Integer display_count = Declarations.display_count;
Integer page_number=Declarations.page_number, page_tmp=Declarations.page_tmp;
int start=0;
PrintWriter error_printing = response.getWriter();
// String  button_clicked_g = request.getParameter("button_clicked_g");
// String button_clicked = request.getParameter("button_clicked");
// String button_clicked_n = request.getParameter("button_clicked_n");

// if(request.getParameter("year")!=null){
// year= request.getParameter("year");
// } //replicating this for sorting

%>

<form method="post" action="new_star.jsp?display_count=5&page_tmp=1">
<table>
<!-- <tr> Stars ID <input type="text" name="id"> </tr><br> -->
<tr> Stars First Name <input type="text" name="star_firstname"> </tr><br>
<tr>Stars Last Name <input type="text" name="star_lastname"> </tr><br>
<!-- <tr> DOB <input type="text" name="dob"> </tr><br> -->
<!-- <tr> Photo url <input type="text" name="photo_url"> </tr><br> -->

<tr> <input type ="submit" value="submit"></tr><br>

</table>
</form>

<%	
// if(request.getParameter("id") !=null){
// 	try{
// 	star_id = Integer.parseInt(request.getParameter("id").toLowerCase());
// 	}
// 	catch(Exception e){
// 		error_printing.println("Please enter a valid id that is not a string or empty.");
// 	}

// }
if(request.getParameter("star_firstname") !=null){
	star_firstname = request.getParameter("star_firstname").toLowerCase();
	Declarations.star_firstname=star_firstname;
	}else if(request.getParameter("star_firstname") ==null){
// 		System.out.println("sdaas");
		star_lastname= "";
	}

	if(request.getParameter("star_lastname") !=null){
	star_lastname = request.getParameter("star_lastname");
	Declarations.star_lastname=star_lastname;
	}else if(request.getParameter("star_lastname") ==null){
		star_lastname = "";
	}
	
// 	if(request.getParameter("dob") !=null){
// 	dob = request.getParameter("dob");
// 	Declarations.dob=dob;
// 	}else if(request.getParameter("dob") ==null){
// 		dob = Declarations.dob;
// 	}
// 	if(request.getParameter("photo_url") !=null){
// 		photo_url = request.getParameter("photo_url");
// 	Declarations.photo_url=photo_url;
// 	}else if(request.getParameter("photo_url") ==null){
// 		photo_url = Declarations.photo_url;
// 	}
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

		Statement select_movies = test_connection.createStatement();
		Statement select_movies_duplicate = test_connection.createStatement();
		Statement select_movies_main = test_connection.createStatement();
		Statement select_stars = test_connection.createStatement();
		Statement select_genres = test_connection.createStatement();
		Statement checking = test_connection.createStatement();
		//modified
		Statement select_genre = test_connection.createStatement();
		
		System.out.println(star_id);
		System.out.println(star_firstname);
		System.out.println(star_lastname);
		if((!(star_firstname.equals("") && star_lastname.equals("")))){
			
		if(star_lastname.equals("")){
			star_lastname = star_firstname;
			star_firstname = "";
		}
		CallableStatement myStmt = test_connection.prepareCall("{call add_star(?, ?, ?, ?, ?)}");
		myStmt.setInt(1, star_id);
		myStmt.setString(2, star_firstname);
		myStmt.setString(3, star_lastname);
		myStmt.setString(4,dob);
		myStmt.setString(5,photo_url);
// 		values(star_ids, first_name,last_name, date_birth, photo_url_s);
		String inserting_check = "INSERT INTO STARS values(" + star_id +  ",'" + star_firstname + "','" +star_lastname + "','" + dob + "','" + photo_url + "')";
		
		System.out.println(inserting_check);
// 		checking.executeUpdate(inserting_check);
		System.out.println("Calling stored procedure right after checking");
		try{
		myStmt.execute();
		}
		catch(Exception e){
			error_printing.println(e.getMessage());
		}
		test_connection.close();
	
		myStmt.close();
		error_printing.println("Succesfully entered");
		}
		else{

			error_printing.println("Enter one entry for first name or last name. No changes have been made");
		}
		
	}
	}
	catch (Exception e) {
		System.out.println(e.getMessage());
	}




%>

</body>
</html>

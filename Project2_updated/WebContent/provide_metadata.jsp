
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
<% 
try {

	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
	if (test_connection == null){
		System.out.println("Not successful");
		out.println("Connection not successful");}
	else {
				PrintWriter metadata_printing = response.getWriter();

	           	String printing1 = "SELECT TABLE_NAME  FROM INFORMATION_SCHEMA.TABLES" +
	        			"  WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA= 'moviedb' ";
				//referenced JDBC1.java
				Statement select = test_connection.createStatement();
				Statement select2 = test_connection.createStatement();

		        ResultSet all_tables = select.executeQuery(printing1);
		        while(all_tables.next()){
		        	String table_name = all_tables.getString(1);
		        	String command = "Select * FROM " + table_name;
		        	metadata_printing.println(table_name);
		        	ResultSet data = select2.executeQuery(command);
		            ResultSetMetaData metadata = data.getMetaData();
				    for (int i = 1; i <= metadata.getColumnCount(); i++){
				    	metadata_printing.println("Column" + i + " type " + metadata.getColumnTypeName(i) + "|");
				    }
// 				    metadata_printing.write( System.getProperty("line.separator"));
// 				    metadata_printing.println("start                 end");
				   }
	}
}	
catch (Exception e) {
	System.out.println(e.getMessage());
}

%>
</body>
</html>
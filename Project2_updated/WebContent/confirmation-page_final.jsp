<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
<%@page import="package_test.*"%>
<%@page import="java.text.*"%>
<%@page import="java.net.*"%>
<%@page import="package_test.*"%>
<%@page import="package_test.Declarations"%>
<%@page import="com.sun.javafx.collections.MappingChange.Map"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*  "%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.time.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration" %>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	Thanks for your purchase. The order has been placed successfully.
	<%		
			try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection test_connection = DriverManager.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
			if (test_connection == null){
			System.out.println("Not successful");
			//out.println("Connection not successfull");
			}
		
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			System.out.println(dateFormat.format(date));
			
		// Integer customer_id = Integer.parseInt(request.getParameter("customer_id"));
		Integer customer_id1=490012,movie_id1=0;
		
		 HttpSession session1= request.getSession(false);
		//System.out.println("Session in "+session1);
		ArrayList<Object> list_customer = (ArrayList<Object>) session1.getAttribute("customer_id");
		//System.out.println("List: "+ list_customer);
		if(list_customer!=null){
		customer_id1 = (Integer) list_customer.get(0);
		}else{
			customer_id1=490012;
		}
		if(list_customer!=null){
		movie_id1 = (Integer) list_customer.get(0);
			}else{
				movie_id1=901;
			}
		cart_main cart = (cart_main) session1.getAttribute("cart");
		//System.out.println("Cart : " + cart);
		HashMap<Integer,ArrayList<Object>> cart1 = cart.map_get();
		// System.out.println("before getting inside");
		for (Entry<Integer,ArrayList<Object>> entry : cart1.entrySet()) {
			/* String query_update_sales1 = "insert into sales(customer_id, movie_id,sale_date)" + "values(?,?,?)"; */
			//PreparedStatement preparedStmt = test_connection.prepareStatement(query_update_sales1);
			/* preparedStmt.setString (1, 490012);
		      preparedStmt.setString (2, 901);
		      preparedStmt.setDate   (3, startDate); */
		      System.out.println("went inside");
			String query_update_sales = "insert into sales (customer_id, movie_id, sale_date) values(" + 
		      							customer_id1 + "," + entry.getKey()+ "," + "STR_TO_DATE('"+ dateFormat.format(date) + "','%Y-%m-%d'))";		       
			System.out.println(query_update_sales);
			PreparedStatement preparedStmt = test_connection.prepareStatement(query_update_sales);
			preparedStmt.execute();
		    
								   
		}
		test_connection.close();
			}
	catch (Exception e)
    {
      System.err.println(e.getMessage());
    }

	
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="package_test.Declarations" %>
<%@page import="com.sun.javafx.collections.MappingChange.Map"%>
<%@page import="javax.servlet.*" %>
<%@page import="java.util.*  " %>
<%@page import="java.util.Map.Entry" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.io.*" %>
<%@page import="package_test.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

</head>

<body>

<form action="cart_authenticity_check.jsp">
<input type="submit" value="Proceed to Checkout">
</form>

<form action="logout.jsp">
<input type="submit" value="logout">
</form>

<%
			String home_address="",email="",first_name="",last_name="",credit_card="",movie_name="";
			int customer_id=0,movie_id=0,quantity=0,check=1;
			
			if(request.getAttribute("first_name")!=null);
			first_name = (String) request.getAttribute("first_name");
			
			if(request.getAttribute("last_name")!=null)
			last_name = request.getAttribute("last_name").toString();

			if(request.getAttribute("credit_card_id")!=null)
			credit_card = request.getAttribute("credit_card_id").toString();
			
			if(request.getAttribute("home_address")!=null){
			home_address = request.getAttribute("home_address").toString();
			}
			
			if(request.getAttribute("email")!=null){
			email = request.getAttribute("email").toString();
			}
			
			if(request.getAttribute("id")!=null){
			customer_id = (Integer) request.getAttribute("id");
			}
			
			if(request.getAttribute("movie_id")!=null)
				movie_id= (Integer) request.getAttribute("movie_id");
			
			if(request.getAttribute("check")!=null)
				check = (Integer) request.getAttribute("check");
			
			if(request.getAttribute("movie_name")!=null)
				movie_name=(String)request.getAttribute("movie_name");
			System.out.println("Movie Name" + movie_name);
			
			
			
/*  			 out.println("First Name :" + first_name);
			
			out.println("Last Name :" + last_name);
			
			out.println("Credit Card Number :" + credit_card);
			
			out.println("Customer Id :" + customer_id);   */
		%>
<%-- 	<table border=1 cellpadding=1>
	
		<th>First Name</th>
		<th>Last Name</th>
		<th>Credit Card number</th>
		<th>Home Address</th>
		<th>Email</th>
		<tr>

			<td><%=first_name%></td>

			<td><%=last_name%></td>

			<td><%=credit_card%></td>

			<td><%=home_address%></td>

			<td><%=email%></td>

		</tr>

	</table> --%>
	<br><br><br><br>
	<table border=1 cellpadding=1>
	<th> Sr No</th>
	<th> Product</th>
	<th width="50%"> Movie Name</th>
	<th> Quantity </th>
	<th>Individual Price</th>
	<th>Update Quantity</th>
	<tr>
	<%
	int i=0,final_cost=10;
	Integer total_items=0;

	cart_main cart = (cart_main) session.getAttribute("cart");
	HashMap<Integer,ArrayList<Object>> cart_iterating = cart.map_get();
	
	
/* 	System.out.println("MOVIE ID123:" + request.getParameter("movie_id"));
	System.out.println("QUANTITY123:" + request.getParameter("quantity123"));
	System.out.println("QUANTITY123 VALUE:"+Integer.parseInt(request.getParameter("quantity123"))); */
	System.out.println("hi");
	
	if(request.getParameter("delete")!=null){
	if(request.getParameter("movie_id")!=null && request.getParameter("delete").equals("1")){
		cart.remove(Integer.parseInt(request.getParameter("movie_id")));
	}}

	if(request.getParameter("update")!=null){
	if(request.getParameter("movie_id")!=null && request.getParameter("quantity123")!=null 
			&& Integer.parseInt(request.getParameter("quantity123"))==0 ){
		System.out.println("Went to delete the movieid");
		cart.remove(Integer.parseInt(request.getParameter("movie_id")));
	}}
	
	
	
	
	for (Entry<Integer, ArrayList<Object>> entry : cart_iterating.entrySet()) {
	ArrayList<Object> local_cart_list = (ArrayList<Object>) entry.getValue();
	
/* 	System.out.println("See the list" + local_cart_list); */
	String current_movie_name = local_cart_list.get(0).toString();
/* 	System.out.println("Request update : "+ request.getAttribute(current_movie_name));
	System.out.println("Quantity : " + request.getAttribute("quantity"));
	
	System.out.println("Quantity123 : " + request.getParameter("quantity123"));
	System.out.println("Movie Id123" + request.getParameter("movie_id")); */
	
	if(request.getParameter("quantity123")!=null && (Integer.parseInt(request.getParameter("movie_id"))==entry.getKey()) && request.getParameter("update").equals("1")){
		quantity= Integer.parseInt(request.getParameter("quantity123"));//System.out.println("executed new");
		local_cart_list.set(1,quantity);	 
		//cart.update(Integer.parseInt(request.getParameter("movie_id")), quantity, 1, local_cart_list.get(0).toString());
	}
	else{
		quantity = (Integer) local_cart_list.get(1);//System.out.println("old");
		}

	
	Integer current_item=(Integer) local_cart_list.get(1);
	total_items+= current_item;
	
	System.out.println("Quantity" + quantity);
	%>
	    <tr>
	    <td><%=++i%></td>
	    <td><%=entry.getKey()%></td>
	     <td><%=local_cart_list.get(0)%></td>
	    <td><%=quantity%></td> 
	    <td><%=current_item*10 %>
	    <td>
	    <form method="post" action="confirmation_page.jsp?check=1&movie_id=<%=entry.getKey()%>&movie_name=<%=local_cart_list.get(0)%>
	    			&first_name=<%=first_name%>&last_name=<%=last_name%>&credit_card_id=<%=credit_card%>
	    			&home_address=<%=home_address%>&email=<%=email%>&update=1">
	    <input type="number" name="quantity123">
	    <input type="submit" name=<%=local_cart_list.get(0)%> value="update">
	    </form>
	     <form method="post" action="confirmation_page.jsp?check=1&movie_id=<%=entry.getKey()%>&movie_name=<%=local_cart_list.get(0)%>
	    			&first_name=<%=first_name%>&last_name=<%=last_name%>&credit_card_id=<%=credit_card%>
	    			&home_address=<%=home_address%>&email=<%=email%>&delete=1">
	    <input type="submit" name=<%=local_cart_list.get(0)%> value="delete">
	    </form>
	    

	    
	    </td>
	    </tr>
	<%}
	session.setAttribute("cart",cart);
	%>
	</tr>
	<tr><td colspan="4">Final Cost</td><td> <%=final_cost*total_items%></td></tr>
	</table>


<br><br><br><br>
	<%-- <form method="post"
		action="confirmation-page_final.jsp?&first_name=<%=first_name%>&last_name=<%=last_name%>&customer_id=<%=customer_id%>&">

		 --%>
		 <form method="post" action="cart_authenticity_check.jsp">
		 <input type="submit" value="Confirm" name="submit">

	</form>

</body>

</html>
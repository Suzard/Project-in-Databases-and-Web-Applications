<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- <form method="post" action="display_list.jsp?display_count=5&page_tmp=1"> -->

<%
/* HttpSession session4 = request.getSession(false);
ArrayList<Object> session_local_details = (ArrayList<Object>) session.getAttribute("customer_id");
int customer_id = (int) session_local_details.get(0);
String first_name = (String) session_local_details.get(1);
String last_name = (String) session_local_details.get(2);
String address = (String) session_local_details.get(3);
String email = (String) session_local_details.get(4);
String password = (String) session_local_details.get(5); */

%>
<td>
<form action="confirmation_page.jsp">
<input type="submit" value="checkout">
</form>
</td>
<td>
<form action="cart_authenticity_check.jsp">
<input type="submit" value="Proceed to Checkout">
</form>
</td>
<td>
<form action="logout.jsp">
<input type="submit" value="logout">
</form>
</td>



<br>
<br>
<br>
<form method="post" action="criteria_search">
<table>

<tr><input type="radio" name="criteria_search" value="search" >Search</tr>
<tr><input type="radio" name="criteria_search" value="browse" >Browse</tr><br>
<tr><input type="submit" name="Submit"> </tr>

</table>
</form>
</body>
</html>
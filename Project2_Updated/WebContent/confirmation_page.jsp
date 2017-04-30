<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
 <% String first_name = (String) request.getAttribute("first_name");
	String  last_name = request.getAttribute("last_name").toString();
	String credit_card = request.getAttribute("credit_card_id").toString();
	int customer_id =  (int) request.getAttribute("id");
	out.println("First Name :" + first_name);
	out.println("Last Name :" + last_name);
	out.println("Credit Card Number :" + credit_card);
	out.println("Customer Id :" + customer_id);
	
%>
</table>
</body>
</html>
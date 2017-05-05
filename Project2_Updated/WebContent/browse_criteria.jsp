<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


<form method="post" action="browse_criteria">
<table>

<tr><input type="radio" name="criteria_search" value="display_alphabetically" >display alphabetically</tr>
<tr><input type="radio" name="criteria_search" value="display_genres" >display genres</tr><br>
<tr><input type="submit" name="Submit"> </tr>

</table>
</form>
</body>
</html>
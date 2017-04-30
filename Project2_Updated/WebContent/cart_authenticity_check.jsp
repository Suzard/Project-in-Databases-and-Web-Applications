<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method ="post" action="cart_authenticity_check">
<table>

First Name<input type="text" name="first_name" required><br>
Last Name<input type="text" name="last_name" required><br>
E-mail<input type="text" name="email"><br>
Credit Card Number <input type="text" name="credit_card_number" required>
Expiration Date (Please enter the date as YYYY--MM--DD)<input type="text" name="date" required><br>
<input type="submit" name="submit">

</table>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="display_list.jsp?display_count=5&page_tmp=1">
<table>

<tr><input type="radio" name="criteria_search" value="search" >Search</tr>
<tr><input type="radio" name="criteria_search" value="browse" >Browse</tr><br>
<tr><input type="submit" name="Submit"> </tr>

</table>
</form>
</body>
</html>
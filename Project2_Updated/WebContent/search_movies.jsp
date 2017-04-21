<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="search_movies">
<table>
<tr>Title<input type="text" name="title"></tr><br>
<tr> Year <input type="text" name="year"> </tr><br>
<tr> Director <input type="text" name="director"> </tr><br>
<tr> Stars First Name <input type="text" name="star_firstname"> </tr><br>
<tr> Stars Last Name <input type="text" name="star_lastname"> </tr><br>
<tr> <input type ="submit" value="submit"></tr><br>

</table>
</form>
</body>
</html>
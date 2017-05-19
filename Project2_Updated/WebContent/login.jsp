<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<br><br><br><br><br>
<form method="post" action="login" align="center">

<table>
<tr>Name<input type="text" name="email"></tr>
<tr> Password <input type="password" name="password" > </tr><br><br><br>
<tr> <input type ="submit" value="Login"></tr>

<%
          ReCaptcha c = ReCaptchaFactory.newReCaptcha("6LfBMyAUAAAAAGecU4wVlV4jI0JPvKqfmFBTl5Ny", "6LfBMyAUAAAAAHPqAlU6HzqTAdEGfB6axGC1BM9j", false);
          out.print(c.createRecaptchaHtml(null, null));
        %>
</table>


</form>

        
<%
if(request.getAttribute("error_message")!=null){
String error_message = request.getAttribute("error_message").toString(); 

if(error_message.length()!=0){
	out.println("Please enter the correct credentials");
}}

if(request.getAttribute("error_captcha")!=null){
String error_captcha = request.getAttribute("error_captcha").toString(); 
if(error_captcha.length()!=0){
	out.println(error_captcha);
}
}%>
</body>
</html>
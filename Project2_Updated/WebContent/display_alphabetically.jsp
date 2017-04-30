
	
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
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*" %>
<%@page import="package_test.*"%>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%int id=0,prev_id=1; 

Integer display_count = 5;
Integer page_number=1;
Integer page_number_start = 0;
System.out.println(page_number_start +"checking page 1");
Integer super_temp = 0;
String sort_by = "year";
String sort_order = "asc";
String endcoded_alphabetical_value = request.getParameter("button_clicked");
String alphabetical_value = URLDecoder.decode(endcoded_alphabetical_value);
if(request.getParameter("display_count")!=null){
	display_count= Integer.parseInt(request.getParameter("display_count"));
}
if(request.getParameter("page_number")!=null){
	page_number= Integer.parseInt(request.getParameter("page_number"));
	page_number_start = (page_number -1)*display_count;
}
System.out.println(page_number_start +"checking page 2");
if(request.getParameter("page_number_start")!=null){
	page_number_start=Integer.parseInt(request.getParameter("page_number_start"));
	Declarations.page_tmp = page_number_start;
	super_temp = page_number;
	page_number=(page_number_start-1)*display_count;
	Declarations.page_number=page_number;
	
}
if(request.getParameter("sort_by")!=null){
	sort_by = request.getParameter("sort_by");
	Declarations.page_sort_by=sort_by;
}else if(request.getParameter("sort_by")==null){
	sort_by=Declarations.page_sort_by;
}
if(request.getParameter("sort_order")!=null){
	sort_order = request.getParameter("sort_order");
	Declarations.page_sort_order=sort_order;
}else if(request.getParameter("sort_order")==null){
	sort_order=Declarations.page_sort_order;
}
%>

<%-- <div><%out.print("Number of results to be displayed on Page"); %>&nbsp;	 --%>
<a href="display_alphabetically.jsp?display_count=5&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">5</a> &nbsp;
<a href="display_alphabetically.jsp?display_count=10&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">10</a> &nbsp;
<a href="display_alphabetically.jsp?display_count=15&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">15</a> &nbsp;
<a href="display_alphabetically.jsp?display_count=20&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">20</a> &nbsp;
<a href="display_alphabetically.jsp?display_count=25&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">25</a> &nbsp;
<a href="display_alphabetically.jsp?display_count=30&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">30</a> &nbsp;
<!-- when initially loaded page #=1 -->
<a href="display_alphabetically.jsp?display_count=<%=display_count%>&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>&sort_by=year">YEAR</a> &nbsp;
<a href="display_alphabetically.jsp?display_count=<%=display_count%>&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>&sort_by=title">TITLE</a> &nbsp;

<a href="display_alphabetically.jsp?display_count=<%=display_count%>&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>&sort_by=id">ID</a> &nbsp;

<a href="display_alphabetically.jsp?sort_order=asc&display_count=<%=display_count%>&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">Ascending</a> &nbsp;
<a href="display_alphabetically.jsp?sort_order=desc&display_count=<%=display_count%>&button_clicked=<%=alphabetical_value%>&page_number=<%=page_number%>&page_number_start=<%=page_number_start%>">Descending</a> &nbsp;



<%
//PrintWriter out = response.getWriter();
	Connection test_connection = DriverManager
			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
	Map<Integer, ArrayList<Object>> data = new LinkedHashMap<Integer, ArrayList<Object>>();
// 	Map<Integer, ArrayList<Object>> data1 = new LinkedHashMap<Integer, ArrayList<Object>>();
// 	Map<Integer, ArrayList<Object>> data2 = new LinkedHashMap<Integer, ArrayList<Object>>();
// 		Map<Integer, Integer> sort_by_year =  new LinkedHashMap<Integer, Integer>();
// 		Map<String, Integer> sort_by_title =  new LinkedHashMap<String, Integer>();

		Statement select = test_connection.createStatement();
		Statement select2 = test_connection.createStatement();
        Statement select3 = test_connection.createStatement();
        Statement select4 = test_connection.createStatement();
        Statement select5 = test_connection.createStatement();
        Statement select6 = test_connection.createStatement();
        Statement select7 = test_connection.createStatement();
        Statement select8 = test_connection.createStatement();
        Statement select9 = test_connection.createStatement();
             int star_id;
             Map<String,String> stars_first_and_last = new HashMap<String, String>();
             String dob;
             String photo_url;
             String movie_title;
             int movie_year;
             String movie_director;
             String banner_url;
             String trailer_url;
             ArrayList<String> genres;
             int movie_id;
             String calculate_genre_c = "select id from genres where name =  " + "\"" +alphabetical_value + 
            							 "\"";
             ResultSet genre_calculating = select8.executeQuery(calculate_genre_c);
             System.out.println(calculate_genre_c);
             int genre_v = 0;
             int movie_v = 0;
             while(genre_calculating.next()){
            	 genre_v = genre_calculating.getInt(1);
             }
			System.out.println(page_number_start+  " query using start");
			System.out.println(page_number+  " query using page #");
			
			System.out.println(display_count+  " query using display_count");
			String calcing_movies;
			if(page_number_start <0){
				page_number_start = 0;
			}

			
// 			if(request.getParameter("page_number_start") != null){
// 				Integer zowi = Integer.parseInt(request.getParameter("page_number_start"));
// 				if(Integer.parseInt(request.getParameter("page_number_start")) <0){
// 					zowi = 0;
// 				}
			System.out.println(request.getParameter("sort_order"));
			 if(alphabetical_value.equals("Number")){
				 calcing_movies = "select * from movies where title REGEXP '^[0-9]' ORDER by " + sort_by + " " + sort_order + " limit " + page_number_start + "," + display_count;;
			 }
			 else{
             	calcing_movies = "select * from movies where title like " + "\"" + alphabetical_value + "%" + "\"" + "ORDER by " + sort_by + " " + sort_order+ " limit " + page_number_start + "," + display_count;
			 }
			System.out.println(calcing_movies);

// 			}
// 			else{
// 	             calcing_movies = "select movies_id from genres_in_movies where genre_id = " + genre_v  + " limit " + page_number_start + "," + display_count;
// 			}
             ResultSet all = select9.executeQuery(calcing_movies);

             while(all.next()){
            	 movie_id = all.getInt(1);
                 ArrayList<Object> list = new ArrayList<Object>();
            		 movie_title = all.getString(2);
            		 movie_year = all.getInt(3);
            		 movie_director = all.getString(4);
            		 banner_url  = all.getString(5);
        	         trailer_url  = all.getString(6);
                	 list.add(movie_title);
                	 list.add(movie_year);
                	 list.add(movie_director);
                	 list.add(banner_url);
                	 list.add(trailer_url);
            	 String star_details = "select star_id from stars_in_movies where movie_id = " +movie_id;
            	 ResultSet star_details_r = select3.executeQuery(star_details);
            	 ArrayList<String> star_list= new ArrayList<String>();
            	 while(star_details_r.next()){
                     star_id = star_details_r.getInt(1);
                     String star_converted_f = "select first_name from stars where id =" + star_id;
                     String star_converted_l = "select last_name from stars where id = " + star_id;
                     String full_name = "";
                     ResultSet star_result_f = select4.executeQuery(star_converted_f);
                     while(star_result_f.next()){
                    	 full_name += star_result_f.getString(1);
                     }
                     ResultSet star_result_l = select5.executeQuery(star_converted_l);
                     full_name += "~";
                     while(star_result_l.next()){
                    	 full_name += star_result_l.getString(1);
                     }
                     star_list.add(full_name);
            	 }
//             	 System.out.println(star_list + "before");
//             	 Collections.sort(star_list);
//             	 System.out.println(star_list + "after");

            	 ArrayList<String> genre_list = new ArrayList<String>();
            	 String genre_details = "select genre_id from genres_in_movies where movies_id = " +movie_id;
            	 ResultSet genre_ids = select6.executeQuery(genre_details);
            	 while(genre_ids.next()){
            		 int genre_id = genre_ids.getInt(1);
            		 String genre_name_command = "select name from genres where id = " + genre_id;
            		 ResultSet genre_name = select7.executeQuery(genre_name_command);
            		 while(genre_name.next()){
            			 String genre = genre_name.getString(1);
                		 genre_list.add(genre);
            		 }

            	 }
               	 list.add(star_list);
               	 list.add(genre_list);
               	 data.put(movie_id, list);
//                	 sort_by_year.put(movie_year,movie_id);
//                	 sort_by_title.put(movie_title, movie_id);
            	 }

//         	 System.out.println("Sorting" +data.keySet());
        	 
//         	 System.out.println(data);
// 				SortedSet<Integer> id_keys = new TreeSet<Integer>(data.keySet());
// 				SortedSet<Integer> year_keys = new TreeSet<Integer>(sort_by_year.keySet());
// 				SortedSet<String> title_keys = new TreeSet<String>(sort_by_title.keySet());
// 				Map<Integer, ArrayList<Object>> real_sort = new LinkedHashMap<Integer, ArrayList<Object>>();
				Iterator <Map.Entry<Integer, ArrayList<Object>>> iterating =  data.entrySet().iterator();
		%>
		<%if(data.size()==0) {

		String redirectURL = "http://localhost:8080/Project2_Updated/display_alphabetically.jsp?page_number=" + 0 + "&display_count=" + display_count + "&button_clicked=" + alphabetical_value + "&page_number_start=" + (page_number_start-display_count);
// httpResp.sendRedirect(httpReq.getRequestURI());
		System.out.println("wrong");
// 	    response.sendRedirect(getRequestURI()); 
		response.sendRedirect(redirectURL);
		}
	    %>
		<table border=1 cellpadding=1>
		<th>Image</th>  
		<th>ID</th>
		<th>Title</th>
		<th>Year</th>
		<th>Director</th>
		<th>List of genres</th>
		<th>List of Stars</th>
		
        <% while(iterating.hasNext()){%>

        			
        			<% Map.Entry<Integer, ArrayList<Object>> entry = iterating.next();%>
					<%ArrayList<Object> e = entry.getValue();%>
					<%ArrayList<String> star_listing = (ArrayList<String>) e.get(5); %>
					<%Iterator <String> iterate_star = star_listing.iterator(); %>
					<%ArrayList<String> genre_listing = (ArrayList<String>) e.get(6); %>
					<%Iterator <String> iterate_genre = genre_listing.iterator(); %>
        <% String image_url = e.get(3).toString();%>
        <%id= 1;%>
        <tr>
      <td><img src=<%=image_url%> style="width:100px;height:100px;">
		<td><%=Integer.parseInt(entry.getKey().toString())%></td>
		<% String q = e.get(0).toString();%>
		<%String encodedString = URLEncoder.encode(q, "UTF-8"); %>		
		<td><a href= "movie_file.jsp?Movie=<%=q%>" ><%=q%></a></td> <!-- title -->
		<td><%=e.get(1).toString()%></td> <!-- year -->
		<td><%=e.get(2).toString()%></td> <!-- director -->
		<td><% while(iterate_genre.hasNext()){ %>
			<%String encoded_name_v = iterate_genre.next(); %>	
			<%String genre_name_v = URLEncoder.encode(encoded_name_v); %>
		
		<a href= "display_alphabetically.jsp?button_clicked=<%=genre_name_v%>&page_number=<%=page_number%>&display_count=<%=display_count%>" ><%=encoded_name_v%></a>
		<% }%>
		<td><% while(iterate_star.hasNext()){ %>
			<%String star_name_v = iterate_star.next(); %>
			<%String []splitting = star_name_v.split("~");%>
			<%String encoded_first =  URLEncoder.encode(splitting[0],"UTF-8");%>
			<%String encoded_last =  URLEncoder.encode(splitting[1],"UTF-8");%>
			
		<a href= "star_file.jsp?Star=<%=encoded_first%>&Last=<%=encoded_last%>" ><%=splitting[0]+" " +splitting[1]%></a>
		<% }%>

		<tr>
		<%}%>
        </table>
		
		


<% if(page_number >1){ //changed href to include page number start%>

 <a href="display_alphabetically.jsp?page_number=<%=page_number-1%>&display_count=<%=display_count %>&button_clicked=<%=alphabetical_value%>&page_number_start=<%=page_number_start-display_count%>">PREV</a>
 <% }%>

 <a href="display_alphabetically.jsp?page_number=<%=page_number+1%>&display_count=<%=display_count %>&button_clicked=<%=alphabetical_value%>&page_number_start=<%=page_number_start+display_count%>">NEXT</a> 

</body>
</html>


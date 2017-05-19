//package package_test;
//
//import java.io.*;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.LinkedHashMap;
//
//import package_test.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
//
//import com.sun.javafx.collections.MappingChange.Map;
//import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;
//
//public class query_main {
//	List<Object> query(int year,String title,String director,String first_name, String last_name,
//			int per_page_count,String page_sort_by,String page_sort_order){
//		List<Object> final_list= new ArrayList<Object>;
//	try
//	{
//    	Class.forName("com.mysql.jdbc.Driver");
//    	//PrintWriter out = response.getWriter();
//    	Connection test_connection = DriverManager
//    			.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");
//    	if (test_connection == null){
//    		System.out.println("Not successful");
//    		}
//    	else {
//    		
//    		Map<Integer, ArrayList<Object>> data = (Map<Integer, ArrayList<Object>>) new LinkedHashMap<Integer, ArrayList<Object>>();
//    		
//    		Statement select_movies = test_connection.createStatement();
//    		Statement select_stars = test_connection.createStatement();
//    		Statement select_genres = test_connection.createStatement();
//    	
//    	
//    	String query_movies = "select * from movies where (movies.title like '"
//    							+ "where movies.year = " + year
//    							+ " and movies.director like '%" + director + "%" + "' "
//    							+ "and (movies.title like '%" + title + "%" + "') ";
//    		}}
//	catch(Exception e)
//	{
//		System.out.println(e.getMessage());
//	}
//	return list;
//}}
//	
//	

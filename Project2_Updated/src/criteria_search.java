

import java.io.IOException;
import java.io.PrintWriter;
import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;

import java.sql.*; 

import java.util.*;
import package_test.*;


/**
 * Servlet implementation class criteria_search
 */
@WebServlet("/criteria_search")
public class criteria_search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public criteria_search() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		response.setContentType("text/html");  
        PrintWriter out=response.getWriter();  
         
//        int id=0,prev_id=1,count=0, counter=0;
//        
//        String title=Declarations.title, director=Declarations.director, star_firstname=Declarations.first_name, 
//        		star_lastname=Declarations.last_name, query_movies="", page_sort_by=Declarations.page_sort_by, 
//        		page_sort_order=Declarations.page_sort_order;
//        int year;
//
//        	if(request.getParameter("director") !=null){
//        	title = request.getParameter("title");
//        	Declarations.title=title;
//        	}
//        	
//        	if(request.getParameter("director") !=null){
//        	director = request.getParameter("director").toLowerCase();
//        	Declarations.director=director;
//        	}
//        	
//        	if(request.getParameter("star_firstname") !=null){
//        	star_firstname = request.getParameter("star_firstname").toLowerCase();
//        	Declarations.first_name=star_firstname;
//        	}
//        	
//        	if(request.getParameter("star_last_name") !=null){
//        	star_lastname = request.getParameter("star_lastname");
//        	Declarations.last_name=star_lastname;
//        	}
//        	
//        	if(request.getParameter("sort_by")!=null){
//        		page_sort_by = request.getParameter("sort_by");
//        		Declarations.page_sort_by=page_sort_by;
//        	}else if(request.getParameter("sort_by")==null){
//        		page_sort_by="title";
//        	}
//        	
//        	if(request.getParameter("sort_order")!=null){
//        		page_sort_order = request.getParameter("sort_order");
//        		Declarations.page_sort_order=page_sort_order;
//        	}else if(request.getParameter("sort_order")==null){
//        		page_sort_order="asc";
//        	}
//        	int per_page_count= Declarations.display_count1;
//        	Declarations.display_count1 = per_page_count;
//        	
//        try{
//        if(request.getParameter("display_count") != null)
//        	per_page_count = Integer.parseInt(request.getParameter("display_count"));
//            Declarations.display_count1 = per_page_count;
//        }
//        catch(NumberFormatException e){
//        /* 	e.printtrace(); */
//        }
//        out.println("Results Per page:" + "   " + per_page_count);
//        out.println("Results Sort By:" + "  " + page_sort_by);
//        out.println("Results Ordered By:  " + page_sort_order);
//        
        String val= request.getParameter("criteria_search");
        System.out.println("Search requested : " + val);
        
        
		if(val.equals("search")) response.sendRedirect("display_list.jsp?display_count=10");
		else if(val.equals("browse")) response.sendRedirect("browse_movies.jsp");
//        RequestDispatcher rd=request.getRequestDispatcher("display_list.jsp");  
//        rd.forward(request, response);
		
	}

}

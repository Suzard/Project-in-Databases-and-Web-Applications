

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

		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
		response.setContentType("text/html");  
        PrintWriter out=response.getWriter();  
         
        String val="";
        if(request.getParameter("criteria_search")!=null){  

         val= request.getParameter("criteria_search");
	}
        System.out.println("Search requested : " + val);
        
        
		if(val.equals("search")) response.sendRedirect("display_list.jsp?display_count=5&page_tmp=1");
		else if(val.equals("browse")) response.sendRedirect("browse_criteria.jsp");
		
	}

}

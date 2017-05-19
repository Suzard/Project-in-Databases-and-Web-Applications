

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

/**
 * Servlet implementation class criteria_search
 */
@WebServlet("/browse_criteria")
public class browse_criteria extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public browse_criteria() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");  
        PrintWriter out=response.getWriter();  
     
        String val= request.getParameter("criteria_search");

		if(val.equals("display_alphabetically")) response.sendRedirect("browse_movies_alphabetically.jsp");
		else if(val.equals("display_genres")) response.sendRedirect("browse_movies.jsp"); //for display genres
		else if(val.equals("employee_add")) response.sendRedirect("_dashboard.jsp"); //for adding employees
		else if(val.equals("star_add"))response.sendRedirect("new_star.jsp"); //for adding employees
		else if(val.equals("provide_metadata"))response.sendRedirect("provide_metadata.jsp"); //for displaying metadata
		else if(val.equals("movie_add"))response.sendRedirect("movie_add.jsp"); //for adding movies
		else if(val.equals("add_information"))response.sendRedirect("add_information.jsp"); //for adding movies

	}

}

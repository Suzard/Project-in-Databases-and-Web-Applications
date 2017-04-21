

import java.io.IOException;
import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.org.apache.bcel.internal.generic.Select;

import javax.servlet.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Scanner;
import java.sql.*;

/**
 * Servlet implementation class LoginInside
 */
@WebServlet("/LoginInside")
public class LoginInside extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginInside() {
        super();
        // TODO Auto-generated constructor stub
    }

	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String username_db = "root";
		String password_db = "aruna@10";
		Connection test_connection = null;
		ResultSet result_login;
		
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String url = "jdbc:mysql:///" + "moviedb" + "?autoReconnect=true&useSSL=false";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			test_connection = DriverManager.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false","root","aruna@10");
			if(test_connection==null) out.println("Connection not successfull");
			Statement select = test_connection.createStatement();

			String query_customer = "select * from customers where customers.email ='"
					+ email+ "'and customers.password='" + password+ "'";
			
			ResultSet result =  select.executeQuery(query_customer);
			
			if(result.next()) {
				//System.out.println("Connection Successful");
				String welcome_string = "Welcome\t" + result.getString(2) + "\t"+result.getString(3);
				out.println(welcome_string);
				
//				request.setAttribute("first_name",result.getString(2));
//				request.setAttribute("last_name", result.getString(3));
//				RequestDispatcher rd = request.getRequestDispatcher("criteria_search");
//				rd.forward(request,response);
				
				response.sendRedirect("criteria_search.jsp");
//				System.out.println("Welcome");
				
			}
			else System.out.println("Connection Unsuccessfull");
			
		}
		
		catch (Exception e){
			System.out.println(e.getMessage());
		}
//		try {
//			test_connection.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		out.close();
		
		
	}

}

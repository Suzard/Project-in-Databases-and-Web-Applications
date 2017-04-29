

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;

import package_test.Declarations;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import com.mysql.*;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
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
				PrintWriter out = response.getWriter();
				
				Connection test_connection = null;
				String email="",password="";
				try {
				Class.forName("com.mysql.jdbc.Driver");
				
					test_connection = (Connection) DriverManager
							.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
				
				if (test_connection == null){
					System.out.println("Not successful");
					out.println("Connection not successfull");}
				else {
					out.println("Connection Successfull");
				}
				if(request.getParameter("email")!=null){
				email = (String) request.getParameter("email");
				}
				
				if(request.getParameter("password")!=null){
				password = (String) request.getParameter("password");
				}
				
				Statement select_login = test_connection.createStatement();
				String query_login= "select * from customers where email='" + email + 
									"' and password ='" + password + "'" + "limit 1";
				System.out.println(query_login);
				ResultSet result_movies = select_login.executeQuery(query_login);
				
				while(result_movies.next())
				{
					System.out.println("Welcome " + result_movies.getString("email"));
				}
	}
				 catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
	}

}

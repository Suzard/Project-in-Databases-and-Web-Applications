

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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String username_db = "root";
		String password_db = "aruna@10";
		ResultSet result_login;
		
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
//		String url="jdbc:mysql://localhost:3306/moviedb,+"\""root+"\","aruna@10+"\"+";
		String url = "jdbc:mysql:///" + "moviedb" + "?autoReconnect=true&useSSL=false";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection test_connection = DriverManager.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false","root","aruna@10");
			if(test_connection==null) out.println("Connection not successfull");
//			else out.print("Connection successfull");
			Statement select = test_connection.createStatement();
//			String query_customer = "select * from customers where customers.email ='"
//					+ email+"' +and customers.password=" + 'password';
			String query_customer = "select * from customers where customers.email ='"
					+ email+ "'and customers.password='" + password+"'";
			System.out.println(query_customer);
			ResultSet result =  select.executeQuery(query_customer);
			if(result.next()) System.out.println("Connection Successful");
			else System.out.println("Connectin Unsuccesfull");
			
		}
		
		catch (Exception e){
			System.out.println(e.getMessage()+"hi");
		}
		out.print("HI");
		out.close();
		
		
	}

}

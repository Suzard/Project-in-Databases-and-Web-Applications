

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;

import package_test.*;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import com.mysql.*;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

/**
 * Servlet implementation class login
 */
@WebServlet("/employee_login")
public class employee_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public employee_login() {
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
				PrintWriter out = response.getWriter();
				ArrayList<Object> session_local_details = new ArrayList<Object>();
				Connection test_connection = null;
				String email="",password="";
				HttpSession session= request.getSession(false);
				if(session!=null && request.getAttribute("customer_id")!=null)
				{
					RequestDispatcher dispatcher = request.getRequestDispatcher("criteria_search");
					dispatcher.forward(request, response);
				}
				
				try {
				Class.forName("com.mysql.jdbc.Driver");
				
					test_connection = (Connection) DriverManager
							.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
				
				if (test_connection == null){
					System.out.println("Not successful");
					System.out.println("Connection not successfull");}
				else {
					System.out.println("Connection Successfull");
				}
				if(request.getParameter("email")!=null){
				email = (String) request.getParameter("email");
				}
				
				if(request.getParameter("password")!=null){
				password = (String) request.getParameter("password");
				}
				
				Statement select_login = test_connection.createStatement();
				String query_login= "select * from employees where email='" + email + 
									"' and password ='" + password + "'" + " limit 1";
				System.out.println(query_login);
				ResultSet result_movies = select_login.executeQuery(query_login);
				
				if(result_movies.next())
				{	
//					session_local_details.add(result_movies.getInt("id"));
//					session_local_details.add(result_movies.getString("first_name"));
//					session_local_details.add(result_movies.getString("last_name"));
//					session_local_details.add(result_movies.getString("address"));
					session_local_details.add(result_movies.getString("email"));
					session_local_details.add(result_movies.getString("password"));
//					if(request.getSession(false)!=null && request.getAttribute("id")!=null)
//					{
//						System.out.println("Session present");
//						RequestDispatcher dispatcher = request.getRequestDispatcher("criteria_search");
//						test_connection.close();
//						dispatcher.forward(request, response);
//					}else if(request.getSession(false)==null && request.getAttribute("id")==null){
						System.out.println("Session not present");
						session =  request.getSession(true);
						if(session!=null) System.out.println("Session Created on Login");
						session.setAttribute("customer_id",session_local_details);
						session.setAttribute("cart", new cart_main());
						if(!Declarations.session_active.containsKey(session))
							Declarations.session_active.put(session, session_local_details);
						if(!Declarations.cart.containsKey(session))
							Declarations.cart.put(session, new cart_main());
						String remoteAddr = request.getRemoteAddr();
				        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
				        reCaptcha.setPrivateKey("6LfBMyAUAAAAAHPqAlU6HzqTAdEGfB6axGC1BM9j");

				        String challenge = request.getParameter("recaptcha_challenge_field");
				        String uresponse = request.getParameter("recaptcha_response_field");
				        ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);

				        if (reCaptchaResponse.isValid()) {
				          //out.print("Answer was entered correctly!");
				        	RequestDispatcher dispatcher = request.getRequestDispatcher("employee_add.jsp");
							test_connection.close();
							dispatcher.forward(request, response);
				        } else {
				        	request.setAttribute("error_captcha", "Please enter the correct captcha.");
							RequestDispatcher dispatcher = request.getRequestDispatcher("employee_login.jsp");
							test_connection.close();
							dispatcher.forward(request,response);
							
				        }
						//RequestDispatcher dispatcher = request.getRequestDispatcher("criteria_search.jsp");
						//test_connection.close();
						//dispatcher.forward(request, response);
						//response.sendRedirect("criteria_search");
//					}
					//response.sendRedirect("criteria_search.jsp");
					//System.out.println("Welcome " + result_movies.getString("email"));
					
				}else{
//	
					
					
					request.setAttribute("error_message", "Please enter the correct credentials");
					RequestDispatcher dispatcher = request.getRequestDispatcher("employee_login.jsp");
					test_connection.close();
					dispatcher.forward(request,response);
//					out.println("Invalid credential. Please enter the correct username and password.");
//					response.sendRedirect("login.jsp");
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

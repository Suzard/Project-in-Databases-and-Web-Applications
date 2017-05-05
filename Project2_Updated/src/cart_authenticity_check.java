

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;

import package_test.Declarations;
import package_test.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

/**
 * Servlet implementation class cart_authenticity_check
 */
@WebServlet("/cart_authenticity_check")
public class cart_authenticity_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cart_authenticity_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		
		
		String first_name= request.getParameter("first_name");
		String last_name=request.getParameter("last_name");
		String email = request.getParameter("email");
	    String date =request.getParameter("date");
		String credit_card_number = request.getParameter("credit_card_number");
		int customer_id = 0;

		
		
		String query_authentication = "select * from creditcards where id='" + credit_card_number + "' "+
									  "and first_name='" + first_name + "' and last_name = '" + last_name + "' " +
				                      "and expiration = '" + date + "'" + " limit 1" ;
		System.out.println(query_authentication);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
				Connection test_connection = (Connection) DriverManager
						.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
			
				if (test_connection == null){
					System.out.println("Not successful");
					System.out.println("Connection not successfull");}
				else {
					System.out.println("Connection Successfull");
				}
				
				Statement select_auth_check = test_connection.createStatement();
				Statement select_get_id = test_connection.createStatement();
				ResultSet result_authentication = select_auth_check.executeQuery(query_authentication);
				ArrayList<Object> session_local_details = new ArrayList<Object>();
				
				HttpSession session = request.getSession(false);
				ArrayList<Object> list_customers =  (ArrayList<Object>) session.getAttribute("customer_id");
				System.out.println("The list is " + list_customers);
				
				if(result_authentication.next())
				{
					String query_id = "select * from customers where first_name='" + first_name + "' and last_name= '" + last_name +"'";
					System.out.println("query_id :" + query_id);
					ResultSet result_customer_id = select_get_id.executeQuery(query_id);
							if(result_customer_id.next()){
								customer_id = result_customer_id.getInt("id");
							}
					
					request.setAttribute("first_name", first_name);
					request.setAttribute("last_name", last_name);
					request.setAttribute("credit_card_id", credit_card_number);
					if(list_customers!=null){
					request.setAttribute("id", list_customers.get(0));
					request.setAttribute("home_address", list_customers.get(3));
					request.setAttribute("email", list_customers.get(3));
					}
					RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation-page_final.jsp");
					test_connection.close();
					dispatcher.forward(request, response);
							
							
//				out.println("Valid Customer");
				//out.println(list_customers.get(0));
						
				}else{
					out.println("Invalid Customer");
				}
		
	}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

}}

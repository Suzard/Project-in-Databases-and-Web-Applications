
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.OutputStreamWriter;

import package_test.Declarations;

/**
 * Servlet implementation class connection
 */
@WebServlet("/connection")
public class connection extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public connection() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = "", password = "", input_data;
		try{
		BufferedReader reader_buffer = new BufferedReader(new InputStreamReader(request.getInputStream()));
		StringBuilder string_builder = new StringBuilder();

		while ((input_data = reader_buffer.readLine()) != null) {
			string_builder.append(input_data);
		}

		String string_split[] = string_builder.toString().trim().split("\\s+");
		
		username = string_split[0];
		password = string_split[1];
		
		try {

			// Setting up database connection

			Connection test_connection = null;

			Class.forName("com.mysql.jdbc.Driver");

			test_connection = (Connection) DriverManager
					.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "root");

			if (test_connection == null)
				System.out.println("Database Connection Not successful");
			else
				System.out.println("Database Connection Successfull");

			// Fetching the user name and password from database
			String login_query = "Select * from customers where email = '" + username + "' and password = '" + password
					+ "'" + "limit 1;";
			Statement statement_login = test_connection.createStatement();
			ResultSet result_login = statement_login.executeQuery(login_query);
			if (result_login.next()) {
				username = result_login.getString("email");
				password = result_login.getString("password");

				// sending the data over the internet
				response.setStatus(HttpServletResponse.SC_OK);
				OutputStreamWriter writer_send = new OutputStreamWriter(response.getOutputStream());
				writer_send.write("true");
				writer_send.flush();
				writer_send.close();

			} else {
				response.setStatus(HttpServletResponse.SC_OK);
				OutputStreamWriter writer_send = new OutputStreamWriter(response.getOutputStream());
				writer_send.write("false");
				writer_send.flush();
				writer_send.close();

			}
		} catch (Exception e) {
			e.printStackTrace();
		}}catch(IOException e){
			try{
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print(e.getMessage());
            response.getWriter().close();
        }catch (IOException ioe) {
        	
        }
			}
	}
}

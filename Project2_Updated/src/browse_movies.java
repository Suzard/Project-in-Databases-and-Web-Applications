import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class browse_movies
 */
@WebServlet("/browse_movies")
public class browse_movies extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public browse_movies() {
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
//		doGet(request, response);
		try {
			PrintWriter out = response.getWriter();
			Class.forName("com.mysql.jdbc.Driver");
			String buttonClicked = request.getParameter("button_clicked");
			Connection test_connection = DriverManager
					.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");

			if (test_connection == null)
				System.out.println("Connection not successfull");
			else {
				Statement select = test_connection.createStatement();
				Statement select2 = test_connection.createStatement();
				Statement select3 = test_connection.createStatement();
				String query = "SELECT id from genres where name = " + "'" + buttonClicked +"'" ;

				out.println(buttonClicked +"\r\n" + System.getProperty("line.separator") );
    	        out.println(System.getProperty("line.separator"));   
				ResultSet result = select.executeQuery(query);
            	while(result.next()){
            		int genre_id = result.getInt(1);
            		String command_movie_id = "Select movies_id from genres_in_movies where genre_id = " +genre_id;
//            		String command_movie_details = "Select id FROM genres_in_movies" + 
//            		" where genre_id = " + movie_resulting;
            		ResultSet movie_id = select2.executeQuery(command_movie_id);
    
            		//out.println(movie_id);
            		while(movie_id.next()){
            			int movie_detail = movie_id.getInt(1);
            			String command_movie_details = "Select * from movies where id = " + movie_detail;
            			ResultSet movie_details = select3.executeQuery(command_movie_details);
                		//out.println(movie_id);
                		while(movie_details.next()){
                	        out.println(" Title = " + movie_details.getString(2) +System.getProperty("line.separator") );
////                	        out.println(System.getProperty("line.separator"));   
//                	        out.println(" Year = " + movie_details.getInt(3) + System.getProperty("line.separator"));
////                	        out.println("\r\n");   
//                	        out.println(" Director  = " + movie_details.getString(4));
////                	        out.println("\n");   
//                	        out.println(" Banner_url  = " + movie_details.getString(5));
//                	        out.println();   
//                	        out.println(" trailer_url  = " + movie_details.getString(6));
                	        out.println();   
                		}
                		

            		}
            		
            	}
				//get id from genres
				//"Select movies_id from genres_in_movies where genre_id =id"
//				while (result.next()) {
//					out.println(result.getString(2));
////					out.println(result.getString(3));
//				}

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}

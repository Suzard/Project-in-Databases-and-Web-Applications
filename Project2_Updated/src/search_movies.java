
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 * Servlet implementation class search_movies
 */
@WebServlet("/search_movies")
public class search_movies extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public search_movies() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String title = request.getParameter("title");
			String year = request.getParameter("year");
			String director = request.getParameter("director");
			String star_firstname = request.getParameter("star_firstname");
			String star_lastname = request.getParameter("star_lastname");
			PrintWriter out = response.getWriter();
			Connection test_connection = DriverManager
					.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", "root", "aruna@10");
			if (test_connection == null)
				out.println("Connection not successfull");
			else {
				Statement select = test_connection.createStatement();
				String query = "select stars.id,stars.first_name,stars.last_name,stars.dob,stars.photo_url,"
						+ "movies.title,movies.year,movies.director,movies.banner_url,movies.trailer_url "
						+ "from stars inner join movies on stars.id=movies.id" + " "
						+ "where ((stars.first_name like '%" + star_firstname.toLowerCase() + "%" + "' "
						+ "and stars.last_name like '%" + star_lastname.toLowerCase() + "%" + "' ) "
						// + "and (stars.first_name like '%" +
						// star_firstname.toLowerCase() + "%" +"' "
						// + "and stars.last_name like '%" +
						// star_lastname.toLowerCase() + "%" +"' ) "
						+ "and (movies.director like '%" + director.toLowerCase() + "%" + "') "
						+ "and (movies.title like '%" + title.toLowerCase() + "%" + "')" + ")";
				// + "or" + " "+ "(stars.first_name like '%" +
				// star_firstname.toLowerCase() +"')) or" + " "
				// + "( (movies.director like '" + director.toLowerCase() + "%"
				// +"')" + " "
				// + "or" + " " + "(movies.director like '%" +
				// director.toLowerCase() +"'))" + ")";
				System.out.println(query);
				ResultSet result = select.executeQuery(query);
//				while (result.next()) {
//					
//					out.print(result.getInt(1));
//					out.print("\t" + result.getString(2));
//					out.print("\t" + result.getString(3));
//					out.print("\t" + result.getDate(4));
//					out.print("\t" + result.getURL(5));
//					out.print("\t" + result.getString(6));
//					out.print("\t" + result.getInt(7));
//					out.print("\t" + result.getString(8));
//					out.print("\t" + result.getURL(9));
//					out.println("\t" + result.getURL(10));
//				}

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
//		response.sendRedirect("display_list.jsp");
		 RequestDispatcher rd=request.getRequestDispatcher("display_list.jsp");  
	        rd.forward(request, response);
	}

}

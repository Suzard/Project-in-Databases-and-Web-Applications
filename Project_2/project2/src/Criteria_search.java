

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class browse
 */
@WebServlet("/criteria_search")
public class Criteria_search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Criteria_search() {
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
		doGet(request, response);
		PrintWriter out = response.getWriter();
		
		String first_name = (String)request.getAttribute("first_name");
		String last_name = (String)request.getAttribute("last_name");
		String welcome_string = "Welcome\t" + first_name + "\t"+last_name;
		out.println(welcome_string);
		
//		HttpSession session = request.getSession();
//		String str= session.getAttribute("first_name").toString();
//		System.out.println(str);
//		out.println(str);
		
		String val= request.getParameter("criteria_Search").toString();
		if(val.equals("search")) response.sendRedirect("search_movies.jsp");
		else if(val.equals("browse")) response.sendRedirect("browse_movies");
	}

}

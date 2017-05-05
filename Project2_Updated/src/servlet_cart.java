

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.javafx.collections.MappingChange.Map;

import package_test.Declarations;
import package_test.cart_main;

/**
 * Servlet implementation class servlet_cart
 */
@WebServlet("/servlet_cart")
public class servlet_cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servlet_cart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.getWriter().append("Served at: ").append(request.getContextPath());

		doPost(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		PrintWriter out = response.getWriter();
		Integer quantity=0,movie_id = 1,check=0;
		String movie_name="";
		
		if(request.getParameter("cart_movie_id")!=null)
			movie_id = Integer.parseInt(request.getParameter("cart_movie_id"));
		
		 if(request.getParameter("movie_name")!=null)
			 movie_name = request.getParameter("movie_name");
		if(request.getParameter("quantity")!=null){
		quantity = Integer.parseInt(request.getParameter("quantity"));
		}
		
		if(request.getParameter("check")!=null){
			check=Integer.parseInt(request.getParameter("check"));
		}
		HttpSession session = request.getSession();
		if(session!=null) System.out.println("Session Present on Servlet Cart");
		cart_main cart = (cart_main) session.getAttribute("cart");
//		System.out.println("Movie ID :" + movie_id + "quantity : " + quantity + "check : " + check + "movie_name : " + movie_name);
		cart.update(movie_id, quantity, check,movie_name);
		
		session.setAttribute("cart", cart);
		
		
		if(movie_id!=null && !cart.contains_key(movie_id)){
			
		}
		
		HashMap<Integer, ArrayList<Object>> cart1 = cart.map_get();
		for (Entry<Integer, ArrayList<Object>> entry : cart1.entrySet()) {
		    System.out.println(entry.getKey()+" : "+entry.getValue());
		}
		
//		if(check==1)
//		{
//			RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation_page.jsp");
//			dispatcher.forward(request,response);
//		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("display_list.jsp");
		dispatcher.forward(request,response);

		System.out.println(movie_id);
		}
		
		
	}



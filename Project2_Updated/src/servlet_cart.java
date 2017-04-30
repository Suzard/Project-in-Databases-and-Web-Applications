

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.javafx.collections.MappingChange.Map;

import package_test.Declarations;

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
		out.println("went inside doGet");
		doPost(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		PrintWriter out = response.getWriter();
		out.print("Went inside doPost");
		Integer quantity=0;
		Integer movie_id = Integer.parseInt(request.getParameter("cart_movie_id"));
		out.println(movie_id);
		if(request.getParameter("quantity")!=null){
		quantity = Integer.parseInt(request.getParameter("quantity"));
		}

		if(request.getParameter("cart_movie_id")!=null){

		if(Declarations.cart.containsKey(movie_id)){
		int cart_available_quantity =  (int) Declarations.cart.get(movie_id);
		Declarations.cart.put(movie_id, cart_available_quantity+quantity);
		}else{
			Declarations.cart.put(movie_id, quantity);
		}
		for (Entry<Integer, Integer> entry : Declarations.cart.entrySet()) {
		    System.out.println(entry.getKey()+" : "+entry.getValue());
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("display_list.jsp");
		dispatcher.forward(request,response);

		System.out.println(movie_id);
		}
		
		
	}

}

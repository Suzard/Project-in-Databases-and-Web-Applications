
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class connection
 */
@WebServlet("/connection")
public class connection extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
    public connection() {
        super();
 
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        response.getOutputStream().println("Hurray !! This Servlet Works");
 
    }
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
            //int length = request.getContentLength();
            //byte[] input = new byte[length];
            ServletInputStream sin = request.getInputStream();
            //int c, count = 0 ;
            String line;
            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String user_name="", pass_word="";
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            sin.close();
            String[] sb_opt = sb.toString().trim().split("\\s+");
            
            user_name = sb_opt[0];
            pass_word  = sb_opt[1];
            
            //String recievedString = new String(input);
            response.setStatus(HttpServletResponse.SC_OK);
            OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream());
 
            //Integer doubledValue = Integer.parseInt(recievedString) * 2;
            if(user_name.equals("a@email.com"))
            writer.write("true");
            else writer.write("false");
            writer.flush();
            writer.close();
 
 
 
        } catch (IOException e) {
 
 
            try{
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print(e.getMessage());
                response.getWriter().close();
            } catch (IOException ioe) {
            }
        }   
        }
 
}
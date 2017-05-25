import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
 
@WebServlet("/DoubleMeServlet")
public class DoubleMeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public DoubleMeServlet() {
        super();
 
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        response.getOutputStream().println("Hurray !! This Servlet Works");
 
    }
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        try {
            int length = request.getContentLength();
            byte[] input = new byte[length];
             BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
             StringBuilder sb = new StringBuilder();
             String line;
             while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            //int c, count = 0 ;
            
            /*while ((c = sin.read(input, count, input.length-count)) != -1) {
                count +=c;
            }*/
            System.out.println(sb.toString());
            String str[] = sb.toString().trim().split("\\s+");
//            
            
            String uname = str[0];
            String pwd = str[1];

            try {

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "root");

                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery(
                        "select * from customers where email='" + uname + "' and password='" + pwd + "'limit 1;");
                if (rs.next()) {
                  

                                    // session.setMaxInactiveInterval(60 * 60 * 24 * 30);

                    // String str=(String) session.getAttribute("customer");
                    // System.out.println("str");

                        response.setStatus(HttpServletResponse.SC_OK);
                        OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream());
                        System.out.println("true");
                        writer.write("true");
                        writer.flush();
                        writer.close();

                } else {
                        response.setStatus(HttpServletResponse.SC_OK);
                        System.out.println("false");

                        OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream());
                        writer.write("false");
                        writer.flush();
                        writer.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }      
 
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
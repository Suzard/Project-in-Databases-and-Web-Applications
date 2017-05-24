

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
import com.mysql.jdbc.PreparedStatement; 
 
@WebServlet("/DoubleMeServlet2")
public class DoubleMeServlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public DoubleMeServlet2() {
        super();
 
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        response.getOutputStream().println("Hurray !! This Servlet2 Works");
 
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
//            
            
            String movie = sb.toString();

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "root");
                Statement stmt = con.createStatement();                
                String[] tokens = movie.split("\\s+");
               /*StringBuilder str = new StringBuilder(
                                      "SELECT id, title FROM movies WHERE MATCH(title) AGAINST ('");
                for (int i = 0; i < tokens.length; i++) {
                           if (i + 1 < tokens.length) {
                                      str.append("+").append(tokens[i]).append(" ");
                           } else {
                                      str.append("+").append(tokens[i]).append("*");
                           }
                }
                str.append("' IN BOOLEAN MODE) LIMIT 10");
                PreparedStatement statement = (PreparedStatement) con.prepareStatement(str.toString());
                ResultSet rs2 = statement.executeQuery();
                    /*String query="select distinct * from movies where match (title) against(\'";

                for(int i=0;i<tokens.length;i++)
                {
                    query+="+"+tokens[i]+" ";
                    if(i==tokens.length-1)
                        query+="+"+tokens[i]+"*";
                }
                
                ResultSet rs2=stmt.executeQuery(query+"+\' in boolean mode);");*/
                //ResultSet rs2 = stmt.executeQuery("select title from movies where title like '"+movie+"%';");
                String query="select distinct * from movies where match (title) against(\'"; 
                for(int i=0;i<tokens.length;i++)
                    {
                        if(i==tokens.length-1 && tokens.length>=1)
                        query+="+"+tokens[i]+"* ";
                    else
                        query+="+"+tokens[i]+" ";
                    }
                   
                    ResultSet rs2=stmt.executeQuery(query+"+\' in boolean mode) limit 10;");
                    System.out.println(query);            
                if (rs2.next()) {                   
                    String str22="";
                    while(rs2.next())
                    {
                        str22=str22+rs2.getString(2)+".";
                    }

                        response.setStatus(HttpServletResponse.SC_OK);
                        OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream());
                        System.out.println("true");
                        writer.write(str22);
                        writer.flush();
                        writer.close();

                } else {
                        response.setStatus(HttpServletResponse.SC_OK);
                        System.out.println("false");
                        OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream());
                        writer.write("");
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
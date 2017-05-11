package data_files;
import java.awt.List;
import java.io.File;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeSet;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.sql.Date;
public class parser {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Reference :
		// https://www.tutorialspoint.com/java_xml/java_dom_parse_document.htm
		Map<String, Object> map_stars = new LinkedHashMap<String, Object>();
		Map<Integer, Object> map_genres = new LinkedHashMap<Integer, Object>();
		TreeSet<String> set = new TreeSet<String>();
		
			try {
				Class.forName("com.mysql.jdbc.Driver");
				
					Connection test_connection = (Connection) DriverManager
							.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
				
				if (test_connection == null){
					System.out.println("Connection not successfull");}
				else {
					System.out.println("Connection Successfull");
				}
				
			String query_stars = "select * from stars";
			String query_genres = "select * from genres_in_movies inner join genres on genres.id = genres_in_movies.genre_id";
			
			Statement select_stars = (Statement) test_connection.createStatement();
			Statement select_genres = (Statement) test_connection.createStatement();
			
			ResultSet result_stars = select_stars.executeQuery(query_stars);
			ResultSet result_genres = select_genres.executeQuery(query_genres);
			
			while(result_stars.next()){
				String first_name1="", last_name1="";
				int dob1=2001;
				ArrayList<Object> list1 = new ArrayList<Object>();
				if(result_stars.getString("first_name")!=null)
				first_name1 = result_stars.getString("first_name").toString();
				last_name1  = result_stars.getString("last_name").toString();
				dob1 = result_stars.getInt("dob");
				list1.add(first_name1 + "," + last_name1);
				map_stars.put(first_name1 + " " + last_name1 + " " + dob1 , list1);
			}
			
			while(result_genres.next()){
				Integer genre_id = (Integer) result_genres.getInt("genre_id");
				Integer movies_id = (Integer) result_genres.getInt("movies_id");
				String genre_name = result_genres.getString("name");
				
				//System.out.println("genre_id :" + genre_id);
				//System.out.println("movies_id :" + movies_id);
				//System.out.print("genre_name : " + genre_name);
				if(map_genres.containsKey(movies_id)){
					ArrayList<Object> list_genres = new ArrayList<Object>();
					list_genres = (ArrayList<Object>) map_genres.get(movies_id);
					list_genres.add(genre_name);
					map_genres.put(movies_id, list_genres);
					//System.out.println("List :"+list_genres);
				}else{
					ArrayList<Object> list_genres = new ArrayList<Object>();
					list_genres.add(genre_name);
					map_genres.put(movies_id, list_genres);
					//System.out.println("List :"+list_genres);
				}
				
				
				
			}
			File inputFile_stars = new File("src/data_files/actors63.xml");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			String path = "actors63.xml";


			
			

			Document document = builder.parse(inputFile_stars);
			document.normalize();
			NodeList list_actors = document.getElementsByTagName("actors");
			Node node_actors = list_actors.item(0);
			Element element_actors = (Element) node_actors;
			NodeList list_actor = element_actors.getElementsByTagName("actor");
			System.out.println("Length :" + list_actor.getLength());
			for (int i = 0; i < list_actor.getLength(); i++) {
				
				String firstname="", lastname="",dob="";
				Node node_actor = list_actor.item(i);
				Element element_actor = (Element) node_actor;
				//System.out.println("\nCurrent Element :" + element_actors.getNodeName());
				Node node_actor_firstname = element_actor.getElementsByTagName("firstname").item(0);
				Node node_actor_lastname  = element_actor.getElementsByTagName("familyname").item(0);
				Node node_actor_dob                  = element_actor.getElementsByTagName("dob").item(0);
				
				try{
				Element element_actor_firstname = (Element) node_actor_firstname;
				firstname=element_actor_firstname.getTextContent().trim();
				if(firstname==null) firstname="";
				//System.out.println("First Name : " +firstname);//+ element_child.getElementsByTagName("firstname").item(0).getTextContent());
				}catch(Exception e){
					e.printStackTrace();
					continue;
				}
				
				try{
				Element element_actor_lastname = (Element) node_actor_lastname;
				lastname=element_actor_lastname.getTextContent().trim();
				if(lastname==null) lastname="";
				//System.out.println("Last Name : " + lastname);//element_child.getElementsByTagName("familyname").item(0).getTextContent());
				}catch(Exception e){
					e.printStackTrace();
					continue;
				}
				
				try{
				Element element_actor_dob = (Element) node_actor_dob;
				dob=element_actor_dob.getTextContent().trim();
			
				if(dob=="") dob="2001";
					
				if(!dob.matches("-?\\d+")) {dob="2001"; }//System.out.println("not matches");}
					//System.out.println("DOB : " + dob);//element_child.getElementsByTagName("dob").item(0).getTextContent());
				}catch(Exception e){
					e.printStackTrace();

					continue;
					
				}
				PreparedStatement star_insert = null;
				star_insert = test_connection.prepareStatement("insert into stars(first_name,last_name,dob) values(?,?,?);");
				if(!map_stars.containsKey(firstname + " " + lastname + " " + dob)){
					star_insert.setString(1, firstname);
					star_insert.setString(2, lastname);
//					DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//					Date myDate = formatter.parse(dob+"-01-01"));
//					java.sql.Date sqlDate = new java.sql.Date(myDate.getTime());
					star_insert.setDate(3, java.sql.Date.valueOf(dob+"-01-01"));
					star_insert.execute();
					map_stars.put(firstname+ " " + lastname + " " + dob, firstname +","+lastname+","+dob);
				}
				
			}
			
//			Iterator<String> it= set.iterator();
//			
//			while(it.hasNext()){
//				int i=1;
//				String  combined_stars = it.next();
//				 for (String star_details: combined_stars.split(",")) {
//					 
//					 System.out.println(i + "." + "Star Details : " +star_details);
//					 ++i;	
//			      }
//				 
//				}
			Iterator <Map.Entry<Integer, Object>> it = map_genres.entrySet().iterator();
//			while(it.hasNext()){
//				Map.Entry<Integer, Object> pair = it.next();
//				System.out.println("Key" + pair.getKey());
//				System.out.println("Value" + pair.getValue());
//			}
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

package data_files;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.mysql.jdbc.Connection;

import org.w3c.dom.Node;
import org.w3c.dom.Element;

import data_files.*;
public class parser {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Reference :
		// https://www.tutorialspoint.com/java_xml/java_dom_parse_document.htm
		
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				
					Connection test_connection = (Connection) DriverManager
							.getConnection("jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username, Declarations.password);
				
				if (test_connection == null){
					System.out.println("Connection not successfull");}
				else {
					System.out.println("Connection Successfull");
				}
			File inputFile_stars = new File("src/data_files/actors63.xml");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			String path = "actors63.xml";


			
			
			System.out.println("Hi 1");
			Document document = builder.parse(inputFile_stars);
			System.out.println("Hi 2");
			document.normalize();
			NodeList list_actors = document.getElementsByTagName("actors");
			System.out.println("Hi 3");
			Node node_actors = list_actors.item(0);
			System.out.println("Hi 4");
			Element element_actors = (Element) node_actors;
			System.out.println("Hi 5");
			NodeList list_actor = element_actors.getElementsByTagName("actor");
			System.out.println("Length :" + list_actor.getLength());
			for (int i = 0; i < 1300; i++) {
				
				String firstname="", lastname="",dob="";
				Node node_actor = list_actor.item(i);
				Element element_actor = (Element) node_actor;
				System.out.println("\nCurrent Element :" + element_actors.getNodeName());
				Node node_actor_firstname = element_actor.getElementsByTagName("firstname").item(0);
				Node node_actor_lastname  = element_actor.getElementsByTagName("familyname").item(0);
				Node node_actor_dob                  = element_actor.getElementsByTagName("dob").item(0);
				Element element_actor_firstname = (Element) node_actor_firstname;
				firstname=element_actor_firstname.getTextContent();
				
				try{
				if(firstname==null) firstname="";
				System.out.println("First Name : " +firstname);//+ element_child.getElementsByTagName("firstname").item(0).getTextContent());
				}catch(Exception e){
					e.printStackTrace();
					continue;
				}
				
				try{
				Element element_actor_lastname = (Element) node_actor_lastname;
				lastname=element_actor_lastname.getTextContent();
				if(lastname==null) lastname="";
				System.out.println("Last Name : " + lastname);//element_child.getElementsByTagName("familyname").item(0).getTextContent());
				}catch(Exception e){
					e.printStackTrace();
					continue;
				}
				
				try{
				Element element_actor_dob = (Element) node_actor_dob;
				dob=element_actor_dob.getTextContent();
				if(dob==null) dob="";
					
					System.out.println("DOB : " + dob);//element_child.getElementsByTagName("dob").item(0).getTextContent());
				}catch(Exception e){
					e.printStackTrace();
//					dob="";
//					System.out.println("DOB : " + dob);
					continue;
					
				}
			}

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

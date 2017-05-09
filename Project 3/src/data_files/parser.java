package data_files;
import java.io.File;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

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
			File inputFile_stars = new File(
					"src/data_files/actors63.xml");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			String path = "actors63.xml";


			
			
			
			Document document = builder.parse(inputFile_stars);
			//document.getDocumentElement().normalize();
			NodeList list_children_stars = document.getElementsByTagName("actor");

			for (int i = 0; i < list_children_stars.getLength(); i++) {
				Node node_child = list_children_stars.item(i);
				System.out.println("\nCurrent Element :" + node_child.getNodeName());
				Element element_child = (Element) node_child;
				String first_name="",last_name="", dob="";
				first_name = element_child.getElementsByTagName("firstname").item(0).getTextContent();
				last_name=element_child.getElementsByTagName("lastname").item(0).getTextContent();
				dob=element_child.getElementsByTagName("dob").item(0).getTextContent();
				
					
					System.out.println("First Name : " +first_name);//+ element_child.getElementsByTagName("firstname").item(0).getTextContent());
					System.out.println("Last Name : " + last_name);//element_child.getElementsByTagName("familyname").item(0).getTextContent());
					System.out.println("DOB : " + dob);//element_child.getElementsByTagName("dob").item(0).getTextContent());

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

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
		Map<String, Object> map_genres = new LinkedHashMap<String, Object>();
		Map<String, Object> map_cat = new LinkedHashMap<String, Object>();
		Map<String, Object> map_movies = new LinkedHashMap<String, Object>();
		Map<String, Integer> map_genres_list = new LinkedHashMap<String, Integer>();

		Integer max_genre_id = 0, max_movie_id = 0;

		TreeSet<String> set = new TreeSet<String>();

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection test_connection = (Connection) DriverManager.getConnection(
					"jdbc:mysql:///moviedb?autoReconnect=true&useSSL=false", Declarations.username,
					Declarations.password);

			if (test_connection == null) {
				System.out.println("Connection not successfull");
			} else {
				System.out.println("Connection Successfull");
			}

			test_connection.setAutoCommit(false);

			String query_stars = "select * from stars order by id";
			String query_genres = "select * from genres_in_movies inner join genres on genres.id = genres_in_movies.genre_id inner join movies on genres_in_movies.movies_id = movies.id order by genres.id";
			String query_movies = "select * from movies order by id";
			String query_max_genre_id = "select max(id) from genres";
			String query_max_movie_id = "Select max(id) from movies";
			String query_genres_list = "select * from genres";

			Statement select_stars = (Statement) test_connection.createStatement();
			Statement select_genres = (Statement) test_connection.createStatement();
			Statement select_movies = (Statement) test_connection.createStatement();
			Statement select_genres_list = (Statement) test_connection.createStatement();

			ResultSet result_stars = select_stars.executeQuery(query_stars);
			ResultSet result_genres = select_genres.executeQuery(query_genres);
			ResultSet result_movies = select_movies.executeQuery(query_movies);
			ResultSet result_genres_list = select_genres_list.executeQuery(query_genres_list);

			PreparedStatement select_max_id_genres = null, select_max_id_movies = null;
			select_max_id_genres = test_connection.prepareStatement("select max(id) from genres");
			select_max_id_movies = test_connection.prepareStatement("select max(id) from movies");

			ResultSet result_max_genres = select_max_id_genres.executeQuery();
			ResultSet result_max_movies = select_max_id_movies.executeQuery();

			if (result_max_genres.next()) {
				max_genre_id = result_max_genres.getInt(1);
			}
			result_max_genres.close();

			if (result_max_movies.next()) {
				max_movie_id = result_max_movies.getInt(1);
			}
			result_max_movies.close();

			while (result_genres_list.next()) {
				String genres_name = result_genres_list.getString("name");
				Integer genres_id = result_genres_list.getInt("id");
				map_genres_list.put(genres_name, genres_id);
			}

			while (result_stars.next()) {
				String first_name1 = "", last_name1 = "";
				int dob1 = 2001;
				ArrayList<Object> list1 = new ArrayList<Object>();
				if (result_stars.getString("first_name") != null)
					first_name1 = result_stars.getString("first_name").toString();
				last_name1 = result_stars.getString("last_name").toString();
				dob1 = result_stars.getInt("dob");
				list1.add(first_name1 + "," + last_name1);
				map_stars.put(first_name1 + " " + last_name1 + " " + dob1, list1);
			}

			while (result_genres.next()) {
				Integer genre_id = (Integer) result_genres.getInt("genre_id");
				Integer movies_id = (Integer) result_genres.getInt("movies_id");
				String genre_name = result_genres.getString("name");
				String movie_name = result_genres.getString("title");

				// System.out.println("genre_id :" + genre_id);
				// System.out.println("movies_id :" + movies_id);
				// System.out.print("genre_name : " + genre_name);
				if (map_genres.containsKey(movie_name)) {
					ArrayList<Object> list_genres = new ArrayList<Object>();
					list_genres = (ArrayList<Object>) map_genres.get(movie_name);
					list_genres.add(genre_name);
					map_genres.put(movie_name, list_genres);
					// System.out.println("List :"+list_genres);
				} else {
					ArrayList<Object> list_genres = new ArrayList<Object>();
					list_genres.add(genre_name);
					map_genres.put(movie_name, list_genres);
					// System.out.println("List :"+list_genres);
				}
			}

			while (result_movies.next()) {
				String title = result_movies.getString("title");
				Integer year = result_movies.getInt("year");
				String director = result_movies.getString("year");

				if (!map_movies.containsKey(title + " " + year + " " + director)) {
					ArrayList<Object> list_movies = new ArrayList<Object>();
					list_movies.add(title);
					list_movies.add(year);
					list_movies.add(director);
					map_movies.put(title + " " + year + " " + director, list_movies);
				}

			}
			File inputFile_stars = new File("src/data_files/actors63.xml");
			File inputFile_mains = new File("src/data_files/mains243.xml");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();

			// Adding mains to the database
			String mains_moviename = null, mains_year_string, mains_director_name = null, mains_directorname = null;
			PreparedStatement main_insert_movies = null, main_insert_genres = null;
			main_insert_movies = test_connection
					.prepareStatement("insert into movies(title,year,director) values(?,?,?);");
			main_insert_genres = test_connection.prepareStatement("insert into genres(id, name) values(?,?)");
			Integer mains_year_integer = 0;
			Document document_mains = builder.parse(inputFile_mains);
			document_mains.normalize();
			NodeList list_mains_movies = document_mains.getElementsByTagName("movies");
			if (list_mains_movies != null && list_mains_movies.getLength() > 0) {
				// for(int i=0;i<list_mains_movies.getLength();i++){
				Element element_mains_movies = (Element) list_mains_movies.item(0);
				NodeList list_mains_directorfilms = (NodeList) element_mains_movies
						.getElementsByTagName("directorfilms");
				if (list_mains_directorfilms.getLength() > 0 && list_mains_directorfilms != null) {
					for (int i = 0; i < list_mains_directorfilms.getLength(); i++) {
						Element element_mains_directorfilms = (Element) list_mains_directorfilms.item(i);
						String mains_directorid = element_mains_directorfilms.getElementsByTagName("dirid").item(0)
								.getTextContent().trim();
						NodeList list_mains_film = element_mains_directorfilms.getElementsByTagName("film");
						if (list_mains_film != null || list_mains_film.getLength() > 0) {
							for (int j = 0; j < list_mains_film.getLength(); j++) {
								Element element_mains_film = (Element) list_mains_film.item(j);

								// Movies ID
								try {
									Integer length = mains_directorid.length();
									String dummy_main_movieid = element_mains_film.getElementsByTagName("fid").item(0)
											.getTextContent().trim();
									String main_movieid = dummy_main_movieid.substring(length,
											dummy_main_movieid.length());
									System.out.println("Main Movie Id" + main_movieid);
								} catch (Exception e) {

								}
								// Fetching movie name
								try {

									mains_moviename = element_mains_film.getElementsByTagName("t").item(0)
											.getTextContent().trim();
								} catch (Exception e) {
									System.out.println("Exception in fetching movie name" + mains_moviename);
									e.printStackTrace();
								}

								// Printing Movie Name
								System.out.println("Movie Name : " + mains_moviename);

								// Fetching movie year
								try {
									if (mains_moviename == null)
										mains_moviename = "";
									mains_year_string = element_mains_film.getElementsByTagName("year").item(0)
											.getTextContent().trim();
									if (mains_year_string != null)
										mains_year_integer = Integer.parseInt(mains_year_string);
								} catch (Exception e) {
									mains_year_integer = 2001;
								}

								// Printing Movie year
								System.out.println("Movie Year : ");
								System.out.println(mains_year_integer);

								// Fetching Director Name
								try {
									NodeList list_mains_dirs = element_mains_film.getElementsByTagName("dirs");
									Element element_main_dirs = (Element) list_mains_dirs.item(0);

									NodeList list_mains_dirn = element_main_dirs.getElementsByTagName("dirn");
									Element element_mains_dirn = (Element) list_mains_dirn.item(0);

									mains_directorname = element_mains_dirn.getTextContent().trim();
								} catch (Exception e) {
									System.out.println("Exception in Director name" + mains_director_name);
									mains_directorname = "Anonymous";
								}

								// Printing Director Name
								System.out.println("Director Name : " + mains_directorname);
//								NodeList catList = element_mains_film.getElementsByTagName("cats");
//								if (catList.getLength() > 0 && catList != null) {
//									org.w3c.dom.Element category = (org.w3c.dom.Element) catList.item(0);
//									NodeList cat1 = category.getElementsByTagName("cat");
//									if (cat1 != null) {
//										for (int m = 0; m < cat1.getLength(); m++) {
//											NodeList subList = cat1.item(m).getChildNodes();
//											if (subList.getLength() > 0 && subList != null) {
//												String genre = subList.item(0).getNodeValue();
//												if (genre != null)
//											System.out.println("Genre: " + genre);		
//											}}}}
								NodeList list_mains_cats = element_mains_film.getElementsByTagName("cats");
								Element element_mains_cats = (Element) list_mains_cats.item(0);

								NodeList list_mains_cat = element_mains_cats.getElementsByTagName("cat");
								ArrayList<Object> local_mains_genres = new ArrayList<Object>();
								// (ArrayList<Object>)
								// map_genres.get(mains_moviename);
								System.out.println("Length : " + list_mains_cat.getLength());
								for (int a = 0; a < list_mains_cat.getLength(); a++) {
									String out_genre_name = list_mains_cat.item(a).getChildNodes().item(0)
											.getNodeValue();
									// if((map_genres.get(mains_moviename)==null)
									// ||
									// (!local_mains_genres.contains(list_mains_cat.item(k)))){
									// local_mains_genres.add(list_mains_cat.item(k).getTextContent().trim());
									// map_genres.put(mains_moviename,
									// local_mains_genres);
									// System.out.println("Local genres" +
									// local_mains_genres);
									// }
									// if(!map_genres_list.containsKey(list_mains_cat.item(k).getTextContent().trim())){
									// ++max_genre_id;
									// map_genres_list.put(list_mains_cat.item(k).getTextContent().trim(),
									// max_genre_id);
									// main_insert_genres.setInt(1,
									// max_genre_id);
									// main_insert_genres.setString(2,list_mains_cat.item(k).getTextContent().trim());
									// main_insert_genres.execute();
									// }
								}
								// Element element_mains_cat = (Element)
								// list_mains_cat.
								//
								if (!map_movies.containsKey(
										mains_moviename + " " + mains_year_integer + " " + mains_directorname)) {
									main_insert_movies.setString(1, mains_moviename);
									main_insert_movies.setInt(2, mains_year_integer);
									main_insert_movies.setString(3, mains_directorname);
									main_insert_movies.execute();
								}
							}
						}
					}
				}
			}

			// Adding actors to the database
			Document document = builder.parse(inputFile_stars);
			PreparedStatement star_insert = null;
			document.normalize();
			NodeList list_actors = document.getElementsByTagName("actors");
			Node node_actors = list_actors.item(0);
			Element element_actors = (Element) node_actors;
			NodeList list_actor = element_actors.getElementsByTagName("actor");
			System.out.println("Length :" + list_actor.getLength());
			for (int i = 0; i < list_actor.getLength(); i++) {

				String firstname = "", lastname = "", dob = "";
				Node node_actor = list_actor.item(i);
				Element element_actor = (Element) node_actor;
				// System.out.println("\nCurrent Element :" +
				// element_actors.getNodeName());
				Node node_actor_firstname = element_actor.getElementsByTagName("firstname").item(0);
				Node node_actor_lastname = element_actor.getElementsByTagName("familyname").item(0);
				Node node_actor_dob = element_actor.getElementsByTagName("dob").item(0);

				try {
					Element element_actor_firstname = (Element) node_actor_firstname;
					firstname = element_actor_firstname.getTextContent().trim();
					if (firstname == null)
						firstname = "";
					// System.out.println("First Name : " +firstname);//+
					// element_child.getElementsByTagName("firstname").item(0).getTextContent());
				} catch (Exception e) {
					System.out.println("Error in First Name" + firstname);
					e.printStackTrace();
					continue;
				}

				try {
					Element element_actor_lastname = (Element) node_actor_lastname;
					lastname = element_actor_lastname.getTextContent();
					if (lastname == null || lastname == "")
						lastname = "";
					else
						lastname = lastname.trim();
					// System.out.println("Last Name : " +
					// lastname);//element_child.getElementsByTagName("familyname").item(0).getTextContent());
				} catch (Exception e) {
					System.out.println("Error in Last Name:" + lastname);
					lastname = "";
					e.printStackTrace();
					continue;
				}

				try {
					Element element_actor_dob = (Element) node_actor_dob;
					if (element_actor_dob.getTextContent() != null) {
						dob = element_actor_dob.getTextContent();

						if (dob.equals("") || dob == null)
							dob = "2001";

						if (!dob.matches("-?\\d+")) {
							dob = "2001";
						} // System.out.println("not matches");}
						else
							dob = dob.trim();
					} else
						dob = "2001";
					// System.out.println("DOB : " +
					// dob);//element_child.getElementsByTagName("dob").item(0).getTextContent());
				} catch (Exception e) {
					System.out.println("error in dob :" + dob);
					dob = "2001";
					e.printStackTrace();

					continue;

				}

				star_insert = test_connection
						.prepareStatement("insert into stars(first_name,last_name,dob) values(?,?,?)");
				if (!map_stars.containsKey(firstname + " " + lastname + " " + dob)) {
					star_insert.setString(1, firstname);
					star_insert.setString(2, lastname);
					star_insert.setDate(3, java.sql.Date.valueOf(dob + "-01-01"));
					star_insert.addBatch();
					map_stars.put(firstname + " " + lastname + " " + dob, firstname + "," + lastname + "," + dob);
				}

			}

			star_insert.executeBatch();
			test_connection.commit();
			star_insert.close();
			Iterator<Map.Entry<String, Object>> it = map_genres.entrySet().iterator();
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

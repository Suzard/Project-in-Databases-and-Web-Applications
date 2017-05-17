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
import java.util.Map.Entry;
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

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Reference :
		// https://www.tutorialspoint.com/java_xml/java_dom_parse_document.html

		// map for (firstname+lastname+dob, firstname+lastname)
		Map<String, Object> map_stars = new LinkedHashMap<String, Object>();
		Map<String, Object> map_genres = new LinkedHashMap<String, Object>();
		Map<String, Object> map_cat = new LinkedHashMap<String, Object>();
		// map for (title+year+director, list of (title+year+director))
		Map<String, Object> map_movies = new LinkedHashMap<String, Object>();
		Map<String, Integer> map_genres_list = new LinkedHashMap<String, Integer>();

		// map for (moviename,movieid)
		Map<String, Integer> map_movie_id = new LinkedHashMap<String, Integer>();
		// map for (filmid,movieid)
		Map<String, Integer> map_film_movie_id = new LinkedHashMap<String, Integer>();
		// map for (stagename, starid)
		Map<String, Integer> map_stage_starid = new LinkedHashMap<String, Integer>();
		// map for (stagename+starid,starid)
		Map<String, Integer> map_stage_plus_starid = new LinkedHashMap<String, Integer>();
		// map for (movies_id,genres_id)
		Map<Integer, Object> map_movies_genres = new LinkedHashMap<Integer, Object>();
		Integer max_genre_id = 0, max_movie_id = 0, check = 0, database_movie_id = 0;

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

			// test_connection.setAutoCommit(false);

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

			while (result_genres_list.next()) {
				String genres_name = result_genres_list.getString("name");
				Integer genres_id = result_genres_list.getInt("id");
				map_genres_list.put(genres_name, genres_id);
			}

			while (result_stars.next()) {
				String first_name1 = "", last_name1 = "";
				String dob1 = "2001";
				ArrayList<Object> list1 = new ArrayList<Object>();
				Integer tmp_star_id1 = result_stars.getInt("id");
				if (result_stars.getString("first_name") != null)
					first_name1 = result_stars.getString("first_name").toString();
				
				last_name1 = result_stars.getString("last_name").toString();
				
				dob1 = result_stars.getString("dob");
				list1.add(first_name1);
				list1.add(last_name1);
				list1.add(dob1);
				if(!map_stage_starid.containsKey(first_name1 + " "+last_name1)) map_stage_starid.put(first_name1 + " "+last_name1, tmp_star_id1);
				map_stars.put(first_name1 + last_name1 + dob1, list1);
			}

			while (result_genres.next()) {
				Integer genre_id = (Integer) result_genres.getInt("genre_id");
				Integer movies_id = (Integer) result_genres.getInt("movies_id");
				String genre_name = result_genres.getString("name");
				String movie_name = result_genres.getString("title");

				if (!map_movies_genres.containsKey(movies_id)) {
					ArrayList<Object> list_local = new ArrayList<Object>();
					list_local.add(genre_id);
					map_movies_genres.put(movies_id, list_local);
				} else {
					ArrayList<Object> list_local = (ArrayList<Object>) map_movies_genres.get(movies_id);
					if (!list_local.contains(genre_id))
						list_local.add(genre_id);
					map_movies_genres.put(movies_id, list_local);
				}


				if (map_genres.containsKey(movie_name)) {
					ArrayList<Object> list_genres = new ArrayList<Object>();
					list_genres = (ArrayList<Object>) map_genres.get(movie_name);
					if (!list_genres.contains(genre_name)) {
						list_genres.add(genre_name);
						map_genres.put(movie_name, list_genres);
					}
					// System.out.println("List :"+list_genres);
				} else {
					ArrayList<Object> list_genres = new ArrayList<Object>();
					list_genres.add(genre_name);
					map_genres.put(movie_name, list_genres);
					// System.out.println("List :"+list_genres);
				}
			}
//			for (Map.Entry<String, Object> entry : map_stars.entrySet()) {
//				System.out.println(entry.getKey() + "/" + entry.getValue());
//			}

			while (result_movies.next()) {
				Integer id = result_movies.getInt("id");
				String title = result_movies.getString("title");
				Integer year = result_movies.getInt("year");
				String director = result_movies.getString("director");
				if (!map_movie_id.containsKey(title))
					map_movie_id.put(title, id);
				if (!map_movies.containsKey(title + year + director)) {
					ArrayList<Object> list_movies = new ArrayList<Object>();
					list_movies.add(title);
					list_movies.add(year);
					list_movies.add(director);
					map_movies.put(title + year + director, list_movies);
				}
				// for (Map.Entry<String, Object> entry : map_movies.entrySet())
				// {
				// System.out.println(entry.getKey() + "/" + entry.getValue());
				// }
			}
			File inputFile_stars = new File("src/data_files/actors63.xml");
			File inputFile_mains = new File("src/data_files/mains243.xml");
			File inputFile_cast = new File("src/data_files/casts124.xml");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();

			// Adding mains to the database
			System.out.println("Started Parsing Mains File");
			String mains_moviename = null, mains_year_string, mains_director_name = null, mains_directorname = null,
					mains_movie_id = null;
			Integer mains_year_integer = 2017;

			PreparedStatement main_insert_movies = null, main_insert_genres = null, main_add_genres = null;
			PreparedStatement select_max_id_genres = null, select_max_id_movies = null;

			select_max_id_genres = test_connection.prepareStatement("select max(id) from genres;");
			select_max_id_movies = test_connection.prepareStatement("select max(movies.id) from movies;");

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
			//System.out.println("Max Genre ID : " + max_genre_id);
			//System.out.println("Max Movie ID : " + max_movie_id);

			main_insert_movies = test_connection
					.prepareStatement("insert into movies(title,year,director) values(?,?,?);");
			main_insert_genres = test_connection.prepareStatement("insert into genres(id, name) values(?,?);");
			main_add_genres = test_connection
					.prepareStatement("insert into genres_in_movies(genre_id,movies_id) values (?,?);");

			Document document_mains = builder.parse(inputFile_mains);
			document_mains.normalize();
			NodeList list_mains_movies = document_mains.getElementsByTagName("movies");

			if (list_mains_movies != null && list_mains_movies.getLength() > 0) {
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

									mains_movie_id = element_mains_film.getElementsByTagName("fid").item(0)
											.getTextContent().trim();
								} catch (Exception e) {

									try {

										mains_movie_id = element_mains_film.getElementsByTagName("filmed").item(0)
												.getTextContent().trim();
										//System.out.println("Movie ID : " + mains_movie_id);
									} catch (Exception e1) {
										System.out.println("Movie ID is not existing in the file");
									}
								}

								// printing movie id
								//System.out.println("Movie ID : " + mains_movie_id);

								// Fetching movie name
								try {

									mains_moviename = element_mains_film.getElementsByTagName("t").item(0)
											.getTextContent().trim();
								} catch (Exception e) {
									if(mains_movie_id!=null){
									System.out.println("Exception in fetching movie name" + mains_moviename + "Movie id :" +mains_movie_id);
									}else{
										System.out.println("Exception in fetching movie name");
									}
									e.printStackTrace();
									mains_moviename = "Default Movie";
									continue;
								}

								// Printing Movie Name
								//System.out.println("Movie Name : " + mains_moviename);

								// Fetching movie year
								try {

									mains_year_string = element_mains_film.getElementsByTagName("year").item(0)
											.getTextContent().trim();
									if (mains_year_string != null)
										mains_year_integer = Integer.parseInt(mains_year_string);
								} catch (Exception e) {
									if(mains_movie_id!=null){
									System.out.println("Error in reading the year" + "Movie id :" +mains_movie_id);
									}else{
										System.out.println("Error in reading the year");
									}
									mains_year_integer = 2017;
									continue;
								}

								// Printing Movie year
								//System.out.print("Movie Year : ");
								//System.out.println(mains_year_integer);

								// Fetching Director Name
								try {
									NodeList list_mains_dirs = element_mains_film.getElementsByTagName("dirs");
									Element element_main_dirs = (Element) list_mains_dirs.item(0);

									NodeList list_mains_dirn = element_main_dirs.getElementsByTagName("dirn");
									Element element_mains_dirn = (Element) list_mains_dirn.item(0);
									if(element_mains_dirn!=null){
									mains_directorname = element_mains_dirn.getTextContent().trim();
									}
								} catch (Exception e) {
									if(mains_movie_id!=null){
									System.out.println("Exception in Director name : " + mains_director_name + "Movie id :" +mains_movie_id);
									}else{
										System.out.println("Exception in Director name : " + mains_director_name);
									}
									mains_directorname = "Anonymous Director";
								}

								if (mains_directorname == null)
									mains_directorname = "Anonymous Director";
								// Printing Director Name
								//System.out.println("Director Name : " + mains_directorname);

								// Putting the movie id as well as the
								// incremented movieid
								map_film_movie_id.put(mains_movie_id, ++max_movie_id);
								if (!map_movies
										.containsKey(mains_moviename + mains_year_integer + mains_directorname)) {
									main_insert_movies.setString(1, mains_moviename);
									main_insert_movies.setInt(2, mains_year_integer);
									main_insert_movies.setString(3, mains_directorname);
									main_insert_movies.execute();
									ArrayList<Object> list_local = new ArrayList<Object>();
									list_local.add(mains_moviename);
									list_local.add(mains_year_integer);
									list_local.add(mains_directorname);
//									System.out.println("Before putting into map :" + mains_moviename
//											+ mains_year_integer + mains_directorname);
									map_movies.put("mains_moviename" + mains_year_integer + mains_directorname,
											list_local);
								}

								NodeList list_mains_cats = element_mains_film.getElementsByTagName("cats");
								Element element_mains_cats = (Element) list_mains_cats.item(0);
								try{
							
								NodeList list_mains_cat = element_mains_cats.getElementsByTagName("cat");
								//System.out.println("Length : " + list_mains_cat.getLength());
								
								ArrayList<Object> local_mains_genres = (ArrayList<Object>) map_genres
										.get(mains_moviename);

								
								if (map_movie_id.containsKey(mains_moviename)) {
									database_movie_id = map_movie_id.get(mains_moviename);
								} else {
									database_movie_id = max_movie_id;
								}
								//System.out.println("Database Movie ID :" + database_movie_id);
								for (int a = 0; a < list_mains_cat.getLength(); a++) {
//									try{
//									String out_genre_name = list_mains_cat.item(a).getChildNodes().item(0)
//											.getNodeValue();
//									}catch(Exception e){
//										e.printStackTrace();
//									}
									// if((map_genres.get(mains_moviename)==null)
									// ||
									// (!local_mains_genres.contains(list_mains_cat.item(a)))){
									// local_mains_genres.add(list_mains_cat.item(a).getTextContent().trim());
									// map_genres.put(mains_moviename,local_mains_genres);
									// System.out.println("Local genres" +
									// local_mains_genres);
									// }
									String genre_current = list_mains_cat.item(a).getTextContent().trim();
									//System.out.println("Genre Current" + genre_current);
									ArrayList<Object> list_add_genres = new ArrayList<Object>();
									if (map_movies_genres.containsKey(database_movie_id)) {
										list_add_genres = (ArrayList<Object>) map_movies_genres.get(database_movie_id);
									}
									//System.out.println("List before going inside condition :" + list_add_genres);
									if (!map_genres_list.containsKey(list_mains_cat.item(a).getTextContent().trim())) {

										// ++max_movie_id;
										map_genres_list.put(list_mains_cat.item(a).getTextContent().trim(),
												++max_genre_id);
										main_insert_genres.setInt(1, max_genre_id);
										main_insert_genres.setString(2, genre_current);
										main_insert_genres.execute();
										// main_insert_genres.execute();
										if (!list_add_genres.contains(max_genre_id)) {
											list_add_genres.add(max_genre_id);
											map_movies_genres.put(database_movie_id, list_add_genres);
											main_add_genres.setInt(1, max_genre_id);
											main_add_genres.setInt(2, database_movie_id);
											// main_insert_genres.execute();
											main_add_genres.execute();
										}

									} else {
										String genre_name = list_mains_cat.item(a).getTextContent().trim();
										Integer genre_id = map_genres_list.get(genre_name);

										if (!list_add_genres.contains(genre_id)) {
											list_add_genres.add(genre_id);
											map_movies_genres.put(database_movie_id, list_add_genres);
											main_add_genres.setInt(1, genre_id);
											main_add_genres.setInt(2, database_movie_id);
											// main_insert_genres.execute();
											main_add_genres.execute();
										}
									}
								}}catch(Exception e){
									e.printStackTrace();
								}
							}
						}
					}
				}
			}
			
			System.out.println("Parsed Successfully Mains243.xml");
			// Adding actors to the database
			System.out.println("Started Parsing Actors63.xml File");
			Integer database_starid = 0;
			Document document = builder.parse(inputFile_stars);
			PreparedStatement star_insert = null;
			document.normalize();
			String original_dob="",original_firstname="",original_lastname="";
			PreparedStatement prepare_statement_stars = null;
			prepare_statement_stars = test_connection.prepareStatement("select max(id) from stars;");
			ResultSet result_maxid_stars = prepare_statement_stars.executeQuery();
			if (result_maxid_stars.next()) {
				database_starid = result_maxid_stars.getInt(1);
			}
			prepare_statement_stars.close();

			PreparedStatement starInsert = null;
			starInsert = test_connection
					.prepareStatement("insert into stars(id,first_name,last_name,dob) values(?,?,?,?);");

			NodeList list_actors = document.getElementsByTagName("actors");
			Node node_actors = list_actors.item(0);
			Element element_actors = (Element) node_actors;
			NodeList list_actor = element_actors.getElementsByTagName("actor");
			//System.out.println("Length :" + list_actor.getLength());
			for (int i = 0; i < list_actor.getLength(); i++) {

				String firstname = null, lastname = null, dob = null, actors_stagename = null;

				// Node node_actor = list_actor.item(i);
				Element element_actor = (Element) list_actor.item(i);
				// System.out.println("\nCurrent Element :" +
				// element_actors.getNodeName());

				// Node node_actor_firstname =
				// element_actor.getElementsByTagName("firstname").item(0);
				//
				// Node node_actor_lastname =
				// element_actor.getElementsByTagName("familyname").item(0);
				// Node node_actor_dob =
				// element_actor.getElementsByTagName("dob").item(0);

				// Actors stagename
				try {
					if(element_actor.getElementsByTagName("stagename").item(0).getTextContent()!=null)
					actors_stagename = element_actor.getElementsByTagName("stagename").item(0).getTextContent().trim().toLowerCase();
					else System.out.println("Actor Stage Name is null");
				} catch (Exception e) {
					System.out.println("Error while reading the actors stage name");
					e.printStackTrace();
					continue;
				}
				//System.out.println("Stage Name : " + actors_stagename);

				// Actors firstname
				try {
					// Element element_actor_firstname = (Element)
					// node_actor_firstname;
					firstname = element_actor.getElementsByTagName("firstname").item(0).getTextContent().trim();
					original_firstname=firstname;
					if (firstname == null || firstname.length() <= 0)
						firstname = "Anonymous";

				} catch (Exception e) {
					if(actors_stagename==null)
					System.out.println("Error in First Name" + firstname);
					else System.out.println("Error in First Name" + firstname +"Actors Stage Name" + actors_stagename);
					e.printStackTrace();
					firstname = "Anonymous";
					continue;
				}
				//System.out.println("First Name" + firstname);

				// Actors lastname
				try {
					lastname = element_actor.getElementsByTagName("familyname").item(0).getTextContent().trim();
					original_lastname=lastname;
					if (lastname == null || lastname.length() <= 0)
						lastname = "Anonymous";
					else
						lastname = lastname.trim();

				} catch (Exception e) {
					if(actors_stagename==null)
					System.out.println("Error in Last Name:" + lastname);
					else System.out.println("Error in Last Name:" + lastname + "Actors Stage Name" + actors_stagename);
					lastname = "Anonymous";
					e.printStackTrace();
					continue;
				}
				//System.out.println("Last Name" + lastname);
				// Actors date of birth
				
				try {
					if (element_actor.getElementsByTagName("dob").item(0).getTextContent() != null) {
						dob = element_actor.getElementsByTagName("dob").item(0).getTextContent();
						original_dob=dob;

						if (dob.equals("") || dob == null)
							dob = "2001";

						if (!dob.matches("-?\\d+")) {
							dob = "2001";
						} else
							dob = dob.trim();
					} else
						dob = "2001";

				} catch (Exception e) {
					if(actors_stagename==null)
					System.out.println("error in dob :" + dob);
					else System.out.println("error in dob :" + dob + "Actors Stage Name" + actors_stagename);
					dob = "2001";
					e.printStackTrace();

					continue;

				}
				//System.out.println("DOB" + dob);
				star_insert = test_connection
						.prepareStatement("insert into stars(first_name,last_name,dob) values(?,?,?)");
				//System.out.println("Before going inside : " + map_stars.get(firstname + lastname + dob));

				ArrayList<Object> list_local_map_stars = new ArrayList<Object>();
				if(!map_stage_starid.containsKey(firstname + " " + lastname));
				if (map_stars.get(original_firstname + original_lastname + original_dob) != null) {
					list_local_map_stars = (ArrayList<Object>) map_stars.get(firstname + lastname + dob);
				}
				if (!map_stars.containsKey(original_firstname + original_lastname+original_dob)) {
					//System.out.println("Map Value : " + map_stars.get(firstname + lastname + dob));
					//System.out.println("After going inside");
					//System.out.println("List : " + list_local_map_stars);
					++database_starid;
					star_insert.setString(1, firstname);
					star_insert.setString(2, lastname);
					star_insert.setDate(3, java.sql.Date.valueOf(dob + "-01-01"));
					star_insert.execute();
					try {
						list_local_map_stars.add(firstname);
						//System.out.println("List : " + list_local_map_stars);
					} catch (Exception e) {
						e.printStackTrace();
						continue;
					}
					list_local_map_stars.add(lastname);
					//System.out.println("List : " + list_local_map_stars);
					list_local_map_stars.add(dob + "-01-01");
					//System.out.println("List : " + list_local_map_stars);
					map_stars.put(original_firstname + original_lastname+original_dob, list_local_map_stars);
					//firstname + lastname + dob+ "-01-01"
				}
				if (actors_stagename!=null ){
					if(map_stage_starid.get(actors_stagename) != null )
					//System.out.println("actors_stagename : " + actors_stagename);
					//System.out.println("database_starid" + database_starid);
					
					
					if(!map_stage_starid.containsKey(actors_stagename))map_stage_starid.put(actors_stagename, database_starid);
					map_stage_plus_starid.put(actors_stagename+database_starid, database_starid);
				}

			}
			
			System.out.println("Successfully parsed Actors63.xml file");
			// Adding cast to the database
			System.out.println("Started parsing Casts124.xml file");
			//System.out.println("LOOP IN THE CAST");
//			for (Entry<String, Integer> entry : map_film_movie_id.entrySet()) {
//				System.out.println(entry.getKey() + "/" + entry.getValue());
//			}	

			
			String stagename = null,movieid_string=null;
			Integer movieid_integer = 0, star_id_max=0;
			PreparedStatement insertStarMovie = null, insert_stars_cast=null;
			insertStarMovie = test_connection
					.prepareStatement("insert into stars_in_movies(star_id,movie_id) values(?,?);");
			insert_stars_cast = test_connection
					.prepareStatement("insert into stars(first_name,last_name, dob) values(?,?,?);");
			
			PreparedStatement prepare_max_id_stars = null;
			prepare_max_id_stars = test_connection.prepareStatement("select max(id) from stars;");
			ResultSet result_max_id_stars = prepare_max_id_stars.executeQuery();
			
			if (result_max_id_stars.next()) {
				star_id_max = result_max_id_stars.getInt(1);
			}
			prepare_max_id_stars.close();
			
			
			Document document_cast = builder.parse(inputFile_cast);
			document_cast.normalize();
			NodeList list_cast_casts = document_cast.getElementsByTagName("casts");
			Element element_cast_casts = (Element) list_cast_casts.item(0);

			
			NodeList list_cast_movies = element_cast_casts.getElementsByTagName("dirfilms");
			//System.out.println("DirFilms Length : " + list_cast_movies.getLength());
			for (int d = 0; d < list_cast_movies.getLength(); d++) {
				Element element_cast_movies = (Element) list_cast_movies.item(d);

				NodeList list_cast_filmc = element_cast_movies.getElementsByTagName("filmc");
				//System.out.println("filmc length : " + list_cast_filmc.getLength());
				for (int b = 0; b < list_cast_filmc.getLength(); b++) {
					Element element_cast_filmc = (Element) list_cast_filmc.item(b);
					NodeList list_cast_m = element_cast_filmc.getElementsByTagName("m");
					//System.out.println("Listm Length : " + list_cast_m.getLength());
					for (int c = 0; c < list_cast_m.getLength(); c++) {
						Element element_cast_m = (Element) list_cast_m.item(c);
						try {
							movieid_string = element_cast_m.getElementsByTagName("f").item(0).getTextContent()
									.trim();
							//movieid_integer = Integer.parseInt(movieid_string);
						} catch (Exception e) {
							e.printStackTrace();
						}
						try {
							stagename = element_cast_m.getElementsByTagName("a").item(0).getTextContent().trim()
									.toLowerCase();
						} catch (Exception e) {
							e.printStackTrace();
							continue;
						}
						if (movieid_string != null && stagename != null) {

							try{
								int starId=0, movieId=0,tmp_id=0,tmp_check=1;
								//System.out.println("Stagename : "+stagename);
								//System.out.println("Movie ID : " + movieid_string);
								
								if(map_stage_starid.get(stagename)!=null && map_film_movie_id.get(movieid_string)!=null)
								{
									starId = map_stage_starid.get(stagename);
									insertStarMovie.setInt(1, starId);
									
									movieId = map_film_movie_id.get(movieid_string);
									//System.out.println("Move ID : " + movieId);
									insertStarMovie.setInt(2, movieId);
									insertStarMovie.execute();	
								}
								
								if(map_stage_starid.get(stagename)==null){
									++star_id_max;
									
									String[] split = stagename.split(" ");
									
									if(split[0]!=null && split[0].length()>0)
									insert_stars_cast.setString(1, split[0]);
									else insert_stars_cast.setString(1, "Anonymous");
									if(split.length >1 ){
										insert_stars_cast.setString(2, split[1]);
									}
									else{
										insert_stars_cast.setString(2, "Anonymous");
									}
									insert_stars_cast.setString(3, null);
									map_stage_starid.put(stagename, star_id_max);
									insert_stars_cast.execute();
									//insertStarMovie.setInt(1, star_id_max);
								}
								
								
//								if(map_stage_starid.get(stagename)!=null){
//								starId = map_stage_starid.get(stagename);
//								tmp_id=starId;
//								tmp_check=1;
//								//insertStarMovie.setInt(1, starId);
//								}else{
//									++star_id_max;
//									tmp_id=star_id_max;
//									String[] split = stagename.split(" ");
//									if(split[0]!=null || split[0].length()>0)
//									insert_stars_cast.setString(1, split[0]);
//									else insert_stars_cast.setString(1, "Anonymous");
//									
//									if(split[1]!=null || split[1].length()>0)
//									insert_stars_cast.setString(2, split[1]);
//									else insert_stars_cast.setString(2, "Anonymous");
//									insert_stars_cast.setString(3, null);
//									//map_stage_starid.put(stagename, value);
//									//insert_stars_cast.execute();
//									//insertStarMovie.setInt(1, star_id_max);
//									tmp_check=1;
//								}
//								
//								System.out.println("After Star ID : "+tmp_id);
//								System.out.println("Max Star ID : "+star_id_max);
//								
//								if(map_film_movie_id.get(movieid_string)!=null){
//								movieId = map_film_movie_id.get(movieid_string);
//								insertStarMovie.setInt(1, tmp_id);
//								insertStarMovie.setInt(2, movieId);
//								insertStarMovie.execute();
//								//map_film_movie_id.put(tmp_id, movieId);
//								}else{
//									continue;
//								}
//								
//								System.out.println("After Movie ID : "+movieId);
//								System.out.println("Star ID : " + starId);
//								System.out.println("Movie ID : " + movieId);
//								if(tmp_check==1){
//								map_stage_starid.put(stagename, tmp_id);
//								insert_stars_cast.execute();
//							}
							}catch(Exception e){
								e.printStackTrace();
							}
							//}
						}
					}
				}
			}
			System.out.println("Parsed Successfully Casts124.xml file");
//			star_insert.executeBatch();
//			test_connection.commit();
//			star_insert.close();
//			Iterator<Map.Entry<String, Object>> it = map_genres.entrySet().iterator();
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

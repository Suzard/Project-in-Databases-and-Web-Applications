-- The Begin of the script
CREATE DATABASE IF NOT EXISTS `moviedb` DEFAULT CHARACTER SET latin1;
USE `moviedb`;

#executing after creating the schema causes errorstars_in_movies
# which is why we use set foreign key
SET FOREIGN_KEY_CHECKS=0; 
DROP TABLE IF EXISTS `movies`; 
DROP TABLE IF EXISTS `stars`; 
DROP TABLE IF EXISTS `stars_in_movies`; 
DROP TABLE IF EXISTS `genres`; 
DROP TABLE IF EXISTS `genres_in_movies`; 
DROP TABLE IF EXISTS `customers`; 
DROP TABLE IF EXISTS `sales`; 
DROP TABLE IF EXISTS `creditcards`; 
DROP TABLE IF EXISTS `employees`; 
SET FOREIGN_KEY_CHECKS=1; 

#    title varchar(100) not null default ''
# possibly replace everything with not null to this
# no need for default value when auto_incrementing

--  used sample_script from CS 122a as reference

-- Table structure for table `movies`
CREATE TABLE `movies` (
  `id` integer NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,-- DEFAULT "",
  `year` integer NOT NULL,
  `director` varchar(100) NOT NULL,-- DEFAULT "",
  `banner_url` varchar(200) DEFAULT NULL,
  `trailer_url` varchar(200) DEFAULT NULL,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `stars`
CREATE TABLE `stars` (
  `id` integer NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,-- DEFAULT "",
  `last_name` varchar(50) NOT NULL,-- DEFAULT "",
  `dob` date DEFAULT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `stars_in_movies`
CREATE TABLE `stars_in_movies` (
-- just integer or do you need not null auto increment? we test this and it seems
-- no need for auto increment when inheriting
	`star_id` integer,
	`movie_id` integer,
	
	FOREIGN KEY(star_id) REFERENCES stars(id) ON DELETE CASCADE,
	FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE
    
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `genres`
CREATE TABLE `genres` (
  `id` integer NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,-- DEFAULT "",
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table structure for table `genres_in_movies`
CREATE TABLE `genres_in_movies` (
  `genre_id` integer,
  `movies_id` integer,
  FOREIGN KEY(genre_id) REFERENCES genres(id)ON DELETE CASCADE,
  FOREIGN KEY(movies_id) REFERENCES movies(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `customers`
CREATE TABLE `customers` (
  `id` integer NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,-- DEFAULT "",
  `last_name` varchar(50) NOT NULL,-- DEFAULT "",  
  `cc_id` varchar(20) NOT NULL,-- DEFAULT "",
  `address` varchar(200) NOT NULL,-- DEFAULT "",
  `email` varchar(50) NOT NULL,-- DEFAULT "",
  `password` varchar(20) NOT NULL,-- DEFAULT "",
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `sales`
CREATE TABLE `sales` (
  `id` integer NOT NULL AUTO_INCREMENT,
  `customer_id` integer,
  `movie_id` integer,	 
  `sale_date` date NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY(customer_id) REFERENCES customers(id)ON DELETE CASCADE,
  FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  -- Table structure for table `creditcards`
CREATE TABLE `creditcards` (
  `id` varchar (20) NOT NULL,-- DEFAULT "",
  `first_name` varchar(50) NOT NULL,-- DEFAULT "",
  `last_name` varchar(50) NOT NULL,-- DEFAULT "",
  `expiration` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `employees` (
`email` varchar(50) NOT NULL,
`password` varchar(20) NOT NULL,
`fullname` varchar(100) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$
DROP PROCEDURE IF EXISTS `add_star`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_star`(IN star_ids INT, IN first_name varchar(50), IN last_name varchar(50), IN date_birth date, IN photo_url_s varchar(200))
BEGIN
	INSERT INTO stars values(star_ids, first_name,last_name, date_birth, photo_url_s);
END$$
DELIMITER ;
DELIMITER $$
DROP PROCEDURE IF EXISTS `add_movie`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_movie`(IN movie_ids INT, IN title varchar(100), IN years INT, IN director varchar(200), IN banner_url varchar(200), IN trailer_url varchar(200), IN first_name varchar(50), IN last_name varchar(50), IN genre varchar(32), IN star_url varchar(200), IN update_movie_check INT, OUT counting INT, OUT counting2 INT, OUT check_star varchar(50), OUT check_genre varchar(50))
BEGIN
	CASE WHEN update_movie_check = 0
    then
	INSERT INTO movies values(movie_ids, title,years, director, banner_url, trailer_url);
    
	SET @check_genre =  'genre exists!'; #defaults to this if the genre is not found
	SELECT COUNT(*) INTO counting FROM genres where genres.name =genre;
	CASE WHEN counting = 0  # if genre does not exist create it
    then 
    INSERT INTO genres values(0,genre);
	SET @check_genre =  'genre does not exist. It has been created';
    ELSE BEGIN END;END CASE;
	INSERT INTO genres_in_movies (genre_id, movies_id) values((select id from genres  where genres.name = genre),movie_ids) ;
    
    
    SET @check_star = 'star exists!'; #defaults to this if the star is not found
	SELECT COUNT(*) INTO counting2 FROM stars where stars.first_name = first_name && stars.last_name = last_name;
    CASE when counting2 = 0 # if star does not exist create it
    then 
    INSERT INTO stars values(0,first_name, last_name, '1995-01-01',star_url); #default for empty star
    SET @check_star = 'star does not exist. It has been created';
    ELSE BEGIN END;END CASE;
    INSERT INTO stars_in_movies (star_id, movie_id) values ((select id from stars where stars.first_name = first_name && stars.last_name = last_name), movie_ids);
    SET check_genre = @check_genre; #must be done at the end to initialize message
    SET check_star = @check_star; #must be done at the end to initialize message
	ELSE BEGIN END;END CASE;

	CASE WHEN update_movie_check != 0
    then
    update movies set movies.title = title, movies.year = years, movies.director = director, movies.banner_url = banner_url, movies.trailer_url = trailer_url where movies.id = movie_ids;
    
	SET @check_genre =  'genre exists!'; #defaults to this if the genre is not found
	SELECT COUNT(*) INTO counting FROM genres where genres.name =genre;
	CASE WHEN counting = 0  # if genre does not exist create it
    then 
    INSERT INTO genres values(0,genre);
	SET @check_genre =  'genre does not exist. It has been created';
    ELSE BEGIN END;END CASE;
    SELECT id into counting FROM genres where genres.name = genre;
	update genres_in_movies set genres_in_movies.genre_id = counting where genres_in_movies.movies_id = movie_ids;
    #beginning of deleting duplicate entries
	SELECT COUNT(*) into counting2 from genres_in_movies where genres_in_movies.genre_id = counting  && genres_in_movies.movies_id = movie_ids;
    CASE WHEN counting2 >1
    then
	SET @counting2 = (counting2-1);
    DELETE FROM  genres_in_movies where genres_in_movies.genre_id = counting  && genres_in_movies.movies_id = movie_ids limit counting2;

	ELSE BEGIN END;END CASE;
    #end of deleting duplicate entries

    SET @check_star = 'star exists!'; #defaults to this if the star is not found
	SELECT COUNT(*) INTO counting FROM stars where stars.first_name = first_name && stars.last_name = last_name;
    CASE when counting = 0 # if star does not exist create it
    then 
    INSERT INTO stars values(0,first_name, last_name, '1995-01-01',star_url); #default for empty star
    SET @check_star = 'star does not exist. It has been created';
    ELSE BEGIN END;END CASE;
	SELECT id into counting FROM stars where stars.first_name = first_name && stars.last_name = last_name;
	update stars_in_movies set stars_in_movies.star_id = counting where stars_in_movies.movie_id = movie_ids;


	SELECT COUNT(*) into counting2 from stars_in_movies where stars_in_movies.star_id = counting  && stars_in_movies.movie_id = movie_ids;
    CASE WHEN counting2 >1
    then
	SET @counting2 = (counting2-1);
    DELETE FROM  stars_in_movies where stars_in_movies.star_id = counting  && stars_in_movies.movie_id = movie_ids limit counting2;


	ELSE BEGIN END;END CASE;
    #end of deleting duplicate entries
    SET check_genre = @check_genre; #must be done at the end to initialize message
    SET check_star = @check_star; #must be done at the end to initialize message


	ELSE BEGIN END;END CASE;
    


END$$
DELIMITER ;


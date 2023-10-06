
DROP DATABASE IF EXISTS agora;

CREATE DATABASE IF NOT EXISTS agora;
USE agora;

-- at least 3 datatypes: INT, CHAR, VARCHAR, DATE, TIMESTAMP.
-- at least 2 constraints: NOT NULL, UNIQUE, DEFAULT.
-- DML commands: INSERT (for each table, total of 4 queries).
-- PRIMARY KEYS in all tables except 'status'.
-- FOREIGN KEY in 'posts' table.

-- user information.
CREATE TABLE IF NOT EXISTS users(
	id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(30),
    ctry_code CHAR(3),
    username VARCHAR(20) NOT NULL UNIQUE,
    passcode VARCHAR(18) NOT NULL,
    email VARCHAR(319) NOT NULL UNIQUE,
    creation DATE NOT NULL
);

-- membership information.
CREATE TABLE IF NOT EXISTS members(
	-- one-to-one relationship with users:
	-- ok for foreign key to be primary key.
	user_id INT UNIQUE PRIMARY KEY,
		FOREIGN KEY (user_id) REFERENCES users(id),
	payment_id VARCHAR(20),
    membership CHAR(8),
    member_from DATE
);
    
-- categories of posts.
CREATE TABLE IF NOT EXISTS class(
	id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
	category VARCHAR(20),
	posts INT
);

-- track all posts.
CREATE TABLE IF NOT EXISTS posts(
	id INT UNIQUE PRIMARY KEY,
    class_id INT,
		FOREIGN KEY (class_id) REFERENCES class(id),
    title VARCHAR(80) NOT NULL,
    user_id INT NOT NULL,
		FOREIGN KEY (user_id) REFERENCES users(id),
    posted TIMESTAMP NOT NULL,
    comments INT,
    cheer INT,
    grumble INT
);

-- statuses that users obtain depending on activity.
CREATE TABLE IF NOT EXISTS status(
	id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
	typ VARCHAR(20) DEFAULT 'Hero',
    lvl INT
);

-- table insertions.

INSERT INTO users
(region, ctry_code, username, passcode, email, creation)
VALUES
('Northern Europe', 'GBR', 'asyndev', 'p@ZZ-Wr97', 'agora_dev1@gmail.com', '2020-06-30'),
('Sub-Saharan Africa', 'NGA', 'cognisnt', 'quwRT9_ps8', 'lgsgrl@gmail.com', '2020-07-22'),
('Northern Europe', 'GBR', 'byclo', 'fiysba3HGB', 'byronclover@outlook.com', '2021-11-01'),
('Northern Europe', 'GBR', 'l1vne', 'AkhLna782lfTkk50', 'olanna_dev2@gmail.com', '2021-11-14'),
('Oceania', 'TUV', 'sia_iaia', '63gsjdKB-agd', 'siaosilan@gmail.com', '2021-12-16'),
('Sub-Saharan Africa', 'TGO', 'chamchee', 'Gugguggug04', 'koff1_e@gmail.com', '2022-05-12'),
('Northern Europe', 'IRL', 'caoimhe', '5fguy_8ky', 'caocoa@outlook.com', '2022-09-06'),
('Central America', 'GTM', 'ximexime', 'BlueboTTl41', 'gwataxime@outlook.com', '2022-11-18'),
('Central America', 'NIC', 'strisrr', 'Penguins11', 'anteaterjo@gmail.com', '2022-12-08'),
('Central America', 'NIC', '1needon', 'S3cur33', 'marmaloader@yahoo.com', '2023-01-02'),
('Oceania', 'AUS', 'wrandium', 'sk8rejdj', 'uwranium@yahoo.com', '2023-04-21'),
('Oceania', 'AUS', 'privetic', 'C3ry8aFa8', 'hannamac@yahoo.com', '2023-06-29'),
('Central America', 'HND', 'srenpidity', 'L1ghtn1ngng', 'srena@gmail.com', '2023-08-01');

INSERT INTO members
(user_id, payment_id, membership, member_from)
VALUES
(1, 'ewMVQulP0PsJ5tXH7Mk4', 'Ambrosia', '2022-02-28'),
(2, 'EpqcU4H8WrYFwtL0GkoT', 'Ambrosia', '2022-02-28'),
(5, 'f6GF6upXUGoZh2wIZoCM', 'Ambrosia', '2022-06-01'),
(10, 'jHycIRJqfni3O9FF8LOO', 'Ambrosia', '2023-01-25'),
(11, 'rOrTVo1MlUl43HgxLXY0', 'Ambrosia', '2023-07-24'),
(13, 'UPQgxTXGO0QBmOXBSDwv', 'Ambrosia', '2023-09-01');

INSERT INTO class
(category, posts)
VALUES
('Beta', 53),
('General', 458),
('News', 372),
('Gaming', 493),
('Anime', 368),
('Books', 291),
('Plants', 174),
('Food', 293),
('Bugs', 138);

-- all posts from 01/06 to 30/09 (3 months).
INSERT INTO posts
(id, class_id, title, user_id, posted, comments, cheer, grumble)
VALUES
(10945, 4, 'Unity runtime fees ?!?!?!', 10, '2023-09-30 07:09:50', 249, 147, 93),
(10944, 4, "unity's fees are ok.", 8, '2023-09-25 11:14:35', 278, 238, 148),
(10943, 8, 'Best meals to make for guests?', 10, '2023-09-22 12:44:41', 79, 46, 2),
(10942, 1, 'Rolling out testing for newest feature.', 1, '2023-09-06 09:07:10', 6, 4, 0),
(10941, 9, "Can't access this service on Agora?", 9, '2023-09-01 00:01:21', 21, 3, 1),
(10940, 5, 'Jujutsu Kaisen S2E29!!! [Spoilers]', 12, '2023-08-17 13:23:25', 148, 94, 8),
(10939, 2, 'How to get a status on Agora', 3, '2023-08-15 16:20:01', 309, 293, 15),
(10938, 3, "Last month's news (Global)", 3, '2023-08-08 19:19:14', 328, 95, 22),
(10937, 5, 'one piece chapter 1088.', 1, '2023-07-27 03:45:02', 423, 221, 35),
(10936, 6, 'The Beekeeper of Aleppo review', 4, '2023-07-19 21:51:43', 67, 12, 0),
(10935, 5, 'where are you watching your anime?', 11, '2023-07-18 21:58:43', 82, 9, 1),
(10934, 7, 'What is happening to my tillandsia :(', 4, '2023-07-07 20:52:16', 132, 32, 2),
(10933, 1, 'Update to newest feature.', 2, '2023-07-06 00:29:19', 12, 2, 0),
(10932, 5, 'kissanime?', 10, '2023-07-04 16:12:01', 138, 242, 48),
(10931, 4, 'tears of the kingdom', 9, '2023-06-30 01:36:48', 308, 157, 67),
(10930, 7, 'Black Coral Colocasia - My favourite plant!', 1, '2023-06-28 05:38:42', 214, 37, 2),
(10929, 8, "What's your favourite cuisine?", 9, '2023-06-14 16:11:09', 142, 68, 1),
(10928, 9, 'how do i use this in agora?', 8, '2023-06-13 07:39:49', 52, 6, 0),
(10927, 3, "has anyone else seen this?", 8, '2023-06-07 12:49:31', 92, 7, 26),
(10926, 5, 'rewatching Haikyuu for the fifth time', 7, '2023-06-06 23:11:32', 237, 78, 0),
(10925, 1, 'Updates to Ambrosia membership.', 1, '2023-05-29 12:10:28', 10, 3, 0),
(10924, 7, 'Help identifying this plant?', 3, '2023-05-23 06:16:53', 21, 6, 2),
(10923, 5, 'looking for new manga to read, what are your favourites?', 11, '2023-05-13 16:09:47', 271, 104, 21),
(10922, 5, 'What anime will you never rewatch?', 6, '2023-05-09 13:36:14', 194, 67, 8),
(10921, 6, 'Rereading books from your childhood, anyone else?', 4, '2023-05-02 17:48:34', 115, 43, 0),
(10920, 4, 'confused about skyrim', 11, '2023-04-24 20:26:36', 231, 134, 46),
(10919, 8, 'best homemade shakshouka recipes?', 8, '2023-04-22 00:12:54', 183, 94, 0),
(10918, 9, "how do I use this feature? it doesn't work for me", 9, '2023-04-12 02:15:27', 12, 1, 0),
(10917, 6, 'The Song of Achilles review', 4, '2023-04-10 15:15:14', 114, 53, 11),
(10916, 9, "can't seem to leave comments?", 8, '2023-04-09 17:26:06', 42, 13, 2),
(10915, 3, 'What is something important that is happening in your country?', 4, '2023-04-01 04:21:00', 241, 19, 0),
(10914, 2, 'New updates coming for Ambrosia members', 3, '2023-03-20 22:34:42', 286, 193, 2),
(10913, 6, "my opinion on 'Bitter Fruit'", 8, '2023-03-17 16:33:56', 210, 4, 54),
(10912, 4, 'Do I start Dark Souls at the beginning or jump to Elden Ring?', 9, '2023-03-14 14:12:28', 373, 217, 21),
(10911, 8, "Tastiest sandwich I've ever had", 10, '2023-03-09 11:28:46', 75, 28, 3),
(10910, 4, 'whats the best game youve played so far', 7, '2023-03-06 08:41:34', 212, 31, 0),
(10909, 3, "Last month's news (Global)", 2, '2023-03-04 10:11:55', 283, 4, 0),
(10908, 3, 'Updates on Russia and Ukraine.', 1, '2023-03-01 17:17:34', 121, 2, 0),
(10907, 7, 'are these mealies?!', 5, '2023-02-28 05:27:03', 100, 4, 0),
(10906, 6, 'Jonathan Strange and Mr. Norrell [SPOILERS]', 3, '2023-02-13 00:36:09', 44, 12, 1),
(10905, 2, 'Poll: New features for statuses', 2, '2023-02-08 17:38:17', 290, 154, 23),
(10904, 2, 'Just discovered the conditions for Primordial status', 7, '2023-02-06 21:01:18', 198, 74, 11),
(10903, 8, 'My spicy pork pho recipe', 10, '2023-01-31 14:55:06', 238, 45, 3),
(10902, 9, 'no access to this feature.', 8, '2023-01-27 21:44:19', 11, 2, 0),
(10901, 4, 'ACNH: Decorating my island for kk slider.', 1, '2023-01-20 10:11:52', 81, 34, 2),
(10900, 1, 'Polling members for status changes?', 2, '2023-01-18 04:38:15', 62, 36, 4),
(10899, 5, 'anime similar to devilman crybaby', 8, '2023-01-15 01:56:16', 171, 63, 0),
(10898, 9, 'is it me or the web page?', 5, '2023-01-08 11:10:05', 267, 35, 12),
(10897, 3, 'News in Nicaragua', 9, '2023-01-07 08:31:30', 92, 3, 0),
(10896, 3, 'What is happening in your country?', 9, '2023-01-03 20:52:16', 340, 11, 1);

-- scaled down status levels.
  -- levels are the number of posts.
INSERT INTO status
(typ, lvl)
VALUES
('Hero', 0),
('Nymph', 4), -- actual level: 700
('Olympian', 7), -- actual level: 1600
('Titan', 12), -- actual level: 2900
('Primordial', 19); -- actual level: 5000


    

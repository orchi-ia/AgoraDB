
USE agora;

-- Scenario: End of year review!

-- Please view the README for an overview of our end of year goals (including the results from the below)!



-- GOAL 1:
-- query(5): the % of users who do not have Ambrosia.
	-- uses inbuilt function (ISNULL) and second aggregate function (SUM).
SELECT
	SUM(CASE WHEN ISNULL(m.membership) THEN 1 ELSE 0 END)
	/ SUM(CASE WHEN u.id THEN 1 ELSE 0 END) * 100
AS '% users without ambrosia'
FROM users u
LEFT JOIN members m
ON u.id = m.user_id;

-- result: less than 50% of users in the dataset do not have a membership.


-- query(6): compare the num of Ambrosia memberships since the update vs
-- using the same time period before the update as a ratio.
	-- uses second and third inbuilt functions (DATE_ADD and DATEDIFF).
    -- uses aggregate function (COUNT).
SELECT
	SUM(CASE WHEN m.member_from > '2023-05-29'
		THEN 1
        ELSE 0
        END)
        /
    SUM(CASE WHEN m.member_from BETWEEN
		-- get the difference between today and the day of the update in days.
        -- take away those num of days from the day of update to compare 
        -- the same time periods.
		DATE_ADD('2023-05-29',
			INTERVAL -DATEDIFF(NOW(), '2023-05-29') DAY)
		AND '2023-05-29'
        THEN 1
        ELSE 0
        END)
AS 'ratio'
FROM members m;

-- result: tripled memberships bought since the update compared to the months before.



-- GOAL 2:
-- queries(7) to filter posts assuming all posts in the table are under one category.
	-- uses third join (EQUI JOIN) and ORDER BY.
    
-- filter by post date.
SELECT u.username, p.title, p.posted
FROM posts p
JOIN users u
ON u.id = p.user_id
ORDER BY p.posted DESC
LIMIT 15;

-- filter by most cheers.
SELECT u.username, p.title, p.cheer, p.grumble
FROM posts p
JOIN users u
ON u.id = p.user_id
ORDER BY p.cheer DESC
LIMIT 15;

-- filter by most grumbles.
SELECT u.username, p.title, p.cheer, p.grumble
FROM posts p
JOIN users u
ON u.id = p.user_id
ORDER BY p.grumble DESC
LIMIT 15;

-- filter by most controversial.
SELECT u.username, p.title, p.cheer, p.grumble
FROM posts p
JOIN users u
ON u.id = p.user_id
ORDER BY p.cheer DESC, p.grumble DESC
LIMIT 15;

-- demonstrating an example filter on a single category using a nested SELECT.
SELECT u.username, p.title, p.posted
FROM posts p
JOIN users u
ON u.id = p.user_id
WHERE p.class_id IN (SELECT c.id
						FROM class c
                        WHERE c.category = 'Books')
ORDER BY p.posted DESC
LIMIT 15;



-- GOAL 3:
-- queries(8) to track user engagement in post categories.
	-- uses third and fourth aggregate functions (MAX and MIN) and ORDER BY.
SELECT c.category, p.title, p.posted, u.username
FROM posts p
JOIN class c
ON c.id = p.class_id
JOIN users u
ON u.id = p.user_id
WHERE p.class_id IN (SELECT c.id
						FROM class c
						WHERE c.posts IN (SELECT MAX(c.posts)
											FROM class c))
ORDER BY p.posted DESC;

                                            
SELECT c.category, p.title, p.posted, u.username
FROM posts p
JOIN class c
ON c.id = p.class_id
JOIN users u
ON u.id = p.user_id
WHERE p.class_id IN (SELECT c.id
						FROM class c
						WHERE c.posts IN (SELECT MIN(c.posts)
											FROM class c))
ORDER BY p.posted DESC;

-- result: Gaming is the most popular category and Beta is the least popular.


    
-- GOAL 4:
-- query(9) to see how many central american users we have.
SELECT
	SUM(CASE WHEN u.region = 'Central America' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN u.id THEN 1 ELSE 0 END) * 100
    AS '% central american users'
FROM users u;

-- queries(10) to consider how much central american users have posted.
SELECT (SELECT COUNT(*)
		FROM posts p
		WHERE p.user_id IN (SELECT u.id
							FROM users u
							WHERE u.region = 'Central America')) /
-- relative to all posts.
	(SELECT COUNT(*)
	FROM posts) * 100 AS 'ratio of central american user posts to all posts';

-- result: 1/3rd of our users are from the central american region, they have made 39% of posts in the table.

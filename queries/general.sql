
USE agora;

-- 2 stored procedures for repeatable procs:
	-- an existing user wants to purchase Ambrosia (an Agora membership)!
    -- an existing user would like to delete their account...
    -- DML commands used: INSERT, DELETE.

-- query(1) to view the users table before the below sprocs are called.
	-- uses ORDER BY.
SELECT *
FROM users u
ORDER BY u.id;

DROP PROCEDURE new_ambrosia;

DELIMITER //
CREATE PROCEDURE new_ambrosia(id INT, payment_id VARCHAR(20), date DATE)
BEGIN
	-- add payment and membership details.
	INSERT INTO members
    (user_id, payment_id, membership, member_from)
    VALUES
    (id, payment_id, 'Ambrosia', date);
END//
DELIMITER ;

CALL new_ambrosia(9, 'I35TccIVc5oVehY7HnDC', '2023-09-29');

DROP PROCEDURE user_deleter;

DELIMITER //
CREATE PROCEDURE user_deleter(id INT)
BEGIN
	-- disable foreign key checks as would still like to keep user's posts!
	SET FOREIGN_KEY_CHECKS = 0;

	-- delete the user.
	DELETE FROM users u
	WHERE u.id = id;
    
    DELETE FROM members m
    WHERE m.user_id = id;
    
    -- re-enable foreign key checks.
    SET FOREIGN_KEY_CHECKS = 1;

END//
DELIMITER ;

CALL user_deleter(12);

-- query(2) to view updated records after changes from sprocs.
	-- should only return the record of user id 9
    -- and reflect their new payment ID and membership.
    -- user id 12 is no longer in the DB.
    -- uses ORDER BY.
SELECT *
FROM members m
WHERE m.user_id = 9 OR m.user_id = 12
ORDER BY m.user_id;


-- view the users table again to ensure user id 12 has been deleted.
SELECT *
FROM users u
ORDER BY u.id;



-- view the statuses of each user!
	-- creates a view, followed by a query(3) to set and retrieve user statuses.
    -- uses ORDER BY, LEFT JOIN, aggregate function (COUNT).
CREATE OR REPLACE VIEW vw_user_activity
AS
-- initialise the username column.
SELECT u.username AS 'user', 

-- use case expression to return user statuses.
CASE
	WHEN COUNT(p.user_id) BETWEEN 4 AND 6 THEN 'Nymph'
    WHEN COUNT(p.user_id) BETWEEN 7 AND 11 THEN 'Olympian'
    WHEN COUNT(p.user_id) BETWEEN 12 AND 18 THEN 'Titan'
    WHEN COUNT(p.user_id) >= 19 THEN 'Primordial'
    ELSE 'Hero'
END AS 'status'

FROM users u
LEFT JOIN posts p
ON u.id = p.user_id
GROUP BY u.id
ORDER BY u.id;

-- query(3) to see the view.
	-- uses ORDER BY and second join (INNER JOIN) to return
    -- only matching users.
SELECT u.id, u.username, v.status, m.membership
FROM vw_user_activity v
INNER JOIN users u
ON u.username = v.user
LEFT JOIN members m
ON m.user_id = u.id
ORDER BY u.id;


-- user id 8 would like to delete their most recent post as it seems to be quite controversial.
	-- uses ORDER BY.
DELETE FROM posts p
WHERE user_id = 8
ORDER BY p.posted DESC
LIMIT 1;

-- query(4) to view updated posts from user id 8.
	-- uses ORDER BY.
SELECT *
FROM posts p
WHERE user_id = 8
ORDER BY p.posted DESC;



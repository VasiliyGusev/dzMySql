
# 1. Возможных вариантов улучшения запросов - не представляю.
# 2. Поиск человека, который больше всех общался с нашим пользователем.

SELECT count(*) message, object FROM 
	(SELECT body, to_user_id AS object FROM messages WHERE from_user_id = 18
	 UNION
	 SELECT body,from_user_id AS object FROM messages WHERE to_user_id = 18) as nams

GROUP BY object
ORDER BY message DESC
LIMIT 1
;

# 3. Oбщее количество лайков, которые получили 10 самых молодых пользователей.

SELECT COUNT(id) FROM likes	 WHERE user_id IN (
  SELECT * FROM (
    SELECT id FROM users ORDER BY birthday DESC LIMIT 10
    ) as age
);

# 4. Kто больше поставил лайков (всего) - мужчины или женщины?

SELECT COUNT(*) AS likes, gender FROM likes, profiles
WHERE likes.user_id = profiles.user_id
GROUP BY gender;

# 5. 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT id, SUM(acts) as acts FROM 
	(SELECT id, 0 as acts FROM users
	UNION
	SELECT user_id as id, count(*) as acts FROM media
	GROUP BY user_id
	UNION
	SELECT user_id, COUNT(*) FROM likes
	GROUP BY user_id
	UNION
	SELECT from_user_id, COUNT(*) FROM messages
	GROUP BY from_user_id) AS activ
GROUP BY id
ORDER BY acts
LIMIT 10 
;
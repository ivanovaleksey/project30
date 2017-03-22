```sql
SELECT
   users.email,
   message_stats.cnt AS messages_cnt
FROM users
  INNER JOIN (
    SELECT
      user_id,
      count(1) AS cnt
    FROM messages
    GROUP BY user_id
    ORDER BY cnt desc
    LIMIT 10
  ) AS message_stats
  ON users.id = message_stats.user_id
```

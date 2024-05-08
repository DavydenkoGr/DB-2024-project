SELECT
    name,
    surname,
    phone,
    count(*) AS homework_count
FROM
    ediary.teacher AS teacher
NATURAL JOIN
    ediary.lesson AS lesson
NATURAL JOIN
    ediary.task AS task
WHERE
    type = 1
GROUP BY
    name,
    phone,
    surname
ORDER BY
    homework_count
LIMIT 5;

SELECT
    surname,
    name,
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
    lesson.teacher_id,
    name,
    phone,
    surname
ORDER BY
    homework_count DESC,
    surname,
    name
LIMIT 5;

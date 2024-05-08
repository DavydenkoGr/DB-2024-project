SELECT
    CASE
        WHEN length(description) > 0 THEN
            description
        ELSE
            'Домашнее задание не выставлено'
    END AS homework,
    to_char(schedule, 'HH24:MI') AS lesson_time
FROM
    ediary.task AS task
NATURAL JOIN
    ediary.lesson AS lesson
WHERE
    type = 1 AND
    subject_id = (
        SELECT
            subject_id
        FROM
            ediary.subject AS subject
        WHERE
            name = 'Математика'
    ) AND
    schedule::date = '2024-01-01'
ORDER BY
    schedule;

SELECT
    avg(value) AS average_score
FROM
    ediary.mark AS mark
NATURAL JOIN
    ediary.task AS task
NATURAL JOIN
    ediary.lesson AS lesson
NATURAL JOIN
    ediary.subject AS subject
WHERE
    -- долг не будем считать за оценку
    value != 0 AND
    subject.name = 'Математика' AND
    lesson.class_id IN (
        SELECT
            class_id
        FROM
            ediary.class AS class
        WHERE number = 1
    );

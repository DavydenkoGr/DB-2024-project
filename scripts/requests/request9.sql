WITH
    class_subject_avg AS (
        SELECT
            class_id,
            avg(value) AS average_score
        FROM
            ediary.class AS class
        NATURAL JOIN
            ediary.lesson AS lesson
        NATURAL JOIN
            ediary.subject AS subject
        NATURAL JOIN
            ediary.task AS task
        NATURAL JOIN
            ediary.mark AS mark
        WHERE
            value != 0 AND
            schedule > '2023-12-31' AND
            schedule < '2024-06-01'
        GROUP BY
            class_id,
            subject_id
    )

SELECT
    concat(number, letter) AS class,
    coalesce(avg(average_score), 0) AS average_score
FROM
    ediary.class
LEFT JOIN
    class_subject_avg
    ON class.class_id = class_subject_avg.class_id
GROUP BY
    class
ORDER BY
    average_score DESC;

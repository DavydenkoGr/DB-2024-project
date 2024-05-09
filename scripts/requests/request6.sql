-- считаем, что ученики переходят в следующий класс в 00:00 1 июня
WITH
    year AS (
        SELECT
            student_id,
            number AS current_class,
            CASE
                WHEN extract(MONTH FROM enrollment_date) >= 6 THEN
                    extract(YEAR FROM now()) - extract(YEAR FROM enrollment_date)
                WHEN extract(YEAR FROM now()) - extract(YEAR FROM enrollment_date) > 0 THEN
                    extract(YEAR FROM now()) - extract(YEAR FROM enrollment_date) - 1
                ELSE
                    0
            END AS studied_years
        FROM
            ediary.student
        NATURAL JOIN
            ediary.class
        WHERE
            number > 9
    )

SELECT
    surname,
    name,
    current_class,
    enrollment_date
FROM
    ediary.student
NATURAL JOIN
    year
WHERE
    current_class = 10 AND studied_years = 0 OR
    current_class = 11 AND studied_years = 1
ORDER BY
    surname,
    name;

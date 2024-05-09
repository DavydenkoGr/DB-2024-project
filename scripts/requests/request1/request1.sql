WITH
    a1 AS (
        SELECT
            class_id
        FROM
            ediary.class
        WHERE
            number = '1'
    )

SELECT
    surname,
    name
FROM
    ediary.student AS student
JOIN
    ediary.class_history AS class_history
    ON student.student_id = class_history.student_id
WHERE
    student.class_id IN (SELECT * FROM a1) OR
    class_history.class_id IN (SELECT * FROM a1)
GROUP BY
    student.student_id,
    surname,
    name
ORDER BY
    surname,
    name;

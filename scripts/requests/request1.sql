WITH
    a1 AS (
        SELECT
            class_id
        FROM
            ediary.class
        WHERE
            letter = 'A' AND number = '1'
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
    student.class_id = (SELECT * FROM a1) OR
    class_history.class_id = (SELECT * FROM a1)
GROUP BY
    student.student_id,
    surname,
    name
ORDER BY
    surname,
    name;

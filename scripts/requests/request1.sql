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
    name,
    surname
FROM
    ediary.student AS student
INNER JOIN
    ediary.class_history AS class_history
    ON student.student_id = class_history.student_id
WHERE
    student.class_id = (SELECT * FROM a1) OR
    class_history.class_id = (SELECT * FROM a1);

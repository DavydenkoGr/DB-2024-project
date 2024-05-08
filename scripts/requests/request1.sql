WITH
    a1 as (
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
    ediary.student as student
INNER JOIN
    ediary.class_history as class_history
    ON student.student_id = class_history.student_id
WHERE
    student.class_id = (SELECT * FROM a1) OR
    class_history.class_id = (SELECT * FROM a1);

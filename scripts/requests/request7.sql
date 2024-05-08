WITH
    student_id AS (
        SELECT
            student_id
        FROM
            EDiary.class_history AS class_history
        JOIN
            EDiary.class class1
            ON class_history.class_id = class1.class_id
        JOIN
            EDiary.class class2
            ON class1.number = class2.number AND
               class1.letter <> class2.letter
        WHERE
            start_date BETWEEN '2020-06-01' AND '2021-05-31'
        GROUP BY
            class_history.student_id
        HAVING
            count(DISTINCT class1.letter) = 2
    )

SELECT
    name,
    surname,
    phone
FROM
    ediary.student
JOIN
    student_id
    ON student_id.student_id = student.student_id;

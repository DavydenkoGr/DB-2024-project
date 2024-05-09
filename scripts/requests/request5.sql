SELECT
    concat(number, letter) AS class,
    count(student_id) AS students
FROM
    ediary.class AS class
LEFT JOIN
    ediary.student AS student
    ON class.class_id = student.class_id
GROUP BY
    class.class_id,
    number,
    letter
ORDER BY
    number,
    letter;

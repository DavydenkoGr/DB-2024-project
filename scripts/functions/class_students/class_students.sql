DROP FUNCTION IF EXISTS class_students(INTEGER);

CREATE FUNCTION class_students(class_id INTEGER)
RETURNS TABLE(
    student_id VARCHAR,
    name       VARCHAR,
    surname    VARCHAR,
    phone      VARCHAR
) AS $$
    SELECT
        student_id,
        name,
        surname,
        phone
    FROM
        ediary.student AS student
    JOIN
        ediary.class AS class
        ON class.class_id = student.class_id
    WHERE
        class.class_id = class_students.class_id
$$ LANGUAGE SQL;

WITH
    subject_to_student AS (
        SELECT
            student_id,
            subject_id
        FROM
            ediary.subject
        NATURAL JOIN
            ediary.subject_to_class
        NATURAL JOIN
            ediary.class AS class
        JOIN
            ediary.student AS student
            ON student.class_id = class.class_id
        GROUP BY
            student_id,
            subject_id
    ),
    avg_for_existing AS (
        SELECT
            student_id,
            subject_id,
            avg(value)
        FROM
            ediary.lesson AS lesson
        NATURAL JOIN
            ediary.task AS task
        JOIN
            ediary.mark AS mark
            ON mark.task_id = task.task_id
        WHERE
            value != 0 AND
            schedule BETWEEN '2024-01-01' AND '2024-05-31'
        GROUP BY
            subject_id,
            student_id
    ),
    student_avg AS (
        SELECT
            avg_for_existing.student_id,
            avg(avg_for_existing.avg) AS average_score
        FROM
            subject_to_student
        JOIN
            avg_for_existing
            ON avg_for_existing.subject_id = subject_to_student.subject_id AND
               avg_for_existing.student_id = subject_to_student.student_id
        JOIN
            ediary.subject AS subject
            ON subject_to_student.subject_id = subject.subject_id
        GROUP BY
            avg_for_existing.student_id
    )

SELECT
    surname,
    name,
    coalesce(average_score, 0) AS average_score
FROM
    ediary.student AS student
LEFT JOIN
    student_avg
    ON student_avg.student_id = student.student_id
ORDER BY
    surname,
    name,
    average_score DESC;

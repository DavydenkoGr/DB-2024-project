WITH
    relevant_subject AS (
        SELECT
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
        WHERE
            student_id = 1
    ),
    avg_for_existing AS (
        SELECT
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
            schedule BETWEEN '2024-01-01' AND '2024-05-31' AND
            student_id = 1
        GROUP BY
            subject_id
    )

SELECT
    subject.name,
    coalesce(avg_for_existing.avg, 0) AS avg_score
FROM
    relevant_subject
LEFT JOIN
    avg_for_existing
    ON avg_for_existing.subject_id = relevant_subject.subject_id
JOIN
    ediary.subject AS subject
    ON relevant_subject.subject_id = subject.subject_id

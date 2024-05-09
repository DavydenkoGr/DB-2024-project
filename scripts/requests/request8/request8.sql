SELECT
    subject.name AS subject,
    coalesce(avg(value), 0) AS average_score
FROM
    ediary.class AS class
NATURAL JOIN
    ediary.lesson AS lesson
NATURAL JOIN
    ediary.subject AS subject
LEFT JOIN
    ediary.task AS task
    ON lesson.lesson_id = task.lesson_id
LEFT JOIN
    ediary.mark
    ON task.task_id = mark.task_id
WHERE
    value != 0 AND
    student_id = 1 AND
    schedule > '2023-12-31' AND
    schedule < '2024-06-01'
GROUP BY
    subject_id,
    subject.name
ORDER BY
    subject.name;

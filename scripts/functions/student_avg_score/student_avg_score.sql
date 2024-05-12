DROP FUNCTION IF EXISTS student_avg_score(INTEGER, INTEGER, DATE, DATE);

CREATE FUNCTION student_avg_score(student_id INTEGER,
                                  subject_id INTEGER,
                                  start_date DATE,
                                  end_date DATE)
RETURNS NUMERIC AS $$
    SELECT
        coalesce(avg(value), 0)
    FROM
        ediary.mark AS mark
    JOIN
        ediary.task AS task
        ON mark.task_id = task.task_id
    JOIN
        ediary.lesson AS lesson
        ON task.lesson_id = lesson.lesson_id
    WHERE
        value != 0 AND
        mark.student_id = student_avg_score.student_id AND
        lesson.subject_id = student_avg_score.subject_id AND
        lesson.schedule BETWEEN start_date AND end_date
$$ LANGUAGE SQL;

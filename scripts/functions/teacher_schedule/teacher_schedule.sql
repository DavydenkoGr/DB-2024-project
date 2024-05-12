DROP FUNCTION IF EXISTS teacher_schedule(INTEGER, DATE);

CREATE FUNCTION teacher_schedule(teacher_id INTEGER, date DATE)
RETURNS TABLE (
    lesson_id  INTEGER,
    subject_id INTEGER,
    class_id   INTEGER,
    schedule   TIME
) AS $$
    SELECT
        lesson_id,
        subject_id,
        class_id,
        schedule::time
    FROM
        ediary.lesson AS lesson
    WHERE
        lesson.teacher_id = teacher_schedule.teacher_id AND
        lesson.schedule::date = date
$$ LANGUAGE SQL;

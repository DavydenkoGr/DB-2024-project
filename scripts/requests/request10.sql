SELECT
    concat(number, letter) AS class,
    student.name,
    student.surname,
    description AS task_description,
    schedule::date
FROM
    ediary.student AS student
JOIN
    ediary.mark AS mark ON student.student_id = mark.student_id
JOIN
    ediary.task AS task ON mark.task_id = task.task_id
JOIN
    ediary.lesson AS lesson ON task.lesson_id = lesson.lesson_id
JOIN
    ediary.teacher AS teacher ON lesson.teacher_id = teacher.teacher_id
JOIN
    ediary.class AS class ON student.class_id = class.class_id
WHERE
    value = 0 AND
    lesson.teacher_id = 8;

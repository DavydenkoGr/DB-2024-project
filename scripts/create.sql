CREATE SCHEMA IF NOT EXISTS EDiary;

CREATE TABLE EDiary.class (
    class_id SERIAL PRIMARY KEY,
    number   INTEGER CHECK (number >= 0 AND number <= 11),
    letter   CHAR NOT NULL,
    CONSTRAINT unique_number_letter UNIQUE (number, letter)
);

CREATE TABLE EDiary.student (
    student_id      SERIAL PRIMARY KEY,
    class_id        INTEGER      NOT NULL,
    name            VARCHAR(128) NOT NULL,
    surname         VARCHAR(128) NOT NULL,
    phone           VARCHAR CHECK (phone LIKE '+7 (___) ___-__-__') UNIQUE,
    hashed_password VARCHAR      NOT NULL,
    enrollment_date DATE         NOT NULL DEFAULT now(),
    FOREIGN KEY (class_id) REFERENCES EDiary.class (class_id)
);

CREATE TABLE EDiary.teacher (
    teacher_id      SERIAL PRIMARY KEY,
    name            VARCHAR(128) NOT NULL,
    surname         VARCHAR(128) NOT NULL,
    phone           VARCHAR CHECK (phone LIKE '+7 (___) ___-__-__') UNIQUE,
    hashed_password VARCHAR      NOT NULL
);

CREATE TABLE EDiary.subject (
    subject_id SERIAL PRIMARY KEY,
    name       VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE EDiary.lesson (
    lesson_id  SERIAL PRIMARY KEY,
    class_id   INTEGER   NOT NULL,
    teacher_id INTEGER   NOT NULL,
    subject_id INTEGER   NOT NULL,
    schedule   TIMESTAMP NOT NULL,
    FOREIGN KEY (class_id) REFERENCES EDiary.class (class_id),
    FOREIGN KEY (teacher_id) REFERENCES EDiary.teacher (teacher_id),
    FOREIGN KEY (subject_id) REFERENCES EDiary.subject (subject_id),
    CONSTRAINT one_lesson_at_time UNIQUE (class_id, schedule),
    CONSTRAINT teacher_time_conflict UNIQUE (teacher_id, schedule)
);

CREATE TABLE EDiary.task (
    task_id     SERIAL PRIMARY KEY,
    lesson_id   INTEGER NOT NULL,
    type        INTEGER CHECK (type IN (0, 1)),
    description VARCHAR(2000),
    FOREIGN KEY (lesson_id) REFERENCES EDiary.lesson (lesson_id)
);

CREATE TABLE EDiary.mark (
    mark_id    SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    task_id    INTEGER NOT NULL,
    value      INTEGER CHECK (value IN (0, 1, 2, 3, 4, 5)),
    FOREIGN KEY (student_id) REFERENCES EDiary.student (student_id),
    FOREIGN KEY (task_id) REFERENCES EDiary.task (task_id)
);

CREATE TABLE EDiary.class_history (
    student_id INTEGER NOT NULL,
    class_id   INTEGER NOT NULL,
    start_date DATE    NOT NULL,
    end_date   DATE    NOT NULL DEFAULT now() CHECK (end_date >= start_date),
    FOREIGN KEY (student_id) REFERENCES EDiary.student (student_id),
    FOREIGN KEY (class_id) REFERENCES EDiary.class (class_id),
    PRIMARY KEY (student_id, class_id, start_date)
);


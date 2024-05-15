DROP TRIGGER IF EXISTS empty_classwork_trigger ON ediary.lesson;
DROP FUNCTION IF EXISTS empty_classwork();

CREATE FUNCTION empty_classwork()
RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO ediary.task (lesson_id, type, description)
        VALUES (NEW.lesson_id, 0, NULL);

        RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER empty_classwork_trigger
    AFTER INSERT ON ediary.lesson
    FOR EACH ROW
    EXECUTE FUNCTION empty_classwork();

DROP TRIGGER IF EXISTS class_history_update_trigger ON ediary.student;
DROP FUNCTION IF EXISTS class_history_update();

CREATE FUNCTION class_history_update()
RETURNS TRIGGER AS $$
    DECLARE previous_date DATE = (
        SELECT
            coalesce(max(end_date), now()::DATE - INTERVAL '1 year')
        FROM
            ediary.class_history
        WHERE
            NEW.student_id = class_history.student_id
    );

    BEGIN
        INSERT INTO ediary.class_history (student_id, class_id, start_date, end_date)
        VALUES (NEW.student_id, OLD.class_id, previous_date, now()::DATE);

        RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER class_history_update_trigger
    AFTER UPDATE ON ediary.student
    FOR EACH ROW
    WHEN (NEW.class_id != OLD.class_id)
    EXECUTE FUNCTION class_history_update();

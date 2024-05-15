DROP TRIGGER IF EXISTS class_history_consistency_trigger ON ediary.class_history;
DROP FUNCTION IF EXISTS class_history_consistency();

CREATE FUNCTION class_history_consistency()
RETURNS TRIGGER AS $$
    DECLARE count INTEGER = (
        SELECT
            count(*)
        FROM
            ediary.class_history
        WHERE
            NEW.start_date < class_history.end_date AND
            NEW.end_date > class_history.start_date
    );

    BEGIN
        IF count > 0 THEN
            RETURN NULL;
        END IF;

        RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER class_history_consistency_trigger
    BEFORE UPDATE OR INSERT ON ediary.class_history
    FOR EACH ROW
    EXECUTE FUNCTION class_history_consistency();

-- користувацьикй тип 
CREATE TYPE payment_status AS ENUM ('pending', 'completed', 'failed');

ALTER TABLE payments 
ALTER COLUMN status TYPE payment_status 
USING status::payment_status;

--функція
CREATE FUNCTION total_payments_analysis(user_id_param INT) 
RETURNS TABLE (
    total_amount DECIMAL, 
    completed_amount DECIMAL, 
    pending_amount DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(SUM(amount), 0) AS total_amount,
        COALESCE(SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END), 0) AS completed_amount,
        COALESCE(SUM(CASE WHEN status = 'pending' THEN amount ELSE 0 END), 0) AS pending_amount
    FROM payments
    WHERE user_id = user_id_param;
END;
$$ LANGUAGE plpgsql;

-- логування
CREATE TABLE payment_log (
    log_id SERIAL PRIMARY KEY,
    payment_id INT,
    operation VARCHAR(10),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_payment_changes() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO payment_log (payment_id, operation)
    VALUES (NEW.id, TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER track_payment_changes
AFTER INSERT OR UPDATE OR DELETE ON payments
FOR EACH ROW
EXECUTE FUNCTION log_payment_changes();

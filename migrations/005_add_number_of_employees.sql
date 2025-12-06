-- Add number_of_employees column to coaches table
-- Stored as VARCHAR to support ranges like "1-5", "6-10", "500+", etc.
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS number_of_employees VARCHAR(20);

-- Add comment to the column
COMMENT ON COLUMN coaches.number_of_employees IS 'Number of employees/staff at the coaching institute (stored as range, e.g., "1-5", "6-10", "500+")';


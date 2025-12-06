-- Add subcategories column to coaches table
-- This allows storing multiple subcategories as an array

-- Add subcategories column (array of strings)
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS subcategories TEXT[];

-- Add comment to the column
COMMENT ON COLUMN coaches.subcategories IS 'Array of subcategories selected for this listing';

-- Create index for better query performance (GIN index for array searches)
CREATE INDEX IF NOT EXISTS idx_coaches_subcategories ON coaches USING GIN(subcategories);


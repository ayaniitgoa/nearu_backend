-- Add google_maps_link column to coaches table
-- This stores the validated Google Maps link for the location

-- Add google_maps_link column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS google_maps_link TEXT;

-- Add comment to the column
COMMENT ON COLUMN coaches.google_maps_link IS 'Validated Google Maps link for the location';


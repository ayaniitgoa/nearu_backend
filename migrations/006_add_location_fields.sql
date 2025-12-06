-- Add location and contact fields to coaches table
-- This migration adds pincode, nearby_landmark, state, country, phone, email, and website

-- Add pincode column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS pincode VARCHAR(20);

-- Add nearby landmark column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS nearby_landmark VARCHAR(255);

-- Add state column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS state VARCHAR(100);

-- Add country column (store country code)
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS country VARCHAR(10);

-- Add phone column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS phone VARCHAR(20);

-- Add email column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS email VARCHAR(255);

-- Add website column
ALTER TABLE coaches 
ADD COLUMN IF NOT EXISTS website VARCHAR(255);

-- Add comments to columns
COMMENT ON COLUMN coaches.pincode IS 'Postal/ZIP code';
COMMENT ON COLUMN coaches.nearby_landmark IS 'Nearby landmark for easier location identification';
COMMENT ON COLUMN coaches.state IS 'State or province name';
COMMENT ON COLUMN coaches.country IS 'Country code (ISO 3166-1 alpha-2)';
COMMENT ON COLUMN coaches.phone IS 'Contact phone number';
COMMENT ON COLUMN coaches.email IS 'Contact email address';
COMMENT ON COLUMN coaches.website IS 'Website URL';

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_coaches_state ON coaches(state);
CREATE INDEX IF NOT EXISTS idx_coaches_country ON coaches(country);
CREATE INDEX IF NOT EXISTS idx_coaches_pincode ON coaches(pincode);


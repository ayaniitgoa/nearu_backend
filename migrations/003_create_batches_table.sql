-- Add batches table for coaching centers
-- Each coaching center can have multiple batches with different pricing

CREATE TABLE IF NOT EXISTS batches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  cost DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for better query performance
CREATE INDEX IF NOT EXISTS idx_batches_coach ON batches(coach_id);

-- Create updated_at trigger function for batches
CREATE OR REPLACE FUNCTION update_batches_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for batches
CREATE TRIGGER update_batches_updated_at
    BEFORE UPDATE ON batches
    FOR EACH ROW
    EXECUTE FUNCTION update_batches_updated_at();

-- Row Level Security for batches
ALTER TABLE batches ENABLE ROW LEVEL SECURITY;

-- Public can view batches for approved coaches
CREATE POLICY "Public can view batches for approved coaches"
  ON batches FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM coaches 
      WHERE coaches.id = batches.coach_id 
      AND coaches.is_approved = true
    )
  );

-- Owners can manage batches for their coaches
CREATE POLICY "Owners can insert batches for their coaches"
  ON batches FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM coaches 
      WHERE coaches.id = batches.coach_id 
      AND coaches.owner_id = auth.uid()
    )
  );

CREATE POLICY "Owners can update batches for their coaches"
  ON batches FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM coaches 
      WHERE coaches.id = batches.coach_id 
      AND coaches.owner_id = auth.uid()
    )
  );

CREATE POLICY "Owners can delete batches for their coaches"
  ON batches FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM coaches 
      WHERE coaches.id = batches.coach_id 
      AND coaches.owner_id = auth.uid()
    )
  );


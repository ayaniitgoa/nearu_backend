-- SkillBridge Database Schema Migration
-- Run this SQL in your Supabase SQL Editor to create all required tables

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Coaches table
CREATE TABLE IF NOT EXISTS coaches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  category VARCHAR(100) NOT NULL,
  description TEXT,
  timing VARCHAR(255),
  fees DECIMAL(10, 2),
  address TEXT,
  images TEXT[], -- Array of image URLs
  is_approved BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enquiries table
CREATE TABLE IF NOT EXISTS enquiries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  message TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Reviews table
CREATE TABLE IF NOT EXISTS reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  text TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_coaches_city ON coaches(city);
CREATE INDEX IF NOT EXISTS idx_coaches_category ON coaches(category);
CREATE INDEX IF NOT EXISTS idx_coaches_owner ON coaches(owner_id);
CREATE INDEX IF NOT EXISTS idx_coaches_approved ON coaches(is_approved);
CREATE INDEX IF NOT EXISTS idx_enquiries_coach ON enquiries(coach_id);
CREATE INDEX IF NOT EXISTS idx_reviews_coach ON reviews(coach_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for updated_at
CREATE TRIGGER update_coaches_updated_at BEFORE UPDATE ON coaches
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE coaches ENABLE ROW LEVEL SECURITY;
ALTER TABLE enquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- Coaches policies
-- Anyone can view approved coaches
CREATE POLICY "Anyone can view approved coaches"
  ON coaches FOR SELECT
  USING (is_approved = true);

-- Coaches owners can view their own coaches (approved or not)
CREATE POLICY "Owners can view their own coaches"
  ON coaches FOR SELECT
  USING (auth.uid() = owner_id);

-- Coaches owners can insert their own coaches
CREATE POLICY "Owners can insert their own coaches"
  ON coaches FOR INSERT
  WITH CHECK (auth.uid() = owner_id);

-- Coaches owners can update their own coaches
CREATE POLICY "Owners can update their own coaches"
  ON coaches FOR UPDATE
  USING (auth.uid() = owner_id);

-- Coaches owners can delete their own coaches
CREATE POLICY "Owners can delete their own coaches"
  ON coaches FOR DELETE
  USING (auth.uid() = owner_id);

-- Admins can update any coach (for approval)
CREATE POLICY "Admins can update any coach"
  ON coaches FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM auth.users
      WHERE auth.users.id = auth.uid()
      AND auth.users.raw_user_meta_data->>'role' = 'admin'
    )
  );

-- Enquiries policies
-- Anyone can create an enquiry
CREATE POLICY "Anyone can create enquiries"
  ON enquiries FOR INSERT
  WITH CHECK (true);

-- Coaches owners can view enquiries for their coaches
CREATE POLICY "Owners can view enquiries for their coaches"
  ON enquiries FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM coaches
      WHERE coaches.id = enquiries.coach_id
      AND coaches.owner_id = auth.uid()
    )
  );

-- Reviews policies
-- Anyone can view reviews
CREATE POLICY "Anyone can view reviews"
  ON reviews FOR SELECT
  USING (true);

-- Anyone can create reviews
CREATE POLICY "Anyone can create reviews"
  ON reviews FOR INSERT
  WITH CHECK (true);

-- Users can update their own reviews (optional - if you want to allow editing)
-- CREATE POLICY "Users can update their own reviews"
--   ON reviews FOR UPDATE
--   USING (auth.uid() = user_id);

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON coaches TO anon, authenticated;
GRANT ALL ON enquiries TO anon, authenticated;
GRANT ALL ON reviews TO anon, authenticated;


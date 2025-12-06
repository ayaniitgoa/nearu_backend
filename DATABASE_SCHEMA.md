# Supabase Database Schema

This document describes the database schema for SkillBridge MVP 1.

## Tables

### coaches

Stores coaching center listings.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY, DEFAULT uuid_generate_v4() | Unique identifier |
| owner_id | uuid | NOT NULL, FOREIGN KEY (auth.users) | Owner user ID from Supabase Auth |
| name | text | NOT NULL | Coaching center name |
| city | text | NOT NULL | City where coaching is located |
| category | text | NOT NULL | Category (Tuition, Dance, Sports, etc.) |
| description | text | NULL | Description of the coaching center |
| timing | text | NULL | Class timings |
| fees | numeric | NULL | Monthly fees |
| address | text | NULL | Full address |
| images | text[] | NULL | Array of image URLs |
| is_approved | boolean | NOT NULL, DEFAULT false | Approval status for admin |
| created_at | timestamp | NOT NULL, DEFAULT now() | Creation timestamp |
| updated_at | timestamp | NULL | Last update timestamp |

**Indexes:**
- `idx_coaches_city` on `city`
- `idx_coaches_category` on `category`
- `idx_coaches_owner` on `owner_id`
- `idx_coaches_approved` on `is_approved`

**Row Level Security (RLS):**
- Public can SELECT only approved coaches
- Owners can INSERT/UPDATE/DELETE their own coaches
- Admins can UPDATE approval status

### enquiries

Stores user enquiries for coaching centers.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY, DEFAULT uuid_generate_v4() | Unique identifier |
| coach_id | uuid | NOT NULL, FOREIGN KEY (coaches.id) | Coaching center ID |
| name | text | NOT NULL | Enquirer's name |
| phone | text | NOT NULL | Enquirer's phone number |
| message | text | NULL | Optional message |
| created_at | timestamp | NOT NULL, DEFAULT now() | Creation timestamp |

**Indexes:**
- `idx_enquiries_coach` on `coach_id`
- `idx_enquiries_created` on `created_at`

**Row Level Security (RLS):**
- Public can INSERT enquiries
- Owners can SELECT enquiries for their coaches
- Admins can SELECT all enquiries

### reviews

Stores user reviews and ratings for coaching centers.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PRIMARY KEY, DEFAULT uuid_generate_v4() | Unique identifier |
| coach_id | uuid | NOT NULL, FOREIGN KEY (coaches.id) | Coaching center ID |
| rating | integer | NOT NULL, CHECK (rating >= 1 AND rating <= 5) | Star rating (1-5) |
| text | text | NULL | Review text |
| user_name | text | NULL | Reviewer's name (optional) |
| user_photo | text | NULL | Reviewer's photo URL (optional) |
| created_at | timestamp | NOT NULL, DEFAULT now() | Creation timestamp |

**Indexes:**
- `idx_reviews_coach` on `coach_id`
- `idx_reviews_created` on `created_at`

**Row Level Security (RLS):**
- Public can SELECT and INSERT reviews
- Owners can SELECT reviews for their coaches
- Admins can SELECT/DELETE all reviews

## SQL Setup Script

Run this in your Supabase SQL Editor:

```sql
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create coaches table
CREATE TABLE coaches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  city TEXT NOT NULL,
  category TEXT NOT NULL,
  description TEXT,
  timing TEXT,
  fees NUMERIC,
  address TEXT,
  images TEXT[],
  is_approved BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE
);

-- Create enquiries table
CREATE TABLE enquiries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  message TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create reviews table
CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  text TEXT,
  user_name TEXT,
  user_photo TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create indexes
CREATE INDEX idx_coaches_city ON coaches(city);
CREATE INDEX idx_coaches_category ON coaches(category);
CREATE INDEX idx_coaches_owner ON coaches(owner_id);
CREATE INDEX idx_coaches_approved ON coaches(is_approved);
CREATE INDEX idx_enquiries_coach ON enquiries(coach_id);
CREATE INDEX idx_enquiries_created ON enquiries(created_at);
CREATE INDEX idx_reviews_coach ON reviews(coach_id);
CREATE INDEX idx_reviews_created ON reviews(created_at);

-- Enable Row Level Security
ALTER TABLE coaches ENABLE ROW LEVEL SECURITY;
ALTER TABLE enquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- RLS Policies for coaches
-- Public can view approved coaches
CREATE POLICY "Public can view approved coaches"
  ON coaches FOR SELECT
  USING (is_approved = true);

-- Owners can manage their own coaches
CREATE POLICY "Owners can insert their coaches"
  ON coaches FOR INSERT
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update their coaches"
  ON coaches FOR UPDATE
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can delete their coaches"
  ON coaches FOR DELETE
  USING (auth.uid() = owner_id);

-- RLS Policies for enquiries
-- Public can create enquiries
CREATE POLICY "Public can create enquiries"
  ON enquiries FOR INSERT
  WITH CHECK (true);

-- Owners can view enquiries for their coaches
CREATE POLICY "Owners can view their enquiries"
  ON enquiries FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM coaches
      WHERE coaches.id = enquiries.coach_id
      AND coaches.owner_id = auth.uid()
    )
  );

-- RLS Policies for reviews
-- Public can view and create reviews
CREATE POLICY "Public can view reviews"
  ON reviews FOR SELECT
  USING (true);

CREATE POLICY "Public can create reviews"
  ON reviews FOR INSERT
  WITH CHECK (true);
```

## Notes

- All tables use UUIDs for primary keys
- Foreign keys use CASCADE delete to maintain referential integrity
- Timestamps are stored with timezone information
- RLS policies ensure data security and proper access control
- Indexes are created on frequently queried columns for performance



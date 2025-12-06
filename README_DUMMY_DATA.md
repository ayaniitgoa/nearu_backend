# Inserting Dummy Data

This guide explains how to insert dummy data into your Supabase database.

## Option 1: Using SQL Editor (Recommended - No Service Role Key Needed)

1. **Get a User ID** (required for `owner_id`):
   - Go to your Supabase Dashboard
   - Navigate to **Authentication** → **Users**
   - If you don't have any users, create one:
     - Click **"Add user"** → **"Create new user"**
     - Enter an email and password
     - Make sure to set `user_type` to `'institution'` in the user metadata
   - Copy the user's UUID (the ID column)

2. **Run the SQL Script**:
   - Go to **SQL Editor** in your Supabase Dashboard
   - Click **"New query"**
   - Open `backend/migrations/002_insert_dummy_data.sql`
   - Copy and paste the entire SQL script
   - The script will automatically use the first user from your auth.users table
   - Click **"Run"** (or press `Ctrl+Enter`)

3. **Verify the Data**:
   - Go to **Table Editor** → **coaches** table
   - You should see 12 coaches inserted
   - Go to **reviews** table
   - You should see reviews for each coach

## Option 2: Using Node.js Script (Requires Service Role Key)

If you have a service role key, you can use the Node.js script:

1. **Add Service Role Key to `.env`**:
   ```env
   SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
   ```
   You can find this in: Supabase Dashboard → Project Settings → API → `service_role` key

2. **Run the script**:
   ```bash
   cd backend
   npm run seed
   ```

## What Data Will Be Inserted?

- **12 Coaches** across 6 cities:
  - Mumbai: 3 coaches (Tuition, Dance, Sports)
  - Delhi: 2 coaches (Music, Yoga)
  - Bangalore: 2 coaches (Art, Fitness)
  - Hyderabad: 2 coaches (Language, Sports)
  - Pune: 2 coaches (Cooking, Singing)
  - Chennai: 1 coach (Hobby)

- **Reviews**: 2-4 reviews per coach (30-40 total reviews)

## Troubleshooting

- **"No users found" error**: Create a user first via Authentication → Users
- **RLS Policy errors**: Make sure your RLS policies allow inserts (check `backend/migrations/001_create_tables.sql`)
- **Duplicate key errors**: The script may have already run. Clear the tables first if needed.

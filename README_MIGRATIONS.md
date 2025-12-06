# Database Migrations Guide

## Option 1: Using Supabase SQL Editor (Recommended)

This is the easiest and most reliable method:

1. **Go to your Supabase Dashboard**: https://app.supabase.com
2. **Select your project**
3. **Navigate to**: SQL Editor (in the left sidebar)
4. **Click**: "New query"
5. **Copy and paste** the contents of `migrations/001_create_tables.sql`
6. **Click**: "Run" (or press Ctrl+Enter)

That's it! All tables, indexes, and RLS policies will be created.

## Option 2: Using the Migration Script

The script `scripts/create-tables.js` attempts to create tables programmatically, but Supabase's REST API has limitations for DDL operations.

**Note**: Supabase doesn't support executing arbitrary SQL through the REST API for security reasons. The SQL Editor method (Option 1) is recommended.

## What Gets Created

The migration creates:

1. **Tables**:
   - `coaches` - Coaching listings
   - `enquiries` - User enquiries for coaches
   - `reviews` - Reviews/ratings for coaches

2. **Indexes**: For better query performance on frequently queried columns

3. **Row Level Security (RLS) Policies**: 
   - Public can view approved coaches
   - Owners can manage their own coaches
   - Anyone can create enquiries and reviews
   - Owners can view enquiries for their coaches

4. **Triggers**: Auto-update `updated_at` timestamp

## Verifying Tables Were Created

After running the migration:

1. Go to **Table Editor** in Supabase Dashboard
2. You should see: `coaches`, `enquiries`, and `reviews` tables
3. Check the **Authentication** > **Policies** section to verify RLS policies

## Troubleshooting

### Error: "relation already exists"
- Tables already exist. You can either:
  - Drop existing tables and re-run migration
  - Or modify the SQL to use `CREATE TABLE IF NOT EXISTS` (already included)

### Error: "permission denied"
- Make sure you're using the SQL Editor (not REST API)
- Check that you're logged into the correct Supabase project

### Need to Reset Everything
```sql
-- WARNING: This will delete all data!
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS enquiries CASCADE;
DROP TABLE IF EXISTS coaches CASCADE;
```
Then re-run the migration.

## Next Steps

After creating tables:
1. Test the connection: `GET /api/test-db` on your backend
2. Try creating a coach listing through your dashboard
3. Verify RLS policies are working correctly


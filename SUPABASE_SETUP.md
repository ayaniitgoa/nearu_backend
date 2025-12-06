# Supabase Setup Guide

To connect your backend to Supabase, you need to add the following environment variables to your `.env` file.

## Required Environment Variables

Create a `.env` file in the `backend` folder with the following variables:

```env
PORT=5000
NODE_ENV=development

# Supabase Configuration
SUPABASE_URL=your-project-url
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

## How to Get Your Supabase Credentials

1. **Go to your Supabase project dashboard**: https://app.supabase.com
2. **Navigate to Project Settings** → **API**
3. **Copy the following values**:
   - **Project URL** → This is your `SUPABASE_URL`
   - **anon/public key** → This is your `SUPABASE_ANON_KEY`
   - **service_role key** → This is your `SUPABASE_SERVICE_ROLE_KEY` (keep this secret!)

## Example .env file:

```env
PORT=5000
NODE_ENV=development

SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh4eHh4eHh4eHh4eHh4eHh4eHgiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTY0NTk5OTk5OSwiZXhwIjoxOTYxNTc1OTk5fQ.example
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh4eHh4eHh4eHh4eHh4eHh4eHgiLCJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNjQ1OTk5OTk5LCJleHAiOjE5NjE1NzU5OTl9.example
```

## Important Notes

- **SUPABASE_ANON_KEY**: Safe to use in client-side code (with Row Level Security policies)
- **SUPABASE_SERVICE_ROLE_KEY**: ⚠️ **NEVER expose this in client-side code**. It bypasses Row Level Security and has admin privileges. Only use it in server-side code.
- Make sure your `.env` file is in `.gitignore` (it already is) to keep your credentials secure.

## Testing the Connection

After setting up your `.env` file, you can test the connection by:

1. Starting your server: `npm run dev`
2. Visiting: `http://localhost:5000/api/test-db`

This will verify that your Supabase connection is working correctly.



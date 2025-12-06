# Environment Variables Setup

## Required Environment Variables

Create a `.env` file in the `backend` directory with the following variables:

```env
# Your Supabase project URL
SUPABASE_URL=https://your-project-id.supabase.co

# Your Supabase anonymous/public key
SUPABASE_ANON_KEY=your-anon-key-here

# Your Supabase service role key (for admin operations)
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
```

## How to Get Your Keys

1. Go to your Supabase Dashboard: https://app.supabase.com
2. Select your project
3. Go to **Settings** → **API**
4. Copy the following:
   - **Project URL** → `SUPABASE_URL`
   - **anon/public key** → `SUPABASE_ANON_KEY`
   - **service_role key** → `SUPABASE_SERVICE_ROLE_KEY` (⚠️ Keep this secret!)

## Security Notes

- ✅ `.env` is already in `.gitignore` - your keys will NOT be pushed to GitHub
- ⚠️ Never commit `.env` or any file containing actual keys
- 🔒 The service role key has admin access - keep it secure

## For Production Deployment

When deploying to production, add these environment variables in your hosting platform's dashboard or use a secrets management service.


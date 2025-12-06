const { createClient } = require('@supabase/supabase-js');

// Initialize Supabase client
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('⚠️  Missing Supabase environment variables.');
  console.error('Please create a .env file in the backend folder with:');
  console.error('SUPABASE_URL=your-project-url');
  console.error('SUPABASE_ANON_KEY=your-anon-key');
  // Don't throw error immediately - allow script to handle it
}

// Client for regular operations (uses anon key)
const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Admin client for server-side operations (uses service role key)
// Only use this for operations that require elevated permissions
const supabaseAdmin = supabaseServiceRoleKey
  ? createClient(supabaseUrl, supabaseServiceRoleKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false
      }
    })
  : null;

module.exports = {
  supabase,
  supabaseAdmin
};



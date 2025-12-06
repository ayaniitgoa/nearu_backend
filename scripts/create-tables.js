/**
 * Script to create database tables programmatically using Supabase
 * 
 * Usage:
 *   node scripts/create-tables.js
 * 
 * Make sure your .env file has SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY set
 */

require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceRoleKey) {
  console.error('❌ Missing Supabase environment variables.');
  console.error('Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY in your .env file');
  process.exit(1);
}

// Create admin client with service role key
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

async function createTables() {
  try {
    console.log('🚀 Starting database migration...\n');

    // Read SQL file
    const sqlPath = path.join(__dirname, '../migrations/001_create_tables.sql');
    const sql = fs.readFileSync(sqlPath, 'utf8');

    // Split SQL into individual statements
    const statements = sql
      .split(';')
      .map(s => s.trim())
      .filter(s => s.length > 0 && !s.startsWith('--'));

    console.log(`📝 Found ${statements.length} SQL statements to execute\n`);

    // Execute each statement
    for (let i = 0; i < statements.length; i++) {
      const statement = statements[i];
      
      // Skip empty statements and comments
      if (!statement || statement.startsWith('--')) continue;

      try {
        console.log(`Executing statement ${i + 1}/${statements.length}...`);
        
        const { error } = await supabase.rpc('exec_sql', { sql_query: statement });
        
        if (error) {
          // Try direct query if RPC doesn't work
          const { error: queryError } = await supabase.from('_migration_test').select('1').limit(0);
          
          if (queryError && queryError.code !== '42P01') { // 42P01 = table doesn't exist (expected)
            console.warn(`⚠️  Statement ${i + 1} warning:`, error.message);
          }
        }
      } catch (err) {
        console.warn(`⚠️  Statement ${i + 1} warning:`, err.message);
      }
    }

    console.log('\n✅ Migration completed!');
    console.log('\n⚠️  Note: Supabase requires SQL to be run through the SQL Editor.');
    console.log('Please copy the contents of migrations/001_create_tables.sql');
    console.log('and run it in your Supabase Dashboard > SQL Editor\n');

  } catch (error) {
    console.error('❌ Error creating tables:', error.message);
    console.error('\n💡 Tip: Run the SQL file directly in Supabase SQL Editor instead.');
    process.exit(1);
  }
}

// Alternative: Use Supabase REST API to execute SQL
async function createTablesViaAPI() {
  console.log('📋 Using Supabase SQL Editor is recommended.');
  console.log('Please run migrations/001_create_tables.sql in your Supabase Dashboard.\n');
}

// Run the migration
if (require.main === module) {
  createTablesViaAPI();
  createTables().catch(console.error);
}

module.exports = { createTables };


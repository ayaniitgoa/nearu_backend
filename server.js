const express = require('express');
const cors = require('cors');
require('dotenv').config();
const { supabase } = require('./config/supabase');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to SkillBridge API' });
});

app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Example route using Supabase
app.get('/api/test-db', async (req, res) => {
  try {
    // Test Supabase client initialization
    const isConfigured = !!(process.env.SUPABASE_URL && process.env.SUPABASE_ANON_KEY);
    
    if (!isConfigured) {
      return res.status(500).json({ 
        error: 'Supabase not configured', 
        message: 'Please set SUPABASE_URL and SUPABASE_ANON_KEY in your .env file' 
      });
    }
    
    res.json({ 
      status: 'Supabase client initialized successfully',
      supabaseUrl: process.env.SUPABASE_URL,
      timestamp: new Date().toISOString()
    });
  } catch (err) {
    res.status(500).json({ 
      error: 'Supabase connection error', 
      message: err.message 
    });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});


# SkillBridge Backend

Backend API server built with Express and Node.js, integrated with Supabase.

## Getting Started

First, install the dependencies:

```bash
npm install
```

Create a `.env` file in the `backend` folder. See `SUPABASE_SETUP.md` for detailed instructions on getting your Supabase credentials.

Required environment variables:
- `PORT` - Server port (default: 5000)
- `NODE_ENV` - Environment (development/production)
- `SUPABASE_URL` - Your Supabase project URL
- `SUPABASE_ANON_KEY` - Your Supabase anonymous key
- `SUPABASE_SERVICE_ROLE_KEY` - Your Supabase service role key (optional but recommended)

Then, run the development server:

```bash
npm run dev
```

The server will start on port 5000 (or the port specified in your `.env` file).

## API Endpoints

- `GET /` - Welcome message
- `GET /api/health` - Health check endpoint
- `GET /api/test-db` - Test Supabase database connection

## Scripts

- `npm start` - Start the production server
- `npm run dev` - Start the development server with nodemon

## Supabase Integration

The backend is configured to use Supabase for database operations. See `SUPABASE_SETUP.md` for setup instructions.


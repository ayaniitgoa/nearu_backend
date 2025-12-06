# Batches System

The batches system allows institutions to offer multiple pricing options (batches) for their coaching centers.

## Database Setup

1. **Create the batches table**: Run the migration file to create the batches table:
   ```sql
   -- Run this in Supabase SQL Editor
   -- File: backend/migrations/003_create_batches_table.sql
   ```

2. **Add dummy batch data (optional)**: To test the batches feature:
   ```sql
   -- Run this in Supabase SQL Editor
   -- File: backend/migrations/004_insert_dummy_batches.sql
   ```
   
   This will add:
   - **Single batches** to: Elite Maths Academy, Music Masters Institute
   - **Multiple batches** to: Dance Studio Pro, Cricket Champions Academy, Yoga Wellness Center, Fitness Zone Gym
   - Other coaches will continue using the old `fees` field (backward compatibility)

## Batch Structure

Each batch has:
- `id`: UUID (auto-generated)
- `coach_id`: UUID (references coaches table)
- `name`: VARCHAR(255) - Batch name (e.g., "Morning Batch", "Weekend Batch")
- `description`: TEXT - Optional description of the batch
- `cost`: DECIMAL(10, 2) - Monthly cost for this batch
- `created_at`: Timestamp
- `updated_at`: Timestamp

## How It Works

### Single Batch
- If a coach has only **one batch**, it displays like the old fees system:
  - Shows the batch cost in the header
  - Shows a simple "Fees" card with the batch name and cost

### Multiple Batches
- If a coach has **multiple batches**, the UI changes:
  - Header shows "Starting from ₹{lowest_cost}/month"
  - A dedicated "Available Batches" section lists all batches with:
    - Batch name
    - Batch description (if available)
    - Batch cost

### Fallback to Old System
- If a coach has **no batches** but has the old `fees` field, it will display the fees as before
- This ensures backward compatibility

## Frontend Usage

### Getting Batches
Batches are automatically included when fetching coaches:

```javascript
import { coachService } from '@/services/coachService';

// Batches are included in the coach object
const coach = await coachService.getCoachById(coachId);
console.log(coach.batches); // Array of batches
```

### Batch Service
For managing batches directly:

```javascript
import { batchService } from '@/services/batchService';

// Get batches for a coach
const batches = await batchService.getBatchesByCoach(coachId);

// Create a batch
const newBatch = await batchService.createBatch({
  coach_id: coachId,
  name: 'Morning Batch',
  description: 'Classes from 8 AM to 10 AM',
  cost: 2500
});

// Update a batch
await batchService.updateBatch(batchId, { cost: 3000 });

// Delete a batch
await batchService.deleteBatch(batchId);
```

## UI Display Logic

The frontend automatically handles:
1. **Single batch**: Shows it simply like the old fees
2. **Multiple batches**: Shows a dedicated batches section
3. **No batches but has fees**: Falls back to showing fees
4. **Home page cards**: Shows single batch cost or "From ₹X" for multiple batches

## Migration Notes

- The old `fees` field in the `coaches` table is still available for backward compatibility
- New coaches should use batches instead of the `fees` field
- Existing coaches with `fees` will continue to work


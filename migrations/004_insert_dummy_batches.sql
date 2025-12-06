-- ============================================
-- Insert Dummy Batches for Testing
-- ============================================
-- 
-- This script adds batches to existing coaches
-- Some coaches will have single batches, others will have multiple batches
-- ============================================

DO $$
DECLARE
  v_coach_id UUID;
BEGIN
  -- Get coaches that exist
  -- We'll add batches to some coaches to demonstrate both single and multiple batch scenarios
  
  -- Coach 1: Single batch (Elite Maths Academy)
  SELECT id INTO v_coach_id FROM coaches WHERE name = 'Elite Maths Academy' LIMIT 1;
  IF v_coach_id IS NOT NULL THEN
    INSERT INTO batches (coach_id, name, description, cost) VALUES
    (v_coach_id, 'Regular Batch', 'Standard classes for all students', 2500);
  END IF;

  -- Coach 2: Multiple batches (Dance Studio Pro)
  SELECT id INTO v_coach_id FROM coaches WHERE name = 'Dance Studio Pro' LIMIT 1;
  IF v_coach_id IS NOT NULL THEN
    INSERT INTO batches (coach_id, name, description, cost) VALUES
    (v_coach_id, 'Morning Batch', 'Early morning classes from 7 AM to 9 AM', 3000),
    (v_coach_id, 'Evening Batch', 'Evening classes from 6 PM to 8 PM', 3500),
    (v_coach_id, 'Weekend Batch', 'Weekend intensive classes', 4000);
  END IF;

  -- Coach 3: Multiple batches (Cricket Champions Academy)
  SELECT id INTO v_coach_id FROM coaches WHERE name = 'Cricket Champions Academy' LIMIT 1;
  IF v_coach_id IS NOT NULL THEN
    INSERT INTO batches (coach_id, name, description, cost) VALUES
    (v_coach_id, 'Beginner Batch', 'For beginners and young players', 3500),
    (v_coach_id, 'Advanced Batch', 'For experienced players', 4500),
    (v_coach_id, 'Elite Batch', 'Professional training with personal coaching', 6000);
  END IF;

  -- Coach 4: Single batch (Music Masters Institute)
  SELECT id INTO v_coach_id FROM coaches WHERE name = 'Music Masters Institute' LIMIT 1;
  IF v_coach_id IS NOT NULL THEN
    INSERT INTO batches (coach_id, name, description, cost) VALUES
    (v_coach_id, 'Standard Batch', 'Regular music classes', 3500);
  END IF;

  -- Coach 5: Multiple batches (Yoga Wellness Center)
  SELECT id INTO v_coach_id FROM coaches WHERE name = 'Yoga Wellness Center' LIMIT 1;
  IF v_coach_id IS NOT NULL THEN
    INSERT INTO batches (coach_id, name, description, cost) VALUES
    (v_coach_id, 'Morning Yoga', 'Early morning sessions', 1800),
    (v_coach_id, 'Evening Yoga', 'Evening relaxation sessions', 2200);
  END IF;

  -- Coach 6: Multiple batches (Fitness Zone Gym)
  SELECT id INTO v_coach_id FROM coaches WHERE name = 'Fitness Zone Gym' LIMIT 1;
  IF v_coach_id IS NOT NULL THEN
    INSERT INTO batches (coach_id, name, description, cost) VALUES
    (v_coach_id, 'Basic Membership', 'Access to gym equipment', 4000),
    (v_coach_id, 'Premium Membership', 'Includes personal trainer sessions', 6000),
    (v_coach_id, 'VIP Membership', 'Unlimited access with nutrition counseling', 8000);
  END IF;

  -- Note: Remaining coaches will continue to use the old 'fees' field
  -- This demonstrates backward compatibility

  RAISE NOTICE '✅ Inserted dummy batches';
  RAISE NOTICE '';
  RAISE NOTICE '📋 Summary:';
  RAISE NOTICE '   - Single batch coaches: Elite Maths Academy, Music Masters Institute';
  RAISE NOTICE '   - Multiple batch coaches: Dance Studio Pro, Cricket Champions Academy, Yoga Wellness Center, Fitness Zone Gym';
  RAISE NOTICE '   - Other coaches will use the old fees field';

END $$;


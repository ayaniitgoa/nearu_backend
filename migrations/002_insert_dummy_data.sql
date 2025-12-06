-- ============================================
-- Insert Dummy Data for SkillBridge
-- ============================================
-- 
-- INSTRUCTIONS:
-- 1. First, get a user ID from your auth.users table:
--    - Go to Supabase Dashboard → Authentication → Users
--    - Copy any user's UUID (or create a test user first)
--    - Replace 'YOUR_USER_ID_HERE' below with that UUID
--
-- 2. Or, if you want to use the first user in your auth table:
--    - Uncomment the line that gets the first user ID
--    - Comment out the manual user_id line
--
-- 3. Run this entire script in Supabase SQL Editor
-- ============================================

-- Option 1: Use a specific user ID (replace with your actual user ID)
-- You can get this from: Supabase Dashboard → Authentication → Users
DO $$
DECLARE
  v_owner_id UUID;
  v_coach_id UUID;
  v_review_id UUID;
BEGIN
  -- Get the first user from auth.users (or replace with a specific UUID)
  SELECT id INTO v_owner_id 
  FROM auth.users 
  LIMIT 1;
  
  -- If no user exists, you'll need to create one first via the Auth UI
  IF v_owner_id IS NULL THEN
    RAISE EXCEPTION 'No users found. Please create a user first via Authentication → Users in Supabase Dashboard';
  END IF;

  RAISE NOTICE 'Using owner_id: %', v_owner_id;

  -- Insert Coaches (insert all at once)
  INSERT INTO coaches (owner_id, name, city, category, description, timing, fees, address, images, is_approved) VALUES
  (v_owner_id, 'Elite Maths Academy', 'Mumbai', 'Tuition', 'Expert mathematics coaching for all grades. Experienced faculty with proven track record.', 'Mon-Fri: 4 PM - 7 PM, Sat: 10 AM - 1 PM', 2500, '123 Education Street, Andheri West, Mumbai', ARRAY['https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Dance Studio Pro', 'Mumbai', 'Dance', 'Learn Bollywood, Hip Hop, and Contemporary dance styles. Professional instructors.', 'Mon, Wed, Fri: 6 PM - 8 PM', 3000, '456 Arts Avenue, Bandra, Mumbai', ARRAY['https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Cricket Champions Academy', 'Mumbai', 'Sports', 'Professional cricket coaching for all age groups. State-of-the-art facilities.', 'Daily: 6 AM - 9 AM, 4 PM - 7 PM', 4000, '789 Sports Complex, Powai, Mumbai', ARRAY['https://images.unsplash.com/photo-1534158914592-062992fbe900?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Music Masters Institute', 'Delhi', 'Music', 'Learn Guitar, Piano, and Drums from certified instructors. Individual and group classes.', 'Tue, Thu, Sat: 3 PM - 7 PM', 3500, '321 Music Lane, Connaught Place, Delhi', ARRAY['https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Yoga Wellness Center', 'Delhi', 'Yoga', 'Hatha, Vinyasa, and Power Yoga classes. Experienced yoga instructors for all levels.', 'Daily: 7 AM - 9 AM, 6 PM - 8 PM', 2000, '654 Wellness Road, Saket, Delhi', ARRAY['https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Art & Craft Studio', 'Bangalore', 'Art', 'Painting, Drawing, and Digital Art classes. Creative workshops for all ages.', 'Weekends: 10 AM - 2 PM', 2800, '987 Creative Street, Koramangala, Bangalore', ARRAY['https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Fitness Zone Gym', 'Bangalore', 'Fitness', 'Complete fitness training with cardio, strength training, and Zumba classes.', 'Daily: 6 AM - 10 PM', 4500, '147 Fitness Avenue, Indiranagar, Bangalore', ARRAY['https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Language Learning Hub', 'Hyderabad', 'Language', 'Learn English, French, Spanish, and more. Certified language instructors.', 'Mon-Fri: 5 PM - 8 PM', 3200, '258 Language Center, Hitech City, Hyderabad', ARRAY['https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Swimming Academy', 'Hyderabad', 'Sports', 'Professional swimming coaching for beginners to advanced. Olympic-size pool.', 'Daily: 6 AM - 9 AM, 4 PM - 7 PM', 3800, '369 Pool Road, Banjara Hills, Hyderabad', ARRAY['https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Cooking Classes Delight', 'Pune', 'Cooking', 'Learn Indian, Continental, and Baking. Hands-on cooking experience.', 'Sat-Sun: 11 AM - 2 PM', 2700, '741 Culinary Street, Koregaon Park, Pune', ARRAY['https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Singing Academy', 'Pune', 'Singing', 'Classical and Bollywood singing classes. Voice training and performance coaching.', 'Tue, Thu, Sat: 4 PM - 7 PM', 2900, '852 Music Plaza, Viman Nagar, Pune', ARRAY['https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop'], true),
  (v_owner_id, 'Photography Workshop', 'Chennai', 'Hobby', 'Learn photography techniques, composition, and editing. Professional photographers.', 'Weekends: 9 AM - 1 PM', 3300, '963 Camera Street, T Nagar, Chennai', ARRAY['https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=800&h=600&fit=crop'], true);

  RAISE NOTICE '✅ Inserted 12 coaches';

  -- Insert Reviews for each coach
  -- We'll add 2-4 reviews per coach
  FOR v_coach_id IN SELECT id FROM coaches WHERE owner_id = v_owner_id LOOP
    -- Review 1
    INSERT INTO reviews (coach_id, rating, text) VALUES
    (v_coach_id, 5, 'Excellent coaching! My child improved significantly.')
    RETURNING id INTO v_review_id;
    
    -- Review 2
    INSERT INTO reviews (coach_id, rating, text) VALUES
    (v_coach_id, 4, 'Great instructors and good facilities.')
    RETURNING id INTO v_review_id;
    
    -- Review 3 (randomly add 1-2 more)
    IF random() > 0.3 THEN
      INSERT INTO reviews (coach_id, rating, text) VALUES
      (v_coach_id, 5, 'Highly recommended! Very professional.')
      RETURNING id INTO v_review_id;
    END IF;
    
    IF random() > 0.5 THEN
      INSERT INTO reviews (coach_id, rating, text) VALUES
      (v_coach_id, 4, 'Good value for money. Satisfied with the service.')
      RETURNING id INTO v_review_id;
    END IF;
  END LOOP;

  RAISE NOTICE '✅ Inserted reviews for all coaches';
  RAISE NOTICE '✨ Dummy data insertion completed!';
  RAISE NOTICE '';
  RAISE NOTICE '📋 Summary:';
  RAISE NOTICE '   - Coaches: 12';
  RAISE NOTICE '   - Reviews: ~30-40';
  RAISE NOTICE '';
  RAISE NOTICE '💡 Cities with data:';
  RAISE NOTICE '   - Mumbai (3 coaches)';
  RAISE NOTICE '   - Delhi (2 coaches)';
  RAISE NOTICE '   - Bangalore (2 coaches)';
  RAISE NOTICE '   - Hyderabad (2 coaches)';
  RAISE NOTICE '   - Pune (2 coaches)';
  RAISE NOTICE '   - Chennai (1 coach)';

END $$;

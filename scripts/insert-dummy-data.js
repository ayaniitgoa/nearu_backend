require('dotenv').config({ path: require('path').join(__dirname, '../.env') });
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

// Initialize Supabase admin client directly in script
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceRoleKey) {
  console.error('❌ Missing Supabase environment variables.');
  console.error('Please ensure your backend/.env file has:');
  console.error('SUPABASE_URL=your-project-url');
  console.error('SUPABASE_SERVICE_ROLE_KEY=your-service-role-key');
  process.exit(1);
}

const supabaseAdmin = createClient(supabaseUrl, supabaseServiceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

// Dummy data for coaches
const dummyCoaches = [
  {
    name: 'Elite Maths Academy',
    city: 'Mumbai',
    category: 'Tuition',
    description: 'Expert mathematics coaching for all grades. Experienced faculty with proven track record.',
    timing: 'Mon-Fri: 4 PM - 7 PM, Sat: 10 AM - 1 PM',
    fees: 2500,
    address: '123 Education Street, Andheri West, Mumbai',
    images: ['https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Dance Studio Pro',
    city: 'Mumbai',
    category: 'Dance',
    description: 'Learn Bollywood, Hip Hop, and Contemporary dance styles. Professional instructors.',
    timing: 'Mon, Wed, Fri: 6 PM - 8 PM',
    fees: 3000,
    address: '456 Arts Avenue, Bandra, Mumbai',
    images: ['https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Cricket Champions Academy',
    city: 'Mumbai',
    category: 'Sports',
    description: 'Professional cricket coaching for all age groups. State-of-the-art facilities.',
    timing: 'Daily: 6 AM - 9 AM, 4 PM - 7 PM',
    fees: 4000,
    address: '789 Sports Complex, Powai, Mumbai',
    images: ['https://images.unsplash.com/photo-1534158914592-062992fbe900?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Music Masters Institute',
    city: 'Delhi',
    category: 'Music',
    description: 'Learn Guitar, Piano, and Drums from certified instructors. Individual and group classes.',
    timing: 'Tue, Thu, Sat: 3 PM - 7 PM',
    fees: 3500,
    address: '321 Music Lane, Connaught Place, Delhi',
    images: ['https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Yoga Wellness Center',
    city: 'Delhi',
    category: 'Yoga',
    description: 'Hatha, Vinyasa, and Power Yoga classes. Experienced yoga instructors for all levels.',
    timing: 'Daily: 7 AM - 9 AM, 6 PM - 8 PM',
    fees: 2000,
    address: '654 Wellness Road, Saket, Delhi',
    images: ['https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Art & Craft Studio',
    city: 'Bangalore',
    category: 'Art',
    description: 'Painting, Drawing, and Digital Art classes. Creative workshops for all ages.',
    timing: 'Weekends: 10 AM - 2 PM',
    fees: 2800,
    address: '987 Creative Street, Koramangala, Bangalore',
    images: ['https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Fitness Zone Gym',
    city: 'Bangalore',
    category: 'Fitness',
    description: 'Complete fitness training with cardio, strength training, and Zumba classes.',
    timing: 'Daily: 6 AM - 10 PM',
    fees: 4500,
    address: '147 Fitness Avenue, Indiranagar, Bangalore',
    images: ['https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Language Learning Hub',
    city: 'Hyderabad',
    category: 'Language',
    description: 'Learn English, French, Spanish, and more. Certified language instructors.',
    timing: 'Mon-Fri: 5 PM - 8 PM',
    fees: 3200,
    address: '258 Language Center, Hitech City, Hyderabad',
    images: ['https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Swimming Academy',
    city: 'Hyderabad',
    category: 'Sports',
    description: 'Professional swimming coaching for beginners to advanced. Olympic-size pool.',
    timing: 'Daily: 6 AM - 9 AM, 4 PM - 7 PM',
    fees: 3800,
    address: '369 Pool Road, Banjara Hills, Hyderabad',
    images: ['https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Cooking Classes Delight',
    city: 'Pune',
    category: 'Cooking',
    description: 'Learn Indian, Continental, and Baking. Hands-on cooking experience.',
    timing: 'Sat-Sun: 11 AM - 2 PM',
    fees: 2700,
    address: '741 Culinary Street, Koregaon Park, Pune',
    images: ['https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Singing Academy',
    city: 'Pune',
    category: 'Singing',
    description: 'Classical and Bollywood singing classes. Voice training and performance coaching.',
    timing: 'Tue, Thu, Sat: 4 PM - 7 PM',
    fees: 2900,
    address: '852 Music Plaza, Viman Nagar, Pune',
    images: ['https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop'],
    is_approved: true,
  },
  {
    name: 'Photography Workshop',
    city: 'Chennai',
    category: 'Hobby',
    description: 'Learn photography techniques, composition, and editing. Professional photographers.',
    timing: 'Weekends: 9 AM - 1 PM',
    fees: 3300,
    address: '963 Camera Street, T Nagar, Chennai',
    images: ['https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=800&h=600&fit=crop'],
    is_approved: true,
  },
];

// Dummy reviews
const dummyReviews = [
  { rating: 5, text: 'Excellent coaching! My child improved significantly.' },
  { rating: 4, text: 'Great instructors and good facilities.' },
  { rating: 5, text: 'Highly recommended! Very professional.' },
  { rating: 4, text: 'Good value for money. Satisfied with the service.' },
  { rating: 5, text: 'Amazing experience! Will definitely continue.' },
];

async function insertDummyData() {
  try {
    console.log('🚀 Starting dummy data insertion...\n');

    // First, create a dummy user or get an existing one
    const testEmail = `test-owner-${Date.now()}@example.com`;
    const testPassword = 'TestPassword123!';

    console.log('📝 Creating test user...');
    const { data: authData, error: authError } = await supabaseAdmin.auth.admin.createUser({
      email: testEmail,
      password: testPassword,
      email_confirm: true,
      user_metadata: {
        user_type: 'institution',
        name: 'Test Institution Owner',
      },
    });

    let ownerId;
    if (authError && !authError.message.includes('already registered')) {
      console.log('⚠️  Could not create new user, trying to use existing user...');
      // Try to get an existing user instead
      const { data: existingUsers, error: listError } = await supabaseAdmin.auth.admin.listUsers();
      if (listError) {
        console.error('❌ Error listing users:', listError.message);
        throw listError;
      }
      if (existingUsers && existingUsers.users.length > 0) {
        ownerId = existingUsers.users[0].id;
        console.log('✅ Using existing user:', existingUsers.users[0].email);
      } else {
        throw new Error('No existing users found and could not create new user');
      }
    } else {
      ownerId = authData.user.id;
      console.log('✅ Test user created:', testEmail);
      console.log('   Password:', testPassword);
    }

    // Insert coaches
    console.log('\n📚 Inserting coaches...');
    const coachesToInsert = dummyCoaches.map(coach => ({
      ...coach,
      owner_id: ownerId,
    }));

    const { data: insertedCoaches, error: coachesError } = await supabaseAdmin
      .from('coaches')
      .insert(coachesToInsert)
      .select();

    if (coachesError) {
      console.error('❌ Error inserting coaches:', coachesError);
      throw coachesError;
    }

    console.log(`✅ Successfully inserted ${insertedCoaches.length} coaches`);

    // Insert reviews for some coaches
    console.log('\n⭐ Inserting reviews...');
    const reviewsToInsert = [];
    
    insertedCoaches.forEach((coach) => {
      // Add 2-4 reviews per coach
      const numReviews = Math.floor(Math.random() * 3) + 2;
      for (let i = 0; i < numReviews; i++) {
        const review = dummyReviews[Math.floor(Math.random() * dummyReviews.length)];
        reviewsToInsert.push({
          coach_id: coach.id,
          rating: review.rating,
          text: review.text,
        });
      }
    });

    if (reviewsToInsert.length > 0) {
      const { error: reviewsError } = await supabaseAdmin
        .from('reviews')
        .insert(reviewsToInsert);

      if (reviewsError) {
        console.error('⚠️  Error inserting reviews:', reviewsError.message);
      } else {
        console.log(`✅ Successfully inserted ${reviewsToInsert.length} reviews`);
      }
    }

    console.log('\n✨ Dummy data insertion completed!');
    console.log('\n📋 Summary:');
    console.log(`   - Coaches: ${insertedCoaches.length}`);
    console.log(`   - Reviews: ${reviewsToInsert.length}`);
    console.log(`   - Test User: ${testEmail || 'Using existing user'}`);
    console.log('\n💡 You can now test the app with these cities:');
    console.log('   - Mumbai (3 coaches)');
    console.log('   - Delhi (2 coaches)');
    console.log('   - Bangalore (2 coaches)');
    console.log('   - Hyderabad (2 coaches)');
    console.log('   - Pune (2 coaches)');
    console.log('   - Chennai (1 coach)');

  } catch (error) {
    console.error('\n❌ Error:', error.message);
    console.error(error);
    process.exit(1);
  }
}

// Run the script
insertDummyData()
  .then(() => {
    console.log('\n✅ Script completed successfully!');
    process.exit(0);
  })
  .catch((error) => {
    console.error('\n❌ Script failed:', error);
    process.exit(1);
  });

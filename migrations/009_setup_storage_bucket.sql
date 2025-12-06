-- Setup Supabase Storage for coaching images
-- This script needs to be run in Supabase Dashboard -> Storage
-- SQL Editor cannot create storage buckets, so follow the manual steps below

-- MANUAL SETUP REQUIRED:
-- 1. Go to Supabase Dashboard -> Storage
-- 2. Click "Create a new bucket"
-- 3. Bucket name: "coaching-images"
-- 4. Make it PUBLIC (or configure RLS policies)
-- 5. Click "Create bucket"

-- After creating the bucket, run the following policies in SQL Editor:

-- Policy: Allow authenticated users to upload images
CREATE POLICY "Authenticated users can upload images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'coaching-images');

-- Policy: Allow authenticated users to update their own images
CREATE POLICY "Users can update their own images"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'coaching-images' AND (storage.foldername(name))[1] = auth.uid()::text);

-- Policy: Allow authenticated users to delete their own images
CREATE POLICY "Users can delete their own images"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'coaching-images' AND (storage.foldername(name))[1] = auth.uid()::text);

-- Policy: Allow public to view images (if bucket is public)
CREATE POLICY "Public can view images"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'coaching-images');

-- Note: If you made the bucket private, use this policy instead:
-- CREATE POLICY "Authenticated users can view images"
-- ON storage.objects FOR SELECT
-- TO authenticated
-- USING (bucket_id = 'coaching-images');


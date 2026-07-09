-- Default food image for all remaining menu items (MenuID 73 to 104)
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 73;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 74;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 75;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 76;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600' WHERE MenuID = 77;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600' WHERE MenuID = 78;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=600' WHERE MenuID = 79;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 80;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=600' WHERE MenuID = 81;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=600' WHERE MenuID = 82;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=600' WHERE MenuID = 83;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 84;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 85;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?w=600' WHERE MenuID = 86;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1619985632461-f33748ef4e7d?w=600' WHERE MenuID = 87;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=600' WHERE MenuID = 88;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600' WHERE MenuID = 89;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=600' WHERE MenuID = 90;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1619985632461-f33748ef4e7d?w=600' WHERE MenuID = 91;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=600' WHERE MenuID = 92;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=600' WHERE MenuID = 93;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600' WHERE MenuID = 94;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=600' WHERE MenuID = 95;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600' WHERE MenuID = 96;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=600' WHERE MenuID = 97;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=600' WHERE MenuID = 98;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=600' WHERE MenuID = 99;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600' WHERE MenuID = 100;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=600' WHERE MenuID = 101;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=600' WHERE MenuID = 102;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1548345680-f5475ea5df84?w=600' WHERE MenuID = 103;
UPDATE menu SET ImageURL = 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600' WHERE MenuID = 104;

-- =====================================================================
-- FIX: Replace wrong images for Garlic Bread items (woman photo removed)
-- Real garlic bread food photos from Unsplash
-- NOTE: Disable safe update mode so WHERE on non-key column is allowed
-- =====================================================================

-- Disable safe update mode temporarily
SET SQL_SAFE_UPDATES = 0;

-- Fix "Cheese Garlic Bread" – replace woman photo with actual cheese garlic bread
UPDATE menu
SET ImageURL = 'https://images.unsplash.com/photo-1619531042059-6e90b14b2a33?w=600&fit=crop&q=80'
WHERE ItemName LIKE '%Cheese Garlic Bread%';

-- Fix "Garlic Bread" (plain) – ensure it also has a correct food photo
UPDATE menu
SET ImageURL = 'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=600&fit=crop&q=80'
WHERE ItemName LIKE '%Garlic Bread%'
  AND ItemName NOT LIKE '%Cheese%';

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;

-- =====================================================================
-- SAFETY NET: Update any item whose current image URL resolves to a
-- known wrong/non-food photo used on Unsplash for portraits.
-- Add more portrait photo hashes here if discovered in future.
-- =====================================================================
-- (No additional rows known at this time — add if new bad URLs are found)

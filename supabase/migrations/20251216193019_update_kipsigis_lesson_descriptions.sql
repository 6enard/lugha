/*
  # Update Kipsigis Lesson Descriptions
  
  Update all lesson descriptions to specifically reference Kipsigis dialect
  instead of generic Kalenjin language references.
*/

UPDATE lessons SET
  description = 'Learn essential greetings and how to introduce yourself in Kipsigis dialect'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Basic Greetings & Introductions';

UPDATE lessons SET
  description = 'Learn the Kipsigis words for family members and understand Kipsigis family structure'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Family & Relationships';

UPDATE lessons SET
  description = 'Master counting from 1 to 10 in Kipsigis and learn basic number usage in daily life'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Numbers & Counting';

UPDATE lessons SET
  description = 'Learn colors and everyday objects in Kipsigis language'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Colors & Common Objects';

UPDATE lessons SET
  description = 'Master time expressions in Kipsigis'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Days of the Week & Time';

UPDATE lessons SET
  description = 'Learn everyday phrases for conversations in Kipsigis'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Common Conversations & Questions';

UPDATE lessons SET
  description = 'Learn about traditional Kipsigis food and dining vocabulary'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Food, Drinks & Dining';

UPDATE lessons SET
  description = 'Learn to navigate and describe locations in Kipsigis'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Directions & Places';

UPDATE lessons SET
  description = 'Learn body vocabulary and health expressions in Kipsigis'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Body Parts & Health';

UPDATE lessons SET
  description = 'Explore weather and nature in the Rift Valley using Kipsigis language'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Weather & Nature';

UPDATE lessons SET
  description = 'Learn ancient Kipsigis proverbs and warrior wisdom'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Traditional Proverbs & Wisdom';

UPDATE lessons SET
  description = 'Understand Kipsigis traditional ceremonies and cultural practices'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Cultural Ceremonies & Customs';

UPDATE lessons SET
  description = 'Master advanced Kipsigis grammar and verb conjugations'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Complex Grammar & Sentence Structures';

UPDATE lessons SET
  description = 'Learn colorful Kipsigis idioms and expressions'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Idiomatic Expressions';

UPDATE lessons SET
  description = 'Discover Kipsigis storytelling and narrative traditions'
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') 
  AND title = 'Storytelling & Oral Traditions';
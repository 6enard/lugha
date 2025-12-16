/*
  # Add Kalenjin Language Content

  ## Overview
  This migration adds comprehensive Kalenjin language content to the platform, including:
  - Language profile for Kalenjin
  - 3 beginner lessons covering essential topics
  - 15+ vocabulary items across all lessons
  - 9 quiz questions to test learning

  ## New Content

  ### Language
  - **Kalenjin** - Spoken by approximately 5.5 million people in the Rift Valley region
  - Counties: Nandi, Uasin Gishu, Elgeyo-Marakwet, Baringo, Kericho, Bomet, Nakuru, Trans-Nzoia
  - Cultural significance: Home of world champions and rich athletic heritage

  ### Lessons Structure
  1. **Basic Greetings & Introductions** (50 XP)
     - Common greetings and responses
     - How to introduce yourself
     - Polite expressions

  2. **Family & Relationships** (75 XP)
     - Family member terms
     - Relationship vocabulary
     - Cultural context

  3. **Numbers & Counting** (75 XP)
     - Numbers 1-10
     - Basic counting
     - Practical applications

  ## Security
  - Uses existing RLS policies on all tables
  - No changes to security configuration needed
*/

-- Insert Kalenjin language
INSERT INTO languages (
  id,
  name,
  tribe_name,
  description,
  total_speakers,
  counties,
  flag_emoji,
  is_active
) VALUES (
  gen_random_uuid(),
  'Kalenjin',
  'Kalenjin',
  'A Southern Nilotic language spoken by the Kalenjin people of the Rift Valley. Known for its tonal nature and the community''s rich athletic heritage and pastoral traditions.',
  5500000,
  ARRAY['Nandi', 'Uasin Gishu', 'Elgeyo-Marakwet', 'Baringo', 'Kericho', 'Bomet', 'Nakuru', 'Trans-Nzoia'],
  '🏃',
  true
);

-- Store the Kalenjin language ID for reference
DO $$
DECLARE
  v_kalenjin_id uuid;
  v_lesson1_id uuid;
  v_lesson2_id uuid;
  v_lesson3_id uuid;
BEGIN
  -- Get the Kalenjin language ID
  SELECT id INTO v_kalenjin_id FROM languages WHERE name = 'Kalenjin' AND tribe_name = 'Kalenjin';

  -- Insert Lesson 1: Basic Greetings & Introductions
  INSERT INTO lessons (
    id,
    language_id,
    title,
    description,
    order_index,
    xp_reward,
    difficulty_level,
    lesson_type
  ) VALUES (
    gen_random_uuid(),
    v_kalenjin_id,
    'Basic Greetings & Introductions',
    'Learn essential greetings and how to introduce yourself in Kalenjin',
    1,
    50,
    'Beginner',
    'vocabulary'
  ) RETURNING id INTO v_lesson1_id;

  -- Insert vocabulary for Lesson 1
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence, audio_url) VALUES
  (v_lesson1_id, 'Chamge', 'Hello/Greetings', 'cham-geh', 'Chamge! Inutye nee? - Hello! How are you?', ''),
  (v_lesson1_id, 'Inutye nee?', 'How are you?', 'ee-noo-tyeh neh', 'Inutye nee? Achen - How are you? I am fine', ''),
  (v_lesson1_id, 'Achen', 'I am fine', 'ah-chen', 'Achen, kong''ai - I am fine, thank you', ''),
  (v_lesson1_id, 'Kong''ai', 'Thank you', 'kong-eye', 'Kong''ai missing - Thank you very much', ''),
  (v_lesson1_id, 'Sere', 'Good morning', 'seh-reh', 'Sere! Inutye nee? - Good morning! How are you?', '');

  -- Insert quiz questions for Lesson 1
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson1_id, 'What is the Kalenjin word for "Hello"?', 'Chamge', 'Chamge', 'Kong''ai', 'Achen', 'Sere', 'Chamge is the standard greeting in Kalenjin, used throughout the day to greet people.'),
  (v_lesson1_id, 'How do you say "Thank you" in Kalenjin?', 'Kong''ai', 'Chamge', 'Kong''ai', 'Achen', 'Sere', 'Kong''ai means "thank you" in Kalenjin and is essential for polite conversation.'),
  (v_lesson1_id, 'What does "Achen" mean?', 'I am fine', 'Hello', 'Thank you', 'Good morning', 'I am fine', 'Achen is the response meaning "I am fine" when someone asks how you are.');

  -- Insert Lesson 2: Family & Relationships
  INSERT INTO lessons (
    id,
    language_id,
    title,
    description,
    order_index,
    xp_reward,
    difficulty_level,
    lesson_type
  ) VALUES (
    gen_random_uuid(),
    v_kalenjin_id,
    'Family & Relationships',
    'Learn the Kalenjin words for family members and understand family structure',
    2,
    75,
    'Beginner',
    'vocabulary'
  ) RETURNING id INTO v_lesson2_id;

  -- Insert vocabulary for Lesson 2
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence, audio_url) VALUES
  (v_lesson2_id, 'Papa', 'Father', 'pah-pah', 'Papa ane matua - My father is old', ''),
  (v_lesson2_id, 'Mama', 'Mother', 'mah-mah', 'Mama ane mising - My mother is good', ''),
  (v_lesson2_id, 'Lakwet', 'Child', 'lah-kwet', 'Lakwet ane ng''atunyi - My child is small', ''),
  (v_lesson2_id, 'Kogo', 'Grandmother', 'koh-goh', 'Kogo ane kesuban - My grandmother is coming', ''),
  (v_lesson2_id, 'Kugo', 'Grandfather', 'koo-goh', 'Kugo ane mutua missing - My grandfather is very old', '');

  -- Insert quiz questions for Lesson 2
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson2_id, 'What is the Kalenjin word for "Mother"?', 'Mama', 'Papa', 'Mama', 'Kogo', 'Lakwet', 'Mama means "mother" in Kalenjin, similar to many other languages.'),
  (v_lesson2_id, 'How do you say "Grandfather" in Kalenjin?', 'Kugo', 'Papa', 'Kogo', 'Kugo', 'Lakwet', 'Kugo refers to grandfather, while Kogo refers to grandmother.'),
  (v_lesson2_id, 'What does "Lakwet" mean?', 'Child', 'Father', 'Mother', 'Child', 'Grandmother', 'Lakwet means "child" in Kalenjin and is commonly used to refer to children.');

  -- Insert Lesson 3: Numbers & Counting
  INSERT INTO lessons (
    id,
    language_id,
    title,
    description,
    order_index,
    xp_reward,
    difficulty_level,
    lesson_type
  ) VALUES (
    gen_random_uuid(),
    v_kalenjin_id,
    'Numbers & Counting',
    'Master counting from 1 to 10 and learn basic number usage in daily life',
    3,
    75,
    'Beginner',
    'vocabulary'
  ) RETURNING id INTO v_lesson3_id;

  -- Insert vocabulary for Lesson 3
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence, audio_url) VALUES
  (v_lesson3_id, 'Akoeng''', 'One', 'ah-koh-eng', 'Akoeng'' lakwet - One child', ''),
  (v_lesson3_id, 'Aeng''', 'Two', 'ah-eng', 'Aeng'' mama - Two mothers', ''),
  (v_lesson3_id, 'Somok', 'Three', 'soh-mohk', 'Somok papa - Three fathers', ''),
  (v_lesson3_id, 'Angwan', 'Four', 'ahng-wahn', 'Angwan tugul - Four people', ''),
  (v_lesson3_id, 'Mut', 'Five', 'moot', 'Mut lakwok - Five children', '');

  -- Insert quiz questions for Lesson 3
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson3_id, 'What is the Kalenjin word for "One"?', 'Akoeng''', 'Akoeng''', 'Aeng''', 'Somok', 'Mut', 'Akoeng'' is the word for "one" in Kalenjin, the starting point for counting.'),
  (v_lesson3_id, 'How do you say "Three" in Kalenjin?', 'Somok', 'Akoeng''', 'Aeng''', 'Somok', 'Angwan', 'Somok means "three" in Kalenjin and is used for counting.'),
  (v_lesson3_id, 'What number is "Mut"?', 'Five', 'Three', 'Four', 'Five', 'Two', 'Mut represents the number five in Kalenjin, completing the first set of basic numbers.');

END $$;
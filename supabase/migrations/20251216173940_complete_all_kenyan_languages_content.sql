/*
  # Complete All Kenyan Languages with Comprehensive Content
  
  ## Overview
  This migration completes all Kenyan language lessons with authentic, culturally accurate content
  from beginner to advanced levels.
  
  ## Changes Made
  
  ### 1. Kikuyu
  - Remove duplicate lesson with 0 content
  - Already has complete 15-lesson curriculum
  
  ### 2. Kikamba (Akamba Language)
  **Missing Intermediate Lessons (8-10):**
  - Lesson 8: Directions & Places - Navigate locations, ask for directions
  - Lesson 9: Body Parts & Health - Health vocabulary, body parts
  - Lesson 10: Weather & Nature - Weather descriptions, natural elements
  
  **Missing Advanced Lessons (12-15):**
  - Lesson 12: Cultural Ceremonies & Customs - Akamba traditions
  - Lesson 13: Complex Grammar & Sentence Structures - Advanced grammar
  - Lesson 14: Idiomatic Expressions - Common Kikamba idioms
  - Lesson 15: Storytelling & Oral Traditions - Akamba folktales
  
  ### 3. Luhya (Abaluhya Language)
  **Missing Intermediate Lessons (7, 9-10):**
  - Lesson 7: Food, Drinks & Dining - Food vocabulary, dining phrases
  - Lesson 9: Body Parts & Health - Health and body terms
  - Lesson 10: Weather & Nature - Weather and natural world
  
  **Missing Advanced Lessons (12-15):**
  - Lesson 12: Cultural Ceremonies & Customs - Luhya traditions
  - Lesson 13: Complex Grammar & Sentence Structures - Advanced structures
  - Lesson 14: Idiomatic Expressions - Luhya idioms and sayings
  - Lesson 15: Storytelling & Oral Traditions - Luhya oral literature
  
  ### 4. Dholuo (Luo Language)
  **Missing Advanced Lessons (13-15):**
  - Lesson 13: Complex Grammar & Sentence Structures - Advanced Luo grammar
  - Lesson 14: Idiomatic Expressions - Luo idioms
  - Lesson 15: Storytelling & Oral Traditions - Luo oral traditions
  
  ### 5. Kiswahili (National Language)
  **Complete curriculum from scratch (Lessons 3-15):**
  - Beginner (3-5): Family, Colors, Days & Time
  - Intermediate (6-10): Conversations, Food, Directions, Health, Weather
  - Advanced (11-15): Proverbs, Culture, Grammar, Idioms, Storytelling
  
  ## Content Quality Standards
  - Authentic pronunciations using IPA-inspired phonetic guides
  - Culturally relevant example sentences
  - Real proverbs and idioms from each community
  - Contextual explanations for cultural practices
  - Progressive difficulty with proper scaffolding
*/

-- First, remove the duplicate Kikuyu lesson with no content
DELETE FROM lessons 
WHERE language_id = (SELECT id FROM languages WHERE name = 'Kikuyu')
  AND title = 'Common Conversations & Questions'
  AND order_index = 6
  AND NOT EXISTS (SELECT 1 FROM vocabulary WHERE lesson_id = lessons.id);

-- ============================================================================
-- KIKAMBA (Akamba) - Complete Missing Lessons
-- ============================================================================

-- Get Kikamba language ID
DO $$
DECLARE
  v_kikamba_id uuid;
  v_lesson_id uuid;
BEGIN
  SELECT id INTO v_kikamba_id FROM languages WHERE name = 'Kikamba';
  
  -- ==================== INTERMEDIATE LESSON 8: Directions & Places ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Directions & Places', 'Learn to navigate and ask for directions in Kikamba', 8, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kũ', 'Where', 'koo', 'Ũthĩĩ kũ? - Where are you going?'),
  (v_lesson_id, 'Mbee', 'Front/Ahead', 'mbeh', 'Thĩĩ mbee - Go ahead'),
  (v_lesson_id, 'Thutha', 'Behind/Back', 'thoo-thah', 'Nyũmba ĩĩ ĩĩ thutha - The house is behind'),
  (v_lesson_id, 'Mwena wa ũmwe', 'Right side', 'mweh-nah wah oo-mweh', 'Ũka mwena wa ũmwe - Turn right'),
  (v_lesson_id, 'Mwena wa ũmwe ũngĩ', 'Left side', 'mweh-nah wah oo-mweh oon-gee', 'Ũka mwena wa ũmwe ũngĩ - Turn left'),
  (v_lesson_id, 'Ndũka', 'Market', 'n-doo-kah', 'Ndathĩĩ ndũka - I am going to the market');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'How do you say "Where are you going?" in Kikamba?', 'Ũthĩĩ kũ?', 'Ũthĩĩ kũ?', 'Ũĩ atĩa?', 'Ũĩ ũũ?', 'Wĩ ata?', '"Ũthĩĩ kũ?" literally means "You go where?" which is how Kikamba asks where someone is going.'),
  (v_lesson_id, 'What does "mbee" mean?', 'Front/Ahead', 'Behind', 'Front/Ahead', 'Left', 'Right', '"Mbee" means front or ahead, used when giving directions to go forward.');
  
  -- ==================== INTERMEDIATE LESSON 9: Body Parts & Health ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Body Parts & Health', 'Learn body parts and health-related vocabulary', 9, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Mũsyi', 'Head', 'moo-syee', 'Mũsyi wakwa ũũmia - My head hurts'),
  (v_lesson_id, 'Maitho', 'Eyes', 'mai-thoh', 'Maitho maku nĩ manene - Your eyes are big'),
  (v_lesson_id, 'Ũtũ', 'Ear', 'oo-too', 'Ũtũ wakwa ũtethĩkĩte - My ear is deaf'),
  (v_lesson_id, 'Kĩĩvo', 'Tooth', 'kee-voh', 'Kĩĩvo kyakwa kĩũmia - My tooth hurts'),
  (v_lesson_id, 'Ũũmia', 'Pain/Hurt', 'oo-oo-mee-ah', 'Nĩndĩ na ũũmia - I have pain'),
  (v_lesson_id, 'Mũthemba', 'Medicine', 'moo-them-bah', 'Nyũa mũthemba - Drink medicine');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is the Kikamba word for "head"?', 'Mũsyi', 'Mũsyi', 'Maitho', 'Ũtũ', 'Kĩĩvo', '"Mũsyi" means head in Kikamba.'),
  (v_lesson_id, 'How do you say "I have pain" in Kikamba?', 'Nĩndĩ na ũũmia', 'Nĩndĩ na ũũmia', 'Mũsyi ũũmia', 'Nĩ mwega', 'Nĩndĩ mũũru', '"Nĩndĩ na ũũmia" means "I have pain" - a common way to express physical discomfort.');
  
  -- ==================== INTERMEDIATE LESSON 10: Weather & Nature ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Weather & Nature', 'Describe weather conditions and natural elements', 10, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Mbũa', 'Rain', 'mboo-ah', 'Mbũa nĩyũa - It is raining'),
  (v_lesson_id, 'Ĩthwa', 'Sun', 'ee-thwah', 'Ĩthwa nĩnene - The sun is strong'),
  (v_lesson_id, 'Rũhuho', 'Wind', 'roo-hoo-hoh', 'Rũhuho nĩkũvĩĩa - The wind is blowing'),
  (v_lesson_id, 'Mũtĩ', 'Tree', 'moo-tee', 'Mũtĩ ũyũ nĩ mũnene - This tree is big'),
  (v_lesson_id, 'Ndũũa', 'River', 'n-doo-wah', 'Ndũũa nĩyũa na maaĩ maingĩ - The river has a lot of water'),
  (v_lesson_id, 'Kĩĩma', 'Mountain', 'kee-mah', 'Kĩĩma kĩa Kenya nĩ kĩnene - Mount Kenya is big');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "Mbũa nĩyũa" mean?', 'It is raining', 'It is sunny', 'It is raining', 'It is windy', 'It is cold', '"Mbũa nĩyũa" literally means "rain is falling" - the standard way to say it is raining.'),
  (v_lesson_id, 'What is the Kikamba word for "tree"?', 'Mũtĩ', 'Ndũũa', 'Kĩĩma', 'Mũtĩ', 'Ĩthwa', '"Mũtĩ" means tree in Kikamba.');
  
  -- ==================== ADVANCED LESSON 12: Cultural Ceremonies & Customs ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Cultural Ceremonies & Customs', 'Learn about Akamba cultural practices and ceremonies', 12, 120, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kĩama', 'Council of elders', 'kee-ah-mah', 'Kĩama kĩathana itua - The elders council makes decisions'),
  (v_lesson_id, 'Ngoma', 'Dance/Drum', 'n-goh-mah', 'Tũĩna ngoma nĩ mbĩla - We dance because it is a celebration'),
  (v_lesson_id, 'Mbĩla', 'Celebration', 'mbee-lah', 'Ũmũthĩ nĩ mbĩla - Today is a celebration'),
  (v_lesson_id, 'Ũthiani', 'Friendship ceremony', 'oo-thee-ah-nee', 'Ũthiani nĩ mũtũũra mwega - Friendship ceremony is a good tradition'),
  (v_lesson_id, 'Mũĩko', 'Taboo/Custom', 'moo-ee-koh', 'Nĩtwĩ na mĩĩko mĩingĩ - We have many customs');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "Kĩama" in Akamba culture?', 'Council of elders', 'Council of elders', 'Dance ceremony', 'Harvest festival', 'Wedding ceremony', '"Kĩama" refers to the council of elders who are respected decision-makers in Akamba society.'),
  (v_lesson_id, 'What does "ngoma" mean?', 'Dance/Drum', 'Dance/Drum', 'Food', 'House', 'Celebration', '"Ngoma" means both dance and drum, as they are inseparable in Akamba culture.');
  
  -- ==================== ADVANCED LESSON 13: Complex Grammar ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Complex Grammar & Sentence Structures', 'Master advanced Kikamba grammar patterns', 13, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Angĩkorwo', 'If', 'ah-ngee-koh-rwoh', 'Angĩkorwo ũũka, nĩtũkakũona - If you come, we will see you'),
  (v_lesson_id, 'Tondũ', 'Because', 'tohn-doo', 'Ndatiĩte tondũ ndarĩ na mũthemba - I didn''t come because I didn''t have time'),
  (v_lesson_id, 'Ũngĩkorwo', 'Although/Even though', 'oon-gee-koh-rwoh', 'Ũngĩkorwo nĩ mũũru, nĩatĩĩte - Although he was sick, he came'),
  (v_lesson_id, 'Kana', 'Or', 'kah-nah', 'Ũkwenda ĩsũkũma kana nyama? - Do you want vegetables or meat?');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "angĩkorwo" mean?', 'If', 'If', 'Because', 'Although', 'Or', '"Angĩkorwo" introduces conditional statements, similar to "if" in English.'),
  (v_lesson_id, 'How do you say "or" in Kikamba?', 'Kana', 'Tondũ', 'Angĩkorwo', 'Kana', 'Ũngĩkorwo', '"Kana" is used to present alternatives or choices, meaning "or".');
  
  -- ==================== ADVANCED LESSON 14: Idiomatic Expressions ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Idiomatic Expressions', 'Learn common Kikamba idioms and figurative language', 14, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Mũndũ wa mbee nĩwe ũkũyaga', 'First come, first served', 'moon-doo wah mbeh nee-weh oo-koo-yah-gah', 'Used to encourage promptness'),
  (v_lesson_id, 'Kĩĩla kĩĩ na nzĩĩla yako', 'Every path has its way', 'kee-lah kee nah n-zee-lah yah-koh', 'Everyone has their own journey in life'),
  (v_lesson_id, 'Mũtumĩa nowe mũmbi wa mũcie', 'A woman is the builder of the home', 'moo-too-mee-ah noh-weh moom-bee wah moo-chee-eh', 'Recognizing women''s central role in family');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "Kĩĩla kĩĩ na nzĩĩla yako" teach?', 'Everyone has their own path', 'Everyone has their own path', 'Time is money', 'Unity is strength', 'Patience pays', 'This idiom teaches that everyone has their own unique journey and way of doing things.');
  
  -- ==================== ADVANCED LESSON 15: Storytelling ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_kikamba_id, 'Storytelling & Oral Traditions', 'Explore Akamba folktales and oral narrative traditions', 15, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Ngano', 'Story/Tale', 'n-gah-noh', 'Ũka tũkũhe ngano - Come tell us a story'),
  (v_lesson_id, 'Tene', 'Long ago', 'teh-neh', 'Tene nĩ kwarĩ na mũndũ - Long ago there was a person'),
  (v_lesson_id, 'Nĩndavoya', 'The storyteller', 'nee-n-dah-voh-yah', 'Nĩndavoya wa kũũa - The traditional storyteller'),
  (v_lesson_id, 'Mũthiiya', 'Riddle', 'moo-thee-yah', 'Tũĩne mĩthiiya - Let us share riddles');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is a "ngano" in Kikamba culture?', 'A story or tale', 'A dance', 'A story or tale', 'A drum', 'A ceremony', '"Ngano" refers to stories and tales, central to Akamba oral tradition.');
END $$;

-- ============================================================================
-- LUHYA (Abaluhya) - Complete Missing Lessons
-- ============================================================================

DO $$
DECLARE
  v_luhya_id uuid;
  v_lesson_id uuid;
BEGIN
  SELECT id INTO v_luhya_id FROM languages WHERE name = 'Luhya';
  
  -- ==================== INTERMEDIATE LESSON 7: Food, Drinks & Dining ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Food, Drinks & Dining', 'Learn food vocabulary and dining expressions in Luhya', 7, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Obusuma', 'Ugali (corn meal)', 'oh-boo-soo-mah', 'Obusuma buli obulahi - The ugali is good'),
  (v_lesson_id, 'Eshikokho', 'Chicken', 'eh-shee-koh-khoh', 'Nakunyola eshikokho - I want chicken'),
  (v_lesson_id, 'Amatsi', 'Water', 'ah-mah-tsee', 'Mba ni amatsi - Give me water'),
  (v_lesson_id, 'Okhulya', 'To eat', 'oh-khoo-lyah', 'Okhulya obusuma - To eat ugali'),
  (v_lesson_id, 'Obunywa', 'To drink', 'oh-boo-nywa', 'Nakunywa amatsi - I am drinking water'),
  (v_lesson_id, 'Omusala', 'Vegetables', 'oh-moo-sah-lah', 'Omusala kuli omusala omulayi - The vegetables are tasty');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "obusuma" in Luhya cuisine?', 'Ugali (corn meal)', 'Rice', 'Ugali (corn meal)', 'Chicken', 'Vegetables', '"Obusuma" is the Luhya word for ugali, a staple food made from corn meal.'),
  (v_lesson_id, 'How do you say "Give me water" in Luhya?', 'Mba ni amatsi', 'Mba ni amatsi', 'Nakunywa amatsi', 'Amatsi kuli', 'Okhulya amatsi', '"Mba ni amatsi" means "Give me water" in Luhya.');
  
  -- ==================== INTERMEDIATE LESSON 9: Body Parts & Health ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Body Parts & Health', 'Learn body parts and health vocabulary', 9, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Omutwe', 'Head', 'oh-moo-tweh', 'Omutwe kwanje kurauma - My head hurts'),
  (v_lesson_id, 'Amashio', 'Eyes', 'ah-mah-shee-oh', 'Amashio kange kamalayi - My eyes are beautiful'),
  (v_lesson_id, 'Omukoyo', 'Arm/Hand', 'oh-moo-koh-yoh', 'Omukoyo kwanje kurauma - My arm hurts'),
  (v_lesson_id, 'Okhurwa', 'To be sick', 'oh-khoo-rwah', 'Endirwa - I am sick'),
  (v_lesson_id, 'Omukhuwa', 'Medicine', 'oh-moo-khoo-wah', 'Nywa omukhuwa - Drink medicine'),
  (v_lesson_id, 'Okhulava', 'To heal', 'oh-khoo-lah-vah', 'Nakulava - I am healing');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is the Luhya word for "head"?', 'Omutwe', 'Amashio', 'Omukoyo', 'Omutwe', 'Omukhuwa', '"Omutwe" means head in Luhya.'),
  (v_lesson_id, 'How do you say "I am sick" in Luhya?', 'Endirwa', 'Endirwa', 'Nakulava', 'Omutwe kurauma', 'Nywa omukhuwa', '"Endirwa" is the first-person form meaning "I am sick".');
  
  -- ==================== INTERMEDIATE LESSON 10: Weather & Nature ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Weather & Nature', 'Describe weather and natural phenomena', 10, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Efula', 'Rain', 'eh-foo-lah', 'Efula yinona - It is raining'),
  (v_lesson_id, 'Eshishina', 'Sun', 'eh-shee-shee-nah', 'Eshishina yikhula - The sun is strong'),
  (v_lesson_id, 'Omuyaka', 'Wind', 'oh-moo-yah-kah', 'Omuyaka kukhuma - The wind is blowing'),
  (v_lesson_id, 'Omukhi', 'Tree', 'oh-moo-khee', 'Omukhi omulahi - A beautiful tree'),
  (v_lesson_id, 'Olucheshe', 'River', 'oh-loo-cheh-sheh', 'Olucheshe lulitsi amatsi kamanji - The river has a lot of water'),
  (v_lesson_id, 'Eshikulu', 'Mountain', 'eh-shee-koo-loo', 'Eshikulu eshilayi - A beautiful mountain');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "Efula yinona" mean?', 'It is raining', 'It is sunny', 'It is raining', 'It is windy', 'It is cold', '"Efula yinona" means "It is raining" in Luhya.'),
  (v_lesson_id, 'What is the Luhya word for "sun"?', 'Eshishina', 'Efula', 'Eshishina', 'Omuyaka', 'Omukhi', '"Eshishina" means sun in Luhya.');
  
  -- ==================== ADVANCED LESSON 12: Cultural Ceremonies ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Cultural Ceremonies & Customs', 'Learn about Luhya cultural practices and traditions', 12, 120, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kamakembeka', 'Circumcision ceremony', 'kah-mah-kem-beh-kah', 'Kamakembeka nikhamuramo khwafu - Circumcision is our important ceremony'),
  (v_lesson_id, 'Obwima', 'Bullfighting', 'oh-bwee-mah', 'Obwima buli obulayi - Bullfighting is exciting'),
  (v_lesson_id, 'Eshibingu', 'Funeral ceremony', 'eh-shee-been-goo', 'Eshibingu shilunyala - The funeral is sad'),
  (v_lesson_id, 'Omukhuwa', 'Traditional healer', 'oh-moo-khoo-wah', 'Omukhuwa akhumanila avasiani - The healer helps sick people'),
  (v_lesson_id, 'Obusaala', 'Blessing', 'oh-boo-saa-lah', 'Basekulu barula obusaala - Elders give blessings');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "obwima" in Luhya culture?', 'Bullfighting', 'Wedding', 'Bullfighting', 'Funeral', 'Circumcision', '"Obwima" is the traditional sport of bullfighting, significant in Luhya culture.'),
  (v_lesson_id, 'What does "kamakembeka" refer to?', 'Circumcision ceremony', 'Circumcision ceremony', 'Wedding', 'Funeral', 'Harvest festival', '"Kamakembeka" is the important circumcision initiation ceremony in Luhya tradition.');
  
  -- ==================== ADVANCED LESSON 13: Complex Grammar ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Complex Grammar & Sentence Structures', 'Master advanced Luhya grammar patterns', 13, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kale', 'If/When', 'kah-leh', 'Kale oncha, nakunyola - If you come, I want'),
  (v_lesson_id, 'Nende', 'And/With', 'nen-deh', 'Nende wewe - And you'),
  (v_lesson_id, 'Khulwakho', 'Because', 'khoo-lwah-khoh', 'Khulwakho endikhuma - Because I am going'),
  (v_lesson_id, 'Nende khandi', 'Although', 'nen-deh khan-dee', 'Nende khandi endirwa - Although I am sick');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "khulwakho" mean?', 'Because', 'If', 'Because', 'Although', 'And', '"Khulwakho" introduces causal clauses, meaning "because".'),
  (v_lesson_id, 'How do you say "and" in Luhya?', 'Nende', 'Kale', 'Nende', 'Khulwakho', 'Khandi', '"Nende" means "and" or "with" in Luhya.');
  
  -- ==================== ADVANCED LESSON 14: Idiomatic Expressions ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Idiomatic Expressions', 'Learn common Luhya idioms and sayings', 14, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Omusiru takholanga obuvoshi', 'A fool does not listen to advice', 'oh-moo-see-roo tah-khoh-lan-gah oh-boo-voh-shee', 'Teaching the value of wisdom'),
  (v_lesson_id, 'Enkhuku yikhukhutsanga avana bayo', 'A hen protects her chicks', 'en-khoo-koo yee-khoo-khoo-tsan-gah ah-vah-nah bah-yoh', 'About maternal protection'),
  (v_lesson_id, 'Efula yinona khuli vose', 'Rain falls on everyone', 'eh-foo-lah yee-noh-nah khoo-lee voh-seh', 'Life challenges affect everyone equally');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "Efula yinona khuli vose" teach?', 'Challenges affect everyone', 'Challenges affect everyone', 'Listen to advice', 'Protect family', 'Work together', 'This proverb teaches that life''s challenges affect everyone equally, regardless of status.');
  
  -- ==================== ADVANCED LESSON 15: Storytelling ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_luhya_id, 'Storytelling & Oral Traditions', 'Explore Luhya folktales and oral literature', 15, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Esigano', 'Story/Tale', 'eh-see-gah-noh', 'Usimba esigano - Tell a story'),
  (v_lesson_id, 'Emburi', 'Old times', 'em-boo-ree', 'Emburi muno - In the old days'),
  (v_lesson_id, 'Omusimanyi', 'Storyteller', 'oh-moo-see-man-yee', 'Omusimanyi wafu - Our storyteller'),
  (v_lesson_id, 'Eshitsukulu', 'Riddle', 'eh-shee-tsoo-koo-loo', 'Usimba eshitsukulu - Share a riddle');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "esigano" in Luhya culture?', 'A story or tale', 'A dance', 'A story or tale', 'A song', 'A ceremony', '"Esigano" refers to stories and tales in Luhya oral tradition.');
END $$;

-- ============================================================================
-- DHOLUO (Luo) - Add Missing Advanced Lessons
-- ============================================================================

DO $$
DECLARE
  v_dholuo_id uuid;
  v_lesson_id uuid;
BEGIN
  SELECT id INTO v_dholuo_id FROM languages WHERE name = 'Dholuo';
  
  -- ==================== ADVANCED LESSON 13: Complex Grammar ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_dholuo_id, 'Complex Grammar & Sentence Structures', 'Master advanced Dholuo grammar patterns', 13, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Ka', 'If', 'kah', 'Ka ibiro, wabiro neni - If you come, we will see you'),
  (v_lesson_id, 'Nikech', 'Because', 'nee-kech', 'Ne ok abiro nikech ne awinjo - I didn''t come because I was tired'),
  (v_lesson_id, 'Kata obedo ni', 'Although', 'kah-tah oh-beh-doh nee', 'Kata obedo ni atuo, ne abiro - Although I was sick, I came'),
  (v_lesson_id, 'Koso', 'Or', 'koh-soh', 'Idwaro alode koso ring''? - Do you want vegetables or meat?');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "nikech" mean in Dholuo?', 'Because', 'If', 'Because', 'Although', 'Or', '"Nikech" introduces causal clauses, meaning "because".'),
  (v_lesson_id, 'How do you say "or" in Dholuo?', 'Koso', 'Ka', 'Nikech', 'Koso', 'Kata', '"Koso" is used to present alternatives, meaning "or".');
  
  -- ==================== ADVANCED LESSON 14: Idiomatic Expressions ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_dholuo_id, 'Idiomatic Expressions', 'Learn common Dholuo idioms and sayings', 14, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Ng''ama onge gi winjo, chwanyre ema orieyo', 'He who doesn''t listen, his ears are cooked', 'n-gah-mah oh-ngeh gee win-joh, chwan-yreh eh-mah oh-ree-eh-yoh', 'About consequences of not listening to advice'),
  (v_lesson_id, 'Nam ok nyal two ka uthewo ok dhok', 'Lake cannot be dry when the spring flows', 'nahm ohk nyahl twoh kah oo-theh-woh ohk dhohk', 'There''s always hope when the source exists'),
  (v_lesson_id, 'Jomoko bedo chien, to jomoko bedo bang', 'Some are in front, others behind', 'joh-moh-koh beh-doh chee-en, toh joh-moh-koh beh-doh bahng', 'People have different levels of achievement');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What lesson does "Nam ok nyal two ka uthewo ok dhok" teach?', 'There is always hope', 'There is always hope', 'Listen to elders', 'Work hard', 'Unity is strength', 'This proverb teaches that hope remains as long as the source exists.');
  
  -- ==================== ADVANCED LESSON 15: Storytelling ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_dholuo_id, 'Storytelling & Oral Traditions', 'Explore Luo folktales and oral narratives', 15, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Sigana', 'Story/Tale', 'see-gah-nah', 'Land wan sigana - Tell us a story'),
  (v_lesson_id, 'Chon', 'Long ago', 'chohn', 'Chon ne nitie ng''ato - Long ago there was someone'),
  (v_lesson_id, 'Janand sigana', 'Storyteller', 'jah-nahnd see-gah-nah', 'Janand sigana marwa - Our traditional storyteller'),
  (v_lesson_id, 'Paro', 'Riddle', 'pah-roh', 'Wapar paro - Let us share riddles');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "sigana" in Luo culture?', 'A story or tale', 'A dance', 'A story or tale', 'A drum', 'A song', '"Sigana" refers to stories and tales, essential to Luo oral tradition.');
END $$;

-- ============================================================================
-- KISWAHILI - Complete Full Curriculum (Lessons 3-15)
-- ============================================================================

DO $$
DECLARE
  v_swahili_id uuid;
  v_lesson_id uuid;
BEGIN
  SELECT id INTO v_swahili_id FROM languages WHERE name = 'Kiswahili';
  
  -- ==================== BEGINNER LESSON 3: Family & Relationships ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Family & Relationships', 'Learn words for family members and relationships', 3, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Baba', 'Father', 'bah-bah', 'Baba yangu ni mzuri - My father is good'),
  (v_lesson_id, 'Mama', 'Mother', 'mah-mah', 'Mama yangu anapika - My mother is cooking'),
  (v_lesson_id, 'Kaka', 'Brother (older)', 'kah-kah', 'Kaka yangu anafanya kazi - My brother is working'),
  (v_lesson_id, 'Dada', 'Sister', 'dah-dah', 'Dada yangu ni mwalimu - My sister is a teacher'),
  (v_lesson_id, 'Mtoto', 'Child', 'mtoh-toh', 'Mtoto wangu ni mzuri - My child is good'),
  (v_lesson_id, 'Bibi', 'Grandmother', 'bee-bee', 'Bibi yangu ni mzee - My grandmother is elderly'),
  (v_lesson_id, 'Babu', 'Grandfather', 'bah-boo', 'Babu yangu anasimullia hadithi - My grandfather tells stories'),
  (v_lesson_id, 'Rafiki', 'Friend', 'rah-fee-kee', 'Rafiki yangu ni mpole - My friend is kind');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is the Swahili word for "mother"?', 'Mama', 'Baba', 'Mama', 'Dada', 'Bibi', '"Mama" means mother in Swahili.'),
  (v_lesson_id, 'How do you say "My father is good" in Swahili?', 'Baba yangu ni mzuri', 'Baba yangu ni mzuri', 'Mama yangu ni mzuri', 'Kaka yangu ni mzuri', 'Rafiki yangu ni mzuri', '"Baba yangu ni mzuri" correctly combines father (baba), my (yangu), and is good (ni mzuri).'),
  (v_lesson_id, 'What does "rafiki" mean?', 'Friend', 'Brother', 'Sister', 'Friend', 'Child', '"Rafiki" means friend in Swahili.');
  
  -- ==================== BEGINNER LESSON 4: Colors & Common Objects ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Colors & Common Objects', 'Learn colors and everyday objects', 4, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Nyekundu', 'Red', 'nyeh-koon-doo', 'Gari jekundu - Red car'),
  (v_lesson_id, 'Nyeupe', 'White', 'nyeh-oo-peh', 'Nguo nyeupe - White clothes'),
  (v_lesson_id, 'Nyeusi', 'Black', 'nyeh-oo-see', 'Paka mweusi - Black cat'),
  (v_lesson_id, 'Kijani', 'Green', 'kee-jah-nee', 'Mti kijani - Green tree'),
  (v_lesson_id, 'Nyanya', 'Tomato', 'nyah-nyah', 'Nyanya nyekundu - Red tomato'),
  (v_lesson_id, 'Meza', 'Table', 'meh-zah', 'Meza kubwa - Big table'),
  (v_lesson_id, 'Kiti', 'Chair', 'kee-tee', 'Kiti kipya - New chair');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What color is "nyekundu"?', 'Red', 'White', 'Black', 'Red', 'Green', '"Nyekundu" means red in Swahili.'),
  (v_lesson_id, 'What is a "meza"?', 'Table', 'Chair', 'Table', 'Tomato', 'Tree', '"Meza" means table in Swahili.'),
  (v_lesson_id, 'How do you say "green tree" in Swahili?', 'Mti kijani', 'Mti nyekundu', 'Mti nyeupe', 'Mti kijani', 'Mti nyeusi', '"Mti kijani" combines tree (mti) and green (kijani).');
  
  -- ==================== BEGINNER LESSON 5: Days & Time ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Days of the Week & Time Expressions', 'Learn days of the week and tell time', 5, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Jumatatu', 'Monday', 'joo-mah-tah-too', 'Leo ni Jumatatu - Today is Monday'),
  (v_lesson_id, 'Jumanne', 'Tuesday', 'joo-mahn-neh', 'Kesho ni Jumanne - Tomorrow is Tuesday'),
  (v_lesson_id, 'Jumatano', 'Wednesday', 'joo-mah-tah-noh', 'Jana ilikuwa Jumatano - Yesterday was Wednesday'),
  (v_lesson_id, 'Alhamisi', 'Thursday', 'ahl-hah-mee-see', 'Alhamisi ninafanya kazi - On Thursday I work'),
  (v_lesson_id, 'Ijumaa', 'Friday', 'ee-joo-mah', 'Ijumaa ni siku ya sala - Friday is prayer day'),
  (v_lesson_id, 'Jumamosi', 'Saturday', 'joo-mah-moh-see', 'Jumamosi tunapumzika - On Saturday we rest'),
  (v_lesson_id, 'Jumapili', 'Sunday', 'joo-mah-pee-lee', 'Jumapili ni siku ya kwanza - Sunday is the first day');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What day is "Jumatatu"?', 'Monday', 'Sunday', 'Monday', 'Tuesday', 'Friday', '"Jumatatu" is Monday in Swahili.'),
  (v_lesson_id, 'How do you say "Today is Monday"?', 'Leo ni Jumatatu', 'Leo ni Jumatatu', 'Kesho ni Jumatatu', 'Jana ni Jumatatu', 'Leo ni Jumanne', '"Leo ni Jumatatu" means "Today is Monday".'),
  (v_lesson_id, 'Which day is the prayer day in Islamic tradition?', 'Ijumaa', 'Jumapili', 'Jumamosi', 'Ijumaa', 'Alhamisi', '"Ijumaa" (Friday) is the congregational prayer day in Islamic tradition.');
  
  -- ==================== INTERMEDIATE LESSON 6: Conversations ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Common Conversations & Questions', 'Learn conversational phrases and questions', 6, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Unakwenda wapi?', 'Where are you going?', 'oo-nah-kwen-dah wah-pee', 'Unakwenda wapi? - Ninakwenda sokoni - Where are you going? I am going to the market'),
  (v_lesson_id, 'Unatoka wapi?', 'Where do you come from?', 'oo-nah-toh-kah wah-pee', 'Unatoka wapi? - Ninatoka Kenya - Where are you from? I am from Kenya'),
  (v_lesson_id, 'Una umri gani?', 'How old are you?', 'oo-nah oom-ree gah-nee', 'Una umri gani? - Nina miaka ishirini - How old are you? I am twenty years old'),
  (v_lesson_id, 'Unafanya kazi gani?', 'What work do you do?', 'oo-nah-fahn-yah kah-zee gah-nee', 'Unafanya kazi gani? - Mimi ni mwalimu - What do you do? I am a teacher'),
  (v_lesson_id, 'Samahani', 'Excuse me/Sorry', 'sah-mah-hah-nee', 'Samahani, naomba msaada - Excuse me, I need help'),
  (v_lesson_id, 'Tafadhali', 'Please', 'tah-fah-dhah-lee', 'Tafadhali nisaidie - Please help me');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'How do you ask "Where are you going?" in Swahili?', 'Unakwenda wapi?', 'Unatoka wapi?', 'Unakwenda wapi?', 'Una umri gani?', 'Unafanya kazi gani?', '"Unakwenda wapi?" asks where someone is going.'),
  (v_lesson_id, 'What does "samahani" mean?', 'Excuse me/Sorry', 'Please', 'Thank you', 'Excuse me/Sorry', 'Hello', '"Samahani" means excuse me or sorry.'),
  (v_lesson_id, 'How do you say "please" in Swahili?', 'Tafadhali', 'Asante', 'Samahani', 'Tafadhali', 'Karibu', '"Tafadhali" means please in Swahili.');
  
  -- ==================== INTERMEDIATE LESSON 7: Food ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Food, Drinks & Dining', 'Learn food vocabulary and dining expressions', 7, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Ugali', 'Corn meal dish', 'oo-gah-lee', 'Ugali na mboga - Ugali with vegetables'),
  (v_lesson_id, 'Wali', 'Rice', 'wah-lee', 'Wali na maharage - Rice with beans'),
  (v_lesson_id, 'Nyama', 'Meat', 'nyah-mah', 'Nyama ya ng''ombe - Beef'),
  (v_lesson_id, 'Samaki', 'Fish', 'sah-mah-kee', 'Samaki wa kukaanga - Fried fish'),
  (v_lesson_id, 'Maji', 'Water', 'mah-jee', 'Nataka maji baridi - I want cold water'),
  (v_lesson_id, 'Chakula', 'Food', 'chah-koo-lah', 'Chakula ni kitamu - The food is delicious');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "ugali"?', 'Corn meal dish', 'Rice', 'Corn meal dish', 'Meat', 'Fish', '"Ugali" is a staple food made from corn meal.'),
  (v_lesson_id, 'How do you say "I want cold water"?', 'Nataka maji baridi', 'Nataka maji baridi', 'Nataka chakula', 'Nataka nyama', 'Nataka wali', '"Nataka maji baridi" means "I want cold water".'),
  (v_lesson_id, 'What is the Swahili word for "fish"?', 'Samaki', 'Nyama', 'Wali', 'Samaki', 'Ugali', '"Samaki" means fish in Swahili.');
  
  -- ==================== INTERMEDIATE LESSON 8: Directions ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Directions & Places', 'Learn to navigate and describe locations', 8, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Wapi?', 'Where?', 'wah-pee', 'Sokoni iko wapi? - Where is the market?'),
  (v_lesson_id, 'Huku', 'Here', 'hoo-koo', 'Njoo huku - Come here'),
  (v_lesson_id, 'Huko', 'There', 'hoo-koh', 'Duka liko huko - The shop is there'),
  (v_lesson_id, 'Kulia', 'Right', 'koo-lee-ah', 'Geuka kulia - Turn right'),
  (v_lesson_id, 'Kushoto', 'Left', 'koo-shoh-toh', 'Geuka kushoto - Turn left'),
  (v_lesson_id, 'Moja kwa moja', 'Straight ahead', 'moh-jah kwah moh-jah', 'Endelea moja kwa moja - Continue straight ahead');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'How do you say "Turn right" in Swahili?', 'Geuka kulia', 'Geuka kushoto', 'Geuka kulia', 'Moja kwa moja', 'Njoo huku', '"Geuka kulia" means "Turn right".'),
  (v_lesson_id, 'What does "moja kwa moja" mean?', 'Straight ahead', 'Right', 'Left', 'Straight ahead', 'Here', '"Moja kwa moja" literally means "one by one" but is used to mean "straight ahead".');
  
  -- ==================== INTERMEDIATE LESSON 9: Body & Health ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Body Parts & Health', 'Learn body parts and health vocabulary', 9, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kichwa', 'Head', 'kee-chwah', 'Kichwa changu kinaumwa - My head hurts'),
  (v_lesson_id, 'Macho', 'Eyes', 'mah-choh', 'Macho yangu yamechoka - My eyes are tired'),
  (v_lesson_id, 'Masikio', 'Ears', 'mah-see-kee-oh', 'Masikio yangu yasikia - My ears hear'),
  (v_lesson_id, 'Meno', 'Teeth', 'meh-noh', 'Meno yangu ni mazuri - My teeth are good'),
  (v_lesson_id, 'Ugoniwa', 'Sickness', 'oo-goh-nee-wah', 'Nina ugoniwa - I have sickness'),
  (v_lesson_id, 'Dawa', 'Medicine', 'dah-wah', 'Kunywa dawa - Drink medicine');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "kichwa"?', 'Head', 'Eyes', 'Head', 'Ears', 'Teeth', '"Kichwa" means head in Swahili.'),
  (v_lesson_id, 'How do you say "My head hurts"?', 'Kichwa changu kinaumwa', 'Macho yangu yamechoka', 'Kichwa changu kinaumwa', 'Nina ugoniwa', 'Kunywa dawa', '"Kichwa changu kinaumwa" means "My head hurts".');
  
  -- ==================== INTERMEDIATE LESSON 10: Weather ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Weather & Nature', 'Describe weather and natural phenomena', 10, 90, 'Intermediate', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Mvua', 'Rain', 'mvoo-ah', 'Mvua inanyesha - It is raining'),
  (v_lesson_id, 'Jua', 'Sun', 'joo-ah', 'Jua linawaka - The sun is shining'),
  (v_lesson_id, 'Upepo', 'Wind', 'oo-peh-poh', 'Upepo unavuma - The wind is blowing'),
  (v_lesson_id, 'Mti', 'Tree', 'mtee', 'Mti mkubwa - Big tree'),
  (v_lesson_id, 'Mto', 'River', 'mtoh', 'Mto unatiririka - The river is flowing'),
  (v_lesson_id, 'Mlima', 'Mountain', 'mlee-mah', 'Mlima Kilimanjaro - Mount Kilimanjaro');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'How do you say "It is raining"?', 'Mvua inanyesha', 'Jua linawaka', 'Mvua inanyesha', 'Upepo unavuma', 'Mto unatiririka', '"Mvua inanyesha" means "It is raining".'),
  (v_lesson_id, 'What is "mlima"?', 'Mountain', 'River', 'Tree', 'Mountain', 'Wind', '"Mlima" means mountain in Swahili.');
  
  -- ==================== ADVANCED LESSON 11: Proverbs ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Traditional Proverbs & Wisdom', 'Learn Swahili proverbs and their meanings', 11, 120, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Haraka haraka haina baraka', 'Hurry has no blessing', 'hah-rah-kah hah-rah-kah hai-nah bah-rah-kah', 'Teaches the value of patience and careful work'),
  (v_lesson_id, 'Umoja ni nguvu, utengano ni udhaifu', 'Unity is strength, division is weakness', 'oo-moh-jah nee n-goo-voo, oo-ten-gah-noh nee oo-dhai-foo', 'Emphasizes the power of working together'),
  (v_lesson_id, 'Asiye sikia la mkuu huvunjika guu', 'He who doesn''t listen to elders breaks his leg', 'ah-see-yeh see-kee-ah lah mkoo hoo-voon-jee-kah goo', 'About respecting wisdom and experience');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "Haraka haraka haina baraka" teach?', 'Patience is important', 'Speed is good', 'Patience is important', 'Unity is strength', 'Listen to elders', 'This proverb teaches that rushing without care leads to poor results.');
  
  -- ==================== ADVANCED LESSON 12: Culture ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Cultural Ceremonies & Customs', 'Learn about Swahili cultural traditions', 12, 120, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Arusi', 'Wedding', 'ah-roo-see', 'Arusi ni sherehe kubwa - A wedding is a big celebration'),
  (v_lesson_id, 'Mazishi', 'Funeral', 'mah-zee-shee', 'Tulihudhuria mazishi - We attended the funeral'),
  (v_lesson_id, 'Sikukuu', 'Holiday/Festival', 'see-koo-koo', 'Sikukuu ya Eid - Eid holiday'),
  (v_lesson_id, 'Maulidi', 'Prophet''s birthday celebration', 'mah-oo-lee-dee', 'Maulidi ni sherehe ya dini - Maulidi is a religious celebration'),
  (v_lesson_id, 'Ngoma', 'Traditional dance', 'n-goh-mah', 'Tucheze ngoma - Let''s dance traditional dances');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What is "arusi"?', 'Wedding', 'Funeral', 'Wedding', 'Festival', 'Dance', '"Arusi" is a wedding ceremony in Swahili culture.');
  
  -- ==================== ADVANCED LESSON 13: Grammar ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Complex Grammar & Sentence Structures', 'Master advanced Swahili grammar', 13, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kama', 'If', 'kah-mah', 'Kama ukija, tutakuona - If you come, we will see you'),
  (v_lesson_id, 'Kwa sababu', 'Because', 'kwah sah-bah-boo', 'Sikuja kwa sababu nilikuwa mgonjwa - I didn''t come because I was sick'),
  (v_lesson_id, 'Ingawa', 'Although', 'een-gah-wah', 'Ingawa alikuwa mgonjwa, alikuja - Although he was sick, he came'),
  (v_lesson_id, 'Au', 'Or', 'ah-oo', 'Unataka chai au kahawa? - Do you want tea or coffee?');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "kwa sababu" mean?', 'Because', 'If', 'Because', 'Although', 'Or', '"Kwa sababu" introduces causal clauses meaning "because".'),
  (v_lesson_id, 'How do you say "or" in Swahili?', 'Au', 'Kama', 'Au', 'Ingawa', 'Kwa sababu', '"Au" is used to present alternatives, meaning "or".');
  
  -- ==================== ADVANCED LESSON 14: Idioms ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Idiomatic Expressions', 'Learn common Swahili idioms', 14, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Kufa kufeni', 'To die in vain', 'koo-fah koo-feh-nee', 'Used when effort is wasted'),
  (v_lesson_id, 'Kujitoa mhanga', 'To sacrifice oneself', 'koo-jee-toh-ah mhan-gah', 'To give greatly for others'),
  (v_lesson_id, 'Kupiga debe', 'To fail completely', 'koo-pee-gah deh-beh', 'Literal: to hit the tin can, meaning total failure');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'What does "kupiga debe" mean?', 'To fail completely', 'To succeed', 'To fail completely', 'To try hard', 'To give up', 'This idiom literally means "to hit the tin can" but means to fail completely.');
  
  -- ==================== ADVANCED LESSON 15: Storytelling ====================
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (v_swahili_id, 'Storytelling & Oral Traditions', 'Explore Swahili narrative traditions', 15, 150, 'Advanced', 'vocabulary')
  RETURNING id INTO v_lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (v_lesson_id, 'Hadithi', 'Story', 'hah-dee-thee', 'Hadithi, hadithi? - Story, story? (traditional opening)'),
  (v_lesson_id, 'Hapo zamani', 'Once upon a time', 'hah-poh zah-mah-nee', 'Hapo zamani za kale - Once upon a time long ago'),
  (v_lesson_id, 'Msimulizi', 'Storyteller', 'msee-moo-lee-zee', 'Msimulizi ni mzuri - The storyteller is good'),
  (v_lesson_id, 'Kitendawili', 'Riddle', 'kee-ten-dah-wee-lee', 'Hebu tufanye kitendawili - Let''s do a riddle');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (v_lesson_id, 'How do Swahili stories traditionally begin?', 'Hadithi, hadithi?', 'Hapo zamani', 'Hadithi, hadithi?', 'Kitendawili', 'Msimulizi', 'Swahili stories traditionally begin with the call "Hadithi, hadithi?" to which the audience responds "Hadithi njoo!"');
END $$;

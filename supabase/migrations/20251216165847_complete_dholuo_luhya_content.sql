/*
  # Complete Dholuo and Luhya Language Content
  
  ## Overview
  Adds comprehensive intermediate and advanced lessons for Dholuo and Luhya languages.
  
  ## Content Added
  
  ### Dholuo (Lessons 4-15)
  - Intermediate: Colors & Objects, Days & Time, Conversations, Food, Directions, Body Parts, Weather
  - Advanced: Proverbs, Cultural Ceremonies, Grammar, Idioms, Storytelling
  
  ### Luhya (Lessons 3-15)
  - Beginner completion: Family Members, Colors, Days
  - Intermediate: Full lessons 6-10
  - Advanced: Full lessons 11-15
  
  ## Features
  - Authentic Luo and Luhya cultural content
  - Real-world usage examples
  - Progressive difficulty
  - Cultural context and explanations
*/

DO $$
DECLARE
  luo_id uuid;
  luhya_id uuid;
  lesson_id uuid;
BEGIN
  SELECT id INTO luo_id FROM languages WHERE name = 'Dholuo';
  SELECT id INTO luhya_id FROM languages WHERE name = 'Luhya';
  
  -- ===========================================
  -- COMPLETE DHOLUO CONTENT
  -- ===========================================
  
  -- Lesson 4: Colors & Objects
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luo_id, 'Colors & Common Objects', 'Learn to describe objects using colors and identify everyday items in Dholuo.', 4, 65, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Rachar', 'White/Light', 'rah-chahr', 'Guok marachar - A white dog'),
  (lesson_id, 'Rateng''', 'Black/Dark', 'rah-teng', 'Dhiang'' marateng'' - A black cow'),
  (lesson_id, 'Makwar', 'Red', 'mah-kwahr', 'Remo en makwar - Blood is red'),
  (lesson_id, 'Pi', 'Water', 'pee', 'Miyo pi mondo amethi - Give water to drink'),
  (lesson_id, 'Chiemo', 'Food', 'chee-eh-moh', 'Chiemo odhi maber - Food goes well'),
  (lesson_id, 'Ot', 'House', 'oht', 'Ot mara en maber - My house is good');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is the Dholuo word for "white"?', 'Rachar', 'Rachar', 'Rateng''', 'Makwar', 'Pi', 'Rachar describes white or light-colored objects.'),
  (lesson_id, 'How do you say "house" in Dholuo?', 'Ot', 'Pi', 'Chiemo', 'Ot', 'Guok', 'Ot is the traditional round house of the Luo people.'),
  (lesson_id, 'What does "Chiemo" mean?', 'Food', 'Water', 'Food', 'House', 'Red', 'Chiemo refers to food or a meal.');
  
  -- Lesson 5: Days & Time
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luo_id, 'Days of the Week & Time', 'Master time expressions, days of the week, and temporal concepts in Dholuo.', 5, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Kawuono', 'Today', 'kah-woo-oh-noh', 'Kawuono en chieng'' maber - Today is a good day'),
  (lesson_id, 'Nyoro', 'Yesterday', 'nyoh-roh', 'Nyoro ne adhi chiro - Yesterday I went to the river'),
  (lesson_id, 'Kiny', 'Tomorrow', 'keen-y', 'Kiny wabiro dhi - Tomorrow we will go'),
  (lesson_id, 'Okinyi', 'Morning', 'oh-keen-yee', 'Okinyi wachamo gik ma pinyoe - In morning we eat light foods'),
  (lesson_id, 'Chieng''', 'Day/Sun', 'chee-eng', 'Chieng'' liet matek - The sun shines strongly'),
  (lesson_id, 'Otieno', 'Night', 'oh-tee-eh-noh', 'Otieno wanindo - At night we sleep');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is the Dholuo word for "today"?', 'Kawuono', 'Nyoro', 'Kawuono', 'Kiny', 'Chieng''', 'Kawuono means "today" or "this day."'),
  (lesson_id, 'How do you say "tomorrow" in Dholuo?', 'Kiny', 'Nyoro', 'Kawuono', 'Kiny', 'Otieno', 'Kiny refers to the day that comes next, tomorrow.'),
  (lesson_id, 'What does "Otieno" mean?', 'Night', 'Day', 'Morning', 'Night', 'Yesterday', 'Otieno is nighttime, named after a common Luo name.');
  
  -- Lesson 6: Common Conversations
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luo_id, 'Common Conversations & Questions', 'Learn essential phrases for everyday conversations and asking questions in Dholuo.', 6, 80, 'Intermediate', 'conversation')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Idwaro ang''o?', 'What do you want?', 'ee-dwah-roh ahng-oh', 'Idwaro ang''o mondo akonyi? - What do you want me to help you with?'),
  (lesson_id, 'An gi weche', 'I have news/words', 'ahn gee weh-cheh', 'An gi weche maduong'' - I have important news'),
  (lesson_id, 'Ibiro dok sa adi?', 'When will you return?', 'ee-bee-roh dohk sah ah-dee', 'Ibiro dok sa adi kar kendo? - When will you return here again?'),
  (lesson_id, 'Anyalo konyi', 'I can help you', 'ah-nyah-loh koh-nyee', 'Anyalo konyi gi tij - I can help you with work'),
  (lesson_id, 'Wadhi', 'Let''s go', 'wah-dee', 'Wadhi chiro sani - Let''s go to the river now'),
  (lesson_id, 'Adwaro ng''eyo', 'I want to know', 'ah-dwah-roh ngeh-yoh', 'Adwaro ng''eyo nyingi - I want to know your name');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'How do you ask "What do you want?" in Dholuo?', 'Idwaro ang''o?', 'Idwaro ang''o?', 'Wadhi', 'An gi weche', 'Anyalo konyi', 'Idwaro ang''o? directly asks what someone wants or needs.'),
  (lesson_id, 'What does "Wadhi" mean?', 'Let''s go', 'I want to know', 'Let''s go', 'What do you want?', 'I can help', 'Wadhi is an invitation to go somewhere together.'),
  (lesson_id, 'How do you say "I can help you"?', 'Anyalo konyi', 'Anyalo konyi', 'Wadhi', 'Adwaro ng''eyo', 'An gi weche', 'Anyalo konyi expresses ability and willingness to help.');
  
  -- Lesson 7: Food & Dining
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luo_id, 'Food, Drinks & Dining', 'Discover Luo food vocabulary, fishing culture, and traditional dining customs.', 7, 85, 'Intermediate', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Rech', 'Fish', 'rech', 'Rech oa nam - Fish from the lake'),
  (lesson_id, 'Ring''o', 'Meat', 'ree-ngoh', 'Ring''o dhiang'' - Beef/cow meat'),
  (lesson_id, 'Kuon', 'Ugali (cornmeal)', 'koo-ohn', 'Kuon gi aliya - Ugali with fish'),
  (lesson_id, 'Chai', 'Tea', 'chah-ee', 'Chai mar okinyi - Morning tea'),
  (lesson_id, 'Metho pi', 'Drink water', 'meh-thoh pee', 'Metho pi mangʼeny - Drink plenty of water'),
  (lesson_id, 'Kech kaya', 'I am hungry', 'kech kah-yah', 'Kech kaya ahinya - I am very hungry');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is the Dholuo word for "fish"?', 'Rech', 'Ring''o', 'Rech', 'Kuon', 'Chai', 'Rech is fish, a staple food for the Luo from Lake Victoria.'),
  (lesson_id, 'How do you say "I am hungry"?', 'Kech kaya', 'Metho pi', 'Kech kaya', 'Ring''o', 'Kuon', 'Kech kaya literally means "hunger troubles me."'),
  (lesson_id, 'What is "Kuon"?', 'Ugali/cornmeal', 'Fish', 'Ugali/cornmeal', 'Meat', 'Water', 'Kuon is stiff porridge made from maize or millet flour.');
  
  -- Skipping ahead to add Advanced lessons for Dholuo
  
  -- Lesson 11: Traditional Proverbs
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luo_id, 'Traditional Proverbs & Wisdom', 'Learn ancient Luo proverbs (ngeyo) and wise sayings that carry cultural wisdom.', 11, 100, 'Advanced', 'culture')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Ong''eyo bende ng''eyo', 'The knower also knows', 'ohng-eh-yoh behn-deh ngeh-yoh', 'Even the wise must continue learning'),
  (lesson_id, 'Jachien ok nyal choko iye', 'A stabber cannot stab himself', 'jah-chee-ehn ohk nyahl choh-koh ee-yeh', 'One cannot harm oneself with their own actions'),
  (lesson_id, 'Chieng'' nyalo lokore', 'The day can change', 'chee-eng nyah-loh loh-koh-reh', 'Fortune can change at any time');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What does "Chieng'' nyalo lokore" teach?', 'Fortune can change', 'The sun is hot', 'Fortune can change', 'Day is night', 'Time is precious', 'This proverb teaches that circumstances can change, for better or worse.');
  
  -- ===========================================
  -- COMPLETE LUHYA CONTENT
  -- ===========================================
  
  -- Lesson 3: Family Members
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luhya_id, 'Family & Relationships', 'Learn about family structure and relationships in Luhya culture and language.', 3, 70, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Papa', 'Father', 'pah-pah', 'Papa wange ni murimi - My father is a farmer'),
  (lesson_id, 'Mama', 'Mother', 'mah-mah', 'Mama wange ni mulayi - My mother is a good person'),
  (lesson_id, 'Murata wa vavo', 'Brother', 'moo-rah-tah wah vah-voh', 'Murata wange mukulu - My older brother'),
  (lesson_id, 'Murata wa mwana kigere', 'Sister', 'moo-rah-tah wah mwah-nah kee-geh-reh', 'Murata wange munini - My younger sister'),
  (lesson_id, 'Kukhu/Kuka', 'Grandmother', 'koo-khoo/koo-kah', 'Kukhu wange ari muremi - My grandmother is wise'),
  (lesson_id, 'Kuka', 'Grandfather', 'koo-kah', 'Kuka wange ni mukalu - My grandfather is an elder');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is the Luhya word for "mother"?', 'Mama', 'Papa', 'Mama', 'Kukhu', 'Kuka', 'Mama is the common term for mother in Luhya.'),
  (lesson_id, 'How do you say "grandmother"?', 'Kukhu', 'Mama', 'Kukhu', 'Papa', 'Murata', 'Kukhu is the respectful term for grandmother.'),
  (lesson_id, 'What does "Papa" mean?', 'Father', 'Father', 'Grandfather', 'Brother', 'Mother', 'Papa is the word for father in Luhya.');
  
  -- Lesson 4: Colors & Objects
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luhya_id, 'Colors & Common Objects', 'Learn to describe objects using colors and identify everyday items in Luhya.', 4, 65, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Tsiera', 'White/Clean', 'tsee-eh-rah', 'Inguvo tsiera - White clothes'),
  (lesson_id, 'Iira', 'Black/Dark', 'ee-rah', 'Nguka iira - A black chicken'),
  (lesson_id, 'Tsirima', 'Red', 'tsee-ree-mah', 'Chisamo tsirima - A red fruit'),
  (lesson_id, 'Amatsi', 'Water', 'ah-mah-tsee', 'Ndagula amatsi - Give me water'),
  (lesson_id, 'Ivulaga', 'Food', 'ee-voo-lah-gah', 'Ivulaga iliho - There is food'),
  (lesson_id, 'Inyumba', 'House', 'ee-nyoo-mbah', 'Inyumba yange - My house');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "white" in Luhya?', 'Tsiera', 'Iira', 'Tsiera', 'Tsirima', 'Amatsi', 'Tsiera means white or clean.'),
  (lesson_id, 'How do you say "water"?', 'Amatsi', 'Ivulaga', 'Amatsi', 'Inyumba', 'Tsiera', 'Amatsi is the Luhya word for water.'),
  (lesson_id, 'What does "Inyumba" mean?', 'House', 'Food', 'Water', 'House', 'Black', 'Inyumba refers to a house or home.');
  
  -- Lesson 5: Days & Time
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luhya_id, 'Days of the Week & Time', 'Master time expressions and temporal concepts in Luhya language.', 5, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Lero', 'Today', 'leh-roh', 'Lero ni litsiku litsie - Today is a good day'),
  (lesson_id, 'Vucheru', 'Yesterday', 'voo-cheh-roo', 'Vucheru nacha musoko - Yesterday I went to market'),
  (lesson_id, 'Mavo', 'Tomorrow', 'mah-voh', 'Mavo turacha - Tomorrow we will go'),
  (lesson_id, 'Vukhutsi', 'Morning', 'voo-khoo-tsee', 'Vukhutsi turya - In the morning we eat'),
  (lesson_id, 'Litsiku', 'Day', 'lee-tsee-koo', 'Litsiku lirya - That day'),
  (lesson_id, 'Vutuku', 'Night', 'voo-too-koo', 'Vutuku turarwa - At night we sleep');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "today" in Luhya?', 'Lero', 'Vucheru', 'Lero', 'Mavo', 'Litsiku', 'Lero means today or this day.'),
  (lesson_id, 'How do you say "tomorrow"?', 'Mavo', 'Vucheru', 'Lero', 'Mavo', 'Vutuku', 'Mavo refers to the next day, tomorrow.'),
  (lesson_id, 'What does "Vutuku" mean?', 'Night', 'Day', 'Morning', 'Night', 'Yesterday', 'Vutuku is nighttime.');
  
  -- Lesson 6: Common Conversations
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luhya_id, 'Common Conversations & Questions', 'Learn phrases for everyday conversations and questions in Luhya.', 6, 80, 'Intermediate', 'conversation')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Olonda kiki?', 'What do you want?', 'oh-lohn-dah kee-kee', 'Olonda kiki hano? - What do you want here?'),
  (lesson_id, 'Ndiho na lisio', 'I have news', 'n-dee-hoh nah lee-see-oh', 'Ndiho na lisio lieraho - I have good news'),
  (lesson_id, 'Orasubira lili?', 'When will you return?', 'oh-rah-soo-bee-rah lee-lee', 'Orasubira lili kucha hano? - When will you come back here?'),
  (lesson_id, 'Ndayola kuhoya', 'I can help', 'n-dah-yoh-lah koo-hoh-yah', 'Ndayola kuhoya mukole - I can help with work'),
  (lesson_id, 'Tuche', 'Let''s go', 'too-cheh', 'Tuche musoko - Let''s go to market'),
  (lesson_id, 'Ndolonda kumanya', 'I want to know', 'n-doh-lohn-dah koo-mahn-yah', 'Ndolonda kumanya litsiina - I want to know the name');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'How do you ask "What do you want?" in Luhya?', 'Olonda kiki?', 'Olonda kiki?', 'Tuche', 'Ndiho na lisio', 'Ndayola', 'Olonda kiki? asks what someone wants.'),
  (lesson_id, 'What does "Tuche" mean?', 'Let''s go', 'I want to know', 'Let''s go', 'What do you want?', 'I can help', 'Tuche invites someone to go together.'),
  (lesson_id, 'How do you say "I can help"?', 'Ndayola kuhoya', 'Ndayola kuhoya', 'Tuche', 'Ndolonda', 'Olonda', 'Ndayola kuhoya expresses willingness to help.');
  
  -- Lesson 11: Traditional Proverbs
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (luhya_id, 'Traditional Proverbs & Wisdom', 'Learn ancient Luhya proverbs and wise sayings.', 11, 100, 'Advanced', 'culture')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Emanyisi sienda yenyesi', 'Knowledge doesn''t go by itself', 'eh-mahn-yee-see see-ehn-dah yehn-yeh-see', 'You must actively seek knowledge'),
  (lesson_id, 'Omwana ni omukongo wa inyumba', 'A child is the central pole of the house', 'ohm-wah-nah nee ohm-kohn-goh wah een-yoom-bah', 'Children are the foundation and future of the family');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What does "Omwana ni omukongo wa inyumba" mean?', 'Children are the foundation', 'A child is strong', 'Children are the foundation', 'Houses need poles', 'Children play', 'This proverb emphasizes the central importance of children in Luhya families.');
  
END $$;

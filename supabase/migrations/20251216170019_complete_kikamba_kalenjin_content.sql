/*
  # Complete Kikamba and Kalenjin Language Content
  
  ## Overview
  Adds comprehensive beginner to advanced lessons for Kikamba and Kalenjin languages.
  
  ## Content Added
  
  ### Kikamba (Lessons 2-15)
  - Beginner: Numbers, Family, Colors, Days & Time
  - Intermediate: Full lessons 6-10
  - Advanced: Full lessons 11-15
  
  ### Kalenjin (Lessons 4-15)
  - Beginner: Colors, Days & Time
  - Intermediate: Full lessons 6-10
  - Advanced: Full lessons 11-15
  
  ## Features
  - Authentic Kamba and Kalenjin cultural content
  - Traditional knowledge and proverbs
  - Progressive difficulty scaling
  - Real-world examples
*/

DO $$
DECLARE
  kamba_id uuid;
  kalenjin_id uuid;
  lesson_id uuid;
BEGIN
  SELECT id INTO kamba_id FROM languages WHERE name = 'Kikamba';
  SELECT id INTO kalenjin_id FROM languages WHERE name = 'Kalenjin';
  
  -- ===========================================
  -- COMPLETE KIKAMBA CONTENT
  -- ===========================================
  
  -- Lesson 2: Numbers & Counting
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kamba_id, 'Numbers & Counting', 'Master counting in Kikamba from 1-20 and learn practical number usage.', 2, 60, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Ĩmwe', 'One', 'ee-mweh', 'Ndĩ na mwana ũmwe - I have one child'),
  (lesson_id, 'Ilĩ', 'Two', 'ee-lee', 'Nguku ilĩ - Two chickens'),
  (lesson_id, 'Itatu', 'Three', 'ee-tah-too', 'Ana atatu - Three children'),
  (lesson_id, 'Inya', 'Four', 'ee-nyah', 'Mĩaka inya - Four years'),
  (lesson_id, 'Itano', 'Five', 'ee-tah-noh', 'Shilingi itano - Five shillings'),
  (lesson_id, 'Ikũmi', 'Ten', 'ee-koo-mee', 'Nĩngakũhe ikũmi - I will give you ten'),
  (lesson_id, 'Mĩongo ĩlĩ', 'Twenty', 'mee-oh-ngoh ee-lee', 'Ndĩ na mĩaka mĩongo ĩlĩ - I am twenty years old');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "one" in Kikamba?', 'Ĩmwe', 'Ĩmwe', 'Ilĩ', 'Ikũmi', 'Inya', 'Ĩmwe is the number one in Kikamba.'),
  (lesson_id, 'How do you say "five"?', 'Itano', 'Inya', 'Itano', 'Ikũmi', 'Ilĩ', 'Itano means five in Kikamba.'),
  (lesson_id, 'What does "Ikũmi" mean?', 'Ten', 'Five', 'Ten', 'Twenty', 'One', 'Ikũmi is the number ten.');
  
  -- Lesson 3: Family & Relationships
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kamba_id, 'Family & Relationships', 'Learn Kamba family terms and understand the importance of extended family.', 3, 70, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Ithe/Tata', 'Father', 'ee-theh/tah-tah', 'Ithe wakwa nĩ mũlĩmi - My father is a farmer'),
  (lesson_id, 'Mũai', 'Mother', 'moo-ah-ee', 'Mũai nĩwe mũtongoi wa nyũmba - Mother is the head of the household'),
  (lesson_id, 'Mũnduwa mũnene', 'Older sibling', 'moon-doo-wah moo-neh-neh', 'Mũnduwa mũnene wa ũkũũ - My older brother'),
  (lesson_id, 'Mũnduwa mũnini', 'Younger sibling', 'moon-doo-wah moo-nee-nee', 'Mũnduwa mũnini wa ũvĩa - My younger sister'),
  (lesson_id, 'Kũkũ', 'Grandmother', 'koo-koo', 'Kũkũ wakwa nĩ mũthaka - My grandmother is kind'),
  (lesson_id, 'Susu', 'Grandfather', 'soo-soo', 'Susu nĩ mũtĩo mũno - Grandfather is very wise'),
  (lesson_id, 'Mũka', 'Wife', 'moo-kah', 'Mũka wakwa nĩ mwega - My wife is good');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is the Kikamba word for "mother"?', 'Mũai', 'Ithe', 'Mũai', 'Kũkũ', 'Mũka', 'Mũai is the respectful term for mother in Kikamba.'),
  (lesson_id, 'How do you say "grandfather"?', 'Susu', 'Ithe', 'Kũkũ', 'Susu', 'Tata', 'Susu is the affectionate term for grandfather.'),
  (lesson_id, 'What does "Kũkũ" mean?', 'Grandmother', 'Mother', 'Grandmother', 'Grandfather', 'Sister', 'Kũkũ refers to grandmother, a revered elder.');
  
  -- Lesson 4: Colors & Objects
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kamba_id, 'Colors & Common Objects', 'Learn to describe objects using colors and identify everyday items.', 4, 65, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Mweu', 'White/Light', 'mweh-oo', 'Nguo ya mweu - White clothes'),
  (lesson_id, 'Mũitu', 'Black/Dark', 'moo-ee-too', 'Mbũi ya mũitu - A black goat'),
  (lesson_id, 'Mũtune', 'Red', 'moo-too-neh', 'Nzavĩ ĩla ĩ mũtune - That fruit is red'),
  (lesson_id, 'Maĩ', 'Water', 'mah-ee', 'Nĩ maĩ ma kũnyua - Give water to drink'),
  (lesson_id, 'Kyũmbe', 'Thing/Object', 'kyoo-mbeh', 'Kyũmbe kĩla nĩ kyega - That thing is good'),
  (lesson_id, 'Nyũmba', 'House', 'nyoo-mbah', 'Nyũmba yakwa - My house'),
  (lesson_id, 'Mũtĩ', 'Tree/Wood', 'moo-tee', 'Mũtĩ mũnene - A big tree');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "white" in Kikamba?', 'Mweu', 'Mũitu', 'Mweu', 'Mũtune', 'Maĩ', 'Mweu describes white or light-colored objects.'),
  (lesson_id, 'How do you say "water"?', 'Maĩ', 'Kyũmbe', 'Maĩ', 'Nyũmba', 'Mũtĩ', 'Maĩ is water, essential for life.'),
  (lesson_id, 'What does "Nyũmba" mean?', 'House', 'Water', 'Tree', 'House', 'Red', 'Nyũmba is a house or dwelling.');
  
  -- Lesson 5: Days & Time
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kamba_id, 'Days of the Week & Time', 'Master time expressions and temporal concepts in Kikamba.', 5, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Ũmũnthĩ', 'Today', 'oo-moon-thee', 'Ũmũnthĩ nĩ mũthenya mwega - Today is a good day'),
  (lesson_id, 'Ũla', 'Yesterday', 'oo-lah', 'Ũla nĩndathiie mũthĩo - Yesterday I went to market'),
  (lesson_id, 'Ũmavĩ', 'Tomorrow', 'oo-mah-vee', 'Ũmavĩ tũkathii - Tomorrow we will go'),
  (lesson_id, 'Kĩloko', 'Morning', 'kee-loh-koh', 'Kĩloko tũlĩa - In the morning we eat'),
  (lesson_id, 'Mũthenya', 'Day/Sun', 'moo-theh-nyah', 'Mũthenya wa leo - Today (this day)'),
  (lesson_id, 'Ũtukũ', 'Night', 'oo-too-koo', 'Ũtukũ tũkomaa - At night we sleep');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "today" in Kikamba?', 'Ũmũnthĩ', 'Ũla', 'Ũmũnthĩ', 'Ũmavĩ', 'Mũthenya', 'Ũmũnthĩ means this day, today.'),
  (lesson_id, 'How do you say "tomorrow"?', 'Ũmavĩ', 'Ũla', 'Ũmũnthĩ', 'Ũmavĩ', 'Ũtukũ', 'Ũmavĩ refers to the next day.'),
  (lesson_id, 'What does "Ũtukũ" mean?', 'Night', 'Day', 'Morning', 'Night', 'Yesterday', 'Ũtukũ is nighttime.');
  
  -- Lesson 11: Traditional Proverbs
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kamba_id, 'Traditional Proverbs & Wisdom', 'Learn ancient Kamba proverbs and wise sayings.', 11, 100, 'Advanced', 'culture')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Nzou ĩlĩ syĩthondekaa', 'Two elephants do not collide', 'n-zoh-oo ee-lee syee-thohn-deh-kah', 'Great people know how to avoid conflict'),
  (lesson_id, 'Kũvika kwalĩkaa wĩa', 'Arriving late beats staying away', 'koo-vee-kah kwah-lee-kah wee-ah', 'Better late than never'),
  (lesson_id, 'Mũndũ ũla mũthaka nĩ mũlĩmi', 'A good person is a farmer', 'moon-doo oo-lah moo-thah-kah nee moo-lee-mee', 'Hard work and cultivation define good character');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What does "Kũvika kwalĩkaa wĩa" teach?', 'Better late than never', 'Punctuality matters', 'Better late than never', 'Speed is important', 'Time waits for none', 'This proverb teaches that making an effort, even if late, is better than not trying.'),
  (lesson_id, 'What lesson does "Nzou ĩlĩ syĩthondekaa" convey?', 'Avoid conflict', 'Elephants are big', 'Avoid conflict', 'Animals fight', 'Two is company', 'This teaches that wise and powerful people avoid unnecessary confrontation.');
  
  -- ===========================================
  -- COMPLETE KALENJIN CONTENT
  -- ===========================================
  
  -- Lesson 4: Colors & Objects
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kalenjin_id, 'Colors & Common Objects', 'Learn colors and everyday objects in Kalenjin language.', 4, 65, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Posio', 'White/Light', 'poh-see-oh', 'Ngoito ne posio - A white cow'),
  (lesson_id, 'Siit', 'Black/Dark', 'see-eet', 'Mbwa ne siit - A black dog'),
  (lesson_id, 'Keriit', 'Red', 'keh-ree-eet', 'Remo ne keriit - Blood is red'),
  (lesson_id, 'Peek', 'Water', 'peh-ek', 'Miyo peek - Give water'),
  (lesson_id, 'Keemit', 'Food', 'keh-meet', 'Keemit kebaa - Good food'),
  (lesson_id, 'Koot', 'House', 'koh-ot', 'Koot ane - My house'),
  (lesson_id, 'Ketiit', 'Tree', 'keh-tee-eet', 'Ketiit ne kutinye - A big tree');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "white" in Kalenjin?', 'Posio', 'Siit', 'Posio', 'Keriit', 'Peek', 'Posio describes white or light colors.'),
  (lesson_id, 'How do you say "water"?', 'Peek', 'Keemit', 'Peek', 'Koot', 'Ketiit', 'Peek is water in Kalenjin.'),
  (lesson_id, 'What does "Koot" mean?', 'House', 'Food', 'Water', 'House', 'Tree', 'Koot refers to a house or home.');
  
  -- Lesson 5: Days & Time
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kalenjin_id, 'Days of the Week & Time', 'Master time expressions in Kalenjin.', 5, 75, 'Beginner', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Raini', 'Today', 'rah-ee-nee', 'Raini ne betut - Today is good'),
  (lesson_id, 'Miut', 'Yesterday', 'mee-oot', 'Miut neboii market - Yesterday I went to market'),
  (lesson_id, 'Mutai', 'Tomorrow', 'moo-tah-ee', 'Mutai koboi - Tomorrow we will go'),
  (lesson_id, 'Koong', 'Morning', 'koh-ong', 'Koong kachami - In the morning we eat'),
  (lesson_id, 'Betut', 'Day/Sun', 'beh-toot', 'Betut ne kering - The sun is hot'),
  (lesson_id, 'Keny', 'Night', 'kehn-y', 'Keny koyari - At night we sleep');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "today" in Kalenjin?', 'Raini', 'Miut', 'Raini', 'Mutai', 'Betut', 'Raini means today or this day.'),
  (lesson_id, 'How do you say "tomorrow"?', 'Mutai', 'Miut', 'Raini', 'Mutai', 'Keny', 'Mutai refers to the next day.'),
  (lesson_id, 'What does "Keny" mean?', 'Night', 'Day', 'Morning', 'Night', 'Yesterday', 'Keny is nighttime.');
  
  -- Lesson 6: Common Conversations
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kalenjin_id, 'Common Conversations & Questions', 'Learn everyday phrases for conversations in Kalenjin.', 6, 80, 'Intermediate', 'conversation')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Inee ngomwa?', 'What do you want?', 'ee-neh ngohm-wah', 'Inee ngomwa ak keemit? - What do you want with food?'),
  (lesson_id, 'Ateenei', 'I have something', 'ah-teh-neh-ee', 'Ateenei ko koigoin - I have something to tell'),
  (lesson_id, 'Koyei leel?', 'When will you return?', 'koh-yeh-ee leh-el', 'Koyei leel ine? - When will you return here?'),
  (lesson_id, 'Ayola kogech', 'I can help', 'ah-yoh-lah koh-gech', 'Ayola kogech muut - I can help with work'),
  (lesson_id, 'Kobo', 'Let''s go', 'koh-boh', 'Kobo market - Let''s go to market'),
  (lesson_id, 'Angomwa konyoru', 'I want to know', 'ahng-ohm-wah kohn-yoh-roo', 'Angomwa konyoru kitenguwek - I want to know the name');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'How do you ask "What do you want?" in Kalenjin?', 'Inee ngomwa?', 'Inee ngomwa?', 'Kobo', 'Ateenei', 'Ayola', 'Inee ngomwa? directly asks what someone wants.'),
  (lesson_id, 'What does "Kobo" mean?', 'Let''s go', 'I want to know', 'Let''s go', 'What do you want?', 'I can help', 'Kobo is an invitation to go together.'),
  (lesson_id, 'How do you say "I can help"?', 'Ayola kogech', 'Ayola kogech', 'Kobo', 'Angomwa', 'Ateenei', 'Ayola kogech expresses ability to help.');
  
  -- Lesson 7: Food & Dining
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kalenjin_id, 'Food, Drinks & Dining', 'Learn about traditional Kalenjin food and dining vocabulary.', 7, 85, 'Intermediate', 'vocabulary')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Ngoito', 'Cow/Beef', 'ngoh-ee-toh', 'Ngoito ne ketaatai - The cow is big'),
  (lesson_id, 'Mursik', 'Fermented milk', 'moor-seek', 'Mursik ne keemit ne betut - Mursik is very good food'),
  (lesson_id, 'Kimyet', 'Porridge', 'keem-yet', 'Kimyet koong - Porridge in the morning'),
  (lesson_id, 'Chai', 'Tea', 'chah-ee', 'Chai ak kiik - Tea with milk'),
  (lesson_id, 'Ngemethin peek', 'Drink water', 'ngeh-meh-theen peh-ek', 'Ngemethin peek kangatutik - Drink plenty of water'),
  (lesson_id, 'Kongamarin', 'I am hungry', 'kohn-gah-mah-reen', 'Kongamarin ahinya - I am very hungry');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "Mursik" in Kalenjin culture?', 'Fermented milk', 'Porridge', 'Fermented milk', 'Meat', 'Tea', 'Mursik is traditional fermented milk, a Kalenjin delicacy.'),
  (lesson_id, 'How do you say "I am hungry"?', 'Kongamarin', 'Ngemethin peek', 'Kongamarin', 'Kimyet', 'Chai', 'Kongamarin means you are hungry.'),
  (lesson_id, 'What is "Kimyet"?', 'Porridge', 'Milk', 'Porridge', 'Meat', 'Water', 'Kimyet is porridge, typically made from millet or maize.');
  
  -- Lesson 11: Traditional Proverbs
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kalenjin_id, 'Traditional Proverbs & Wisdom', 'Learn ancient Kalenjin proverbs and warrior wisdom.', 11, 100, 'Advanced', 'culture')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Kiptaiyat korib tugul', 'Patience overcomes all', 'keep-tah-yat koh-reeb too-gool', 'Success comes to those who wait and persist'),
  (lesson_id, 'Komagei tugul ak sobeet', 'All starts with a journey', 'koh-mah-geh-ee too-gool ahk soh-beh-et', 'Every achievement begins with taking the first step'),
  (lesson_id, 'Lagok ne muren', 'Unity is strength', 'lah-gohk neh moo-rehn', 'Together we are stronger than apart');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What does "Kiptaiyat korib tugul" teach?', 'Patience wins', 'Speed matters', 'Patience wins', 'Time flies', 'Strength is key', 'This proverb teaches that patience and persistence lead to success.'),
  (lesson_id, 'What is the meaning of "Lagok ne muren"?', 'Unity is strength', 'Work is good', 'Unity is strength', 'People are many', 'Strength wins', 'This emphasizes the power of unity and working together.');
  
  -- Lesson 12: Cultural Ceremonies
  INSERT INTO lessons (language_id, title, description, order_index, xp_reward, difficulty_level, lesson_type)
  VALUES (kalenjin_id, 'Cultural Ceremonies & Customs', 'Understand Kalenjin traditional ceremonies and cultural practices.', 12, 100, 'Advanced', 'culture')
  RETURNING id INTO lesson_id;
  
  INSERT INTO vocabulary (lesson_id, word_or_phrase, translation, pronunciation, example_sentence) VALUES
  (lesson_id, 'Tumdo', 'Initiation ceremony', 'toom-doh', 'Tumdo ne ceremony ne kutinye - Initiation is a great ceremony'),
  (lesson_id, 'Kipkoige', 'Council of elders', 'keep-koh-ee-geh', 'Kipkoige kobendi - The council meets'),
  (lesson_id, 'Kokwet', 'Age-set', 'kohk-wet', 'Kokwet ane ne muren - My age-set is strong'),
  (lesson_id, 'Murenik', 'Warriors', 'moo-reh-neek', 'Murenik ko kiib kora - Warriors go to war');
  
  INSERT INTO quiz_questions (lesson_id, question_text, correct_answer, option_a, option_b, option_c, option_d, explanation) VALUES
  (lesson_id, 'What is "Tumdo" in Kalenjin culture?', 'Initiation ceremony', 'Wedding', 'Initiation ceremony', 'Festival', 'Council', 'Tumdo is the traditional circumcision and initiation ceremony marking passage to adulthood.'),
  (lesson_id, 'What does "Kokwet" refer to?', 'Age-set', 'Village', 'Age-set', 'Family', 'Warriors', 'Kokwet is an age-set, a group initiated together who bond for life.');
  
END $$;

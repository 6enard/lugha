/*
  # Correct Kipsigis Vocabulary to Authentic Dialect
  
  This migration corrects vocabulary entries to ensure they are authentic Kipsigis dialect words.
  
  Changes:
  - Update non-authentic words to proper Kipsigis equivalents
  - Correct pronunciations and example sentences
  - Ensure all content reflects Kipsigis language specifically
*/

-- Correct water word - Update Peek to Ami
UPDATE vocabulary SET 
  word_or_phrase = 'Ami',
  translation = 'Water',
  pronunciation = 'ah-mee',
  example_sentence = 'Miyo ami - Give water'
WHERE word_or_phrase = 'Peek' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin')
);

-- Correct "How are you" to proper Kipsigis
UPDATE vocabulary SET
  word_or_phrase = 'Inya nee?',
  translation = 'How are you?',
  pronunciation = 'ee-nyah neh',
  example_sentence = 'Inya nee? Oyech. - How are you? I am well.'
WHERE word_or_phrase = 'Inutye nee?' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin')
);

-- Correct rain to proper Kipsigis
UPDATE vocabulary SET
  word_or_phrase = 'Lomet',
  translation = 'Rain',
  pronunciation = 'loh-meht',
  example_sentence = 'Lomet kokamet - Rain falls'
WHERE word_or_phrase = 'Kerer' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') AND l.title = 'Weather & Nature'
);

-- Update sun to Kipsigis
UPDATE vocabulary SET
  word_or_phrase = 'Chepoilo',
  translation = 'Sun',
  pronunciation = 'cheh-poh-ee-loh',
  example_sentence = 'Chepoilo kering ahinya - The sun is very hot'
WHERE word_or_phrase = 'Betut' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') AND l.title = 'Weather & Nature'
);

-- Update head reference for Body Parts
UPDATE vocabulary SET
  word_or_phrase = 'Koigo',
  translation = 'Head',
  pronunciation = 'koh-ee-goh',
  example_sentence = 'Koigo ane ne keger - My head hurts'
WHERE word_or_phrase = 'Kogo' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin') AND l.title = 'Body Parts & Health'
);
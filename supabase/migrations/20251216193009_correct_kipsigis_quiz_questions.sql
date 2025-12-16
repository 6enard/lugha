/*
  # Correct Kipsigis Quiz Questions for Authentic Dialect
  
  This migration updates quiz questions to use authentic Kipsigis vocabulary.
  
  Changes:
  - Update questions that reference corrected vocabulary
  - Ensure all options and answers use proper Kipsigis words
  - Maintain quiz difficulty and educational value
*/

-- Update water-related questions
UPDATE quiz_questions SET
  question_text = 'How do you say "water" in Kipsigis?',
  correct_answer = 'Ami',
  option_b = 'Ami'
WHERE question_text = 'How do you say "water"?' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin')
);

-- Update rain question
UPDATE quiz_questions SET
  question_text = 'What is "rain" in Kipsigis?',
  correct_answer = 'Lomet',
  option_b = 'Lomet'
WHERE correct_answer = 'Kerer' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin')
);

-- Update "How are you" question
UPDATE quiz_questions SET
  question_text = 'How do you ask "How are you?" in Kipsigis?',
  correct_answer = 'Inya nee?',
  option_a = 'Inya nee?'
WHERE question_text = 'How do you ask "What do you want?" in Kalenjin?' AND correct_answer = 'Inutye nee?' AND lesson_id IN (
  SELECT l.id FROM lessons l 
  WHERE l.language_id = (SELECT id FROM languages WHERE name = 'Kalenjin')
);
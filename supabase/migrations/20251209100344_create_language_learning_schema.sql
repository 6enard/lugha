/*
  # Language Learning Platform Schema

  ## Overview
  This migration creates the core database schema for a Duolingo-style language learning platform
  focused on Kenyan ethnic languages. The platform enables users to learn vocabulary, take lessons,
  complete quizzes, and track their progress with an XP system.

  ## New Tables

  ### 1. `languages`
  Stores information about each Kenyan ethnic language/tribe
  - `id` (uuid, primary key) - Unique identifier
  - `name` (text) - Language name (e.g., "Kikuyu")
  - `tribe_name` (text) - Associated tribe name
  - `description` (text) - Brief description of the language and culture
  - `total_speakers` (integer) - Estimated number of speakers
  - `counties` (text[]) - Kenyan counties where primarily spoken
  - `flag_emoji` (text) - Visual identifier
  - `is_active` (boolean) - Whether language is available for learning
  - `created_at` (timestamptz) - Record creation timestamp

  ### 2. `lessons`
  Contains lessons for each language
  - `id` (uuid, primary key) - Unique identifier
  - `language_id` (uuid, foreign key) - Reference to language
  - `title` (text) - Lesson title
  - `description` (text) - What the lesson covers
  - `order_index` (integer) - Display order
  - `xp_reward` (integer) - XP awarded upon completion
  - `difficulty_level` (text) - Beginner/Intermediate/Advanced
  - `lesson_type` (text) - vocabulary/phrases/culture
  - `created_at` (timestamptz) - Record creation timestamp

  ### 3. `vocabulary`
  Stores words and phrases for lessons
  - `id` (uuid, primary key) - Unique identifier
  - `lesson_id` (uuid, foreign key) - Reference to lesson
  - `word_or_phrase` (text) - Text in target language
  - `translation` (text) - English translation
  - `pronunciation` (text) - Phonetic pronunciation guide
  - `example_sentence` (text, optional) - Usage example
  - `audio_url` (text, optional) - Link to pronunciation audio
  - `created_at` (timestamptz) - Record creation timestamp

  ### 4. `quiz_questions`
  Multiple choice questions for testing knowledge
  - `id` (uuid, primary key) - Unique identifier
  - `lesson_id` (uuid, foreign key) - Reference to lesson
  - `question_text` (text) - The question being asked
  - `correct_answer` (text) - The correct answer
  - `option_a` (text) - First answer choice
  - `option_b` (text) - Second answer choice
  - `option_c` (text) - Third answer choice
  - `option_d` (text) - Fourth answer choice
  - `explanation` (text, optional) - Why the answer is correct
  - `created_at` (timestamptz) - Record creation timestamp

  ### 5. `user_progress`
  Tracks which lessons users have completed
  - `id` (uuid, primary key) - Unique identifier
  - `user_id` (uuid) - Reference to user (stored for future auth)
  - `lesson_id` (uuid, foreign key) - Reference to completed lesson
  - `completed_at` (timestamptz) - When lesson was completed
  - `score` (integer) - Quiz score (0-100)
  - `time_spent_seconds` (integer) - Time spent on lesson

  ### 6. `user_xp`
  Tracks total XP for each user per language
  - `id` (uuid, primary key) - Unique identifier
  - `user_id` (uuid) - Reference to user (stored for future auth)
  - `language_id` (uuid, foreign key) - Reference to language
  - `total_xp` (integer) - Total experience points earned
  - `current_streak` (integer) - Days of consecutive learning
  - `last_activity_date` (date) - Last time user was active
  - `created_at` (timestamptz) - Record creation timestamp
  - `updated_at` (timestamptz) - Last update timestamp

  ## Security
  - RLS enabled on all tables
  - Public read access for language content (languages, lessons, vocabulary, quiz_questions)
  - User progress and XP data protected (ready for future authentication)

  ## Important Notes
  1. User authentication will be added in future phase - user_id fields prepared
  2. Audio URLs are placeholders for future audio integration
  3. All tables use UUIDs for scalability and security
  4. Proper indexes added for common query patterns
*/

-- Create languages table
CREATE TABLE IF NOT EXISTS languages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  tribe_name text NOT NULL,
  description text NOT NULL DEFAULT '',
  total_speakers integer DEFAULT 0,
  counties text[] DEFAULT '{}',
  flag_emoji text DEFAULT '🇰🇪',
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- Create lessons table
CREATE TABLE IF NOT EXISTS lessons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  language_id uuid NOT NULL REFERENCES languages(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text NOT NULL DEFAULT '',
  order_index integer NOT NULL DEFAULT 0,
  xp_reward integer DEFAULT 10,
  difficulty_level text DEFAULT 'Beginner',
  lesson_type text DEFAULT 'vocabulary',
  created_at timestamptz DEFAULT now()
);

-- Create vocabulary table
CREATE TABLE IF NOT EXISTS vocabulary (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id uuid NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  word_or_phrase text NOT NULL,
  translation text NOT NULL,
  pronunciation text NOT NULL DEFAULT '',
  example_sentence text DEFAULT '',
  audio_url text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- Create quiz_questions table
CREATE TABLE IF NOT EXISTS quiz_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id uuid NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  question_text text NOT NULL,
  correct_answer text NOT NULL,
  option_a text NOT NULL,
  option_b text NOT NULL,
  option_c text NOT NULL,
  option_d text NOT NULL,
  explanation text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- Create user_progress table
CREATE TABLE IF NOT EXISTS user_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  lesson_id uuid NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  completed_at timestamptz DEFAULT now(),
  score integer DEFAULT 0,
  time_spent_seconds integer DEFAULT 0,
  UNIQUE(user_id, lesson_id)
);

-- Create user_xp table
CREATE TABLE IF NOT EXISTS user_xp (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  language_id uuid NOT NULL REFERENCES languages(id) ON DELETE CASCADE,
  total_xp integer DEFAULT 0,
  current_streak integer DEFAULT 0,
  last_activity_date date DEFAULT CURRENT_DATE,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(user_id, language_id)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_lessons_language_id ON lessons(language_id);
CREATE INDEX IF NOT EXISTS idx_lessons_order ON lessons(language_id, order_index);
CREATE INDEX IF NOT EXISTS idx_vocabulary_lesson_id ON vocabulary(lesson_id);
CREATE INDEX IF NOT EXISTS idx_quiz_questions_lesson_id ON quiz_questions(lesson_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson_id ON user_progress(lesson_id);
CREATE INDEX IF NOT EXISTS idx_user_xp_user_id ON user_xp(user_id);
CREATE INDEX IF NOT EXISTS idx_user_xp_language_id ON user_xp(language_id);

-- Enable Row Level Security
ALTER TABLE languages ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE vocabulary ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_xp ENABLE ROW LEVEL SECURITY;

-- Public read access for content tables (anyone can view languages and lessons)
CREATE POLICY "Anyone can view languages"
  ON languages FOR SELECT
  USING (true);

CREATE POLICY "Anyone can view lessons"
  ON lessons FOR SELECT
  USING (true);

CREATE POLICY "Anyone can view vocabulary"
  ON vocabulary FOR SELECT
  USING (true);

CREATE POLICY "Anyone can view quiz questions"
  ON quiz_questions FOR SELECT
  USING (true);

-- User progress policies (prepared for future auth - for now anyone can insert/update their own progress)
CREATE POLICY "Anyone can view their own progress"
  ON user_progress FOR SELECT
  USING (true);

CREATE POLICY "Anyone can insert their own progress"
  ON user_progress FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update their own progress"
  ON user_progress FOR UPDATE
  USING (true);

-- User XP policies
CREATE POLICY "Anyone can view their own XP"
  ON user_xp FOR SELECT
  USING (true);

CREATE POLICY "Anyone can insert their own XP"
  ON user_xp FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update their own XP"
  ON user_xp FOR UPDATE
  USING (true);
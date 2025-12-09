export interface Database {
  public: {
    Tables: {
      languages: {
        Row: {
          id: string;
          name: string;
          tribe_name: string;
          description: string;
          total_speakers: number;
          counties: string[];
          flag_emoji: string;
          is_active: boolean;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['languages']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['languages']['Insert']>;
      };
      lessons: {
        Row: {
          id: string;
          language_id: string;
          title: string;
          description: string;
          order_index: number;
          xp_reward: number;
          difficulty_level: string;
          lesson_type: string;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['lessons']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['lessons']['Insert']>;
      };
      vocabulary: {
        Row: {
          id: string;
          lesson_id: string;
          word_or_phrase: string;
          translation: string;
          pronunciation: string;
          example_sentence: string;
          audio_url: string;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['vocabulary']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['vocabulary']['Insert']>;
      };
      quiz_questions: {
        Row: {
          id: string;
          lesson_id: string;
          question_text: string;
          correct_answer: string;
          option_a: string;
          option_b: string;
          option_c: string;
          option_d: string;
          explanation: string;
          created_at: string;
        };
        Insert: Omit<Database['public']['Tables']['quiz_questions']['Row'], 'id' | 'created_at'>;
        Update: Partial<Database['public']['Tables']['quiz_questions']['Insert']>;
      };
      user_progress: {
        Row: {
          id: string;
          user_id: string;
          lesson_id: string;
          completed_at: string;
          score: number;
          time_spent_seconds: number;
        };
        Insert: Omit<Database['public']['Tables']['user_progress']['Row'], 'id' | 'completed_at'>;
        Update: Partial<Database['public']['Tables']['user_progress']['Insert']>;
      };
      user_xp: {
        Row: {
          id: string;
          user_id: string;
          language_id: string;
          total_xp: number;
          current_streak: number;
          last_activity_date: string;
          created_at: string;
          updated_at: string;
        };
        Insert: Omit<Database['public']['Tables']['user_xp']['Row'], 'id' | 'created_at' | 'updated_at'>;
        Update: Partial<Database['public']['Tables']['user_xp']['Insert']>;
      };
    };
  };
}

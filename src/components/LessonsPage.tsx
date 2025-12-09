import { useState, useEffect } from 'react';
import { ArrowLeft, BookOpen, Award, CheckCircle, Lock } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useUser } from '../context/UserContext';
import { mockLanguages, mockLessons } from '../lib/mockData';
import type { Database } from '../lib/database.types';

type Language = Database['public']['Tables']['languages']['Row'];
type Lesson = Database['public']['Tables']['lessons']['Row'];

interface LessonsPageProps {
  languageId: string;
  onNavigate: (page: string, lessonId?: string) => void;
}

export function LessonsPage({ languageId, onNavigate }: LessonsPageProps) {
  const { userId } = useUser();
  const [language, setLanguage] = useState<Language | null>(null);
  const [lessons, setLessons] = useState<Lesson[]>([]);
  const [completedLessons, setCompletedLessons] = useState<Set<string>>(new Set());
  const [totalXp, setTotalXp] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, [languageId, userId]);

  async function fetchData() {
    try {
      if (!supabase) {
        const lang = mockLanguages.find(l => l.id === languageId);
        const lessonsList = mockLessons.filter(l => l.language_id === languageId);

        const storedProgress = localStorage.getItem(`progress_${userId}`);
        const progress = storedProgress ? JSON.parse(storedProgress) : {};
        const completedIds = Object.keys(progress).filter(id => progress[id]);

        const storedXp = localStorage.getItem(`xp_${userId}_${languageId}`);
        const xp = storedXp ? parseInt(storedXp, 10) : 0;

        setLanguage(lang || null);
        setLessons(lessonsList);
        setCompletedLessons(new Set(completedIds));
        setTotalXp(xp);
        setLoading(false);
        return;
      }

      const [langResult, lessonsResult, progressResult, xpResult] = await Promise.all([
        supabase.from('languages').select('*').eq('id', languageId).maybeSingle(),
        supabase
          .from('lessons')
          .select('*')
          .eq('language_id', languageId)
          .order('order_index'),
        supabase
          .from('user_progress')
          .select('lesson_id')
          .eq('user_id', userId),
        supabase
          .from('user_xp')
          .select('total_xp')
          .eq('user_id', userId)
          .eq('language_id', languageId)
          .maybeSingle(),
      ]);

      if (langResult.error) throw langResult.error;
      if (lessonsResult.error) throw lessonsResult.error;

      setLanguage(langResult.data);
      setLessons(lessonsResult.data || []);
      setCompletedLessons(
        new Set(progressResult.data?.map((p) => p.lesson_id) || [])
      );
      setTotalXp(xpResult.data?.total_xp || 0);
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setLoading(false);
    }
  }

  const getDifficultyColor = (level: string) => {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 'bg-green-100 text-green-700';
      case 'intermediate':
        return 'bg-yellow-100 text-yellow-700';
      case 'advanced':
        return 'bg-red-100 text-red-700';
      default:
        return 'bg-gray-100 text-gray-700';
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-500 border-t-transparent"></div>
      </div>
    );
  }

  if (!language) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center">
        <p className="text-xl text-gray-600">Language not found</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
      <div className="max-w-4xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('languages')}
          className="flex items-center text-gray-600 hover:text-gray-900 mb-6 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Languages
        </button>

        <div className="bg-white rounded-2xl p-8 shadow-lg mb-8 border border-gray-100">
          <div className="flex items-start justify-between mb-4">
            <div className="flex items-center gap-4">
              <div className="text-6xl">{language.flag_emoji}</div>
              <div>
                <h1 className="text-3xl font-bold text-gray-900">{language.name}</h1>
                <p className="text-gray-600">{language.tribe_name} Language</p>
              </div>
            </div>
            <div className="text-right">
              <div className="flex items-center gap-2 text-emerald-600">
                <Award className="w-6 h-6" />
                <span className="text-2xl font-bold">{totalXp}</span>
              </div>
              <p className="text-sm text-gray-500">Total XP</p>
            </div>
          </div>
          <p className="text-gray-700 leading-relaxed">{language.description}</p>
        </div>

        <h2 className="text-2xl font-bold text-gray-900 mb-6">Lessons</h2>

        <div className="space-y-4">
          {lessons.map((lesson, index) => {
            const isCompleted = completedLessons.has(lesson.id);
            const isLocked = index > 0 && !completedLessons.has(lessons[index - 1].id);

            return (
              <button
                key={lesson.id}
                onClick={() => !isLocked && onNavigate('lesson', lesson.id)}
                disabled={isLocked}
                className={`w-full bg-white rounded-xl p-6 shadow-md border border-gray-100 text-left transition-all duration-300 ${
                  isLocked
                    ? 'opacity-60 cursor-not-allowed'
                    : 'hover:shadow-lg hover:scale-102 transform'
                }`}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-4 flex-1">
                    <div
                      className={`w-12 h-12 rounded-full flex items-center justify-center ${
                        isCompleted
                          ? 'bg-emerald-100'
                          : isLocked
                          ? 'bg-gray-100'
                          : 'bg-teal-100'
                      }`}
                    >
                      {isCompleted ? (
                        <CheckCircle className="w-6 h-6 text-emerald-600" />
                      ) : isLocked ? (
                        <Lock className="w-6 h-6 text-gray-400" />
                      ) : (
                        <BookOpen className="w-6 h-6 text-teal-600" />
                      )}
                    </div>

                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-1">
                        <h3 className="text-xl font-semibold text-gray-900">
                          {lesson.title}
                        </h3>
                        <span
                          className={`text-xs font-medium px-2 py-1 rounded-full ${getDifficultyColor(
                            lesson.difficulty_level
                          )}`}
                        >
                          {lesson.difficulty_level}
                        </span>
                      </div>
                      <p className="text-gray-600">{lesson.description}</p>
                    </div>
                  </div>

                  <div className="text-right ml-4">
                    <div className="flex items-center gap-1 text-emerald-600 font-semibold">
                      <Award className="w-5 h-5" />
                      <span>+{lesson.xp_reward} XP</span>
                    </div>
                  </div>
                </div>
              </button>
            );
          })}
        </div>

        {lessons.length === 0 && (
          <div className="text-center py-20">
            <p className="text-xl text-gray-600">
              No lessons available yet for this language
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

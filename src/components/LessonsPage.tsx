import { useState, useEffect } from 'react';
import { ArrowLeft, BookOpen, Award, CheckCircle, Lock, TrendingUp, Target, Flame } from 'lucide-react';
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
  const [currentStreak, setCurrentStreak] = useState(0);
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
        setCurrentStreak(3);
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
          .select('total_xp, current_streak')
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
      setCurrentStreak(xpResult.data?.current_streak || 0);
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setLoading(false);
    }
  }

  const getDifficultyColor = (level: string) => {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 'bg-emerald-100 text-emerald-700 border-emerald-200';
      case 'intermediate':
        return 'bg-amber-100 text-amber-700 border-amber-200';
      case 'advanced':
        return 'bg-rose-100 text-rose-700 border-rose-200';
      default:
        return 'bg-gray-100 text-gray-700 border-gray-200';
    }
  };

  const completionPercentage = lessons.length > 0
    ? Math.round((completedLessons.size / lessons.length) * 100)
    : 0;

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center">
        <div className="flex flex-col items-center">
          <div className="relative">
            <div className="animate-spin rounded-full h-16 w-16 border-4 border-emerald-500 border-t-transparent"></div>
            <div className="absolute inset-0 flex items-center justify-center">
              <BookOpen className="w-8 h-8 text-emerald-600 animate-pulse" />
            </div>
          </div>
          <p className="mt-4 text-gray-600 font-medium">Loading lessons...</p>
        </div>
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
      <div className="max-w-5xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('languages')}
          className="flex items-center text-gray-700 hover:text-gray-900 mb-6 transition-all duration-300 hover:translate-x-[-4px] font-medium"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Languages
        </button>

        <div className="bg-white/90 backdrop-blur-sm rounded-3xl p-8 shadow-xl mb-8 border-2 border-gray-100">
          <div className="flex items-start justify-between mb-6">
            <div className="flex items-center gap-5">
              <div className="text-7xl filter drop-shadow-lg">{language.flag_emoji}</div>
              <div>
                <h1 className="text-4xl font-bold text-gray-900 mb-1">{language.name}</h1>
                <p className="text-lg text-emerald-600 font-semibold">{language.tribe_name}</p>
              </div>
            </div>
            <div className="flex gap-3">
              <div className="text-center bg-gradient-to-br from-emerald-50 to-emerald-100 p-4 rounded-2xl border-2 border-emerald-200 shadow-md">
                <div className="flex items-center justify-center gap-2 text-emerald-600 mb-1">
                  <Award className="w-6 h-6" />
                  <span className="text-3xl font-bold">{totalXp}</span>
                </div>
                <p className="text-xs text-emerald-700 font-semibold">Total XP</p>
              </div>
              {currentStreak > 0 && (
                <div className="text-center bg-gradient-to-br from-orange-50 to-orange-100 p-4 rounded-2xl border-2 border-orange-200 shadow-md">
                  <div className="flex items-center justify-center gap-2 text-orange-600 mb-1">
                    <Flame className="w-6 h-6" />
                    <span className="text-3xl font-bold">{currentStreak}</span>
                  </div>
                  <p className="text-xs text-orange-700 font-semibold">Day Streak</p>
                </div>
              )}
            </div>
          </div>

          <p className="text-gray-700 leading-relaxed mb-6">{language.description}</p>

          <div className="bg-gradient-to-r from-emerald-50 to-teal-50 rounded-2xl p-5 border-2 border-emerald-200">
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                <Target className="w-5 h-5 text-emerald-600" />
                <span className="text-sm font-bold text-gray-700">Progress</span>
              </div>
              <span className="text-sm font-bold text-emerald-600">
                {completedLessons.size} of {lessons.length} lessons completed
              </span>
            </div>
            <div className="w-full bg-white/60 rounded-full h-4 shadow-inner">
              <div
                className="bg-gradient-to-r from-emerald-500 to-teal-500 h-4 rounded-full transition-all duration-1000 shadow-md flex items-center justify-end pr-2"
                style={{ width: `${completionPercentage}%` }}
              >
                {completionPercentage > 0 && (
                  <span className="text-xs font-bold text-white">{completionPercentage}%</span>
                )}
              </div>
            </div>
          </div>
        </div>

        <div className="flex items-center justify-between mb-6">
          <h2 className="text-3xl font-bold text-gray-900 flex items-center gap-3">
            <TrendingUp className="w-8 h-8 text-emerald-600" />
            Learning Path
          </h2>
          <div className="text-sm text-gray-600 bg-white/80 px-4 py-2 rounded-full font-semibold shadow-sm">
            {lessons.length} lessons available
          </div>
        </div>

        <div className="space-y-4">
          {lessons.map((lesson, index) => {
            const isCompleted = completedLessons.has(lesson.id);
            const isLocked = index > 0 && !completedLessons.has(lessons[index - 1].id);
            const isActive = !isCompleted && !isLocked;

            return (
              <button
                key={lesson.id}
                onClick={() => !isLocked && onNavigate('lesson', lesson.id)}
                disabled={isLocked}
                style={{
                  animation: `slideInUp 0.5s ease-out ${index * 0.05}s forwards`,
                  opacity: 0,
                }}
                className={`w-full bg-white/90 backdrop-blur-sm rounded-2xl p-6 shadow-lg border-2 text-left transition-all duration-300 relative overflow-hidden ${
                  isLocked
                    ? 'opacity-60 cursor-not-allowed border-gray-200'
                    : isCompleted
                    ? 'border-emerald-300 hover:shadow-xl hover:-translate-y-1'
                    : 'border-teal-300 hover:shadow-xl hover:-translate-y-1'
                }`}
              >
                {isActive && (
                  <div className="absolute top-0 right-0 bg-gradient-to-br from-teal-400 to-cyan-400 text-white text-xs font-bold px-3 py-1 rounded-bl-xl rounded-tr-xl shadow-md">
                    Up Next
                  </div>
                )}

                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-5 flex-1">
                    <div
                      className={`w-16 h-16 rounded-2xl flex items-center justify-center shadow-md transition-all duration-300 ${
                        isCompleted
                          ? 'bg-gradient-to-br from-emerald-400 to-emerald-500 scale-110'
                          : isLocked
                          ? 'bg-gray-200'
                          : 'bg-gradient-to-br from-teal-400 to-teal-500'
                      }`}
                    >
                      {isCompleted ? (
                        <CheckCircle className="w-8 h-8 text-white" />
                      ) : isLocked ? (
                        <Lock className="w-7 h-7 text-gray-400" />
                      ) : (
                        <BookOpen className="w-7 h-7 text-white" />
                      )}
                    </div>

                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-2">
                        <h3 className="text-xl font-bold text-gray-900">
                          Lesson {index + 1}: {lesson.title}
                        </h3>
                        <span
                          className={`text-xs font-bold px-3 py-1 rounded-full border-2 ${getDifficultyColor(
                            lesson.difficulty_level
                          )}`}
                        >
                          {lesson.difficulty_level}
                        </span>
                      </div>
                      <p className="text-gray-600 leading-relaxed">{lesson.description}</p>
                    </div>
                  </div>

                  <div className="text-right ml-6 flex flex-col items-end gap-2">
                    <div className="flex items-center gap-2 bg-gradient-to-r from-emerald-50 to-teal-50 px-4 py-2 rounded-full border-2 border-emerald-200 shadow-sm">
                      <Award className="w-5 h-5 text-emerald-600" />
                      <span className="text-lg font-bold text-emerald-600">+{lesson.xp_reward} XP</span>
                    </div>
                    {isCompleted && (
                      <div className="flex items-center gap-1 text-emerald-600 text-sm font-semibold">
                        <CheckCircle className="w-4 h-4" />
                        <span>Completed</span>
                      </div>
                    )}
                  </div>
                </div>
              </button>
            );
          })}
        </div>

        {lessons.length === 0 && (
          <div className="text-center py-20 bg-white/80 rounded-3xl shadow-lg">
            <div className="text-6xl mb-4">📚</div>
            <p className="text-2xl text-gray-700 font-bold mb-2">
              No lessons available yet
            </p>
            <p className="text-gray-600">
              Check back soon for new content!
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

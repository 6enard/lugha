import { useState, useEffect } from 'react';
import { ArrowLeft, Volume2, ChevronLeft, ChevronRight, Award, Sparkles, RotateCcw } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { mockLessons, mockVocabulary } from '../lib/mockData';
import type { Database } from '../lib/database.types';

type Lesson = Database['public']['Tables']['lessons']['Row'];
type Vocabulary = Database['public']['Tables']['vocabulary']['Row'];

interface LessonViewProps {
  lessonId: string;
  onNavigate: (page: string, lessonId?: string) => void;
}

export function LessonView({ lessonId, onNavigate }: LessonViewProps) {
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [vocabulary, setVocabulary] = useState<Vocabulary[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [loading, setLoading] = useState(true);
  const [showCelebration, setShowCelebration] = useState(false);

  useEffect(() => {
    fetchLesson();
  }, [lessonId]);

  async function fetchLesson() {
    try {
      if (!supabase) {
        const lessonData = mockLessons.find(l => l.id === lessonId);
        const vocabData = mockVocabulary.filter(v => v.lesson_id === lessonId);

        setLesson(lessonData || null);
        setVocabulary(vocabData);
        setLoading(false);
        return;
      }

      const [lessonResult, vocabResult] = await Promise.all([
        supabase.from('lessons').select('*').eq('id', lessonId).maybeSingle(),
        supabase.from('vocabulary').select('*').eq('lesson_id', lessonId),
      ]);

      if (lessonResult.error) throw lessonResult.error;
      if (vocabResult.error) throw vocabResult.error;

      setLesson(lessonResult.data);
      setVocabulary(vocabResult.data || []);
    } catch (error) {
      console.error('Error fetching lesson:', error);
    } finally {
      setLoading(false);
    }
  }

  const currentVocab = vocabulary[currentIndex];

  const handleNext = () => {
    if (currentIndex < vocabulary.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setIsFlipped(false);
    } else {
      setShowCelebration(true);
      setTimeout(() => setShowCelebration(false), 3000);
    }
  };

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      setIsFlipped(false);
    }
  };

  const handleFlip = () => {
    setIsFlipped(!isFlipped);
  };

  const resetLesson = () => {
    setCurrentIndex(0);
    setIsFlipped(false);
    setShowCelebration(false);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center">
        <div className="flex flex-col items-center">
          <div className="relative">
            <div className="animate-spin rounded-full h-16 w-16 border-4 border-emerald-500 border-t-transparent"></div>
            <div className="absolute inset-0 flex items-center justify-center">
              <Sparkles className="w-8 h-8 text-emerald-600 animate-pulse" />
            </div>
          </div>
          <p className="mt-4 text-gray-600 font-medium">Loading lesson...</p>
        </div>
      </div>
    );
  }

  if (!lesson || vocabulary.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
        <div className="max-w-4xl mx-auto px-4 py-8">
          <button
            onClick={() => onNavigate('lessons', lesson?.language_id)}
            className="flex items-center text-gray-700 hover:text-gray-900 mb-6 transition-all duration-300 hover:translate-x-[-4px] font-medium"
          >
            <ArrowLeft className="w-5 h-5 mr-2" />
            Back to Lessons
          </button>
          <div className="bg-white/90 rounded-3xl p-12 text-center shadow-xl">
            <div className="text-6xl mb-4">📝</div>
            <p className="text-xl text-gray-700 font-semibold">No vocabulary found for this lesson</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
      {showCelebration && (
        <div className="fixed inset-0 flex items-center justify-center z-50 pointer-events-none">
          <div className="bg-white/95 backdrop-blur-md rounded-3xl p-12 shadow-2xl border-2 border-emerald-300 animate-bounce">
            <div className="text-7xl mb-4 text-center">🎉</div>
            <p className="text-3xl font-bold text-emerald-600 text-center">Lesson Complete!</p>
            <p className="text-gray-600 text-center mt-2">Ready for the quiz?</p>
          </div>
        </div>
      )}

      <div className="max-w-5xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('lessons', lesson.language_id)}
          className="flex items-center text-gray-700 hover:text-gray-900 mb-6 transition-all duration-300 hover:translate-x-[-4px] font-medium"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Lessons
        </button>

        <div className="bg-white/90 backdrop-blur-sm rounded-3xl p-8 shadow-xl mb-8 border-2 border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h1 className="text-4xl font-bold text-gray-900 mb-2">{lesson.title}</h1>
              <p className="text-lg text-gray-600">{lesson.description}</p>
            </div>
            <div className="flex items-center gap-2 bg-gradient-to-r from-emerald-50 to-teal-50 px-5 py-3 rounded-2xl border-2 border-emerald-200 shadow-md">
              <Award className="w-6 h-6 text-emerald-600" />
              <span className="text-2xl font-bold text-emerald-600">+{lesson.xp_reward} XP</span>
            </div>
          </div>
        </div>

        <div className="mb-8">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-4">
              <span className="text-lg font-bold text-gray-700 bg-white/80 px-4 py-2 rounded-full shadow-sm">
                Card {currentIndex + 1} of {vocabulary.length}
              </span>
              {currentIndex === vocabulary.length - 1 && !showCelebration && (
                <button
                  onClick={resetLesson}
                  className="flex items-center gap-2 text-gray-600 hover:text-gray-900 transition-colors text-sm font-semibold"
                >
                  <RotateCcw className="w-4 h-4" />
                  Restart Lesson
                </button>
              )}
            </div>
            <button
              onClick={() => onNavigate('quiz', lessonId)}
              className="px-6 py-3 bg-gradient-to-r from-emerald-500 to-teal-500 text-white rounded-2xl hover:from-emerald-600 hover:to-teal-600 transition-all duration-300 font-bold text-lg shadow-lg hover:shadow-xl hover:scale-105"
            >
              Take Quiz →
            </button>
          </div>
          <div className="w-full bg-white/60 rounded-full h-3 shadow-inner">
            <div
              className="bg-gradient-to-r from-emerald-500 to-teal-500 h-3 rounded-full transition-all duration-500 shadow-md"
              style={{ width: `${((currentIndex + 1) / vocabulary.length) * 100}%` }}
            />
          </div>
        </div>

        <div className="perspective-1000 mb-8 min-h-[500px] flex items-center justify-center">
          <div
            onClick={handleFlip}
            className="relative w-full max-w-2xl h-[500px] transition-transform duration-700 transform-style-3d cursor-pointer group"
            style={{
              transformStyle: 'preserve-3d',
              transform: isFlipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
            }}
          >
            <div
              className="absolute inset-0 w-full h-full bg-gradient-to-br from-white to-emerald-50/30 rounded-3xl shadow-2xl border-4 border-emerald-200 p-12 flex flex-col items-center justify-center transition-all duration-300 group-hover:shadow-emerald-300/50"
              style={{
                backfaceVisibility: 'hidden',
              }}
            >
              <div className="absolute top-4 right-4 bg-emerald-100 text-emerald-700 px-4 py-2 rounded-full text-sm font-bold shadow-md">
                Front
              </div>
              <img src="/lughalogo.png" alt="Lugha" className="w-20 h-20 mb-6 opacity-75 drop-shadow-lg" />
              <p className="text-sm text-emerald-600 font-bold mb-4 tracking-wide">WORD / PHRASE</p>
              <h2 className="text-6xl font-bold text-gray-900 mb-8 text-center leading-tight">
                {currentVocab.word_or_phrase}
              </h2>
              <button className="flex items-center gap-3 text-emerald-600 hover:text-emerald-700 transition-all duration-300 bg-emerald-50 px-6 py-3 rounded-full shadow-md hover:shadow-lg hover:scale-105">
                <Volume2 className="w-7 h-7" />
                <span className="text-lg font-bold">Listen to Pronunciation</span>
              </button>
              <div className="mt-10 flex items-center gap-2 text-gray-400 animate-pulse">
                <Sparkles className="w-5 h-5" />
                <p className="text-sm font-semibold">Click card to see translation</p>
                <Sparkles className="w-5 h-5" />
              </div>
            </div>

            <div
              className="absolute inset-0 w-full h-full bg-gradient-to-br from-emerald-500 via-teal-500 to-cyan-500 rounded-3xl shadow-2xl border-4 border-teal-300 p-12 flex flex-col items-center justify-center"
              style={{
                backfaceVisibility: 'hidden',
                transform: 'rotateY(180deg)',
              }}
            >
              <div className="absolute top-4 right-4 bg-white/90 text-emerald-700 px-4 py-2 rounded-full text-sm font-bold shadow-md">
                Back
              </div>
              <img src="/lughalogo.png" alt="Lugha" className="w-20 h-20 mb-6 opacity-90 filter brightness-0 invert drop-shadow-lg" />
              <p className="text-sm text-white/90 font-bold mb-4 tracking-wide">TRANSLATION</p>
              <h2 className="text-5xl font-bold text-white mb-8 text-center leading-tight drop-shadow-lg">
                {currentVocab.translation}
              </h2>
              <div className="bg-white/95 rounded-2xl p-8 max-w-lg w-full space-y-5 shadow-xl">
                <div className="border-b border-gray-200 pb-4">
                  <p className="text-sm font-bold text-emerald-700 mb-2 tracking-wide">PRONUNCIATION</p>
                  <p className="text-2xl text-gray-900 font-semibold">{currentVocab.pronunciation}</p>
                </div>
                {currentVocab.example_sentence && (
                  <div>
                    <p className="text-sm font-bold text-teal-700 mb-2 tracking-wide">EXAMPLE SENTENCE</p>
                    <p className="text-lg text-gray-900 italic leading-relaxed">{currentVocab.example_sentence}</p>
                  </div>
                )}
              </div>
              <div className="mt-10 flex items-center gap-2 text-white/70 animate-pulse">
                <Sparkles className="w-5 h-5" />
                <p className="text-sm font-semibold">Click card to see word again</p>
                <Sparkles className="w-5 h-5" />
              </div>
            </div>
          </div>
        </div>

        <div className="flex items-center justify-between max-w-2xl mx-auto">
          <button
            onClick={handlePrevious}
            disabled={currentIndex === 0}
            className={`flex items-center gap-3 px-8 py-4 rounded-2xl font-bold text-lg transition-all duration-300 shadow-lg ${
              currentIndex === 0
                ? 'bg-gray-200 text-gray-400 cursor-not-allowed opacity-50'
                : 'bg-white text-gray-700 hover:bg-gray-50 hover:scale-105 hover:shadow-xl'
            }`}
          >
            <ChevronLeft className="w-6 h-6" />
            Previous
          </button>

          <div className="text-center">
            <div className="text-4xl font-bold text-emerald-600">
              {currentIndex + 1}
            </div>
            <div className="text-sm text-gray-500 font-semibold">
              of {vocabulary.length}
            </div>
          </div>

          <button
            onClick={handleNext}
            className="flex items-center gap-3 px-8 py-4 bg-gradient-to-r from-emerald-500 to-teal-500 text-white rounded-2xl hover:from-emerald-600 hover:to-teal-600 transition-all duration-300 font-bold text-lg shadow-lg hover:shadow-xl hover:scale-105"
          >
            {currentIndex === vocabulary.length - 1 ? 'Finish' : 'Next'}
            <ChevronRight className="w-6 h-6" />
          </button>
        </div>
      </div>
    </div>
  );
}

import { useState, useEffect } from 'react';
import { ArrowLeft, Volume2, ChevronLeft, ChevronRight } from 'lucide-react';
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

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-500 border-t-transparent"></div>
      </div>
    );
  }

  if (!lesson || vocabulary.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
        <div className="max-w-4xl mx-auto px-4 py-8">
          <button
            onClick={() => onNavigate('lessons', lesson?.language_id)}
            className="flex items-center text-gray-600 hover:text-gray-900 mb-6 transition-colors"
          >
            <ArrowLeft className="w-5 h-5 mr-2" />
            Back to Lessons
          </button>
          <p className="text-xl text-gray-600 text-center">No vocabulary found for this lesson</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
      <div className="max-w-4xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('lessons', lesson.language_id)}
          className="flex items-center text-gray-600 hover:text-gray-900 mb-6 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Lessons
        </button>

        <div className="bg-white rounded-2xl p-6 shadow-lg mb-8 border border-gray-100">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">{lesson.title}</h1>
          <p className="text-gray-600">{lesson.description}</p>
        </div>

        <div className="mb-6">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium text-gray-600">
              Card {currentIndex + 1} of {vocabulary.length}
            </span>
            <button
              onClick={() => onNavigate('quiz', lessonId)}
              className="px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium text-sm"
            >
              Take Quiz
            </button>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-2">
            <div
              className="bg-emerald-600 h-2 rounded-full transition-all duration-300"
              style={{ width: `${((currentIndex + 1) / vocabulary.length) * 100}%` }}
            />
          </div>
        </div>

        <div className="perspective-1000 mb-8 h-96">
          <div
            onClick={handleFlip}
            className="relative w-full h-full transition-transform duration-500 transform-style-3d cursor-pointer"
            style={{
              transformStyle: 'preserve-3d',
              transform: isFlipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
            }}
          >
            <div
              className="absolute inset-0 w-full h-full bg-white rounded-2xl shadow-xl border-2 border-gray-200 p-12 flex flex-col items-center justify-center"
              style={{
                backfaceVisibility: 'hidden',
              }}
            >
              <img src="/lughalogo.png" alt="Lugha" className="w-16 h-16 mb-4 opacity-75" />
              <p className="text-sm text-gray-500 mb-4">Word / Phrase</p>
              <h2 className="text-5xl font-bold text-gray-900 mb-6 text-center">
                {currentVocab.word_or_phrase}
              </h2>
              <button className="flex items-center gap-2 text-emerald-600 hover:text-emerald-700 transition-colors">
                <Volume2 className="w-6 h-6" />
                <span className="text-sm font-medium">Listen</span>
              </button>
              <p className="text-gray-400 mt-8 text-sm">Click to see translation</p>
            </div>

            <div
              className="absolute inset-0 w-full h-full bg-white rounded-2xl shadow-xl border-2 border-gray-200 p-12 flex flex-col items-center justify-center"
              style={{
                backfaceVisibility: 'hidden',
                transform: 'rotateY(180deg)',
              }}
            >
              <img src="/lughalogo.png" alt="Lugha" className="w-16 h-16 mb-4 opacity-75" />
              <p className="text-sm text-gray-500 mb-4">Translation</p>
              <h2 className="text-4xl font-bold text-emerald-600 mb-6 text-center">
                {currentVocab.translation}
              </h2>
              <div className="bg-gray-50 rounded-xl p-6 max-w-lg w-full space-y-4">
                <div>
                  <p className="text-sm font-semibold text-gray-700 mb-1">Pronunciation:</p>
                  <p className="text-lg text-gray-900">{currentVocab.pronunciation}</p>
                </div>
                {currentVocab.example_sentence && (
                  <div>
                    <p className="text-sm font-semibold text-gray-700 mb-1">Example:</p>
                    <p className="text-gray-900 italic">{currentVocab.example_sentence}</p>
                  </div>
                )}
              </div>
              <p className="text-gray-400 mt-8 text-sm">Click to see word</p>
            </div>
          </div>
        </div>

        <div className="flex items-center justify-between">
          <button
            onClick={handlePrevious}
            disabled={currentIndex === 0}
            className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium transition-colors ${
              currentIndex === 0
                ? 'bg-gray-200 text-gray-400 cursor-not-allowed'
                : 'bg-white text-gray-700 hover:bg-gray-50 shadow-md'
            }`}
          >
            <ChevronLeft className="w-5 h-5" />
            Previous
          </button>

          <button
            onClick={handleNext}
            disabled={currentIndex === vocabulary.length - 1}
            className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium transition-colors ${
              currentIndex === vocabulary.length - 1
                ? 'bg-gray-200 text-gray-400 cursor-not-allowed'
                : 'bg-emerald-600 text-white hover:bg-emerald-700 shadow-md'
            }`}
          >
            Next
            <ChevronRight className="w-5 h-5" />
          </button>
        </div>
      </div>
    </div>
  );
}

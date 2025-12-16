import { useState, useEffect } from 'react';
import { ArrowLeft, CheckCircle, XCircle, Award, Lightbulb, TrophyIcon, Star, Zap } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useUser } from '../context/UserContext';
import { mockLessons, mockQuizQuestions } from '../lib/mockData';
import type { Database } from '../lib/database.types';

type Lesson = Database['public']['Tables']['lessons']['Row'];
type QuizQuestion = Database['public']['Tables']['quiz_questions']['Row'];

interface QuizViewProps {
  lessonId: string;
  onNavigate: (page: string, languageId?: string) => void;
}

export function QuizView({ lessonId, onNavigate }: QuizViewProps) {
  const { userId } = useUser();
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [showResult, setShowResult] = useState(false);
  const [score, setScore] = useState(0);
  const [quizCompleted, setQuizCompleted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [showCorrectAnimation, setShowCorrectAnimation] = useState(false);

  useEffect(() => {
    fetchQuiz();
  }, [lessonId]);

  async function fetchQuiz() {
    try {
      if (!supabase) {
        const lessonData = mockLessons.find(l => l.id === lessonId);
        const questionsData = mockQuizQuestions.filter(q => q.lesson_id === lessonId);

        setLesson(lessonData || null);
        setQuestions(questionsData);
        setLoading(false);
        return;
      }

      const [lessonResult, questionsResult] = await Promise.all([
        supabase.from('lessons').select('*').eq('id', lessonId).maybeSingle(),
        supabase.from('quiz_questions').select('*').eq('lesson_id', lessonId),
      ]);

      if (lessonResult.error) throw lessonResult.error;
      if (questionsResult.error) throw questionsResult.error;

      setLesson(lessonResult.data);
      setQuestions(questionsResult.data || []);
    } catch (error) {
      console.error('Error fetching quiz:', error);
    } finally {
      setLoading(false);
    }
  }

  const currentQuestion = questions[currentQuestionIndex];

  const handleAnswerSelect = (answer: string) => {
    if (showResult) return;
    setSelectedAnswer(answer);
  };

  const handleSubmit = () => {
    if (!selectedAnswer) return;
    setShowResult(true);
    if (selectedAnswer === currentQuestion.correct_answer) {
      setScore(score + 1);
      setShowCorrectAnimation(true);
      setTimeout(() => setShowCorrectAnimation(false), 1500);
    }
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setSelectedAnswer(null);
      setShowResult(false);
    } else {
      completeQuiz();
    }
  };

  async function completeQuiz() {
    const finalScore = Math.round((score / questions.length) * 100);

    try {
      if (!supabase) {
        const storedProgress = localStorage.getItem(`progress_${userId}`) || '{}';
        const progress = JSON.parse(storedProgress);
        progress[lessonId] = finalScore >= 70;
        localStorage.setItem(`progress_${userId}`, JSON.stringify(progress));

        const storedXp = localStorage.getItem(`xp_${userId}_${lesson!.language_id}`) || '0';
        const currentXp = parseInt(storedXp, 10);
        const newXp = currentXp + lesson!.xp_reward;
        localStorage.setItem(`xp_${userId}_${lesson!.language_id}`, newXp.toString());

        setQuizCompleted(true);
        return;
      }

      await Promise.all([
        supabase.from('user_progress').upsert({
          user_id: userId,
          lesson_id: lessonId,
          score: finalScore,
          time_spent_seconds: 0,
        }),
        supabase.from('user_xp').upsert(
          {
            user_id: userId,
            language_id: lesson!.language_id,
            total_xp: 0,
            current_streak: 0,
            last_activity_date: new Date().toISOString().split('T')[0],
          },
          { onConflict: 'user_id,language_id' }
        ),
      ]);

      const { data: xpData } = await supabase
        .from('user_xp')
        .select('total_xp')
        .eq('user_id', userId)
        .eq('language_id', lesson!.language_id)
        .maybeSingle();

      if (xpData) {
        await supabase
          .from('user_xp')
          .update({
            total_xp: xpData.total_xp + lesson!.xp_reward,
            last_activity_date: new Date().toISOString().split('T')[0],
          })
          .eq('user_id', userId)
          .eq('language_id', lesson!.language_id);
      }
    } catch (error) {
      console.error('Error saving progress:', error);
    }

    setQuizCompleted(true);
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center">
        <div className="flex flex-col items-center">
          <div className="relative">
            <div className="animate-spin rounded-full h-16 w-16 border-4 border-emerald-500 border-t-transparent"></div>
            <div className="absolute inset-0 flex items-center justify-center">
              <Zap className="w-8 h-8 text-emerald-600 animate-pulse" />
            </div>
          </div>
          <p className="mt-4 text-gray-600 font-medium">Loading quiz...</p>
        </div>
      </div>
    );
  }

  if (!lesson || questions.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
        <div className="max-w-4xl mx-auto px-4 py-8">
          <button
            onClick={() => onNavigate('lesson', lessonId)}
            className="flex items-center text-gray-700 hover:text-gray-900 mb-6 transition-all duration-300 hover:translate-x-[-4px] font-medium"
          >
            <ArrowLeft className="w-5 h-5 mr-2" />
            Back to Lesson
          </button>
          <div className="bg-white/90 rounded-3xl p-12 text-center shadow-xl">
            <div className="text-6xl mb-4">❓</div>
            <p className="text-xl text-gray-700 font-semibold">No quiz questions available</p>
          </div>
        </div>
      </div>
    );
  }

  if (quizCompleted) {
    const finalScore = Math.round((score / questions.length) * 100);
    const passed = finalScore >= 70;
    const stars = passed ? (finalScore >= 90 ? 3 : finalScore >= 80 ? 2 : 1) : 0;

    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 flex items-center justify-center p-4">
        <div className="max-w-2xl w-full">
          <div className="bg-white/95 backdrop-blur-sm rounded-3xl p-12 shadow-2xl border-2 border-gray-100 text-center relative overflow-hidden">
            <div className="absolute top-0 left-0 right-0 h-2 bg-gradient-to-r from-emerald-500 via-teal-500 to-cyan-500"></div>

            {passed && (
              <div className="absolute top-0 left-0 right-0 flex justify-center -mt-8">
                <div className="w-20 h-20 rounded-full bg-gradient-to-br from-amber-400 to-amber-600 flex items-center justify-center shadow-xl border-4 border-white">
                  <TrophyIcon className="w-10 h-10 text-white" />
                </div>
              </div>
            )}

            <div className="mt-8">
              <div
                className={`w-28 h-28 rounded-full mx-auto mb-6 flex items-center justify-center shadow-xl ${
                  passed
                    ? 'bg-gradient-to-br from-emerald-400 to-emerald-600'
                    : 'bg-gradient-to-br from-amber-400 to-amber-600'
                }`}
              >
                {passed ? (
                  <CheckCircle className="w-16 h-16 text-white" />
                ) : (
                  <Award className="w-16 h-16 text-white" />
                )}
              </div>

              <h2 className="text-4xl font-bold text-gray-900 mb-3">
                {passed ? 'Excellent Work!' : 'Good Effort!'}
              </h2>
              <p className="text-lg text-gray-600 mb-8">
                {passed
                  ? "You've mastered this lesson!"
                  : 'Keep practicing to improve your score'}
              </p>

              {passed && stars > 0 && (
                <div className="flex justify-center gap-3 mb-8">
                  {[...Array(stars)].map((_, i) => (
                    <Star key={i} className="w-10 h-10 text-amber-400 fill-amber-400 animate-pulse" style={{ animationDelay: `${i * 0.2}s` }} />
                  ))}
                </div>
              )}

              <div className="bg-gradient-to-br from-gray-50 to-emerald-50/30 rounded-2xl p-10 mb-8 border-2 border-emerald-200 shadow-inner">
                <div className="text-7xl font-bold bg-gradient-to-r from-emerald-600 to-teal-600 bg-clip-text text-transparent mb-3">
                  {finalScore}%
                </div>
                <p className="text-lg text-gray-700 font-semibold">
                  {score} out of {questions.length} correct answers
                </p>
              </div>

              {passed && (
                <div className="bg-gradient-to-r from-emerald-50 to-teal-50 rounded-2xl p-6 mb-8 border-2 border-emerald-300">
                  <div className="flex items-center justify-center gap-3 text-emerald-600">
                    <Award className="w-8 h-8" />
                    <span className="text-3xl font-bold">
                      +{lesson.xp_reward} XP Earned!
                    </span>
                    <Zap className="w-8 h-8" />
                  </div>
                </div>
              )}

              <div className="flex gap-4 justify-center">
                <button
                  onClick={() => window.location.reload()}
                  className="px-8 py-4 border-2 border-gray-300 text-gray-700 rounded-2xl hover:bg-gray-50 transition-all duration-300 font-bold text-lg shadow-md hover:shadow-lg hover:scale-105"
                >
                  Retry Quiz
                </button>
                <button
                  onClick={() => onNavigate('lessons', lesson.language_id)}
                  className="px-8 py-4 bg-gradient-to-r from-emerald-500 to-teal-500 text-white rounded-2xl hover:from-emerald-600 hover:to-teal-600 transition-all duration-300 font-bold text-lg shadow-lg hover:shadow-xl hover:scale-105"
                >
                  Back to Lessons
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const options = [
    currentQuestion.option_a,
    currentQuestion.option_b,
    currentQuestion.option_c,
    currentQuestion.option_d,
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
      {showCorrectAnimation && (
        <div className="fixed inset-0 flex items-center justify-center z-50 pointer-events-none">
          <div className="text-9xl animate-bounce">🎉</div>
        </div>
      )}

      <div className="max-w-4xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('lesson', lessonId)}
          className="flex items-center text-gray-700 hover:text-gray-900 mb-6 transition-all duration-300 hover:translate-x-[-4px] font-medium"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Lesson
        </button>

        <div className="bg-white/90 backdrop-blur-sm rounded-3xl p-8 shadow-xl mb-8 border-2 border-gray-100">
          <div className="flex items-center justify-between mb-6">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-full bg-gradient-to-br from-emerald-500 to-teal-500 flex items-center justify-center shadow-md">
                <Zap className="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 className="text-3xl font-bold text-gray-900">{lesson.title} Quiz</h1>
                <p className="text-sm text-gray-600 font-semibold">
                  Question {currentQuestionIndex + 1} of {questions.length}
                </p>
              </div>
            </div>
            <div className="text-right">
              <div className="text-3xl font-bold text-emerald-600">{score}</div>
              <div className="text-xs text-gray-500 font-semibold">Correct</div>
            </div>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-3 shadow-inner">
            <div
              className="bg-gradient-to-r from-emerald-500 to-teal-500 h-3 rounded-full transition-all duration-500 shadow-md"
              style={{
                width: `${((currentQuestionIndex + 1) / questions.length) * 100}%`,
              }}
            />
          </div>
        </div>

        <div className="bg-white/90 backdrop-blur-sm rounded-3xl p-10 shadow-xl mb-8 border-2 border-gray-100">
          <div className="flex items-start gap-4 mb-10">
            <div className="w-12 h-12 rounded-full bg-gradient-to-br from-teal-100 to-teal-200 flex items-center justify-center flex-shrink-0 shadow-md border-2 border-teal-300">
              <span className="text-xl font-bold text-teal-700">{currentQuestionIndex + 1}</span>
            </div>
            <h2 className="text-3xl font-bold text-gray-900 leading-tight flex-1">
              {currentQuestion.question_text}
            </h2>
          </div>

          <div className="space-y-4">
            {options.map((option, index) => {
              const isSelected = selectedAnswer === option;
              const isCorrect = option === currentQuestion.correct_answer;
              const showCorrectAnswer = showResult && isCorrect;
              const showWrongAnswer = showResult && isSelected && !isCorrect;

              return (
                <button
                  key={index}
                  onClick={() => handleAnswerSelect(option)}
                  disabled={showResult}
                  className={`w-full p-5 rounded-2xl border-3 text-left font-semibold text-lg transition-all duration-300 ${
                    showCorrectAnswer
                      ? 'border-emerald-500 bg-gradient-to-r from-emerald-50 to-emerald-100 text-emerald-900 shadow-lg scale-105'
                      : showWrongAnswer
                      ? 'border-red-500 bg-gradient-to-r from-red-50 to-red-100 text-red-900 shadow-lg'
                      : isSelected
                      ? 'border-emerald-500 bg-gradient-to-r from-emerald-50 to-teal-50 text-emerald-900 shadow-md scale-102'
                      : 'border-gray-200 hover:border-gray-300 text-gray-900 hover:bg-gray-50 shadow-sm hover:shadow-md hover:scale-102'
                  }`}
                >
                  <div className="flex items-center justify-between">
                    <span className="flex-1">{option}</span>
                    <div className="flex-shrink-0 ml-4">
                      {showCorrectAnswer && (
                        <div className="w-10 h-10 rounded-full bg-emerald-500 flex items-center justify-center shadow-md">
                          <CheckCircle className="w-6 h-6 text-white" />
                        </div>
                      )}
                      {showWrongAnswer && (
                        <div className="w-10 h-10 rounded-full bg-red-500 flex items-center justify-center shadow-md">
                          <XCircle className="w-6 h-6 text-white" />
                        </div>
                      )}
                    </div>
                  </div>
                </button>
              );
            })}
          </div>

          {showResult && currentQuestion.explanation && (
            <div className="mt-8 p-6 bg-gradient-to-r from-blue-50 to-cyan-50 border-2 border-blue-200 rounded-2xl shadow-md">
              <div className="flex items-start gap-3">
                <Lightbulb className="w-6 h-6 text-blue-600 flex-shrink-0 mt-1" />
                <div className="flex-1">
                  <p className="text-sm font-bold text-blue-900 mb-2 tracking-wide">EXPLANATION</p>
                  <p className="text-blue-800 leading-relaxed">{currentQuestion.explanation}</p>
                </div>
              </div>
            </div>
          )}
        </div>

        <div className="flex justify-end">
          {!showResult ? (
            <button
              onClick={handleSubmit}
              disabled={!selectedAnswer}
              className={`px-10 py-4 rounded-2xl font-bold text-lg transition-all duration-300 shadow-lg ${
                selectedAnswer
                  ? 'bg-gradient-to-r from-emerald-500 to-teal-500 text-white hover:from-emerald-600 hover:to-teal-600 hover:shadow-xl hover:scale-105'
                  : 'bg-gray-300 text-gray-500 cursor-not-allowed opacity-60'
              }`}
            >
              Submit Answer
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="px-10 py-4 bg-gradient-to-r from-emerald-500 to-teal-500 text-white rounded-2xl hover:from-emerald-600 hover:to-teal-600 transition-all duration-300 font-bold text-lg shadow-lg hover:shadow-xl hover:scale-105"
            >
              {currentQuestionIndex < questions.length - 1 ? 'Next Question →' : 'Finish Quiz'}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

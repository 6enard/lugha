import { useState, useEffect } from 'react';
import { ArrowLeft, CheckCircle, XCircle, Award } from 'lucide-react';
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
        <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-500 border-t-transparent"></div>
      </div>
    );
  }

  if (!lesson || questions.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
        <div className="max-w-4xl mx-auto px-4 py-8">
          <button
            onClick={() => onNavigate('lesson', lessonId)}
            className="flex items-center text-gray-600 hover:text-gray-900 mb-6 transition-colors"
          >
            <ArrowLeft className="w-5 h-5 mr-2" />
            Back to Lesson
          </button>
          <p className="text-xl text-gray-600 text-center">No quiz questions available</p>
        </div>
      </div>
    );
  }

  if (quizCompleted) {
    const finalScore = Math.round((score / questions.length) * 100);
    const passed = finalScore >= 70;

    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
        <div className="max-w-2xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
          <div className="bg-white rounded-2xl p-12 shadow-xl border border-gray-100 text-center">
            <div
              className={`w-20 h-20 rounded-full mx-auto mb-6 flex items-center justify-center ${
                passed ? 'bg-emerald-100' : 'bg-yellow-100'
              }`}
            >
              {passed ? (
                <CheckCircle className="w-10 h-10 text-emerald-600" />
              ) : (
                <Award className="w-10 h-10 text-yellow-600" />
              )}
            </div>

            <h2 className="text-3xl font-bold text-gray-900 mb-2">
              {passed ? 'Congratulations!' : 'Good Effort!'}
            </h2>
            <p className="text-gray-600 mb-8">
              {passed
                ? "You've completed this lesson!"
                : 'Keep practicing to improve your score'}
            </p>

            <div className="bg-gray-50 rounded-xl p-8 mb-8">
              <div className="text-6xl font-bold text-emerald-600 mb-2">
                {finalScore}%
              </div>
              <p className="text-gray-600">
                {score} out of {questions.length} correct
              </p>
            </div>

            {passed && (
              <div className="flex items-center justify-center gap-2 text-emerald-600 mb-8">
                <Award className="w-6 h-6" />
                <span className="text-xl font-semibold">
                  +{lesson.xp_reward} XP Earned!
                </span>
              </div>
            )}

            <div className="flex gap-4 justify-center">
              <button
                onClick={() => window.location.reload()}
                className="px-6 py-3 border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-medium"
              >
                Retry Quiz
              </button>
              <button
                onClick={() => onNavigate('lessons', lesson.language_id)}
                className="px-6 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium"
              >
                Back to Lessons
              </button>
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
      <div className="max-w-3xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('lesson', lessonId)}
          className="flex items-center text-gray-600 hover:text-gray-900 mb-6 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Lesson
        </button>

        <div className="bg-white rounded-2xl p-6 shadow-lg mb-8 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h1 className="text-2xl font-bold text-gray-900">{lesson.title} Quiz</h1>
            <span className="text-sm font-medium text-gray-600">
              Question {currentQuestionIndex + 1} of {questions.length}
            </span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-2">
            <div
              className="bg-emerald-600 h-2 rounded-full transition-all duration-300"
              style={{
                width: `${((currentQuestionIndex + 1) / questions.length) * 100}%`,
              }}
            />
          </div>
        </div>

        <div className="bg-white rounded-2xl p-8 shadow-lg mb-8 border border-gray-100">
          <h2 className="text-2xl font-semibold text-gray-900 mb-8">
            {currentQuestion.question_text}
          </h2>

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
                  className={`w-full p-4 rounded-xl border-2 text-left font-medium transition-all ${
                    showCorrectAnswer
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-900'
                      : showWrongAnswer
                      ? 'border-red-500 bg-red-50 text-red-900'
                      : isSelected
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-900'
                      : 'border-gray-200 hover:border-gray-300 text-gray-900'
                  }`}
                >
                  <div className="flex items-center justify-between">
                    <span>{option}</span>
                    {showCorrectAnswer && <CheckCircle className="w-6 h-6 text-emerald-600" />}
                    {showWrongAnswer && <XCircle className="w-6 h-6 text-red-600" />}
                  </div>
                </button>
              );
            })}
          </div>

          {showResult && currentQuestion.explanation && (
            <div className="mt-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
              <p className="text-sm font-semibold text-blue-900 mb-1">Explanation:</p>
              <p className="text-blue-800">{currentQuestion.explanation}</p>
            </div>
          )}
        </div>

        <div className="flex justify-end">
          {!showResult ? (
            <button
              onClick={handleSubmit}
              disabled={!selectedAnswer}
              className={`px-8 py-3 rounded-lg font-medium transition-colors ${
                selectedAnswer
                  ? 'bg-emerald-600 text-white hover:bg-emerald-700'
                  : 'bg-gray-300 text-gray-500 cursor-not-allowed'
              }`}
            >
              Submit Answer
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="px-8 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium"
            >
              {currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz'}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

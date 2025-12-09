import { BookOpen, Globe, Trophy, Sparkles } from 'lucide-react';

interface HomePageProps {
  onNavigate: (page: string) => void;
}

export function HomePage({ onNavigate }: HomePageProps) {
  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
      <div className="max-w-6xl mx-auto px-4 py-12 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 mb-6 shadow-lg">
            <Globe className="w-10 h-10 text-white" />
          </div>
          <h1 className="text-5xl sm:text-6xl font-bold text-gray-900 mb-4">
            Lugha
          </h1>
          <p className="text-xl sm:text-2xl text-gray-700 mb-2">
            Preserve Kenya's Heritage, One Word at a Time
          </p>
          <p className="text-lg text-gray-600 max-w-2xl mx-auto">
            Learn the languages of Kenya's 42+ ethnic communities through interactive lessons,
            quizzes, and cultural insights
          </p>
        </div>

        <div className="grid md:grid-cols-3 gap-8 mb-16">
          <div className="bg-white rounded-2xl p-8 shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100">
            <div className="w-14 h-14 rounded-full bg-emerald-100 flex items-center justify-center mb-4">
              <BookOpen className="w-7 h-7 text-emerald-600" />
            </div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              Interactive Lessons
            </h3>
            <p className="text-gray-600 leading-relaxed">
              Master vocabulary, pronunciation, and phrases through engaging flashcards and structured lessons
            </p>
          </div>

          <div className="bg-white rounded-2xl p-8 shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100">
            <div className="w-14 h-14 rounded-full bg-teal-100 flex items-center justify-center mb-4">
              <Trophy className="w-7 h-7 text-teal-600" />
            </div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              Track Your Progress
            </h3>
            <p className="text-gray-600 leading-relaxed">
              Earn XP points, complete quizzes, and watch your language skills grow with every lesson
            </p>
          </div>

          <div className="bg-white rounded-2xl p-8 shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100">
            <div className="w-14 h-14 rounded-full bg-cyan-100 flex items-center justify-center mb-4">
              <Sparkles className="w-7 h-7 text-cyan-600" />
            </div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              Cultural Connection
            </h3>
            <p className="text-gray-600 leading-relaxed">
              Discover the rich heritage and traditions behind each language and connect with your roots
            </p>
          </div>
        </div>

        <div className="text-center">
          <button
            onClick={() => onNavigate('languages')}
            className="inline-flex items-center px-10 py-4 text-lg font-semibold text-white bg-gradient-to-r from-emerald-600 to-teal-600 rounded-full hover:from-emerald-700 hover:to-teal-700 transform hover:scale-105 transition-all duration-200 shadow-lg hover:shadow-xl"
          >
            Start Learning
            <svg className="ml-2 w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 7l5 5m0 0l-5 5m5-5H6" />
            </svg>
          </button>
        </div>

        <div className="mt-20 bg-white rounded-2xl p-8 shadow-md border border-gray-100">
          <h2 className="text-2xl font-bold text-gray-900 mb-4 text-center">
            Why Learn Kenyan Languages?
          </h2>
          <div className="grid md:grid-cols-2 gap-6 text-gray-700">
            <div className="flex gap-3">
              <div className="text-emerald-600 font-bold text-lg">•</div>
              <p>Connect with your heritage and cultural identity</p>
            </div>
            <div className="flex gap-3">
              <div className="text-emerald-600 font-bold text-lg">•</div>
              <p>Communicate with elders and community members</p>
            </div>
            <div className="flex gap-3">
              <div className="text-emerald-600 font-bold text-lg">•</div>
              <p>Preserve endangered languages for future generations</p>
            </div>
            <div className="flex gap-3">
              <div className="text-emerald-600 font-bold text-lg">•</div>
              <p>Gain deeper understanding of Kenyan culture and traditions</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

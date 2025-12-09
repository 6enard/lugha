import { BookOpen, Trophy, Sparkles, ArrowRight, Users, Zap } from 'lucide-react';
import { useState, useEffect } from 'react';

interface HomePageProps {
  onNavigate: (page: string) => void;
}

export function HomePage({ onNavigate }: HomePageProps) {
  const [isLoaded, setIsLoaded] = useState(false);
  const [hoveredCard, setHoveredCard] = useState<number | null>(null);

  useEffect(() => {
    setIsLoaded(true);
  }, []);

  const features = [
    {
      icon: BookOpen,
      title: 'Interactive Lessons',
      description: 'Master vocabulary, pronunciation, and phrases through engaging flashcards and structured lessons',
      color: 'emerald',
      delay: 0,
    },
    {
      icon: Trophy,
      title: 'Track Your Progress',
      description: 'Earn XP points, complete quizzes, and watch your language skills grow with every lesson',
      color: 'teal',
      delay: 100,
    },
    {
      icon: Sparkles,
      title: 'Cultural Connection',
      description: 'Discover the rich heritage and traditions behind each language and connect with your roots',
      color: 'cyan',
      delay: 200,
    },
  ];

  const reasons = [
    'Connect with your heritage and cultural identity',
    'Communicate with elders and community members',
    'Preserve endangered languages for future generations',
    'Gain deeper understanding of Kenyan culture and traditions',
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 overflow-hidden">
      <style>{`
        @keyframes slideInUp {
          from {
            opacity: 0;
            transform: translateY(30px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        @keyframes float {
          0%, 100% {
            transform: translateY(0px);
          }
          50% {
            transform: translateY(-10px);
          }
        }

        @keyframes shimmer {
          0% {
            background-position: -1000px 0;
          }
          100% {
            background-position: 1000px 0;
          }
        }

        @keyframes fadeInScale {
          from {
            opacity: 0;
            transform: scale(0.9);
          }
          to {
            opacity: 1;
            transform: scale(1);
          }
        }

        .animate-in {
          animation: slideInUp 0.7s ease-out forwards;
        }

        .animate-float {
          animation: float 3s ease-in-out infinite;
        }

        .card-hover {
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .icon-float {
          animation: float 3.5s ease-in-out infinite;
        }
      `}</style>

      <div className="max-w-6xl mx-auto px-4 py-16 sm:px-6 lg:px-8">
        <div className="text-center mb-20">
          <div
            className="inline-flex items-center justify-center w-32 h-32 mb-8 animate-float"
            style={{ opacity: isLoaded ? 1 : 0, animation: isLoaded ? 'float 3s ease-in-out infinite' : 'none' }}
          >
            <img src="/lughalogo.png" alt="Lugha Logo" className="w-full h-full object-contain drop-shadow-lg" />
          </div>

          <h1
            className="text-6xl sm:text-7xl font-bold text-gray-900 mb-4 tracking-tight"
            style={{
              opacity: isLoaded ? 1 : 0,
              animation: isLoaded ? 'slideInUp 0.7s ease-out forwards' : 'none',
            }}
          >
            Lugha
          </h1>

          <p
            className="text-2xl sm:text-3xl font-semibold text-emerald-700 mb-4"
            style={{
              opacity: isLoaded ? 1 : 0,
              animation: isLoaded ? 'slideInUp 0.7s ease-out 0.1s forwards' : 'none',
            }}
          >
            Preserve Kenya's Heritage, One Word at a Time
          </p>

          <p
            className="text-lg text-gray-600 max-w-2xl mx-auto leading-relaxed"
            style={{
              opacity: isLoaded ? 1 : 0,
              animation: isLoaded ? 'slideInUp 0.7s ease-out 0.2s forwards' : 'none',
            }}
          >
            Learn the languages of Kenya's 42+ ethnic communities through interactive lessons, quizzes, and cultural insights
          </p>
        </div>

        <div className="grid md:grid-cols-3 gap-8 mb-20">
          {features.map((feature, index) => {
            const Icon = feature.icon;
            const colorMap = {
              emerald: 'emerald',
              teal: 'teal',
              cyan: 'cyan',
            };

            return (
              <div
                key={index}
                className="group card-hover"
                style={{
                  opacity: isLoaded ? 1 : 0,
                  animation: isLoaded ? `slideInUp 0.7s ease-out ${feature.delay}ms forwards` : 'none',
                }}
                onMouseEnter={() => setHoveredCard(index)}
                onMouseLeave={() => setHoveredCard(null)}
              >
                <div
                  className={`bg-white rounded-2xl p-8 shadow-lg border border-gray-100 card-hover h-full
                    ${hoveredCard === index ? 'shadow-2xl -translate-y-2' : 'shadow-lg hover:shadow-xl'}
                  `}
                >
                  <div
                    className={`w-16 h-16 rounded-full bg-${feature.color}-100 flex items-center justify-center mb-6 transition-all duration-300 ${
                      hoveredCard === index ? `scale-110 bg-${feature.color}-200` : ''
                    }`}
                  >
                    <Icon className={`w-8 h-8 text-${feature.color}-600`} />
                  </div>

                  <h3 className="text-xl font-bold text-gray-900 mb-3 group-hover:text-emerald-700 transition-colors">
                    {feature.title}
                  </h3>

                  <p className="text-gray-600 leading-relaxed mb-4">{feature.description}</p>

                  <div className={`flex items-center text-${feature.color}-600 font-semibold text-sm opacity-0 group-hover:opacity-100 transition-opacity`}>
                    Learn more <ArrowRight className="w-4 h-4 ml-2" />
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        <div
          className="text-center mb-20"
          style={{
            opacity: isLoaded ? 1 : 0,
            animation: isLoaded ? 'slideInUp 0.7s ease-out 0.3s forwards' : 'none',
          }}
        >
          <button
            onClick={() => onNavigate('languages')}
            className="group inline-flex items-center px-12 py-5 text-lg font-bold text-white bg-gradient-to-r from-emerald-600 to-teal-600 rounded-full hover:from-emerald-700 hover:to-teal-700 transform hover:scale-110 transition-all duration-300 shadow-xl hover:shadow-2xl"
          >
            Start Learning
            <ArrowRight className="ml-3 w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </button>
        </div>

        <div
          className="bg-white rounded-3xl p-12 shadow-xl border border-gray-100 backdrop-blur-sm"
          style={{
            opacity: isLoaded ? 1 : 0,
            animation: isLoaded ? 'slideInUp 0.7s ease-out 0.4s forwards' : 'none',
          }}
        >
          <div className="mb-8">
            <div className="flex items-center justify-center mb-4">
              <Users className="w-8 h-8 text-emerald-600 mr-3" />
              <h2 className="text-3xl font-bold text-gray-900">Why Learn Kenyan Languages?</h2>
            </div>
          </div>

          <div className="grid md:grid-cols-2 gap-8">
            {reasons.map((reason, index) => (
              <div
                key={index}
                className="flex gap-4 p-4 rounded-xl hover:bg-emerald-50 transition-all duration-300 cursor-pointer group"
              >
                <div className="flex-shrink-0">
                  <div className="flex items-center justify-center h-8 w-8 rounded-full bg-emerald-600 text-white font-bold text-sm group-hover:scale-110 transition-transform">
                    {index + 1}
                  </div>
                </div>
                <p className="text-gray-700 leading-relaxed text-lg group-hover:text-gray-900 transition-colors font-medium">{reason}</p>
              </div>
            ))}
          </div>
        </div>

        <div
          className="mt-20 text-center"
          style={{
            opacity: isLoaded ? 1 : 0,
            animation: isLoaded ? 'slideInUp 0.7s ease-out 0.5s forwards' : 'none',
          }}
        >
          <div className="inline-flex items-center gap-3 bg-emerald-50 rounded-full px-8 py-3 border border-emerald-200">
            <Zap className="w-5 h-5 text-emerald-600" />
            <p className="text-emerald-700 font-semibold">Join thousands learning their heritage languages</p>
          </div>
        </div>
      </div>
    </div>
  );
}

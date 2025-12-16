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
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 overflow-hidden relative">
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute top-20 -left-10 w-96 h-96 bg-emerald-400/20 rounded-full mix-blend-multiply filter blur-3xl animate-blob"></div>
        <div className="absolute top-40 right-20 w-96 h-96 bg-teal-400/20 rounded-full mix-blend-multiply filter blur-3xl animate-blob animation-delay-2000"></div>
        <div className="absolute -bottom-20 left-1/3 w-96 h-96 bg-cyan-400/20 rounded-full mix-blend-multiply filter blur-3xl animate-blob animation-delay-4000"></div>
      </div>

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

        @keyframes blob {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(30px, -50px) scale(1.1); }
          66% { transform: translate(-20px, 20px) scale(0.9); }
        }

        @keyframes shimmer {
          0% {
            background-position: -1000px 0;
          }
          100% {
            background-position: 1000px 0;
          }
        }

        @keyframes pulse-glow {
          0%, 100% {
            box-shadow: 0 0 20px rgba(16, 185, 129, 0.3);
          }
          50% {
            box-shadow: 0 0 40px rgba(16, 185, 129, 0.5);
          }
        }

        .animate-in {
          animation: slideInUp 0.7s ease-out forwards;
        }

        .animate-float {
          animation: float 3s ease-in-out infinite;
        }

        .animate-blob {
          animation: blob 7s infinite;
        }

        .animation-delay-2000 {
          animation-delay: 2s;
        }

        .animation-delay-4000 {
          animation-delay: 4s;
        }

        .card-hover {
          transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .icon-float {
          animation: float 3.5s ease-in-out infinite;
        }

        .glass-effect {
          background: rgba(255, 255, 255, 0.85);
          backdrop-filter: blur(20px);
          border: 1px solid rgba(255, 255, 255, 0.3);
        }
      `}</style>

      <div className="max-w-6xl mx-auto px-4 py-16 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-20">
          <div
            className="inline-flex items-center justify-center w-36 h-36 mb-8 animate-float relative"
            style={{ opacity: isLoaded ? 1 : 0, animation: isLoaded ? 'float 3s ease-in-out infinite' : 'none' }}
          >
            <div className="absolute inset-0 bg-emerald-500/20 rounded-full blur-2xl"></div>
            <img src="/lughalogo.png" alt="Lugha Logo" className="w-full h-full object-contain drop-shadow-2xl relative z-10" />
          </div>

          <h1
            className="text-7xl sm:text-8xl font-bold bg-gradient-to-r from-emerald-600 via-teal-600 to-cyan-600 bg-clip-text text-transparent mb-4 tracking-tight"
            style={{
              opacity: isLoaded ? 1 : 0,
              animation: isLoaded ? 'slideInUp 0.7s ease-out forwards' : 'none',
            }}
          >
            Lugha
          </h1>

          <p
            className="text-2xl sm:text-3xl font-bold bg-gradient-to-r from-emerald-700 to-teal-700 bg-clip-text text-transparent mb-6"
            style={{
              opacity: isLoaded ? 1 : 0,
              animation: isLoaded ? 'slideInUp 0.7s ease-out 0.1s forwards' : 'none',
            }}
          >
            Preserve Kenya's Heritage, One Word at a Time
          </p>

          <p
            className="text-xl text-gray-700 max-w-2xl mx-auto leading-relaxed font-medium"
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
                  className={`glass-effect rounded-3xl p-8 shadow-xl border-2 border-white/50 card-hover h-full relative overflow-hidden
                    ${hoveredCard === index ? 'shadow-2xl -translate-y-3 scale-105' : 'shadow-xl'}
                  `}
                >
                  <div className={`absolute inset-0 bg-gradient-to-br from-${feature.color}-50/50 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500`}></div>

                  <div className="relative z-10">
                    <div
                      className={`w-20 h-20 rounded-2xl bg-gradient-to-br from-${feature.color}-400 to-${feature.color}-600 flex items-center justify-center mb-6 transition-all duration-500 shadow-lg ${
                        hoveredCard === index ? 'scale-110 rotate-6 shadow-2xl' : ''
                      }`}
                    >
                      <Icon className="w-10 h-10 text-white" />
                    </div>

                    <h3 className="text-2xl font-bold text-gray-900 mb-3 group-hover:text-emerald-700 transition-colors">
                      {feature.title}
                    </h3>

                    <p className="text-gray-700 leading-relaxed mb-6 font-medium">{feature.description}</p>

                    <div className={`flex items-center text-${feature.color}-600 font-bold text-sm opacity-0 group-hover:opacity-100 transition-all duration-300 transform group-hover:translate-x-2`}>
                      Learn more <ArrowRight className="w-4 h-4 ml-2" />
                    </div>
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
            className="group relative inline-flex items-center px-14 py-6 text-xl font-bold text-white bg-gradient-to-r from-emerald-600 via-teal-600 to-cyan-600 rounded-full hover:from-emerald-700 hover:via-teal-700 hover:to-cyan-700 transform hover:scale-110 transition-all duration-500 shadow-2xl hover:shadow-emerald-500/50 overflow-hidden"
          >
            <div className="absolute inset-0 bg-gradient-to-r from-white/20 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
            <span className="relative z-10">Start Learning</span>
            <ArrowRight className="relative z-10 ml-3 w-6 h-6 group-hover:translate-x-2 transition-transform duration-300" />
          </button>
        </div>

        <div
          className="glass-effect rounded-3xl p-12 shadow-2xl border-2 border-white/50 relative overflow-hidden"
          style={{
            opacity: isLoaded ? 1 : 0,
            animation: isLoaded ? 'slideInUp 0.7s ease-out 0.4s forwards' : 'none',
          }}
        >
          <div className="absolute top-0 right-0 w-64 h-64 bg-gradient-to-br from-emerald-200/30 to-transparent rounded-full -mr-32 -mt-32"></div>
          <div className="absolute bottom-0 left-0 w-64 h-64 bg-gradient-to-tr from-teal-200/30 to-transparent rounded-full -ml-32 -mb-32"></div>

          <div className="relative z-10">
            <div className="mb-10">
              <div className="flex items-center justify-center mb-4">
                <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center mr-4 shadow-lg">
                  <Users className="w-8 h-8 text-white" />
                </div>
                <h2 className="text-4xl font-bold bg-gradient-to-r from-gray-900 to-gray-700 bg-clip-text text-transparent">Why Learn Kenyan Languages?</h2>
              </div>
            </div>

            <div className="grid md:grid-cols-2 gap-6">
              {reasons.map((reason, index) => (
                <div
                  key={index}
                  className="flex gap-4 p-5 rounded-2xl hover:bg-gradient-to-br hover:from-emerald-50/80 hover:to-teal-50/80 transition-all duration-300 cursor-pointer group border-2 border-transparent hover:border-emerald-200/50 backdrop-blur-sm"
                >
                  <div className="flex-shrink-0">
                    <div className="flex items-center justify-center h-10 w-10 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 text-white font-bold text-base group-hover:scale-110 group-hover:rotate-6 transition-all duration-300 shadow-md">
                      {index + 1}
                    </div>
                  </div>
                  <p className="text-gray-800 leading-relaxed text-lg group-hover:text-gray-900 transition-colors font-semibold">{reason}</p>
                </div>
              ))}
            </div>
          </div>
        </div>

        <div
          className="mt-20 text-center"
          style={{
            opacity: isLoaded ? 1 : 0,
            animation: isLoaded ? 'slideInUp 0.7s ease-out 0.5s forwards' : 'none',
          }}
        >
          <div className="inline-flex items-center gap-3 glass-effect rounded-full px-10 py-4 border-2 border-white/50 shadow-xl hover:scale-105 transition-transform duration-300">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center shadow-md animate-pulse">
              <Zap className="w-5 h-5 text-white" />
            </div>
            <p className="bg-gradient-to-r from-emerald-700 to-teal-700 bg-clip-text text-transparent font-bold text-lg">Join thousands learning their heritage languages</p>
          </div>
        </div>
      </div>
    </div>
  );
}

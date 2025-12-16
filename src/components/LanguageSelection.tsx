import { useState, useEffect } from 'react';
import { Search, Users, MapPin, ArrowLeft, Sparkles } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { mockLanguages, mockLessons } from '../lib/mockData';
import type { Database } from '../lib/database.types';

type Language = Database['public']['Tables']['languages']['Row'] & { lessons_count?: number };

interface LanguageSelectionProps {
  onNavigate: (page: string, languageId?: string) => void;
}

export function LanguageSelection({ onNavigate }: LanguageSelectionProps) {
  const [languages, setLanguages] = useState<Language[]>([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchLanguages();
  }, []);

  async function fetchLanguages() {
    try {
      if (!supabase) {
        const languagesWithCounts = mockLanguages.map(lang => ({
          ...lang,
          lessons_count: mockLessons.filter(l => l.language_id === lang.id).length,
        }));
        setLanguages(languagesWithCounts);
        setLoading(false);
        return;
      }

      const { data, error } = await supabase
        .from('languages')
        .select('*')
        .eq('is_active', true)
        .order('name');

      if (error) throw error;

      const languagesWithCounts = await Promise.all(
        (data || []).map(async (lang) => {
          const { count } = await supabase
            .from('lessons')
            .select('*', { count: 'exact', head: true })
            .eq('language_id', lang.id);
          return { ...lang, lessons_count: count || 0 };
        })
      );

      setLanguages(languagesWithCounts);
    } catch (error) {
      console.error('Error fetching languages:', error);
    } finally {
      setLoading(false);
    }
  }

  const filteredLanguages = languages.filter(
    (lang) =>
      lang.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      lang.tribe_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      lang.counties.some((county) =>
        county.toLowerCase().includes(searchTerm.toLowerCase())
      )
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50 relative overflow-hidden">
      <div className="absolute inset-0 opacity-10">
        <div className="absolute top-20 left-10 w-72 h-72 bg-emerald-400 rounded-full mix-blend-multiply filter blur-3xl animate-blob"></div>
        <div className="absolute top-40 right-10 w-72 h-72 bg-teal-400 rounded-full mix-blend-multiply filter blur-3xl animate-blob animation-delay-2000"></div>
        <div className="absolute -bottom-8 left-1/3 w-72 h-72 bg-cyan-400 rounded-full mix-blend-multiply filter blur-3xl animate-blob animation-delay-4000"></div>
      </div>

      <style>{`
        @keyframes blob {
          0%, 100% { transform: translate(0, 0) scale(1); }
          33% { transform: translate(30px, -50px) scale(1.1); }
          66% { transform: translate(-20px, 20px) scale(0.9); }
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
      `}</style>

      <div className="max-w-7xl mx-auto px-4 py-8 sm:px-6 lg:px-8 relative z-10">
        <button
          onClick={() => onNavigate('home')}
          className="flex items-center text-gray-700 hover:text-gray-900 mb-6 transition-all duration-300 hover:translate-x-[-4px] font-medium"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Home
        </button>

        <div className="text-center mb-12">
          <div className="inline-flex items-center gap-2 bg-emerald-100 text-emerald-700 px-4 py-2 rounded-full mb-4 font-semibold text-sm shadow-sm">
            <Sparkles className="w-4 h-4" />
            <span>{languages.length} Languages Available</span>
          </div>

          <h1 className="text-5xl sm:text-6xl font-bold text-gray-900 mb-4 tracking-tight">
            Choose Your Language
          </h1>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto mb-8">
            Embark on a cultural journey through Kenya's rich linguistic tapestry
          </p>

          <div className="max-w-xl mx-auto relative">
            <div className="absolute left-4 top-1/2 transform -translate-y-1/2">
              <Search className="w-5 h-5 text-gray-400" />
            </div>
            <input
              type="text"
              placeholder="Search by language, tribe, or county..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-12 pr-4 py-4 rounded-2xl border-2 border-gray-200 focus:border-emerald-500 focus:outline-none text-gray-900 placeholder-gray-400 shadow-lg focus:shadow-xl transition-all duration-300 bg-white/80 backdrop-blur-sm"
            />
          </div>
        </div>

        {loading ? (
          <div className="flex flex-col justify-center items-center py-20">
            <div className="relative">
              <div className="animate-spin rounded-full h-20 w-20 border-4 border-emerald-500 border-t-transparent"></div>
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="h-12 w-12 bg-emerald-100 rounded-full animate-pulse"></div>
              </div>
            </div>
            <p className="mt-6 text-gray-600 font-medium text-lg">Discovering languages...</p>
          </div>
        ) : (
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            {filteredLanguages.map((language, index) => (
              <button
                key={language.id}
                onClick={() => onNavigate('lessons', language.id)}
                style={{
                  animation: `slideInUp 0.6s ease-out ${index * 0.1}s forwards`,
                  opacity: 0,
                }}
                className="group bg-white/90 backdrop-blur-sm rounded-3xl p-7 shadow-lg hover:shadow-2xl transition-all duration-500 border-2 border-gray-100 hover:border-emerald-300 text-left hover:-translate-y-3 transform relative overflow-hidden"
              >
                <div className="absolute top-0 right-0 w-40 h-40 bg-gradient-to-br from-emerald-100/50 to-teal-100/50 rounded-full -mr-20 -mt-20 group-hover:scale-150 transition-transform duration-700"></div>
                <div className="absolute bottom-0 left-0 w-32 h-32 bg-gradient-to-tr from-cyan-100/30 to-transparent rounded-full -ml-16 -mb-16 group-hover:scale-125 transition-transform duration-700"></div>

                <div className="relative z-10">
                  <div className="flex items-start justify-between mb-5">
                    <div className="text-7xl group-hover:scale-110 transition-transform duration-300 filter drop-shadow-lg">
                      {language.flag_emoji}
                    </div>
                    <div className="flex flex-col gap-2 items-end">
                      <div className="text-xs font-bold text-white bg-gradient-to-r from-emerald-500 to-teal-500 px-3.5 py-1.5 rounded-full shadow-md">
                        {language.lessons_count || 0} lessons
                      </div>
                      {language.total_speakers > 1000000 && (
                        <div className="text-xs font-semibold text-amber-700 bg-amber-100 px-3 py-1 rounded-full">
                          Popular
                        </div>
                      )}
                    </div>
                  </div>

                  <h3 className="text-2xl font-bold text-gray-900 mb-1 group-hover:text-emerald-600 transition-colors duration-300">
                    {language.name}
                  </h3>
                  <p className="text-sm text-emerald-600 font-bold mb-3 tracking-wide">
                    {language.tribe_name}
                  </p>

                  <p className="text-gray-600 mb-5 leading-relaxed line-clamp-3 text-sm">
                    {language.description}
                  </p>

                  <div className="space-y-3 pt-4 border-t-2 border-gray-100">
                    <div className="flex items-center text-sm text-gray-700">
                      <div className="w-9 h-9 rounded-full bg-gradient-to-br from-emerald-100 to-emerald-50 flex items-center justify-center mr-3 flex-shrink-0 shadow-sm">
                        <Users className="w-4 h-4 text-emerald-600" />
                      </div>
                      <span className="font-semibold">
                        {language.total_speakers.toLocaleString()} speakers
                      </span>
                    </div>
                    <div className="flex items-start text-sm text-gray-700">
                      <div className="w-9 h-9 rounded-full bg-gradient-to-br from-teal-100 to-teal-50 flex items-center justify-center mr-3 flex-shrink-0 mt-0.5 shadow-sm">
                        <MapPin className="w-4 h-4 text-teal-600" />
                      </div>
                      <span className="line-clamp-2 font-semibold">
                        {language.counties.join(', ')}
                      </span>
                    </div>
                  </div>

                  <div className="mt-5 pt-5 border-t-2 border-gray-100 flex items-center justify-between">
                    <span className="text-base font-bold text-emerald-600 group-hover:text-emerald-700 transition-colors">
                      Start Learning
                    </span>
                    <div className="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-teal-500 group-hover:from-emerald-600 group-hover:to-teal-600 flex items-center justify-center transition-all shadow-md group-hover:shadow-lg group-hover:scale-110">
                      <span className="text-white font-bold text-xl">→</span>
                    </div>
                  </div>
                </div>
              </button>
            ))}
          </div>
        )}

        {!loading && filteredLanguages.length === 0 && (
          <div className="text-center py-20">
            <div className="text-6xl mb-4">🔍</div>
            <p className="text-2xl text-gray-700 font-semibold mb-2">
              No languages found
            </p>
            <p className="text-gray-600">
              Try searching with different keywords
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

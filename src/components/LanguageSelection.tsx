import { useState, useEffect } from 'react';
import { Search, Users, MapPin, ArrowLeft } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { mockLanguages, mockLessons } from '../lib/mockData';
import type { Database } from '../lib/database.types';

type Language = Database['public']['Tables']['languages']['Row'];

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
      setLanguages(data || []);
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
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-50">
      <div className="max-w-7xl mx-auto px-4 py-8 sm:px-6 lg:px-8">
        <button
          onClick={() => onNavigate('home')}
          className="flex items-center text-gray-600 hover:text-gray-900 mb-6 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Home
        </button>

        <div className="text-center mb-12">
          <h1 className="text-4xl sm:text-5xl font-bold text-gray-900 mb-4">
            Choose Your Language
          </h1>
          <p className="text-lg text-gray-600 max-w-2xl mx-auto mb-8">
            Select from Kenya's rich linguistic diversity and begin your learning journey
          </p>

          <div className="max-w-xl mx-auto relative">
            <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search by language, tribe, or county..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-12 pr-4 py-3 rounded-full border-2 border-gray-200 focus:border-emerald-500 focus:outline-none text-gray-900 placeholder-gray-400 shadow-sm"
            />
          </div>
        </div>

        {loading ? (
          <div className="flex justify-center items-center py-20">
            <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-500 border-t-transparent"></div>
          </div>
        ) : (
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredLanguages.map((language) => (
              <button
                key={language.id}
                onClick={() => onNavigate('lessons', language.id)}
                className="bg-white rounded-2xl p-6 shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100 text-left hover:scale-105 transform"
              >
                <div className="flex items-start justify-between mb-4">
                  <div className="text-5xl">{language.flag_emoji}</div>
                  <div className="text-sm font-medium text-emerald-600 bg-emerald-50 px-3 py-1 rounded-full">
                    {language.lessons_count || 0} lessons
                  </div>
                </div>

                <h3 className="text-2xl font-bold text-gray-900 mb-1">
                  {language.name}
                </h3>
                <p className="text-sm text-gray-500 mb-3">{language.tribe_name} People</p>

                <p className="text-gray-600 mb-4 leading-relaxed line-clamp-2">
                  {language.description}
                </p>

                <div className="space-y-2">
                  <div className="flex items-center text-sm text-gray-500">
                    <Users className="w-4 h-4 mr-2 flex-shrink-0" />
                    <span>{language.total_speakers.toLocaleString()} speakers</span>
                  </div>
                  <div className="flex items-start text-sm text-gray-500">
                    <MapPin className="w-4 h-4 mr-2 flex-shrink-0 mt-0.5" />
                    <span className="line-clamp-2">
                      {language.counties.join(', ')}
                    </span>
                  </div>
                </div>
              </button>
            ))}
          </div>
        )}

        {!loading && filteredLanguages.length === 0 && (
          <div className="text-center py-20">
            <p className="text-xl text-gray-600">
              No languages found matching "{searchTerm}"
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

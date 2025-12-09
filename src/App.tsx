import { useState } from 'react';
import { UserProvider } from './context/UserContext';
import { HomePage } from './components/HomePage';
import { LanguageSelection } from './components/LanguageSelection';
import { LessonsPage } from './components/LessonsPage';
import { LessonView } from './components/LessonView';
import { QuizView } from './components/QuizView';

type Page = 'home' | 'languages' | 'lessons' | 'lesson' | 'quiz';

interface NavigationState {
  page: Page;
  languageId?: string;
  lessonId?: string;
}

function App() {
  const [navigation, setNavigation] = useState<NavigationState>({
    page: 'home',
  });

  const handleNavigate = (page: string, id?: string) => {
    switch (page) {
      case 'home':
        setNavigation({ page: 'home' });
        break;
      case 'languages':
        setNavigation({ page: 'languages' });
        break;
      case 'lessons':
        setNavigation({ page: 'lessons', languageId: id });
        break;
      case 'lesson':
        setNavigation({ page: 'lesson', lessonId: id });
        break;
      case 'quiz':
        setNavigation({ page: 'quiz', lessonId: id });
        break;
    }
  };

  return (
    <UserProvider>
      {navigation.page === 'home' && <HomePage onNavigate={handleNavigate} />}
      {navigation.page === 'languages' && (
        <LanguageSelection onNavigate={handleNavigate} />
      )}
      {navigation.page === 'lessons' && navigation.languageId && (
        <LessonsPage
          languageId={navigation.languageId}
          onNavigate={handleNavigate}
        />
      )}
      {navigation.page === 'lesson' && navigation.lessonId && (
        <LessonView lessonId={navigation.lessonId} onNavigate={handleNavigate} />
      )}
      {navigation.page === 'quiz' && navigation.lessonId && (
        <QuizView lessonId={navigation.lessonId} onNavigate={handleNavigate} />
      )}
    </UserProvider>
  );
}

export default App;

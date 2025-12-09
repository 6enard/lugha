import { createContext, useContext, useEffect, useState, ReactNode } from 'react';

interface UserContextType {
  userId: string;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export function UserProvider({ children }: { children: ReactNode }) {
  const [userId, setUserId] = useState<string>('');

  useEffect(() => {
    let storedUserId = localStorage.getItem('userId');
    if (!storedUserId) {
      storedUserId = `user_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
      localStorage.setItem('userId', storedUserId);
    }
    setUserId(storedUserId);
  }, []);

  return (
    <UserContext.Provider value={{ userId }}>
      {children}
    </UserContext.Provider>
  );
}

export function useUser() {
  const context = useContext(UserContext);
  if (context === undefined) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
}

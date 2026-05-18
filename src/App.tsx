/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import React, { useState } from 'react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Trophy, Calendar, ListOrdered, GitMerge } from 'lucide-react';
import { motion, AnimatePresence, LayoutGroup } from 'framer-motion';
import { Home } from './screens/Home';
import { Matches } from './screens/Matches';
import { Standings } from './screens/Standings';
import { Bracket } from './screens/Bracket';
import { MatchDetails } from './screens/MatchDetails';
import { Toaster } from 'sonner';
import { footballService } from './services/football';
import { useQuery } from '@tanstack/react-query';

const queryClient = new QueryClient();

type Tab = 'home' | 'matches' | 'standings' | 'bracket';

function AppContent() {
  const [activeTab, setActiveTab] = useState<Tab>('home');
  const [selectedMatchId, setSelectedMatchId] = useState<string | null>(null);

  const { data: allMatches } = useQuery({
    queryKey: ['all-matches-pre'],
    queryFn: async () => {
      const live = await footballService.getLiveMatches();
      const upcoming = await footballService.getUpcomingMatches();
      return [...live, ...upcoming];
    }
  });

  const selectedMatch = allMatches?.find(m => m.id === selectedMatchId);

  return (
    <div className="min-h-screen bg-[#0F1115] text-white font-sans selection:bg-emerald-500/30 overflow-x-hidden relative">
      <Toaster position="top-center" theme="dark" closeButton />
      
      {/* Background Decorative Elements */}
      <div className="fixed inset-0 pointer-events-none overflow-hidden">
        <div className="absolute top-[-10%] left-[-10%] w-[80%] h-[80%] bg-emerald-500/[0.04] blur-[150px] rounded-full" />
        <div className="absolute bottom-[-15%] right-[-5%] w-[60%] h-[60%] bg-emerald-500/[0.03] blur-[120px] rounded-full" />
        <div className="absolute top-[20%] right-[-10%] w-[40%] h-[40%] bg-blue-500/[0.02] blur-[120px] rounded-full" />
        
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_20%_30%,rgba(16,185,129,0.05),transparent_70%)]" />
      </div>

      {/* Main Content Area */}
      <main className="relative pb-32 pt-6 px-4 max-w-[440px] mx-auto min-h-screen">
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
            initial={{ opacity: 0, y: 10, filter: 'blur(10px)' }}
            animate={{ opacity: 1, y: 0, filter: 'blur(0px)' }}
            exit={{ opacity: 0, y: -10, filter: 'blur(10px)' }}
            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
          >
            {activeTab === 'home' && <Home onMatchSelect={setSelectedMatchId} />}
            {activeTab === 'matches' && <Matches onMatchSelect={setSelectedMatchId} />}
            {activeTab === 'standings' && <Standings />}
            {activeTab === 'bracket' && <Bracket />}
          </motion.div>
        </AnimatePresence>
      </main>

      {/* Modal-like Match Details */}
      <AnimatePresence>
        {selectedMatch && (
          <MatchDetails 
            match={selectedMatch} 
            onClose={() => setSelectedMatchId(null)} 
          />
        )}
      </AnimatePresence>

      {/* Floating Bottom Navigation Island */}
      <div className="fixed bottom-6 left-0 right-0 z-50 flex justify-center px-4">
        <nav className="glass rounded-[32px] px-2 py-2 flex items-center gap-0 shadow-2xl shadow-emerald-500/10">
          <LayoutGroup id="nav">
            <NavButton 
              active={activeTab === 'home'} 
              onClick={() => setActiveTab('home')}
              icon={<Trophy size={20} />}
              label="Início"
            />
            <NavButton 
              active={activeTab === 'matches'} 
              onClick={() => setActiveTab('matches')}
              icon={<Calendar size={20} />}
              label="Jogos"
            />
            <NavButton 
              active={activeTab === 'standings'} 
              onClick={() => setActiveTab('standings')}
              icon={<ListOrdered size={20} />}
              label="Tabelas"
            />
            <NavButton 
              active={activeTab === 'bracket'} 
              onClick={() => setActiveTab('bracket')}
              icon={<GitMerge size={20} />}
              label="Fases"
            />
          </LayoutGroup>
        </nav>
      </div>
    </div>
  );
}

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <AppContent />
    </QueryClientProvider>
  );
}

function NavButton({ active, onClick, icon, label }: { active: boolean, onClick: () => void, icon: React.ReactNode, label: string }) {
  return (
    <button
      onClick={onClick}
      className="relative flex flex-col items-center justify-center gap-1.5 px-4 py-2 transition-all duration-300 group outline-none select-none"
    >
      <div className="relative flex items-center justify-center w-12 h-8 rounded-full transition-all duration-300">
         {active && (
           <motion.div 
             layoutId="nav-bg-pill"
             className="absolute inset-0 bg-emerald-500/10 rounded-full"
             transition={{ type: 'spring', bounce: 0.2, duration: 0.6 }}
           />
         )}
         <span className={`relative z-10 transition-all duration-300 group-active:scale-95 ${active ? 'text-emerald-500' : 'text-white/40 group-hover:text-white/60'}`}>
           {React.cloneElement(icon as React.ReactElement, { size: 20 })}
         </span>
      </div>
      <span className={`text-[9px] font-black uppercase tracking-tighter transition-all duration-300 ${active ? 'text-emerald-500' : 'text-white/20 group-hover:text-white/40'}`}>
        {label}
      </span>
    </button>
  );
}



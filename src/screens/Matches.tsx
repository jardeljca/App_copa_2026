import React from 'react';
import { useQuery } from '@tanstack/react-query';
import { footballService } from '../services/football';
import { MatchCard } from '../components/worldcup/MatchCard';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Skeleton } from '@/components/ui/skeleton';
import { motion, AnimatePresence } from 'framer-motion';

export function Matches({ onMatchSelect }: { onMatchSelect: (id: string) => void }) {
  const { data: matches, isLoading } = useQuery({
    queryKey: ['all-matches'],
    queryFn: () => footballService.getUpcomingMatches()
  });

  const today = new Date().toISOString().split('T')[0];
  const tomorrow = new Date(Date.now() + 86400000).toISOString().split('T')[0];

  const filteredMatches = (type: 'todos' | 'hoje' | 'amanha') => {
    if (!matches) return [];
    if (type === 'todos') return matches;
    if (type === 'hoje') return matches.filter(m => m.date.startsWith(today));
    if (type === 'amanha') return matches.filter(m => m.date.startsWith(tomorrow));
    return [];
  };

  return (
    <div className="space-y-6">
      <header className="px-1">
        <h2 className="text-2xl font-black tracking-tighter text-white">CALENDÁRIO</h2>
        <p className="text-white/30 text-[10px] font-black uppercase tracking-[0.3em]">Programação Completa</p>
      </header>

      <Tabs defaultValue="todos" className="w-full">
        <TabsList className="glass p-1 w-full flex rounded-2xl">
          <TabsTrigger value="todos" className="flex-1 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-wider data-[state=active]:bg-emerald-500 data-[state=active]:text-black transition-all">Todos</TabsTrigger>
          <TabsTrigger value="hoje" className="flex-1 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-wider data-[state=active]:bg-emerald-500 data-[state=active]:text-black transition-all">Hoje</TabsTrigger>
          <TabsTrigger value="amanha" className="flex-1 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-wider data-[state=active]:bg-emerald-500 data-[state=active]:text-black transition-all">Amanhã</TabsTrigger>
        </TabsList>

        {['todos', 'hoje', 'amanha'].map((tab) => (
          <TabsContent key={tab} value={tab} className="mt-8 space-y-4 outline-none">
            <AnimatePresence mode="popLayout">
              {isLoading ? (
                [1, 2, 3].map(i => <Skeleton key={i} className="h-32 w-full rounded-[28px] bg-white/5" />)
              ) : filteredMatches(tab as any).length > 0 ? (
                filteredMatches(tab as any).map((match, idx) => (
                  <motion.div
                    key={match.id}
                    initial={{ opacity: 0, scale: 0.95, y: 10 }}
                    animate={{ opacity: 1, scale: 1, y: 0 }}
                    transition={{ delay: idx * 0.05 }}
                  >
                    <MatchCard match={match} onClick={() => onMatchSelect(match.id)} />
                  </motion.div>
                ))
              ) : (
                <div className="p-12 text-center glass rounded-[32px] border-dashed border-white/10">
                  <p className="text-white/20 text-sm font-bold tracking-tight uppercase">Sem jogos no período</p>
                </div>
              )}
            </AnimatePresence>
          </TabsContent>
        ))}
      </Tabs>
    </div>
  );
}


import React from 'react';
import { useQuery } from '@tanstack/react-query';
import { footballService } from '../services/football';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Skeleton } from '@/components/ui/skeleton';
import { motion } from 'framer-motion';

export function Standings() {
  const { data: groups, isLoading } = useQuery({
    queryKey: ['standings'],
    queryFn: () => footballService.getStandings()
  });

  if (isLoading) return <LoadingSkeleton />;

  return (
    <div className="space-y-6">
      <header className="px-1">
        <h2 className="text-2xl font-black tracking-tighter text-white">CLASSIFICAÇÃO</h2>
        <p className="text-white/30 text-[10px] font-black uppercase tracking-[0.3em]">Fase de Grupos</p>
      </header>

      <div className="space-y-6">
        {groups?.map((group, groupIdx) => (
          <motion.div 
            key={group.name} 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: groupIdx * 0.1 }}
            className="glass rounded-[32px] overflow-hidden"
          >
            <div className="px-5 py-4 border-b border-white/[0.05] flex items-center justify-between">
              <h3 className="text-xs font-black text-emerald-500 tracking-[0.2em] uppercase">{group.name}</h3>
              <div className="flex gap-4">
                <span className="text-[10px] font-black text-white/20 uppercase tracking-widest">J</span>
                <span className="text-[10px] font-black text-white/20 uppercase tracking-widest">SG</span>
                <span className="text-[10px] font-black text-white/20 uppercase tracking-widest">PT</span>
              </div>
            </div>
            <div className="overflow-hidden">
              {group.standings.map((entry, idx) => (
                <div 
                  key={entry.team.id} 
                  className={`flex items-center justify-between px-5 py-4 transition-colors hover:bg-white/[0.03] ${idx !== group.standings.length - 1 ? 'border-b border-white/[0.05]' : ''}`}
                >
                  <div className="flex items-center gap-4 flex-1">
                    <span className={`text-[10px] font-black tabular-nums ${idx < 2 ? 'text-emerald-500' : 'text-white/20'}`}>
                      {idx + 1}
                    </span>
                    <div className="w-7 h-7 rounded-full bg-white/[0.05] border-none flex items-center justify-center overflow-hidden">
                      {entry.team.flag.startsWith('http') ? (
                        <img src={entry.team.flag} alt="" className="w-full h-full object-cover" />
                      ) : (
                        <span className="text-sm">{entry.team.flag}</span>
                      )}
                    </div>
                    <span className="text-xs font-bold text-white tracking-tight uppercase">{entry.team.name}</span>
                  </div>
                  
                  <div className="flex items-center gap-4 tabular-nums">
                    <span className="text-xs font-medium text-white/40 w-4 text-center">{entry.played}</span>
                    <span className="text-xs font-medium text-white/40 w-4 text-center">{entry.goalDifference}</span>
                    <span className="text-sm font-black text-white w-4 text-right tracking-tighter">{entry.points}</span>
                  </div>
                </div>
              ))}
            </div>
            <div className="px-5 py-3 bg-white/[0.02] flex items-center justify-between">
              <div className="flex items-center gap-1.5">
                <div className="w-1.5 h-1.5 rounded-full bg-emerald-500" />
                <span className="text-[9px] font-black text-white/40 uppercase tracking-widest">Classificados</span>
              </div>
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
}

function LoadingSkeleton() {
  return (
    <div className="space-y-8">
      <div className="space-y-2">
        <Skeleton className="h-8 w-48 bg-white/5 rounded-xl" />
        <Skeleton className="h-4 w-32 bg-white/5 rounded-lg" />
      </div>
      <Skeleton className="h-64 w-full bg-white/5 rounded-[32px]" />
    </div>
  );
}


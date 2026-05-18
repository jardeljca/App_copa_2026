import React, { FC } from 'react';
import { motion } from 'framer-motion';
import { Match } from '../../types';
import { format } from 'date-fns';
import { ptBR } from 'date-fns/locale';

interface MatchCardProps {
  match: Match;
  onClick?: () => void;
}

export const MatchCard: FC<MatchCardProps> = ({ match, onClick }) => {
  const isLive = match.status === 'LIVE';

  return (
    <motion.div 
      onClick={onClick}
      whileTap={{ scale: 0.98 }}
      className={`bg-white/[0.03] border border-white/[0.08] rounded-[32px] overflow-hidden cursor-pointer group transition-all active:bg-white/[0.05] ${isLive ? 'ring-1 ring-emerald-500/20' : ''}`}
    >
      <div className="p-3">
        {/* Top Info */}
        <div className="flex justify-between items-center mb-3 px-1">
          <div className="flex items-center gap-2">
            <span className="text-[9px] font-black text-white/30 uppercase tracking-[0.2em]">{match.stage}</span>
            <div className="w-1 h-1 bg-white/10 rounded-full" />
            <span className="text-[9px] font-black text-white/60 uppercase tracking-tighter">{match.group || 'Geral'}</span>
          </div>
          
          {isLive ? (
            <div className="flex items-center gap-1.5 px-2 py-0.5 bg-red-500 rounded-full shadow-[0_0_10px_rgba(239,68,68,0.3)]">
              <div className="w-1.5 h-1.5 bg-white rounded-full animate-pulse" />
              <span className="text-[9px] font-black text-white uppercase tracking-tighter">AO VIVO {match.minute}'</span>
            </div>
          ) : (
            <span className="text-[9px] font-black text-white/40 uppercase tracking-tighter tabular-nums bg-white/5 px-2 py-0.5 rounded-full">
              {format(new Date(match.date), "dd MMM, HH:mm", { locale: ptBR })}
            </span>
          )}
        </div>

        {/* Teams & Score */}
        <div className="grid grid-cols-[1fr,auto,1fr] items-center gap-4 px-1">
          {/* Home Team */}
          <div className="flex items-center justify-end gap-2.5">
            <span className="text-right text-[13px] font-black text-white tracking-tight uppercase line-clamp-1">{match.homeTeam.name}</span>
            <div className="w-9 h-9 rounded-full bg-white/[0.05] flex items-center justify-center text-lg overflow-hidden group-hover:bg-white/[0.08] transition-all border-none">
              {match.homeTeam.flag.startsWith('http') ? (
                <img src={match.homeTeam.flag} alt="" className="w-full h-full object-cover" />
              ) : (
                <span className="leading-none">{match.homeTeam.flag}</span>
              )}
            </div>
          </div>

          {/* Central Score/Time */}
          <div className="flex flex-col items-center justify-center gap-1 min-w-[60px]">
            {match.status !== 'SCHEDULED' ? (
              <div className="flex items-center gap-2 text-2xl font-black tabular-nums tracking-tighter">
                <span className={isLive ? 'text-emerald-500 text-glow' : 'text-white'}>{match.homeScore}</span>
                <span className="text-white/10 text-lg font-thin">:</span>
                <span className={isLive ? 'text-emerald-500 text-glow' : 'text-white'}>{match.awayScore}</span>
              </div>
            ) : (
              <div className="px-2.5 py-1 bg-white/5 border border-white/5 rounded-xl text-[12px] font-black text-white">
                {format(new Date(match.date), "HH:mm")}
              </div>
            )}
          </div>

          {/* Away Team */}
          <div className="flex items-center justify-start gap-2.5">
            <div className="w-9 h-9 rounded-full bg-white/[0.05] flex items-center justify-center text-lg overflow-hidden group-hover:bg-white/[0.08] transition-all border-none">
              {match.awayTeam.flag.startsWith('http') ? (
                <img src={match.awayTeam.flag} alt="" className="w-full h-full object-cover" />
              ) : (
                <span className="leading-none">{match.awayTeam.flag}</span>
              )}
            </div>
            <span className="text-left text-[13px] font-black text-white tracking-tight uppercase line-clamp-1">{match.awayTeam.name}</span>
          </div>
        </div>

        {/* Venue Info */}
        <div className="mt-4 flex justify-center items-center gap-2">
          <div className="h-[0.5px] flex-1 bg-gradient-to-r from-transparent to-white/5" />
          <span className="text-[8px] text-white/20 font-black uppercase tracking-[0.2em] shrink-0">{match.venue}</span>
          <div className="h-[0.5px] flex-1 bg-gradient-to-l from-transparent to-white/5" />
        </div>
      </div>
    </motion.div>
  );
}


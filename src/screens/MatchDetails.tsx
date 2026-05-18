import React from 'react';
import { Match } from '../types';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Trophy, MapPin, Clock, Info, Users, Activity, Share2 } from 'lucide-react';

interface MatchDetailsProps {
  match: Match;
  onClose: () => void;
}

export function MatchDetails({ match, onClose }: MatchDetailsProps) {
  const isLive = match.status === 'LIVE';

  return (
    <motion.div
      initial={{ opacity: 0, scale: 1.1 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 1.1 }}
      transition={{ type: 'spring', damping: 25, stiffness: 200 }}
      className="fixed inset-0 z-[100] bg-background flex flex-col overflow-hidden"
    >
      {/* Detail Header */}
      <div className="relative h-[45vh] flex flex-col justify-between p-6">
         <div className="absolute inset-0 z-0 overflow-hidden">
            <motion.img 
              initial={{ scale: 1.2 }}
              animate={{ scale: 1 }}
              transition={{ duration: 10, repeat: Infinity, repeatType: 'reverse' }}
              src="https://images.unsplash.com/photo-1574629810360-7efbbe195018?auto=format&fit=crop&q=80&w=800" 
              className="w-full h-full object-cover opacity-30 grayscale-[0.2]"
              alt="Background"
            />
            <div className="absolute inset-0 bg-gradient-to-b from-background/40 via-background/80 to-background"></div>
         </div>

         {/* Top Bar */}
         <div className="relative z-10 flex justify-between items-center">
            <button 
              onClick={onClose} 
              className="w-10 h-10 glass rounded-full flex items-center justify-center hover:bg-white/10 transition-all active:scale-90"
            >
              <X size={20} className="text-white" />
            </button>
            <div className="bg-emerald-500 text-black font-black uppercase text-[9px] px-3 py-1 rounded-full tracking-wider shadow-lg">
              {match.stage}
            </div>
            <button className="w-10 h-10 glass rounded-full flex items-center justify-center hover:bg-white/10 transition-all active:scale-95">
              <Share2 size={18} className="text-white/60" />
            </button>
         </div>

         {/* Score Display */}
         <div className="relative z-10 grid grid-cols-[1fr,auto,1fr] items-center gap-6 mb-8 mt-auto">
            <div className="flex flex-col items-center gap-4">
              <div className="w-20 h-20 bg-white/[0.05] rounded-full flex items-center justify-center text-4xl shadow-2xl relative">
                {match.homeTeam.flag.startsWith('http') ? (
                  <img src={match.homeTeam.flag} alt="" className="w-full h-full object-cover rounded-full" />
                ) : (
                  <span>{match.homeTeam.flag}</span>
                )}
                <div className="absolute -bottom-1 -right-1 w-6 h-6 glass rounded-full flex items-center justify-center text-[10px] font-black border-none ring-2 ring-background">
                  1
                </div>
              </div>
              <span className="font-black text-white text-base tracking-tight uppercase line-clamp-1">{match.homeTeam.name}</span>
            </div>

            <div className="flex flex-col items-center gap-4 py-2">
              <div className="text-6xl font-black tabular-nums tracking-tighter text-glow drop-shadow-2xl">
                {match.status === 'SCHEDULED' ? (
                  <span className="text-3xl text-white/20 tracking-[0.2em]">VS</span>
                ) : (
                  <span className="flex gap-4">
                    {match.homeScore} <span className="text-white/10 text-4xl font-thin">:</span> {match.awayScore}
                  </span>
                )}
              </div>
              {isLive && (
                <div className="bg-red-500 px-3 py-1 rounded-full flex items-center gap-2 shadow-lg animate-pulse">
                  <div className="w-1.5 h-1.5 bg-white rounded-full" />
                  <span className="text-[10px] font-black text-white uppercase tracking-wider">{match.minute}'</span>
                </div>
              )}
            </div>

            <div className="flex flex-col items-center gap-4">
              <div className="w-20 h-20 bg-white/[0.05] rounded-full flex items-center justify-center text-4xl shadow-2xl relative">
                {match.awayTeam.flag.startsWith('http') ? (
                  <img src={match.awayTeam.flag} alt="" className="w-full h-full object-cover rounded-full" />
                ) : (
                  <span>{match.awayTeam.flag}</span>
                )}
                <div className="absolute -bottom-1 -right-1 w-6 h-6 glass rounded-full flex items-center justify-center text-[10px] font-black border-none ring-2 ring-background">
                  2
                </div>
              </div>
              <span className="font-black text-white text-base tracking-tight uppercase line-clamp-1">{match.awayTeam.name}</span>
            </div>
         </div>
      </div>

      {/* Detail Content */}
      <div className="flex-1 overflow-y-auto px-6 pb-24 space-y-10 no-scrollbar">
         {/* Info Pills */}
         <section className="grid grid-cols-2 gap-3">
            <div className="glass p-4 rounded-[24px] flex items-center gap-4">
              <div className="p-2 bg-emerald-500/10 rounded-xl text-emerald-500">
                <Clock size={16} />
              </div>
              <div>
                <p className="text-[9px] font-black uppercase tracking-widest text-white/30">Início</p>
                <p className="text-xs font-black text-white">{new Date(match.date).toLocaleTimeString([], {hour: '2-digit', minute: '2-digit'})}</p>
              </div>
            </div>
            <div className="glass p-4 rounded-[24px] flex items-center gap-4">
              <div className="p-2 bg-emerald-500/10 rounded-xl text-emerald-500">
                <MapPin size={16} />
              </div>
              <div className="min-w-0">
                <p className="text-[9px] font-black uppercase tracking-widest text-white/30">Estádio</p>
                <p className="text-xs font-black text-white truncate">{match.venue}</p>
              </div>
            </div>
         </section>

         {/* Stats Section */}
         <section className="space-y-6">
            <div className="flex items-center justify-between">
               <div className="flex items-center gap-2">
                  <Activity size={16} className="text-emerald-500" />
                  <h4 className="text-[11px] font-black uppercase tracking-[0.2em] text-white/40">Estatísticas</h4>
               </div>
               <span className="text-[10px] font-black text-emerald-500 px-2 py-0.5 bg-emerald-500/10 rounded-full">Projetado</span>
            </div>
            
            <div className="space-y-6">
               <StatRow label="Posse" homeValue={54} awayValue={46} unit="%" />
               <StatRow label="Chutes" homeValue={12} awayValue={8} />
               <StatRow label="Passes" homeValue={88} awayValue={82} unit="%" />
            </div>
         </section>

         {/* Lineups section */}
         <section className="space-y-6">
            <div className="flex items-center gap-2">
               <Users size={16} className="text-emerald-500" />
               <h4 className="text-[11px] font-black uppercase tracking-[0.2em] text-white/40">Escalações</h4>
            </div>
            <div className="glass p-8 rounded-[32px] border-dashed flex flex-col items-center text-center gap-4">
               <div className="w-12 h-12 glass rounded-full flex items-center justify-center text-white/20">
                 <Info size={24} />
               </div>
               <p className="text-[10px] font-black text-white/30 uppercase tracking-widest leading-loose">Escalações oficiais serão liberadas em breve pela FIFA</p>
            </div>
         </section>
      </div>

      {/* Action Footer */}
      <div className="absolute bottom-0 left-0 right-0 p-6 bg-gradient-to-t from-background via-background to-transparent pt-12 pb-10">
         <button className="w-full h-14 bg-emerald-500 hover:bg-emerald-400 text-black font-black uppercase tracking-[0.2em] rounded-[24px] transition-all shadow-2xl shadow-emerald-500/20 active:scale-95 text-xs">
            Ativar Notificações
         </button>
      </div>
    </motion.div>
  );
}

function StatRow({ label, homeValue, awayValue, unit = '' }: { label: string, homeValue: number, awayValue: number, unit?: string }) {
  const total = homeValue + awayValue;
  const homePct = (homeValue / total) * 100;
  
  return (
    <div className="space-y-2">
      <div className="flex justify-between items-center text-[11px] font-black px-1">
        <span className="text-white w-12">{homeValue}{unit}</span>
        <span className="text-white/30 uppercase tracking-widest text-[9px]">{label}</span>
        <span className="text-white w-12 text-right">{awayValue}{unit}</span>
      </div>
      <div className="h-2 w-full glass rounded-full overflow-hidden flex p-[2px]">
        <motion.div 
          initial={{ width: 0 }}
          animate={{ width: `${homePct}%` }}
          transition={{ duration: 1, delay: 0.5 }}
          className="h-full bg-emerald-500 rounded-full glow-emerald" 
        />
        <div className="flex-1" />
        <motion.div 
          initial={{ width: 0 }}
          animate={{ width: `${100 - homePct}%` }}
          transition={{ duration: 1, delay: 0.7 }}
          className="h-full bg-white/20 rounded-full" 
        />
      </div>
    </div>
  );
}


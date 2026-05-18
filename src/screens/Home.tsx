import React from 'react';
import { useQuery } from '@tanstack/react-query';
import { footballService } from '../services/football';
import { MatchCard } from '../components/worldcup/MatchCard';
import { Skeleton } from '@/components/ui/skeleton';
import { Search, Bell, TrendingUp, Newspaper, ChevronRight } from 'lucide-react';
import { motion } from 'framer-motion';

export function Home({ onMatchSelect }: { onMatchSelect: (id: string) => void }) {
  const { data: liveMatches, isLoading: loadingLive } = useQuery({
    queryKey: ['live-matches'],
    queryFn: () => footballService.getLiveMatches(),
    refetchInterval: 30000 
  });

  const { data: upcomingMatches, isLoading: loadingUpcoming } = useQuery({
    queryKey: ['upcoming-matches'],
    queryFn: () => footballService.getUpcomingMatches()
  });

  const container = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };

  const item = {
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0 }
  };

  return (
    <motion.div 
      variants={container}
      initial="hidden"
      animate="show"
      className="space-y-10"
    >
      {/* Header */}
      <header className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-black tracking-tighter text-white">
            COPA DO MUNDO <span className="text-emerald-500 text-glow">2026</span>
          </h1>
          <p className="text-[10px] font-black text-white/30 uppercase tracking-[0.4em]">Official Kick-off</p>
        </div>
        <div className="flex gap-3">
          <button className="w-11 h-11 bg-white/5 border border-white/10 rounded-full flex items-center justify-center hover:bg-white/10 transition-all active:scale-95 shadow-lg">
            <Search size={20} className="text-white/60" />
          </button>
          <button className="w-11 h-11 bg-white/5 border border-white/10 rounded-full flex items-center justify-center hover:bg-white/10 transition-all active:scale-95 relative shadow-lg">
            <Bell size={20} className="text-white/60" />
            <span className="absolute top-3 right-3 w-2 h-2 bg-emerald-500 rounded-full ring-2 ring-[#0D0D0D] shadow-[0_0_10px_rgba(16,185,129,0.5)]"></span>
          </button>
        </div>
      </header>

      {/* Highlights Section (Hero) */}
      <motion.section variants={item} className="relative h-[220px] rounded-[36px] overflow-hidden group shadow-2xl">
        <img 
          src="https://images.unsplash.com/photo-1574629810360-7efbbe195018?auto=format&fit=crop&q=80&w=800" 
          alt="World Cup Banner"
          className="w-full h-full object-cover transition-transform duration-[2000ms] group-hover:scale-110"
          referrerPolicy="no-referrer"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent p-8 flex flex-col justify-end">
          <motion.div 
            initial={{ opacity: 0, x: -10 }}
            animate={{ opacity: 1, x: 0 }}
            className="mb-3 bg-emerald-500 text-black font-black text-[9px] px-2.5 py-1 rounded-lg w-fit tracking-tighter uppercase"
          >
            Destaque
          </motion.div>
          <h2 className="text-2xl font-black text-white leading-none mb-2 tracking-tight">CAMINHO ATÉ A GLÓRIA</h2>
          <p className="text-sm text-white/70 font-medium">Acompanhe cada momento da maior competição do planeta.</p>
        </div>
      </motion.section>

      {/* Upcoming Matches Card (Re-designed) */}
      <motion.section variants={item}>
        <div className="bg-white/[0.03] border border-white/[0.08] rounded-[36px] p-5 shadow-xl backdrop-blur-sm">
          <div className="flex justify-between items-center mb-4">
            <h3 className="font-black text-[11px] uppercase tracking-[0.2em] text-white/40">Próximos Jogos</h3>
            <div className="flex items-center gap-1 text-white/20">
               <span className="text-[9px] font-black uppercase tracking-widest text-emerald-500">Hoje</span>
               <ChevronRight size={14} />
            </div>
          </div>
          
          <div className="space-y-3">
            {loadingUpcoming ? (
               <Skeleton className="h-24 w-full rounded-[24px] bg-white/5" />
            ) : (
              upcomingMatches?.slice(0, 1).map(match => (
                <MatchCard key={match.id} match={match} onClick={() => onMatchSelect(match.id)} />
              ))
            )}
          </div>
        </div>
      </motion.section>

      {/* Videos & Goals Section */}
      <motion.section variants={item}>
        <div className="flex items-center justify-between mb-5">
          <h3 className="font-black text-[12px] uppercase tracking-[0.2em] text-white/40">Vídeos & Gols</h3>
          <button className="text-emerald-500 text-[10px] font-black uppercase tracking-wider hover:text-white transition-colors">Ver Tudo</button>
        </div>
        
        <div className="flex gap-4 overflow-x-auto pb-4 -mx-4 px-4 no-scrollbar scroll-smooth">
          {[
            { img: "https://images.unsplash.com/photo-1543351611-58f69d7c1781?auto=format&fit=crop&q=80&w=400", title: "Melhores momentos: Brasil vs França" },
            { img: "https://images.unsplash.com/photo-1574629810360-7efbbe195018?auto=format&fit=crop&q=80&w=401", title: "Gols da rodada #3" },
            { img: "https://images.unsplash.com/photo-1510563800743-aed236490d08?auto=format&fit=crop&q=80&w=402", title: "Defesas espetaculares" }
          ].map((video, idx) => (
            <motion.div 
              key={idx}
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
              className="flex-shrink-0 w-64 h-40 rounded-[32px] overflow-hidden relative group cursor-pointer shadow-lg"
            >
              <img src={video.img} className="w-full h-full object-cover" referrerPolicy="no-referrer" />
              <div className="absolute inset-0 bg-gradient-to-t from-black via-black/20 to-transparent p-5 flex flex-col justify-end">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-white/20 backdrop-blur-md flex items-center justify-center text-white">
                    <TrendingUp size={14} className="rotate-90 fill-white" />
                  </div>
                  <p className="text-sm font-bold text-white line-clamp-2 leading-tight">{video.title}</p>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </motion.section>

      {/* News Section */}
      <motion.section variants={item} className="pb-8">
        <h3 className="font-black text-[12px] uppercase tracking-[0.2em] text-white/40 mb-5">Notícias</h3>
        <div className="flex flex-col gap-4">
          <NewsItem 
            image="https://images.unsplash.com/photo-1510563800743-aed236490d08?auto=format&fit=crop&q=80&w=200"
            title="Brasil lidera as casas de aposta para o título de 2026"
            category="Favorito"
            time="2h atrás"
          />
          <NewsItem 
            image="https://images.unsplash.com/photo-1543351611-58f69d7c1781?auto=format&fit=crop&q=80&w=200"
            title="Sede da grande final confirmada: NY se prepara para o espetáculo"
            category="Última"
            time="5h atrás"
          />
        </div>
      </motion.section>
    </motion.div>
  );
}

function NewsItem({ image, title, category, time }: { image: string, title: string, category: string, time: string }) {
  return (
    <div className="bg-white/[0.03] border border-white/[0.08] p-4 rounded-[32px] flex gap-5 group cursor-pointer hover:bg-white/[0.06] transition-all duration-300">
      <div className="w-24 h-24 rounded-2xl overflow-hidden flex-shrink-0 shadow-lg">
        <img src={image} alt={title} className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" referrerPolicy="no-referrer" />
      </div>
      <div className="flex flex-col justify-center gap-2 pr-2">
        <div className="flex items-center gap-2">
          <span className="text-[9px] font-black uppercase tracking-widest text-emerald-500">{category}</span>
          <span className="text-[9px] font-black text-white/20">•</span>
          <span className="text-[10px] text-white/30 font-medium">{time}</span>
        </div>
        <h4 className="text-base font-bold leading-tight group-hover:text-emerald-500 transition-colors line-clamp-2 tracking-tight">{title}</h4>
      </div>
    </div>
  );
}


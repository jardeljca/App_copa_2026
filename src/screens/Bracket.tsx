import React from 'react';
import { motion } from 'framer-motion';

export function Bracket() {
  return (
    <div className="space-y-6">
      <header className="px-1">
        <h2 className="text-2xl font-black tracking-tighter text-white uppercase">Mata-Mata</h2>
        <p className="text-white/30 text-[10px] font-black uppercase tracking-[0.3em]">Caminho para a Taça</p>
      </header>

      <div className="flex flex-col gap-10 overflow-x-auto pb-12 no-scrollbar px-1">
        {/* Placeholder for visual bracket */}
        <section className="space-y-6 min-w-[700px]">
          <h3 className="text-[10px] font-black text-white/20 uppercase tracking-[0.4em] ml-1">Oitavas de Final</h3>
          <div className="grid grid-cols-2 gap-x-8 gap-y-6">
             {[1,2,3,4].map(i => (
               <motion.div 
                key={i} 
                whileHover={{ scale: 1.02 }}
                className="glass rounded-[24px] p-4 space-y-4 relative overflow-hidden group"
               >
                  <div className="absolute left-0 top-0 bottom-0 w-1 bg-emerald-500/20 group-hover:bg-emerald-500 transition-colors" />
                  <div className="flex justify-between items-center text-xs font-black uppercase tracking-tight">
                    <div className="flex items-center gap-3">
                      <div className="w-6 h-6 glass rounded-full flex items-center justify-center text-[10px] border-none overflow-hidden">
                        <span className="grayscale opacity-50 group-hover:grayscale-0 group-hover:opacity-100 transition-all">🇧🇷</span>
                      </div>
                      <span className="text-white/80">Brasil</span>
                    </div>
                    <span className="text-emerald-500 tabular-nums">-</span>
                  </div>
                  <div className="flex justify-between items-center text-xs font-black uppercase tracking-tight opacity-30">
                    <div className="flex items-center gap-3">
                      <div className="w-6 h-6 glass rounded-full flex items-center justify-center text-[10px] border-none overflow-hidden">
                        <span className="grayscale">🇫🇷</span>
                      </div>
                      <span>França</span>
                    </div>
                    <span className="tabular-nums">-</span>
                  </div>
               </motion.div>
             ))}
          </div>
        </section>

        <section className="space-y-6 min-w-[700px] pl-10">
          <h3 className="text-[10px] font-black text-white/20 uppercase tracking-[0.4em]">Quartas de Final</h3>
          <div className="grid grid-cols-2 gap-x-12 gap-y-10">
             {[1,2].map(i => (
               <div key={i} className="glass rounded-[24px] p-5 space-y-4 opacity-20 border-dashed">
                  <div className="h-4 w-32 bg-white/5 rounded-lg animate-pulse" />
                  <div className="h-4 w-24 bg-white/5 rounded-lg animate-pulse" />
               </div>
             ))}
          </div>
        </section>
      </div>

      <motion.div 
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        className="text-center p-10 glass rounded-[32px] border-dashed"
      >
        <p className="text-emerald-500/60 text-[10px] font-black uppercase tracking-[0.2em] leading-loose">
          O chaveamento será gerado <br /> dinamicamente após a fase de grupos.
        </p>
      </motion.div>
    </div>
  );
}


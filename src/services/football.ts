import { Match, Group } from '../types';
import { MOCK_DATA } from '../mockData';

const API_KEY = (import.meta as any).env.VITE_API_FUTEBOL_KEY;
const BASE_URL = 'https://api.api-futebol.com.br/v1';
const WORLD_CUP_ID = 25; // ID fictício para 2026, o usuário pode ajustar conforme a documentação

class FootballService {
  private async fetchFromApi(endpoint: string) {
    try {
      const response = await fetch(`/api/football${endpoint}`);
      if (!response.ok) return null;
      return await response.json();
    } catch (error) {
      console.error('Proxy Fetch Error:', error);
      return null;
    }
  }

  async getLiveMatches(): Promise<Match[]> {
    const data = await this.fetchFromApi('/partidas/ao-vivo');
    
    if (!data || !Array.isArray(data)) {
      return MOCK_DATA.matches.filter(m => m.status === 'LIVE');
    }

    return data.map((f: any) => ({
      id: f.partida_id.toString(),
      homeTeam: { 
        id: f.time_mandante.time_id.toString(), 
        name: f.time_mandante.nome_popular, 
        code: f.time_mandante.sigla, 
        flag: f.time_mandante.escudo
      },
      awayTeam: { 
        id: f.time_visitante.time_id.toString(), 
        name: f.time_visitante.nome_popular, 
        code: f.time_visitante.sigla, 
        flag: f.time_visitante.escudo
      },
      homeScore: f.placar_mandante,
      awayScore: f.placar_visitante,
      date: f.data_realizacao_iso,
      status: 'LIVE',
      minute: f.tempo_partida || '0\'',
      stage: 'Ao Vivo',
      venue: f.estadio?.nome_popular || 'Estádio'
    }));
  }

  async getUpcomingMatches(): Promise<Match[]> {
    const data = await this.fetchFromApi(`/campeonatos/${WORLD_CUP_ID}/partidas`);

    if (!data || !data.partidas) {
      return MOCK_DATA.matches.filter(m => m.status === 'SCHEDULED');
    }

    // A API Futebol separa por fases, vamos pegar a fase atual ou todas
    const allPhases = Object.values(data.partidas).flat() as any[];
    
    return allPhases.map((f: any) => ({
      id: f.partida_id.toString(),
      homeTeam: { 
        id: f.time_mandante.time_id.toString(), 
        name: f.time_mandante.nome_popular, 
        code: f.time_mandante.sigla, 
        flag: f.time_mandante.escudo 
      },
      awayTeam: { 
        id: f.time_visitante.time_id.toString(), 
        name: f.time_visitante.nome_popular, 
        code: f.time_visitante.sigla, 
        flag: f.time_visitante.escudo 
      },
      date: f.data_realizacao_iso,
      status: f.status === 'agendado' ? 'SCHEDULED' : f.status === 'encerrado' ? 'FINISHED' : 'LIVE',
      stage: f.fase?.nome || 'Copa do Mundo',
      venue: f.estadio?.nome_popular || 'Estádio',
      homeScore: f.placar_mandante,
      awayScore: f.placar_visitante
    }));
  }

  async getStandings(): Promise<Group[]> {
    const data = await this.fetchFromApi(`/campeonatos/${WORLD_CUP_ID}/tabela`);

    if (!data) {
      return MOCK_DATA.groups;
    }

    // A API Futebol pode retornar um objeto onde as chaves são os nomes dos grupos
    // ou uma lista se for campeonato de pontos corridos.
    // Vamos detectar e mapear adequadamente para o formato da Copa.

    if (Array.isArray(data)) {
      // Se for um array, verificamos se ele já contém objetos de "grupo"
      // ou se é uma lista única que precisamos repartir (quem sabe).
      // Geralmente pra Copa ela retorna o formato de grupos.
      
      const firstItem = data[0];
      if (firstItem && firstItem.grupo) {
        // Formato agrupado: agrupar por nome de grupo
        const groupsMap: Record<string, Group> = {};
        data.forEach((t: any) => {
          const groupName = t.grupo.nome || 'Grupo';
          if (!groupsMap[groupName]) {
            groupsMap[groupName] = { name: groupName, standings: [] };
          }
          groupsMap[groupName].standings.push({
            team: { 
              id: t.time.time_id.toString(), 
              name: t.time.nome_popular, 
              code: t.time.sigla, 
              flag: t.time.escudo 
            },
            played: t.jogos,
            won: t.vitorias,
            drawn: t.empates,
            lost: t.derrotas,
            goalsFor: t.gols_pro,
            goalsAgainst: t.gols_contra,
            goalDifference: t.saldo_gols,
            points: t.pontos
          });
        });
        return Object.values(groupsMap);
      }

      // Fallback para lista única
      return [{
        name: 'Classificação',
        standings: data.map((t: any) => ({
          team: { 
            id: t.time.time_id.toString(), 
            name: t.time.nome_popular, 
            code: t.time.sigla, 
            flag: t.time.escudo 
          },
          played: t.jogos,
          won: t.vitorias,
          drawn: t.empates,
          lost: t.derrotas,
          goalsFor: t.gols_pro,
          goalsAgainst: t.gols_contra,
          goalDifference: t.saldo_gols,
          points: t.pontos
        }))
      }];
    }

    // Se for um objeto (raro no retorno direto da v1 /tabela, mas bom prever)
    if (typeof data === 'object') {
       // Possível mapeamento de objeto de grupos
       return Object.entries(data).map(([name, teams]: [string, any]) => ({
         name,
         standings: teams.map((t: any) => ({
           team: { id: t.time.time_id.toString(), name: t.time.nome_popular, code: t.time.sigla, flag: t.time.escudo },
           played: t.jogos,
           won: t.vitorias,
           drawn: t.empates,
           lost: t.derrotas,
           goalsFor: t.gols_pro,
           goalsAgainst: t.gols_contra,
           goalDifference: t.saldo_gols,
           points: t.pontos
         }))
       }));
    }

    return MOCK_DATA.groups;
  }
}

export const footballService = new FootballService();

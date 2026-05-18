import { TournamentData } from './types';

export const MOCK_DATA: TournamentData = {
  groups: [
    {
      name: 'Grupo A',
      standings: [
        { team: { id: '1', name: 'Brasil', code: 'BRA', flag: '🇧🇷' }, played: 1, won: 1, drawn: 0, lost: 0, goalsFor: 2, goalsAgainst: 1, goalDifference: 1, points: 3 },
        { team: { id: '2', name: 'França', code: 'FRA', flag: '🇫🇷' }, played: 1, won: 0, drawn: 0, lost: 1, goalsFor: 1, goalsAgainst: 2, goalDifference: -1, points: 0 },
        { team: { id: '3', name: 'Japão', code: 'JPN', flag: '🇯🇵' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '4', name: 'Marrocos', code: 'MAR', flag: '🇲🇦' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
      ]
    },
    {
      name: 'Grupo B',
      standings: [
        { team: { id: '5', name: 'Argentina', code: 'ARG', flag: '🇦🇷' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '6', name: 'Alemanha', code: 'GER', flag: '🇩🇪' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '7', name: 'Espanha', code: 'ESP', flag: '🇪🇸' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '8', name: 'Canadá', code: 'CAN', flag: '🇨🇦' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
      ]
    },
    {
      name: 'Grupo C',
      standings: [
        { team: { id: '9', name: 'Portugal', code: 'POR', flag: '🇵🇹' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '10', name: 'Inglaterra', code: 'ENG', flag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '11', name: 'México', code: 'MEX', flag: '🇲🇽' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '12', name: 'Coreia do Sul', code: 'KOR', flag: '🇰🇷' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
      ]
    },
    {
      name: 'Grupo D',
      standings: [
        { team: { id: '13', name: 'Espanha', code: 'ESP', flag: '🇪🇸' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '14', name: 'Holanda', code: 'NED', flag: '🇳🇱' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '15', name: 'Uruguai', code: 'URU', flag: '🇺🇾' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
        { team: { id: '16', name: 'Senegal', code: 'SEN', flag: '🇸🇳' }, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDifference: 0, points: 0 },
      ]
    }
  ],
  matches: [
    {
      id: 'm1',
      homeTeam: { id: '1', name: 'Brasil', code: 'BRA', flag: '🇧🇷' },
      awayTeam: { id: '2', name: 'França', code: 'FRA', flag: '🇫🇷' },
      homeScore: 2,
      awayScore: 1,
      date: new Date().toISOString(),
      status: 'LIVE',
      minute: 65,
      stage: 'Fase de Grupos',
      group: 'Grupo A',
      venue: 'Lusail Stadium'
    },
    {
      id: 'm2',
      homeTeam: { id: '5', name: 'Argentina', code: 'ARG', flag: '🇦🇷' },
      awayTeam: { id: '6', name: 'Alemanha', code: 'GER', flag: '🇩🇪' },
      date: new Date(Date.now() + 86400000).toISOString(),
      status: 'SCHEDULED',
      stage: 'Fase de Grupos',
      group: 'Grupo B',
      venue: 'MetLife Stadium'
    },
    {
      id: 'm3',
      homeTeam: { id: '9', name: 'Portugal', code: 'POR', flag: '🇵🇹' },
      awayTeam: { id: '10', name: 'Inglaterra', code: 'ENG', flag: '🏴' },
      date: new Date(Date.now() + 172800000).toISOString(),
      status: 'SCHEDULED',
      stage: 'Fase de Grupos',
      group: 'Grupo C',
      venue: 'Azteca Stadium'
    }
  ]
};

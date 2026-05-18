/**
 * MundoCup 2026 Types
 */

export type MatchStatus = 'SCHEDULED' | 'LIVE' | 'FINISHED' | 'POSTPONED';

export interface Team {
  id: string;
  name: string;
  code: string;
  flag: string;
}

export interface Match {
  id: string;
  homeTeam: Team;
  awayTeam: Team;
  homeScore?: number;
  awayScore?: number;
  date: string;
  status: MatchStatus;
  minute?: number;
  group?: string;
  stage: string;
  venue: string;
}

export interface GroupStanding {
  team: Team;
  played: number;
  won: number;
  drawn: number;
  lost: number;
  goalsFor: number;
  goalsAgainst: number;
  goalDifference: number;
  points: number;
}

export interface Group {
  name: string;
  standings: GroupStanding[];
}

export interface TournamentData {
  groups: Group[];
  matches: Match[];
}

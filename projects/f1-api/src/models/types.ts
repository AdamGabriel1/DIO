export interface Driver {
  id: string;
  name: string;
  nationality: string;
  teamId: string;
  number: number;
  points: number;
  wins: number;
  podiums: number;
}

export interface Team {
  id: string;
  name: string;
  base: string;
  teamPrincipal: string;
  championships: number;
  points: number;
}

export interface Race {
  id: string;
  name: string;
  circuit: string;
  country: string;
  date: string;
  season: number;
  results: RaceResult[];
}

export interface RaceResult {
  position: number;
  driverId: string;
  teamId: string;
  points: number;
  fastestLap?: boolean;
}

export interface CreateDriverDTO {
  name: string;
  nationality: string;
  teamId: string;
  number: number;
}

export interface UpdateDriverDTO {
  name?: string;
  nationality?: string;
  teamId?: string;
  number?: number;
  points?: number;
}

export interface CreateTeamDTO {
  name: string;
  base: string;
  teamPrincipal: string;
}

export interface CreateRaceDTO {
  name: string;
  circuit: string;
  country: string;
  date: string;
  season: number;
}

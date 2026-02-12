import { db, generateId } from '../data/database.js';
import { Race, CreateRaceDTO, RaceResult } from '../models/types.js';
import { driversService } from './drivers.service.js';
import { teamsService } from './teams.service.js';

export const racesService = {
  findAll(season?: number): Race[] {
    let races = Array.from(db.races.values());
    if (season) {
      races = races.filter(r => r.season === season);
    }
    return races.sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
  },

  findById(id: string): Race | undefined {
    return db.races.get(id);
  },

  create(data: CreateRaceDTO): Race {
    const id = generateId('race');
    const race: Race = {
      id,
      ...data,
      results: []
    };

    db.races.set(id, race);
    return race;
  },

  addResults(raceId: string, results: RaceResult[]): Race | null {
    const race = db.races.get(raceId);
    if (!race) return null;

    // Atualiza resultados da corrida
    race.results = results;
    db.races.set(raceId, race);

    // Distribui pontos (sistema F1: 25-18-15-12-10-8-6-4-2-1)
    const pointsSystem = [25, 18, 15, 12, 10, 8, 6, 4, 2, 1];
    
    results.forEach((result, index) => {
      const points = pointsSystem[result.position - 1] || 0;
      const bonus = result.fastestLap && result.position <= 10 ? 1 : 0;
      
      // Atualiza pontos do piloto
      driversService.addPoints(result.driverId, points + bonus);
    });

    return race;
  }
};

import { db } from '../data/database.js';
import { teamsService } from './teams.service.js';

export const standingsService = {
  getDriverStandings() {
    const drivers = Array.from(db.drivers.values())
      .sort((a, b) => b.points - a.points)
      .map((driver, index) => ({
        position: index + 1,
        driver: {
          id: driver.id,
          name: driver.name,
          number: driver.number,
          nationality: driver.nationality
        },
        team: db.teams.get(driver.teamId)?.name || 'Unknown',
        points: driver.points,
        wins: driver.wins
      }));

    return {
      season: 2024,
      round: db.races.size,
      standings: drivers
    };
  },

  getTeamStandings() {
    // Calcula pontos totais por equipe
    const teams = Array.from(db.teams.values()).map(team => ({
      ...team,
      points: teamsService.calculatePoints(team.id)
    }));

    const sorted = teams
      .sort((a, b) => b.points - a.points)
      .map((team, index) => ({
        position: index + 1,
        team: {
          id: team.id,
          name: team.name,
          base: team.base
        },
        points: team.points,
        championships: team.championships
      }));

    return {
      season: 2024,
      round: db.races.size,
      standings: sorted
    };
  }
};

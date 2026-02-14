import { db } from '../models/index.js';

export const standingsService = {
  calculate(groupFilter) {
    const groups = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    const result = {};

    groups.forEach(group => {
      if (groupFilter && group !== groupFilter.toUpperCase()) return;

      const teamsInGroup = Array.from(db.teams.values())
        .filter(t => t.group === group);

      const standings = teamsInGroup.map(team => {
        const stats = this.calculateTeamStats(team.id);
        return {
          team: {
            id: team.id,
            name: team.name,
            country: team.country
          },
          ...stats
        };
      });

      // Ordena: pontos, saldo de gols, gols marcados
      standings.sort((a, b) => {
        if (b.points !== a.points) return b.points - a.points;
        if (b.goalDifference !== a.goalDifference) return b.goalDifference - a.goalDifference;
        return b.goalsFor - a.goalsFor;
      });

      // Adiciona posição
      standings.forEach((s, index) => {
        s.position = index + 1;
      });

      result[group] = standings;
    });

    return groupFilter ? result[groupFilter.toUpperCase()] : result;
  },

  calculateTeamStats(teamId) {
    const matches = Array.from(db.matches.values())
      .filter(m => 
        (m.homeTeamId === teamId || m.awayTeamId === teamId) && m.played
      );

    let played = 0, won = 0, drawn = 0, lost = 0;
    let goalsFor = 0, goalsAgainst = 0, points = 0;

    matches.forEach(m => {
      const isHome = m.homeTeamId === teamId;
      const teamGoals = isHome ? m.homeScore : m.awayScore;
      const oppGoals = isHome ? m.awayScore : m.homeScore;

      played++;
      goalsFor += teamGoals;
      goalsAgainst += oppGoals;

      if (teamGoals > oppGoals) {
        won++;
        points += 3;
      } else if (teamGoals === oppGoals) {
        drawn++;
        points += 1;
      } else {
        lost++;
      }
    });

    return {
      played,
      won,
      drawn,
      lost,
      goalsFor,
      goalsAgainst,
      goalDifference: goalsFor - goalsAgainst,
      points
    };
  }
};

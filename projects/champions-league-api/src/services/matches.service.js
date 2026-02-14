import { db, generateId } from '../models/index.js';
import { playersService } from './players.service.js';

export const matchesService = {
  findAll(filters = {}) {
    let matches = Array.from(db.matches.values());
    
    if (filters.group) {
      matches = matches.filter(m => m.group === filters.group.toUpperCase());
    }
    if (filters.matchday) {
      matches = matches.filter(m => m.matchday === parseInt(filters.matchday));
    }
    if (filters.team) {
      matches = matches.filter(m => 
        m.homeTeamId === filters.team || m.awayTeamId === filters.team
      );
    }
    
    return matches.map(m => this.enrichMatch(m));
  },

  findById(id) {
    const match = db.matches.get(id);
    if (!match) return null;
    return this.enrichMatch(match);
  },

  enrichMatch(match) {
    return {
      ...match,
      homeTeam: db.teams.get(match.homeTeamId)?.name || 'Unknown',
      awayTeam: db.teams.get(match.awayTeamId)?.name || 'Unknown',
      played: match.homeScore !== null && match.awayScore !== null
    };
  },

  create(data) {
    if (!data.homeTeamId || !data.awayTeamId) {
      throw new Error('Both teams are required');
    }
    if (!db.teams.has(data.homeTeamId) || !db.teams.has(data.awayTeamId)) {
      throw new Error('One or both teams not found');
    }
    if (data.homeTeamId === data.awayTeamId) {
      throw new Error('Teams must be different');
    }

    const id = `match-${generateId()}`;
    const match = {
      id,
      ...data,
      homeScore: null,
      awayScore: null,
      scorers: [],
      played: false
    };

    db.matches.set(id, match);
    return this.enrichMatch(match);
  },

  updateResult(id, data) {
    const match = db.matches.get(id);
    if (!match) return null;

    if (data.homeScore !== undefined) match.homeScore = data.homeScore;
    if (data.awayScore !== undefined) match.awayScore = data.awayScore;
    if (data.scorers) {
      match.scorers = data.scorers;
      // Atualiza estatísticas dos jogadores
      data.scorers.forEach(s => {
        playersService.addStats(s.playerId, s.goals || 1, 0);
      });
    }
    
    match.played = match.homeScore !== null && match.awayScore !== null;
    match.updatedAt = new Date().toISOString();

    db.matches.set(id, match);
    return this.enrichMatch(match);
  },

  delete(id) {
    return db.matches.delete(id);
  },

  getMatchesByTeam(teamId) {
    return Array.from(db.matches.values())
      .filter(m => m.homeTeamId === teamId || m.awayTeamId === teamId);
  }
};

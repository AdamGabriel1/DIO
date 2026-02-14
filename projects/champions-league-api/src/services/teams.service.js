import { db, generateId } from '../models/index.js';

export const teamsService = {
  findAll(filters = {}) {
    let teams = Array.from(db.teams.values());
    
    if (filters.group) {
      teams = teams.filter(t => t.group === filters.group.toUpperCase());
    }
    if (filters.country) {
      teams = teams.filter(t => 
        t.country.toLowerCase() === filters.country.toLowerCase()
      );
    }
    
    return teams;
  },

  findById(id) {
    return db.teams.get(id);
  },

  getPlayers(teamId) {
    return Array.from(db.players.values())
      .filter(p => p.teamId === teamId);
  },

  create(data) {
    if (!data.name || data.name.length < 2) {
      throw new Error('Team name must be at least 2 characters');
    }
    if (!data.group || !['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'].includes(data.group)) {
      throw new Error('Valid group (A-H) is required');
    }

    const id = data.name.toLowerCase().replace(/\s+/g, '-');
    const team = {
      id,
      ...data,
      titles: data.titles || 0
    };

    db.teams.set(id, team);
    return team;
  },

  update(id, data) {
    const existing = db.teams.get(id);
    if (!existing) return null;

    const updated = { ...existing, ...data, id };
    db.teams.set(id, updated);
    return updated;
  },

  delete(id) {
    // Verifica se há jogadores
    const hasPlayers = this.getPlayers(id).length > 0;
    if (hasPlayers) {
      throw new Error('Cannot delete team with registered players');
    }
    return db.teams.delete(id);
  }
};

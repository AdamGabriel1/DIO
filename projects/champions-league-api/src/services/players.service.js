import { db, generateId } from '../models/index.js';

export const playersService = {
  findAll(filters = {}) {
    let players = Array.from(db.players.values());
    
    if (filters.team) {
      players = players.filter(p => p.teamId === filters.team);
    }
    if (filters.position) {
      players = players.filter(p => 
        p.position.toLowerCase() === filters.position.toLowerCase()
      );
    }
    
    return players;
  },

  findById(id) {
    return db.players.get(id);
  },

  getTopScorers(limit = 10) {
    return Array.from(db.players.values())
      .sort((a, b) => b.goals - a.goals)
      .slice(0, limit)
      .map(p => ({
        ...p,
        teamName: db.teams.get(p.teamId)?.name || 'Unknown'
      }));
  },

  create(data) {
    if (!data.name || !data.teamId) {
      throw new Error('Name and teamId are required');
    }
    if (!db.teams.has(data.teamId)) {
      throw new Error('Team not found');
    }

    const id = `player-${generateId()}`;
    const player = {
      id,
      ...data,
      goals: 0,
      assists: 0
    };

    db.players.set(id, player);
    return player;
  },

  update(id, data) {
    const existing = db.players.get(id);
    if (!existing) return null;

    const updated = { ...existing, ...data, id };
    db.players.set(id, updated);
    return updated;
  },

  addStats(id, goals = 0, assists = 0) {
    const player = db.players.get(id);
    if (!player) return null;
    
    player.goals += goals;
    player.assists += assists;
    db.players.set(id, player);
    return player;
  },

  delete(id) {
    return db.players.delete(id);
  }
};

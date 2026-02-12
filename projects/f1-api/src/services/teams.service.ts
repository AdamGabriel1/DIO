import { db, generateId } from '../data/database.js';
import { Team, CreateTeamDTO } from '../models/types.js';

export const teamsService = {
  findAll(): Team[] {
    return Array.from(db.teams.values())
      .sort((a, b) => b.points - a.points);
  },

  findById(id: string): Team | undefined {
    return db.teams.get(id);
  },

  create(data: CreateTeamDTO): Team {
    if (!data.name || data.name.length < 2) {
      throw new Error('Name must be at least 2 characters');
    }

    const id = generateId('team');
    const team: Team = {
      id,
      ...data,
      championships: 0,
      points: 0
    };

    db.teams.set(id, team);
    return team;
  },

  update(id: string, data: Partial<CreateTeamDTO>): Team | null {
    const existing = db.teams.get(id);
    if (!existing) return null;

    const updated: Team = {
      ...existing,
      ...data,
      id
    };

    db.teams.set(id, updated);
    return updated;
  },

  delete(id: string): boolean {
    return db.teams.delete(id);
  },

  hasDrivers(teamId: string): boolean {
    return Array.from(db.drivers.values())
      .some(d => d.teamId === teamId);
  },

  calculatePoints(teamId: string): number {
    return Array.from(db.drivers.values())
      .filter(d => d.teamId === teamId)
      .reduce((sum, d) => sum + d.points, 0);
  }
};

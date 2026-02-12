import { db, generateId } from '../data/database.js';
import { Driver, CreateDriverDTO, UpdateDriverDTO } from '../models/types.js';

export const driversService = {
  findAll(filters?: { team?: string; nationality?: string }): Driver[] {
    let drivers = Array.from(db.drivers.values());
    
    if (filters?.team) {
      drivers = drivers.filter(d => d.teamId === filters.team);
    }
    if (filters?.nationality) {
      drivers = drivers.filter(d => 
        d.nationality.toLowerCase() === filters.nationality?.toLowerCase()
      );
    }
    
    return drivers.sort((a, b) => b.points - a.points);
  },

  findById(id: string): Driver | undefined {
    return db.drivers.get(id);
  },

  create(data: CreateDriverDTO): Driver {
    // Validações
    if (!data.name || data.name.length < 2) {
      throw new Error('Name must be at least 2 characters');
    }
    if (!data.teamId || !db.teams.has(data.teamId)) {
      throw new Error('Valid teamId is required');
    }
    
    // Verifica número único
    const existingNumber = Array.from(db.drivers.values())
      .find(d => d.number === data.number);
    if (existingNumber) {
      throw new Error(`Number ${data.number} is already taken`);
    }

    const id = generateId('driver');
    const driver: Driver = {
      id,
      ...data,
      points: 0,
      wins: 0,
      podiums: 0
    };

    db.drivers.set(id, driver);
    return driver;
  },

  update(id: string, data: UpdateDriverDTO): Driver | null {
    const existing = db.drivers.get(id);
    if (!existing) return null;

    const updated: Driver = {
      ...existing,
      ...data,
      id // preserva ID original
    };

    db.drivers.set(id, updated);
    return updated;
  },

  delete(id: string): boolean {
    return db.drivers.delete(id);
  },

  addPoints(id: string, points: number): Driver | null {
    const driver = db.drivers.get(id);
    if (!driver) return null;
    
    driver.points += points;
    db.drivers.set(id, driver);
    return driver;
  }
};

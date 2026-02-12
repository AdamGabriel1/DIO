import { Driver, Team, Race } from '../models/types.js';

// Banco de dados em memória
export const db = {
  drivers: new Map<string, Driver>([
    ['verstappen', {
      id: 'verstappen',
      name: 'Max Verstappen',
      nationality: 'Dutch',
      teamId: 'redbull',
      number: 1,
      points: 0,
      wins: 0,
      podiums: 0
    }],
    ['perez', {
      id: 'perez',
      name: 'Sergio Perez',
      nationality: 'Mexican',
      teamId: 'redbull',
      number: 11,
      points: 0,
      wins: 0,
      podiums: 0
    }],
    ['hamilton', {
      id: 'hamilton',
      name: 'Lewis Hamilton',
      nationality: 'British',
      teamId: 'mercedes',
      number: 44,
      points: 0,
      wins: 0,
      podiums: 0
    }]
  ]),

  teams: new Map<string, Team>([
    ['redbull', {
      id: 'redbull',
      name: 'Red Bull Racing',
      base: 'Milton Keynes, UK',
      teamPrincipal: 'Christian Horner',
      championships: 6,
      points: 0
    }],
    ['mercedes', {
      id: 'mercedes',
      name: 'Mercedes-AMG PETRONAS',
      base: 'Brackley, UK',
      teamPrincipal: 'Toto Wolff',
      championships: 8,
      points: 0
    }],
    ['ferrari', {
      id: 'ferrari',
      name: 'Scuderia Ferrari',
      base: 'Maranello, Italy',
      teamPrincipal: 'Frederic Vasseur',
      championships: 16,
      points: 0
    }]
  ]),

  races: new Map<string, Race>()
};

// Helpers
export const generateId = (prefix: string) => 
  `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;

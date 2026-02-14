// Dados iniciais da Champions League 2024/25

export const db = {
  teams: new Map([
    ['real-madrid', {
      id: 'real-madrid',
      name: 'Real Madrid',
      country: 'Spain',
      group: 'A',
      stadium: 'Santiago Bernabéu',
      founded: 1902,
      titles: 15
    }],
    ['bayern', {
      id: 'bayern',
      name: 'Bayern Munich',
      country: 'Germany',
      group: 'A',
      stadium: 'Allianz Arena',
      founded: 1900,
      titles: 6
    }],
    ['man-city', {
      id: 'man-city',
      name: 'Manchester City',
      country: 'England',
      group: 'B',
      stadium: 'Etihad Stadium',
      founded: 1880,
      titles: 1
    }],
    ['inter', {
      id: 'inter',
      name: 'Inter Milan',
      country: 'Italy',
      group: 'B',
      stadium: 'San Siro',
      founded: 1908,
      titles: 3
    }],
    ['psg', {
      id: 'psg',
      name: 'Paris Saint-Germain',
      country: 'France',
      group: 'C',
      stadium: 'Parc des Princes',
      founded: 1970,
      titles: 0
    }],
    ['dortmund', {
      id: 'dortmund',
      name: 'Borussia Dortmund',
      country: 'Germany',
      group: 'C',
      stadium: 'Signal Iduna Park',
      founded: 1909,
      titles: 1
    }]
  ]),

  players: new Map([
    ['player-1', {
      id: 'player-1',
      name: 'Vinícius Júnior',
      nationality: 'Brazil',
      position: 'Forward',
      age: 24,
      teamId: 'real-madrid',
      goals: 0,
      assists: 0
    }],
    ['player-2', {
      id: 'player-2',
      name: 'Jude Bellingham',
      nationality: 'England',
      position: 'Midfielder',
      age: 21,
      teamId: 'real-madrid',
      goals: 0,
      assists: 0
    }],
    ['player-3', {
      id: 'player-3',
      name: 'Harry Kane',
      nationality: 'England',
      position: 'Forward',
      age: 31,
      teamId: 'bayern',
      goals: 0,
      assists: 0
    }],
    ['player-4', {
      id: 'player-4',
      name: 'Erling Haaland',
      nationality: 'Norway',
      position: 'Forward',
      age: 24,
      teamId: 'man-city',
      goals: 0,
      assists: 0
    }]
  ]),

  matches: new Map()
};

// Helpers
export const generateId = () => 
  `${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;

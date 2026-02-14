# Champions League API - Documentação

## Modelos

### Team
```json
{
  "id": "real-madrid",
  "name": "Real Madrid",
  "country": "Spain",
  "group": "A",
  "stadium": "Santiago Bernabéu",
  "founded": 1902,
  "titles": 15
}
```

### Player
```json
{
  "id": "player-1",
  "name": "Vinícius Júnior",
  "nationality": "Brazil",
  "position": "Forward",
  "age": 24,
  "teamId": "real-madrid",
  "goals": 5,
  "assists": 3
}
```

### Match
```json
{
  "id": "match-xxx",
  "homeTeamId": "real-madrid",
  "awayTeamId": "bayern",
  "homeTeam": "Real Madrid",
  "awayTeam": "Bayern Munich",
  "matchday": 1,
  "group": "A",
  "date": "2024-09-17",
  "homeScore": 2,
  "awayScore": 1,
  "played": true,
  "scorers": [
    {"playerId": "player-1", "goals": 2}
  ]
}
```

## Standing Entry
```json
{
  "position": 1,
  "team": { "id": "...", "name": "...", "country": "..." },
  "played": 6,
  "won": 4,
  "drawn": 1,
  "lost": 1,
  "goalsFor": 15,
  "goalsAgainst": 6,
  "goalDifference": 9,
  "points": 13
}
```

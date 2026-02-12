# F1 API Documentation

## Drivers

### GET /drivers
Query params: `team`, `nationality`

### POST /drivers
```json
{
  "name": "Charles Leclerc",
  "nationality": "Monegasque",
  "teamId": "ferrari",
  "number": 16
}
```

## Races

### POST /races/:id/results
```json
{
  "results": [
    {
      "position": 1,
      "driverId": "verstappen",
      "teamId": "redbull",
      "points": 25,
      "fastestLap": true
    }
  ]
}
```

## Standings

### GET /standings/drivers
Retorna classificação dos pilotos com posição, pontos e vitórias.

### GET /standings/teams
Retorna classificação das equipes com pontos acumulados.

import { FastifyInstance } from 'fastify';
import { getDriverStandings, getTeamStandings } from '../controllers/standings.controller.js';

export async function standingsRoutes(app: FastifyInstance) {
  app.get('/drivers', getDriverStandings);
  app.get('/teams', getTeamStandings);
}

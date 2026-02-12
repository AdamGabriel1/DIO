import { FastifyInstance } from 'fastify';
import { 
  getAllTeams, 
  getTeamById, 
  createTeam, 
  updateTeam, 
  deleteTeam 
} from '../controllers/teams.controller.js';

export async function teamsRoutes(app: FastifyInstance) {
  app.get('/', getAllTeams);
  app.get('/:id', getTeamById);
  app.post('/', createTeam);
  app.put('/:id', updateTeam);
  app.delete('/:id', deleteTeam);
}

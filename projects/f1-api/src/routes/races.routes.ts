import { FastifyInstance } from 'fastify';
import { 
  getAllRaces, 
  getRaceById, 
  createRace, 
  addRaceResult 
} from '../controllers/races.controller.js';

export async function racesRoutes(app: FastifyInstance) {
  app.get('/', getAllRaces);
  app.get('/:id', getRaceById);
  app.post('/', createRace);
  app.post('/:id/results', addRaceResult);
}

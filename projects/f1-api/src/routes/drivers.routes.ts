import { FastifyInstance } from 'fastify';
import { 
  getAllDrivers, 
  getDriverById, 
  createDriver, 
  updateDriver, 
  deleteDriver 
} from '../controllers/drivers.controller.js';

export async function driversRoutes(app: FastifyInstance) {
  app.get('/', getAllDrivers);
  app.get('/:id', getDriverById);
  app.post('/', createDriver);
  app.put('/:id', updateDriver);
  app.delete('/:id', deleteDriver);
}

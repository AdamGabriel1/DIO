import { Router } from 'express';
import {
  getAllPlayers,
  getPlayerById,
  getTopScorers,
  createPlayer,
  updatePlayer,
  deletePlayer
} from '../controllers/players.controller.js';

const router = Router();

router.get('/', getAllPlayers);
router.get('/topscorers', getTopScorers);
router.get('/:id', getPlayerById);
router.post('/', createPlayer);
router.put('/:id', updatePlayer);
router.delete('/:id', deletePlayer);

export default router;

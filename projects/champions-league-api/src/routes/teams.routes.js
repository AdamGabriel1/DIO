import { Router } from 'express';
import {
  getAllTeams,
  getTeamById,
  getTeamPlayers,
  createTeam,
  updateTeam,
  deleteTeam
} from '../controllers/teams.controller.js';

const router = Router();

router.get('/', getAllTeams);
router.get('/:id', getTeamById);
router.get('/:id/players', getTeamPlayers);
router.post('/', createTeam);
router.put('/:id', updateTeam);
router.delete('/:id', deleteTeam);

export default router;

import { playersService } from '../services/players.service.js';
import { successResponse, errorResponse } from '../utils/response.js';

export const getAllPlayers = (req, res, next) => {
  try {
    const { team, position } = req.query;
    const players = playersService.findAll({ team, position });
    res.json(successResponse(players));
  } catch (error) {
    next(error);
  }
};

export const getPlayerById = (req, res, next) => {
  try {
    const player = playersService.findById(req.params.id);
    if (!player) {
      return res.status(404).json(errorResponse('Player not found', 404));
    }
    res.json(successResponse(player));
  } catch (error) {
    next(error);
  }
};

export const getTopScorers = (req, res, next) => {
  try {
    const limit = parseInt(req.query.limit) || 10;
    const scorers = playersService.getTopScorers(limit);
    res.json(successResponse(scorers));
  } catch (error) {
    next(error);
  }
};

export const createPlayer = (req, res, next) => {
  try {
    const player = playersService.create(req.body);
    res.status(201).json(successResponse(player, 'Player created successfully'));
  } catch (error) {
    next(error);
  }
};

export const updatePlayer = (req, res, next) => {
  try {
    const player = playersService.update(req.params.id, req.body);
    if (!player) {
      return res.status(404).json(errorResponse('Player not found', 404));
    }
    res.json(successResponse(player, 'Player updated successfully'));
  } catch (error) {
    next(error);
  }
};

export const deletePlayer = (req, res, next) => {
  try {
    const deleted = playersService.delete(req.params.id);
    if (!deleted) {
      return res.status(404).json(errorResponse('Player not found', 404));
    }
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};

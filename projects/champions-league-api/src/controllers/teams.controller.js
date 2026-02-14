import { teamsService } from '../services/teams.service.js';
import { successResponse, errorResponse } from '../utils/response.js';

export const getAllTeams = (req, res, next) => {
  try {
    const { group, country } = req.query;
    const teams = teamsService.findAll({ group, country });
    res.json(successResponse(teams));
  } catch (error) {
    next(error);
  }
};

export const getTeamById = (req, res, next) => {
  try {
    const team = teamsService.findById(req.params.id);
    if (!team) {
      return res.status(404).json(errorResponse('Team not found', 404));
    }
    res.json(successResponse(team));
  } catch (error) {
    next(error);
  }
};

export const getTeamPlayers = (req, res, next) => {
  try {
    const players = teamsService.getPlayers(req.params.id);
    res.json(successResponse(players));
  } catch (error) {
    next(error);
  }
};

export const createTeam = (req, res, next) => {
  try {
    const team = teamsService.create(req.body);
    res.status(201).json(successResponse(team, 'Team created successfully'));
  } catch (error) {
    next(error);
  }
};

export const updateTeam = (req, res, next) => {
  try {
    const team = teamsService.update(req.params.id, req.body);
    if (!team) {
      return res.status(404).json(errorResponse('Team not found', 404));
    }
    res.json(successResponse(team, 'Team updated successfully'));
  } catch (error) {
    next(error);
  }
};

export const deleteTeam = (req, res, next) => {
  try {
    const deleted = teamsService.delete(req.params.id);
    if (!deleted) {
      return res.status(404).json(errorResponse('Team not found', 404));
    }
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};

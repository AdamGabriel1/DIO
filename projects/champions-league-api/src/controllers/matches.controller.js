import { matchesService } from '../services/matches.service.js';
import { successResponse, errorResponse } from '../utils/response.js';

export const getAllMatches = (req, res, next) => {
  try {
    const { group, matchday, team } = req.query;
    const matches = matchesService.findAll({ group, matchday, team });
    res.json(successResponse(matches));
  } catch (error) {
    next(error);
  }
};

export const getMatchById = (req, res, next) => {
  try {
    const match = matchesService.findById(req.params.id);
    if (!match) {
      return res.status(404).json(errorResponse('Match not found', 404));
    }
    res.json(successResponse(match));
  } catch (error) {
    next(error);
  }
};

export const createMatch = (req, res, next) => {
  try {
    const match = matchesService.create(req.body);
    res.status(201).json(successResponse(match, 'Match created successfully'));
  } catch (error) {
    next(error);
  }
};

export const updateMatch = (req, res, next) => {
  try {
    const match = matchesService.updateResult(req.params.id, req.body);
    if (!match) {
      return res.status(404).json(errorResponse('Match not found', 404));
    }
    res.json(successResponse(match, 'Match result updated'));
  } catch (error) {
    next(error);
  }
};

export const deleteMatch = (req, res, next) => {
  try {
    const deleted = matchesService.delete(req.params.id);
    if (!deleted) {
      return res.status(404).json(errorResponse('Match not found', 404));
    }
    res.status(204).send();
  } catch (error) {
    next(error);
  }
};

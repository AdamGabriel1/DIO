import { standingsService } from '../services/standings.service.js';
import { successResponse } from '../utils/response.js';

export const getStandings = (req, res, next) => {
  try {
    const { group } = req.query;
    const standings = standingsService.calculate(group);
    res.json(successResponse(standings));
  } catch (error) {
    next(error);
  }
};

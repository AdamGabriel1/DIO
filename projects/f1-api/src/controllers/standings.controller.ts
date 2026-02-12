import { FastifyRequest, FastifyReply } from 'fastify';
import { standingsService } from '../services/standings.service.js';
import { successResponse } from '../utils/response.js';

export async function getDriverStandings(request: FastifyRequest, reply: FastifyReply) {
  const standings = standingsService.getDriverStandings();
  return reply.send(successResponse(standings));
}

export async function getTeamStandings(request: FastifyRequest, reply: FastifyReply) {
  const standings = standingsService.getTeamStandings();
  return reply.send(successResponse(standings));
}

import { FastifyRequest, FastifyReply } from 'fastify';
import { teamsService } from '../services/teams.service.js';
import { successResponse, errorResponse } from '../utils/response.js';
import { CreateTeamDTO } from '../models/types.js';

export async function getAllTeams(request: FastifyRequest, reply: FastifyReply) {
  const teams = teamsService.findAll();
  return reply.send(successResponse(teams));
}

export async function getTeamById(
  request: FastifyRequest<{ Params: { id: string } }>,
  reply: FastifyReply
) {
  const team = teamsService.findById(request.params.id);
  if (!team) {
    return reply.status(404).send(errorResponse('Team not found', 404));
  }
  return reply.send(successResponse(team));
}

export async function createTeam(
  request: FastifyRequest<{ Body: CreateTeamDTO }>,
  reply: FastifyReply
) {
  try {
    const team = teamsService.create(request.body);
    return reply.status(201).send(successResponse(team, 'Team created successfully'));
  } catch (error: any) {
    return reply.status(400).send(errorResponse(error.message));
  }
}

export async function updateTeam(
  request: FastifyRequest<{ Params: { id: string }; Body: Partial<CreateTeamDTO> }>,
  reply: FastifyReply
) {
  const team = teamsService.update(request.params.id, request.body);
  if (!team) {
    return reply.status(404).send(errorResponse('Team not found', 404));
  }
  return reply.send(successResponse(team, 'Team updated successfully'));
}

export async function deleteTeam(
  request: FastifyRequest<{ Params: { id: string } }>,
  reply: FastifyReply
) {
  // Verifica se há pilotos na equipe
  const hasDrivers = teamsService.hasDrivers(request.params.id);
  if (hasDrivers) {
    return reply.status(400).send(
      errorResponse('Cannot delete team with active drivers', 400)
    );
  }
  
  const deleted = teamsService.delete(request.params.id);
  if (!deleted) {
    return reply.status(404).send(errorResponse('Team not found', 404));
  }
  return reply.status(204).send();
}

import { FastifyRequest, FastifyReply } from 'fastify';
import { racesService } from '../services/races.service.js';
import { successResponse, errorResponse } from '../utils/response.js';
import { CreateRaceDTO, RaceResult } from '../models/types.js';

export async function getAllRaces(
  request: FastifyRequest<{ Querystring: { season?: string } }>,
  reply: FastifyReply
) {
  const { season } = request.query;
  const races = racesService.findAll(season ? parseInt(season) : undefined);
  return reply.send(successResponse(races));
}

export async function getRaceById(
  request: FastifyRequest<{ Params: { id: string } }>,
  reply: FastifyReply
) {
  const race = racesService.findById(request.params.id);
  if (!race) {
    return reply.status(404).send(errorResponse('Race not found', 404));
  }
  return reply.send(successResponse(race));
}

export async function createRace(
  request: FastifyRequest<{ Body: CreateRaceDTO }>,
  reply: FastifyReply
) {
  try {
    const race = racesService.create(request.body);
    return reply.status(201).send(successResponse(race, 'Race created successfully'));
  } catch (error: any) {
    return reply.status(400).send(errorResponse(error.message));
  }
}

export async function addRaceResult(
  request: FastifyRequest<{ Params: { id: string }; Body: { results: RaceResult[] } }>,
  reply: FastifyReply
) {
  try {
    const race = racesService.addResults(request.params.id, request.body.results);
    if (!race) {
      return reply.status(404).send(errorResponse('Race not found', 404));
    }
    return reply.send(successResponse(race, 'Results added and points updated'));
  } catch (error: any) {
    return reply.status(400).send(errorResponse(error.message));
  }
}

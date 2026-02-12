import { FastifyRequest, FastifyReply } from 'fastify';
import { driversService } from '../services/drivers.service.js';
import { successResponse, errorResponse } from '../utils/response.js';
import { CreateDriverDTO, UpdateDriverDTO } from '../models/types.js';

// GET /drivers
export async function getAllDrivers(
  request: FastifyRequest<{ Querystring: { team?: string; nationality?: string } }>,
  reply: FastifyReply
) {
  const { team, nationality } = request.query;
  const drivers = driversService.findAll({ team, nationality });
  return reply.send(successResponse(drivers));
}

// GET /drivers/:id
export async function getDriverById(
  request: FastifyRequest<{ Params: { id: string } }>,
  reply: FastifyReply
) {
  const driver = driversService.findById(request.params.id);
  if (!driver) {
    return reply.status(404).send(errorResponse('Driver not found', 404));
  }
  return reply.send(successResponse(driver));
}

// POST /drivers
export async function createDriver(
  request: FastifyRequest<{ Body: CreateDriverDTO }>,
  reply: FastifyReply
) {
  try {
    const driver = driversService.create(request.body);
    return reply.status(201).send(successResponse(driver, 'Driver created successfully'));
  } catch (error: any) {
    return reply.status(400).send(errorResponse(error.message));
  }
}

// PUT /drivers/:id
export async function updateDriver(
  request: FastifyRequest<{ Params: { id: string }; Body: UpdateDriverDTO }>,
  reply: FastifyReply
) {
  try {
    const driver = driversService.update(request.params.id, request.body);
    if (!driver) {
      return reply.status(404).send(errorResponse('Driver not found', 404));
    }
    return reply.send(successResponse(driver, 'Driver updated successfully'));
  } catch (error: any) {
    return reply.status(400).send(errorResponse(error.message));
  }
}

// DELETE /drivers/:id
export async function deleteDriver(
  request: FastifyRequest<{ Params: { id: string } }>,
  reply: FastifyReply
) {
  const deleted = driversService.delete(request.params.id);
  if (!deleted) {
    return reply.status(404).send(errorResponse('Driver not found', 404));
  }
  return reply.status(204).send();
}

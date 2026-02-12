/**
 * Controllers para endpoints de Podcasts
 */

import http from 'http';
import { podcastService } from '../services/podcastService.js';
import { getRequestBody, sendResponse } from '../utils/httpHelpers.js';

export async function getAllPodcasts(req: http.IncomingMessage, res: http.ServerResponse): Promise<void> {
  const podcasts = await podcastService.getAllPodcasts();
  sendResponse(res, 200, podcasts);
}

export async function createPodcast(req: http.IncomingMessage, res: http.ServerResponse): Promise<void> {
  try {
    const body = await getRequestBody(req);
    const result = await podcastService.createPodcast(body);
    
    if (!result.success) {
      sendResponse(res, 400, { error: result.error });
      return;
    }
    
    sendResponse(res, 201, result.data);
  } catch (error) {
    sendResponse(res, 400, { error: 'Dados inválidos' });
  }
}

export async function updatePodcast(
  req: http.IncomingMessage, 
  res: http.ServerResponse,
  id: string
): Promise<void> {
  try {
    const body = await getRequestBody(req);
    const result = await podcastService.updatePodcast(id, body);
    
    if (!result.success) {
      sendResponse(res, 404, { error: result.error });
      return;
    }
    
    sendResponse(res, 200, result.data);
  } catch (error) {
    sendResponse(res, 400, { error: 'Dados inválidos' });
  }
}

export async function deletePodcast(
  req: http.IncomingMessage, 
  res: http.ServerResponse,
  id: string
): Promise<void> {
  const result = await podcastService.deletePodcast(id);
  
  if (!result.success) {
    sendResponse(res, 404, { error: result.error });
    return;
  }
  
  sendResponse(res, 204, null);
}

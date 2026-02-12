/**
 * Controller para endpoints de Episódios
 */

import http from 'http';
import { podcastService } from '../services/podcastService.js';
import { sendResponse } from '../utils/httpHelpers.js';

export async function getEpisodes(
  req: http.IncomingMessage,
  res: http.ServerResponse,
  query: Record<string, string>
): Promise<void> {
  const category = query.category;
  
  const result = await podcastService.getEpisodesByCategory(category);
  
  sendResponse(res, 200, {
    episodes: result.episodes,
    meta: result.meta
  });
}

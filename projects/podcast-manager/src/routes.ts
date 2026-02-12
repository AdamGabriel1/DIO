/**
 * Roteador de requisições HTTP
 * Direciona para os controllers apropriados
 */

import http from 'http';
import { 
  getAllPodcasts, 
  createPodcast, 
  updatePodcast, 
  deletePodcast 
} from './controllers/podcastController.js';
import { getEpisodes } from './controllers/episodeController.js';

export async function router(req: http.IncomingMessage, res: http.ServerResponse): Promise<void> {
  const { method, url } = req;
  
  // Parse da URL e query params
  const [path, queryString] = (url || '').split('?');
  const query = queryString ? parseQuery(queryString) : {};

  // Log da requisição
  console.log(`${method} ${url}`);

  // Roteamento
  try {
    // GET /api/podcasts - Listar todos
    if (method === 'GET' && path === '/api/podcasts') {
      await getAllPodcasts(req, res);
      return;
    }

    // GET /api/episodes - Listar episódios (com filtro opcional)
    if (method === 'GET' && path === '/api/episodes') {
      await getEpisodes(req, res, query);
      return;
    }

    // POST /api/podcasts - Criar podcast
    if (method === 'POST' && path === '/api/podcasts') {
      await createPodcast(req, res);
      return;
    }

    // PUT /api/podcasts/:id - Atualizar
    if (method === 'PUT' && path?.startsWith('/api/podcasts/')) {
      const id = path.split('/')[3];
      await updatePodcast(req, res, id);
      return;
    }

    // DELETE /api/podcasts/:id - Deletar
    if (method === 'DELETE' && path?.startsWith('/api/podcasts/')) {
      const id = path.split('/')[3];
      await deletePodcast(req, res, id);
      return;
    }

    // Rota não encontrada
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      statusCode: 404,
      body: { error: 'Route not found' }
    }));

  } catch (error) {
    throw error;
  }
}

function parseQuery(queryString: string): Record<string, string> {
  const params = new URLSearchParams(queryString);
  const result: Record<string, string> = {};
  params.forEach((value, key) => {
    result[key] = value;
  });
  return result;
}

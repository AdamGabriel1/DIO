/**
 * Servidor HTTP nativo Node.js
 * Entry point da aplicação
 */

import http from 'http';
import { router } from './routes.js';

const PORT = process.env.PORT || 3333;

const server = http.createServer(async (req, res) => {
  // CORS headers básicos
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  try {
    await router(req, res);
  } catch (error) {
    console.error('Erro no servidor:', error);
    res.writeHead(500, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      statusCode: 500,
      body: { error: 'Internal Server Error' }
    }));
  }
});

server.listen(PORT, () => {
  console.log(`🎙️  Podcast Manager API rodando em http://localhost:${PORT}`);
  console.log(`📚 Documentação: http://localhost:${PORT}/api/podcasts`);
});

export { server };

import Fastify from 'fastify';
import { driversRoutes } from './routes/drivers.routes.js';
import { teamsRoutes } from './routes/teams.routes.js';
import { racesRoutes } from './routes/races.routes.js';
import { standingsRoutes } from './routes/standings.routes.js';

const app = Fastify({
  logger: true
});

const PORT = process.env.PORT ? parseInt(process.env.PORT) : 3000;

// Registra rotas
app.register(driversRoutes, { prefix: '/drivers' });
app.register(teamsRoutes, { prefix: '/teams' });
app.register(racesRoutes, { prefix: '/races' });
app.register(standingsRoutes, { prefix: '/standings' });

// Health check
app.get('/health', async () => {
  return { status: 'ok', timestamp: new Date().toISOString() };
});

// Error handler global
app.setErrorHandler((error, request, reply) => {
  app.log.error(error);
  reply.status(500).send({
    success: false,
    error: 'Internal Server Error',
    message: error.message
  });
});

// Start server
const start = async () => {
  try {
    await app.listen({ port: PORT, host: '0.0.0.0' });
    console.log(`🏎️  F1 API running on http://localhost:${PORT}`);
  } catch (err) {
    app.log.error(err);
    process.exit(1);
  }
};

start();

import express from 'express';
import teamsRoutes from './routes/teams.routes.js';
import playersRoutes from './routes/players.routes.js';
import matchesRoutes from './routes/matches.routes.js';
import standingsRoutes from './routes/standings.routes.js';
import { errorHandler } from './middleware/errorHandler.js';
import { requestLogger } from './middleware/logger.js';

const app = express();

// Middlewares
app.use(express.json());
app.use(requestLogger);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'Champions League API', version: '1.0.0' });
});

// Routes
app.use('/teams', teamsRoutes);
app.use('/players', playersRoutes);
app.use('/matches', matchesRoutes);
app.use('/standings', standingsRoutes);

// 404 handler
app.use((req, res) => {
  res.status(404).json({ success: false, error: 'Route not found' });
});

// Error handler
app.use(errorHandler);

export default app;

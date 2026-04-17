import { FastifyInstance } from 'fastify';
import userRoutes from './auth.route.js';
import dashBoardRoutes from './dashboard.route.js';
import reportRoute from './report.route.js';

export default async function routes(app: FastifyInstance) {
  app.register(userRoutes, { prefix: '/api/v1/auth' });
  app.register(dashBoardRoutes, { prefix: '/api/v1/dashboard' });
  app.register(reportRoute, { prefix: '/api/v1/report' });
}
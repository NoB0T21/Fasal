import { FastifyInstance } from 'fastify';
import userRoutes from './auth.route.js';
import dashBoardRoutes from './dashboard.route.js';

export default async function routes(app: FastifyInstance) {
  app.register(userRoutes, { prefix: '/api/v1/auth' });
  app.register(dashBoardRoutes, { prefix: '/api/v1/dashboard' });
}
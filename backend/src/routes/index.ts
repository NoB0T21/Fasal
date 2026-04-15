import { FastifyInstance } from 'fastify';
import userRoutes from './auth.route.js';

export default async function routes(app: FastifyInstance) {
  app.register(userRoutes, { prefix: '/api/v1/auth' });
}
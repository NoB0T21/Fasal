import { FastifyInstance } from 'fastify';
import { validate } from '../middleware/validator.js';
import { MetaData } from '../utils/validator.schema.js';
import { getDashobardData } from '../controller/dashboard.controller.js';
import { dashBoardCache } from '../middleware/dashboard.cache.js';

export default async function dashBoardRoutes(app: FastifyInstance) {
  app.post('/get-data', {
    config: {
      rateLimit: {
        max: 50,
        timeWindow: '1 minutes'
      }
    },
    preHandler: [
        validate(MetaData),
        dashBoardCache()
    ]
  }, getDashobardData);
//   app.get('/logout', logoutUser);
}
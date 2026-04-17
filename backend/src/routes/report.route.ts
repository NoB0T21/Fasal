import { FastifyInstance } from 'fastify';
import { getReportData } from '../controller/dashboard.controller.js';
import { dashBoardCache } from '../middleware/dashboard.cache.js';

export default async function reportRoute(app: FastifyInstance) {
  app.post('/get-data', {
    config: {
      rateLimit: {
        max: 50,
        timeWindow: '1 minutes'
      }
    },
    preHandler: [
        dashBoardCache('report:')
    ]
  }, getReportData);
//   app.get('/logout', logoutUser);
}
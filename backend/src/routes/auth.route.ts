import { FastifyInstance } from 'fastify';
// import { verifyJWT } from '../middleware/auth.middleware';
import { validate } from '../middleware/validator.js';
import { sendOTP, verifyOTP } from '../utils/validator.schema.js';
import { generateSendOTP, verifyStoredOTP } from '../controller/auth.controller.js';

export default async function authRoutes(app: FastifyInstance) {

  app.post('/get-OTP', {
    config: {
      rateLimit: {
        max: 1,
        timeWindow: '2 minutes'
      }
    },
    preHandler: [validate(sendOTP)]
  }, generateSendOTP);

  app.post('/verify-OTP', {
    config: {
      rateLimit: {
        max: 5,
        timeWindow: '2 minutes'
      }
    },
    preHandler: [validate(verifyOTP)]
  }, verifyStoredOTP);

//   app.get('/profile', {
//     preHandler: [verifyJWT]
//   }, async (request) => {

//     return {
//       message: 'Protected route',
//       user: request.user
//     };
//   });
}
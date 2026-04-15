import fp from 'fastify-plugin';
import cors from '@fastify/cors';
import helmet from '@fastify/helmet';
import rateLimit from '@fastify/rate-limit';

export default fp(async (fastify) => {
  await fastify.register(cors, {
    origin: (origin, cb) => {
      if (!origin) {
        cb(null, true);
        return;
      }

      const allowedOrigins = [
        'http://localhost:5000',
      ];

      if (allowedOrigins.includes(origin)) {
        cb(null, true);
        return;
      }

      cb(new Error("Not allowed by CORS"), false);
    }
  });

  await fastify.register(helmet);

  await fastify.register(rateLimit, {
    max: 100,
    timeWindow: '1 minute',
  });
});
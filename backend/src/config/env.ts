import fp from 'fastify-plugin';
import dotenv from 'dotenv';

dotenv.config();

export default fp(async (fastify) => {
  fastify.decorate('config', {
    PORT: process.env.PORT || 5000,
    JWT_SECRET: process.env.JWT_SECRET as string,
  });
});
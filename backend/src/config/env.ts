import fp from 'fastify-plugin';
import dotenv from 'dotenv';

dotenv.config();

export default fp(async (fastify) => {
  fastify.decorate('config', {
    PORT: process.env.PORT || 5000,
    JWT_SECRET: process.env.JWT_SECRET as string,
    REDIS_URL: process.env.REDIS_URL  as string,
    DEVICE_ID: process.env.DEVICE_ID as string,
    TEXTBEE_API_KEY: process.env.TEXTBEE_API_KEY as string,
    SESSION_SECRET: process.env.SESSION_SECRET as string
  });
});
import fastifyCookie from '@fastify/cookie';
import fp from 'fastify-plugin';
import fastifySession from '@fastify/session';
import { RedisStore } from 'connect-redis';
import redis from '../DB/redis.js'; // Your existing ioredis instance

export default fp(async function (fastify: any) {
  // 1. Register Cookies first (required for sessions)
  fastify.register(fastifyCookie);

  // 2. Setup Redis Store
  const redisStore = new RedisStore({
    client: redis,
    prefix: "sess:", // Sessions will show up in Redis as sess:ID
  });

  // 3. Register Sessions
  fastify.register(fastifySession, {
    store: redisStore,
    secret: process.env.SESSION_SECRET as string || 'a-secret-with-at-least-32-chars-long',
    cookieName: 'fasal_session',
    cookie: {
      secure: process.env.NODE_ENV === 'production', // Use true for HTTPS
      httpOnly: true, // Prevents JS from reading the cookie (XSS protection)
      maxAge: 86400000, // 1 day in milliseconds
      sameSite: 'none'
    }
  });
})
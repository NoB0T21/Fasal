import fastifyCookie from '@fastify/cookie';
import fp from 'fastify-plugin';
import fastifySession from '@fastify/session';
import { RedisStore } from 'connect-redis';
import redis from '../DB/redis.js'; // Your existing ioredis instance

export default fp(async function (fastify: any) {
  fastify.register(fastifyCookie);

  const redisStore = new RedisStore({
    client: redis,
    prefix: "sess:", 
    disableTouch: true,
    ttl: 86400
  });

  fastify.register(fastifySession, {
    store: redisStore,
    secret: process.env.SESSION_SECRET as string || 'a-secret-with-at-least-32-chars-long',
    cookieName: 'fasal_session',
    saveUninitialized: false,
    rolling: false,
    cookie: {
      secure: process.env.NODE_ENV === 'production',
      httpOnly: true,
      maxAge: 86400000, // 1 day in milliseconds
      sameSite: 'lax'
    }
  });
})
import fastifyCookie from '@fastify/cookie';
import fp from 'fastify-plugin';
import fastifySession from '@fastify/session';
import { RedisStore } from 'connect-redis';
import redis from '../DB/redis.js'; // Your existing ioredis instance

// ... imports

export default fp(async function (fastify: any) {
  fastify.register(fastifyCookie);

  // 1. Create a wrapper to prevent the [object Object] syntax error
  const storeClient = {
    get: (key: string) => redis.get(key),
    set: (key: string, val: string, options?: any) => {
      // Connect-redis v9 passes an options object. 
      // We manually extract the TTL to ensure Redis gets the correct syntax.
      if (options && options.ttl) {
        return redis.set(key, val, "EX", options.ttl);
      }
      return redis.set(key, val);
    },
    del: (key: string) => redis.del(key),
  };

  const redisStore = new RedisStore({
    client: storeClient as any, // Use our wrapper instead of the raw redis instance
    prefix: "sess:",
  });

  fastify.register(fastifySession, {
    store: redisStore,
    secret: process.env.SESSION_SECRET || 'a-secret-at-least-32-characters-long-fasal',
    saveUninitialized: false,
    cookieName: 'fasal_session',
    cookie: {
      secure: process.env.NODE_ENV === 'production',
      httpOnly: true,
      maxAge: 86400000, 
      sameSite: 'lax'
    }
  });
});
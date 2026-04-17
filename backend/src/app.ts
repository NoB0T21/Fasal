import Fastify from 'fastify';
import envPlugin from './config/env.js';
import securityPlugin from './plugins/security.js';
import session from './plugins/session.js';
import routes from './routes/index.js';
import multipart from '@fastify/multipart'

export const buildApp = () => {
  const app = Fastify({
    trustProxy: true,
    logger: true,
  });

  app.register(envPlugin);
  app.register(securityPlugin);
  app.register(session);
  app.register(multipart, {
    limits: {
      fileSize: 10 * 1024 * 1024,
    }
  })
  app.register(routes);

  app.get('/', async () => {
    return { message: 'Hello, World!' };
  })
  return app;
};
import Fastify from 'fastify';
import envPlugin from './config/env.js';
import securityPlugin from './plugins/security.js';
import jwtPlugin from './plugins/jwt.js';
// import routes from './routes';

export const buildApp = () => {
  const app = Fastify({
    trustProxy: true,
    logger: true,
  });

  app.register(envPlugin);
  app.register(securityPlugin);
  app.register(jwtPlugin);
//   app.register(routes);

  app.get('/', async () => {
    return { message: 'Hello, World!' };
  })
  return app;
};
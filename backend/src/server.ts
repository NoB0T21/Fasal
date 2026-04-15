import { buildApp } from './app.js';

const start = async () => {
  const app = buildApp();

  try {
    await app.listen({ port: 5000, host: '0.0.0.0' });
    console.log('Server running');
  } catch (err) {
    app.log.error(err);
    process.exit(1);
  }
};

start();
import "@fastify/session";

declare module "fastify" {
  interface Session {
    user: {
      phone: string;
      authenticated: boolean;
    };
  }
}
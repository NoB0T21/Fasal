import { FastifyReply, FastifyRequest } from "fastify";
import { z, ZodSchema } from "zod";

export const validate =
  <T>(schema: ZodSchema<T>) =>
  async (request: FastifyRequest<{ Body: T }>, reply: FastifyReply) => {
    try {
      request.body = schema.parse(request.body);
      return
    } catch (error) {
      if (error instanceof z.ZodError) {
        console.log("Validation error:", error.message);
        reply.status(400).send({
          success: false,
          errors: error.flatten().fieldErrors,
        });
        return
      }
      reply.status(500).send({
        success: false,
        message: "Validation error",
      });
    }
  };
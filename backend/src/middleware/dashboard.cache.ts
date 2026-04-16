import { FastifyReply, FastifyRequest } from "fastify";
import { MetaDataBody } from "../utils/validator.schema.js";
import redis from "../DB/redis.js";

export const dashBoardCache = () => async (request: FastifyRequest<{Body: MetaDataBody}>, reply: FastifyReply) => {
    try {
      const user = request.session.user;
      const { location } = request.body;
      const cacheKey = `${user.phone}-${location.lat}-${location.lon}`
      const data = await redis.get(cacheKey);
      if(data) return reply.status(200).send(JSON.parse(data));
    } catch (error) {
    }
  };
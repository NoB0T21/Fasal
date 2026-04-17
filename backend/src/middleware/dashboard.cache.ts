import { FastifyReply, FastifyRequest } from "fastify";
import { MetaDataBody } from "../utils/validator.schema.js";
import redis from "../DB/redis.js";

export const dashBoardCache = (dashboard: string) => async (request: FastifyRequest<{Body: MetaDataBody}>, reply: FastifyReply) => {
    try {
      const user = request.session.user;
      const cacheKey = `${dashboard} ${user.phone}`
      const data = await redis.get(cacheKey);
      const parsh = JSON.parse(data||'');
      if(dashboard == 'result:')return reply.send({
        data: parsh
      })
      if(data && parsh) return reply.status(200).send({success: true, data: parsh});
    } catch (error) {
    }
  };
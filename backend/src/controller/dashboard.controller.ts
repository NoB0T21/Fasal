import { FastifyReply, FastifyRequest } from "fastify";
import { MetaDataBody } from "../utils/validator.schema.js";
import weatherdata from "../lib/aiModel.js";
import redis from "../DB/redis.js";

export const getDashobardData = async (req: FastifyRequest<{Body: MetaDataBody}>, res: FastifyReply) => {
  const user = req.session.user;
  if (!user) {
    return res.status(401).send({ 
      success: false, 
      message: "Unauthorized: No active session found" 
    });
  }

  const { location, soil } = req.body;
  try {
    const cacheKey = `dashboard: ${user.phone}`
    const data = await weatherdata(soil, location);
    await redis.set(cacheKey, JSON.stringify(data), "EX", 7200);
    return res.status(200).send({success: true,  data: data});
  } catch (error) {
    return res.status(500).send({ error: 'Failed to fetch dashboard data' });
  }
}
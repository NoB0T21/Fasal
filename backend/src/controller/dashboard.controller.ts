import { FastifyReply, FastifyRequest } from "fastify";
import { MetaDataBody } from "../utils/validator.schema.js";
import weatherdata from "../lib/aiModel.js";
import redis from "../DB/redis.js";

export const getDashobardData = async (req: FastifyRequest<{Body: MetaDataBody}>, res: FastifyReply) => {
  const user = req.session.user;
  if (!user) {
    res.status(401).send({ 
      success: false, 
      message: "Unauthorized: No active session found" 
    });
  }

  const { location, soil } = req.body;
  try {
    const cacheKey = `${user.phone}-${location.lat}-${location.lon}`
    const data = await weatherdata(soil, location);
    await redis.set(cacheKey, JSON.stringify(data), "EX", 300);
    res.status(200).send(data);
  } catch (error) {
    res.status(500).send({ error: 'Failed to fetch dashboard data' });
  }
}
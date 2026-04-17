import { FastifyReply, FastifyRequest } from "fastify";
import { MetaDataBody } from "../utils/validator.schema.js";
import weatherdata from "../lib/aiModel.js";
import redis from "../DB/redis.js";
import { pipeline } from 'node:stream/promises'
import fs from 'node:fs'
import path from 'node:path'
import processReport from "../lib/processReport.js";

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

export const getReportData = async (req: FastifyRequest, res: FastifyReply) => {
  const parts = req.parts()
    let soilType = null
    let imagePath = null
    let imageBase64 = null
    let name = null

    const user = req.session.user;
    const cacheKey = `report: ${user.phone}`
    console.log('✅ ','soilType, mediaType')
    for await (const part of parts) {
      if (part.type === 'field' && part.fieldname === 'soil') {
        soilType = part.value
      } else if (part.type === 'file' && part.fieldname === 'image') {
        name = `${Date.now()}_${part.filename}`
        imagePath = path.join('./uploads', name)
        fs.mkdirSync('./uploads', { recursive: true })
        await pipeline(part.file, fs.createWriteStream(imagePath))
      }
    }

    if (!soilType || !imagePath) {
      return res.status(400).send({ error: 'Missing soil or image' })
    }

    imageBase64 = fs.readFileSync(imagePath).toString('base64')
    const ext = path.extname(imagePath).replace('.', '')
    const mediaType = ext === 'jpg' ? 'image/jpeg' : `image/${ext}`
    console.log('✅ ',soilType, mediaType)
    const result = await processReport(soilType.toString(), imageBase64, mediaType)
    fs.unlinkSync(imagePath)
    await redis.set(cacheKey, JSON.stringify(result), "EX", 7200);
    return res.send({
      data: result
    })
}
import { Redis } from 'ioredis';
import dotenv from 'dotenv'
dotenv.config()

const redis = new Redis(process.env.REDIS_URL || 'redis://127.0.0.1:6379');

redis.on("connect", () => console.log("✅ Redis connected"));
redis.on("error", (err: Error) => {
  console.error("❌ Redis error:", err.message);
});

export default redis;
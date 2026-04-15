import { FastifyReply, FastifyRequest } from "fastify";
import { SendOTPBody, VerifyOTPBody } from "../utils/validator.schema.js";
import redis from "../DB/redis.js";
import { sendSIM_SMS } from "../lib/sendSMS.js";

export const generateSendOTP = async (req: FastifyRequest<{Body: SendOTPBody}>, res: FastifyReply) => {
  const { phone } = req.body;
  
  const otp = Math.floor(100000 + Math.random() * 900000).toString();

  const cacheKey = `phone:${phone}`
  await sendSIM_SMS(phone, `Your OTP for Fasal is: ${otp}. It is valid for 2 minutes.`);
  await redis.set(cacheKey, otp, "EX", 120); // OTP valid for 2 minutes
  res.status(200).send({ success: true, message: `OTP sent to ${phone}`, otp });
}

export const verifyStoredOTP = async (req: FastifyRequest<{Body: VerifyOTPBody}>, res: FastifyReply) => {
  const { phone, otp } = req.body;

  const cacheKey = `phone:${phone}`

  try {
    const storedotp = await redis.get(cacheKey);

    if(!storedotp) res.status(400).send({ success: false, message: 'OTP expired or not found' });
    if( storedotp !== otp) {
      res.status(400).send({ success: false, message: 'Invalid OTP' });
      return
    }
    
    redis.del(cacheKey); // Clean up OTP on error
    req.session.user = {
      phone: phone,
      authenticated: true
    };
    res.status(200).send({ success: true, message: `OTP verified for ${phone}`});
  } catch (error) {
    redis.del(cacheKey);
    res.status(500).send({ success: false, message: 'Try again after sometime' });
  }
}
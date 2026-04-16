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
  res.status(200).send({ success: true, message: `OTP sent to ${phone}` });
}

export const verifyStoredOTP = async (req: FastifyRequest<{Body: VerifyOTPBody}>, res: FastifyReply) => {
  const { phone, otp } = req.body;
  const cacheKey = `phone:${phone}`

  try {
    const storedotp = await redis.get(cacheKey);

    if(!storedotp) return res.status(400).send({ success: false, message: 'OTP expired or not found' });
    if( storedotp !== otp) return res.status(400).send({ success: false, message: 'Invalid OTP' });
    if (!req.session) {
      return res.status(500).send({ success: false, message: 'Session configuration error' });
    }
    req.session.user = {
      phone: phone,
      authenticated: true
    };
    await redis.del(cacheKey); // Clean up OTP on error
    return res.status(200).send({ success: true, message: `OTP verified for ${phone}`});
  } catch (error) {
    await redis.del(cacheKey);
    return res.status(500).send({ success: false, message: 'Try again after sometime' });
  }
}

export const verifyUser = async (req: FastifyRequest, res: FastifyReply) => {
  const user = req.session.user;

  if (!user) {
    res.status(401).send({ 
      success: false, 
      message: "Unauthorized: No active session found" 
    });
  }
  res.status(200).send({
    success: true,
    data: {
      phone: user.phone,
    }
  });
}

export const logoutUser = async (req: FastifyRequest, res: FastifyReply) => {
  if (req.session.user) {
    // This removes the data from Redis and clears the cookie
    await req.session.destroy();
    return { success: true, message: "Logged out successfully" };
  }
  
  return res.status(400).send({ message: "No active session to end" });
};
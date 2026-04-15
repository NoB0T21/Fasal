import { object, z } from "zod";

export const sendOTP = z.object({
  phone: z.string().regex(
    /^[0-9]+$/,
    "Invalid phone number format"
  ).min(10, "Invalid phone number").max(10, "Invalid phone number"),
});
export type SendOTPBody = z.infer<typeof sendOTP>;

export const verifyOTP = z.object({
  phone: z.string().regex(
    /^[0-9]+$/,
    "Invalid phone number format"
  ).min(10, "Invalid phone number").max(10, "Invalid phone number"),
  otp: z.string().regex(
    /^[0-9]+$/,
    "Invalid phone number format"
  ).min(6, "Invalid OTP number").max(6, "Invalid OTP number"),
});
export type VerifyOTPBody = z.infer<typeof verifyOTP>;
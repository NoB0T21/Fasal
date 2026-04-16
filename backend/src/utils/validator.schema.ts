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

export const MetaData = z.object({
  soil: z.string().min(6, "Invalid soil data").max(25, "Invalid soil data"),
  location: z.object({
    lat: z.coerce.number().min(-90, "Invalid latitude").max(90, "Invalid latitude"),
    lon: z.coerce.number().min(-180, "Invalid longitude").max(180, "Invalid longitude"),
  }),
});
export type MetaDataBody = z.infer<typeof MetaData>;
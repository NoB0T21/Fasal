import axios from 'axios';

export const sendSIM_SMS = async (phoneNumber: string, message: string) => {
  try {
    const response = await axios.post(
      `https://api.textbee.dev/api/v1/gateway/devices/${process.env.DEVICE_ID as string}/send-sms`,
      {
        recipients: [phoneNumber],
        message: message,
      },
      {
        headers: { 'x-api-key': process.env.TEXTBEE_API_KEY as string }
      }
    );
    console.log("✅ SMS triggered via your phone:");
  } catch (error) {
    console.error("❌ Failed to use phone gateway:", error);
  }
};
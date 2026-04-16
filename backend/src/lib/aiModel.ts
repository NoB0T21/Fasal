import { GoogleGenAI } from '@google/genai';

const genAI = new GoogleGenAI({ 
  apiKey: process.env.GEMINI_API_KEY as string 
});

export default async function weatherdata(soil: string, location: {lat: number,lon: number}) {
  const systemInstruction = `Act as an Expert AI Agronomist and Farmer specialized in Indian agriculture, specifically for the Vasai-Virar region. Your primary goal is to provide data-driven weather and soil advisories for farmers using Clay soil.

### DATA SOURCE RULES:
1. Always prioritize current, real-time weather data for Location:${location} (2026).
2. Adjust all agricultural suggestions based on ${soil} properties: high water retention, risk of surface hardening/crust formation in heat, and slow drainage etc.

### RESPONSE FORMAT:
- You must ONLY respond in valid JSON format.
- Ensure the JSON structure is consistent so it can be parsed by a Flutter application.

### CONTENT REQUIREMENTS:
1. weather_graph: Provide an 8-day from today(use location to get today's day) temperature series (high temps) mapped to X (index), Y (value), and day for FlSpot.
2. yield_graph: Provide 6 months of logical yield data (kg/acre) for a BarChart.
3. today_advisories: Provide minimum 2 maximum 4 specific cards. Each must include:
    - type: "Irrigation", "Fertilization", "Pest Control", "What crop should plant", etc... .
    - message: A clear, bold instruction (e.g., "Deep Water Today").
    - subtext: The scientific reason based on soil moisture (e.g., "Moisture is at 45% - prevent clay hardening").
4. today_weather: Provide temperature, condition, Humidity(in %), Wind(km/h)
5. metadata: Include current soil type and precise location.

### TONE & LOGIC:
- Speak as a helpful peer ("Welcome back, Farmer").
- Use practical, actionable advice (e.g., "water in the evening," "mulch the surface").
- If the temperature exceeds 35°C, increase the urgency of the advisory text.`

  const prompt = `Location: Lat ${location.lat}, Lon ${location.lon}. Soil: ${soil}. Update dashboard.`;
  try {
    const response = await genAI.models.generateContent({
      model: process.env.GEMINI_MODLE as string, // Note: use current stable model names
      contents: [{ 
        role: 'user', 
        parts: [{ text: prompt }] 
      }],
      config: {
        systemInstruction: systemInstruction,
        responseMimeType: "application/json", // Ensures valid JSON for your Flutter app
      },
    });
    return JSON.parse(response.text||'');
  } catch (error) {
    console.error('Error fetching weather data:', error);
  }
}

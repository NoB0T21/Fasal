import { GoogleGenAI } from '@google/genai';

const genAI = new GoogleGenAI({ 
  apiKey: process.env.GEMINI_API_KEY as string 
});

const schema = {
  "type": "object",
  "required": ["pest_name", "confidence", "severity", "treatments"],
  "properties": {
    "pest_name": {
      "type": "string",
      "description": "Common name and scientific name of the detected pest or disease"
    },
    "confidence": {
      "type": "number",
      "minimum": 0,
      "maximum": 100,
      "description": "Confidence percentage of the detection"
    },
    "severity": {
      "type": "string",
      "enum": ["Low", "Moderate", "High", "Critical"],
      "description": "Severity level of the infestation"
    },
    "treatments": {
      "type": "array",
      "minItems": 3,
      "maxItems": 6,
      "items": { "type": "string" },
      "description": "Ordered list of recommended treatment steps"
    },
    "affected_area": {
      "type": "string",
      "description": "Which part of the plant is affected (leaves, roots, stem, fruit)"
    },
    "spread_risk": {
      "type": "string",
      "enum": ["Low", "Medium", "High"],
      "description": "Risk of spreading to nearby plants"
    },
    "best_treatment_time": {
      "type": "string",
      "description": "Best time of day or season to apply treatment"
    }
  }
}

export default async function processReport(soil: string, base64Image: string, mediaType: string) {
  const systemInstruction = `You are an expert agricultural AI assistant specializing in plant disease and pest detection. You analyze crop images alongside soil type data to provide accurate pest/disease diagnoses and actionable treatment recommendations.

BEHAVIOR RULES:
- Always respond ONLY with valid JSON that strictly matches the provided schema.
- Do NOT include any preamble, explanation, markdown formatting, or code fences — raw JSON only.
- Base your diagnosis primarily on visible symptoms in the image.
- Factor in soil type to assess severity and treatment suitability (e.g., sandy soils drain faster, affecting pesticide efficacy).
- If the image is unclear or shows no visible pest/disease, return confidence below 40% and set severity to "Low".
- Never hallucinate pest names. If uncertain, use the closest matching common pest/disease family.
- Treatments must be practical, ordered from immediate action to follow-up steps.
- All treatment steps must be specific and actionable — avoid vague advice like "apply pesticide".

SEVERITY GUIDELINES:
- Low: Less than 10% of visible plant area affected
- Moderate: 10–35% affected, localized
- High: 35–60% affected or rapid spread pattern visible
- Critical: Over 60% affected or signs of systemic infection`

  const prompt = `Analyze the attached crop image and the following soil data to detect any pest or disease present.

Soil Type: ${soil}

Examine the image for:
- Visible pest presence (insects, larvae, eggs)
- Leaf discoloration, spotting, or deformation
- Stem or root damage patterns
- Unusual growth patterns

Consider how the soil type affects:
- Pest likelihood (e.g., aphids thrive in nitrogen-rich soils)
- Treatment effectiveness (e.g., neem oil absorption in clay vs sandy soil)
- Spread risk to nearby plants

Respond strictly in JSON matching the schema. No extra text.`;
  try {
    const response = await genAI.models.generateContent({
      model: process.env.GEMINI_MODLE as string, // Note: use current stable model names
      contents: [
        {
          role: "user",
          parts: [
            {
              inlineData: {
                data: base64Image,
                mimeType: mediaType,
              },
            },
            {
              text: prompt,
            },
          ],
        },
      ],
      config: {
        systemInstruction: systemInstruction,
        responseMimeType: "application/json", // Ensures valid JSON for your Flutter app
        responseJsonSchema: schema
      },
    });
    return JSON.parse(response.text||'');
  } catch (error) {
    console.error('Error fetching weather data:', error);
  }
}

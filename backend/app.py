# app.py

# 1. Load environment variables FIRST
from dotenv import load_dotenv
load_dotenv()

# 2. Import all necessary libraries
from flask import Flask, request, jsonify
from flask_cors import CORS
import os

# 3. Initialize the Flask App
app = Flask(__name__)
CORS(app) # Enable Cross-Origin Resource Sharing

# 4. Import Gemini service
try:
    from services.symptom_checker_service import analyze_symptoms_with_gemini
    GEMINI_LOADED = True
except Exception as e:
    print(f"⚠️ Could not load Gemini service: {e}")
    GEMINI_LOADED = False

# 5. Define routes DIRECTLY here
@app.route('/')
def home():
    return "NirogNet Symptom Checker Backend is running!"

@app.route('/api/symptoms/analyze', methods=['POST'])
def analyze_symptoms_route():
    print("✅ --- Request received at /api/symptoms/analyze ---")
    
    if not GEMINI_LOADED:
        return jsonify({"msg": "Gemini service not available"}), 500
    
    data = request.get_json()
    symptom_text = data.get('symptoms')

    if not symptom_text:
        print("❌ ERROR: No symptom text provided.")
        return jsonify({"msg": "Symptom text is required"}), 400

    print(f"📄 Symptom received: {symptom_text}")
    
    try:
        print("🤖 --- Calling Gemini API... ---")
        ai_response = analyze_symptoms_with_gemini(symptom_text)
        print("✅ --- Gemini API call successful! ---")
        
        return jsonify({"reply": ai_response})
    except Exception as e:
        print(f"❌❌❌ An exception occurred during Gemini call: {e} ❌❌❌")
        return jsonify({"msg": "An internal error occurred while analyzing symptoms"}), 500

# 6. Main entry point to run the server
if __name__ == '__main__':
    print("🚀 Starting Flask server...")
    print(f"📍 Gemini service loaded: {GEMINI_LOADED}")
    app.run(debug=True, host='0.0.0.0', port=5000)
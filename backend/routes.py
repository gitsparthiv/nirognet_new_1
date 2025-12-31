# routes.py
from flask import request, jsonify
from app import app # Only import app
# from models import User # Commented out - no models.py yet
# from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from services.symptom_checker_service import analyze_symptoms_with_gemini

# A simple route to check if the backend is running
@app.route('/')
def home():
    return "NirogNet Symptom Checker Backend is running!"

# --- AI SYMPTOM CHECKER ROUTE ---
@app.route('/api/symptoms/analyze', methods=['POST'])
def analyze_symptoms_route():
    print("✅ --- Request received at /api/symptoms/analyze ---")
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
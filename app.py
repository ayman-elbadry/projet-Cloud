from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({
        "message": "Bienvenue sur l'API du Projet DevOps! (Version automatisée via CI/CD)",
        "status": "success",
        "version": "1.0"
    })

@app.route('/health')
def health_check():
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
# Trigger CI/CD

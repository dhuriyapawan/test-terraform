from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/message', methods=['GET'])
def message():
    return jsonify({"message": "Hello from Backend!"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

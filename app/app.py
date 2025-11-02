from flask import Flask, jsonify
import time, random
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)
REQUEST_COUNT = Counter('app_requests_total', 'Total requests', ['endpoint'])
REQUEST_LATENCY = Histogram('app_request_latency_seconds', 'Request latency', ['endpoint'])

@app.route('/')
def index():
    REQUEST_COUNT.labels('/').inc()
    with REQUEST_LATENCY.labels('/').time():
        time.sleep(random.uniform(0.05, 0.25))
    return "Hello from SRE Lab!\n"

@app.route('/health')
def health():
    return jsonify(status='ok')

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
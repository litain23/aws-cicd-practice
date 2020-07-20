import os
from subprocess import check_output as qx

from flask import Flask, request, jsonify
app = Flask(__name__)

@app.route('/deploy', methods=["POST"])
def home():
    data = request.get_json();
    if(data['id'] == os.environ.get('simple_deploy_id')):# and data['id'] == os.environ.get('deploy_pw')):
        s = qx(['./deploy.sh']);
        return s;
    return ";"

if __name__ == "__main__":
    app.run(host="127.0.0.1", port="9000")

from flask import Flask, request, jsonify

app = Flask(__name__)
missing_credentials = "Username or password is missing"


def get_credentials():
    request_data = request.get_json()
    username = request_data.get("username")
    password = request_data.get("password")
    return username, password


def authenticate(username, password):
    return username == "Hvalfangst" and password == "Plankton747"


@app.route('/login', methods=['POST'])
def login():
    username, password = get_credentials()

    if not (username and password):
        return jsonify({"error": missing_credentials})

    if authenticate(username, password):
        payload = {
            "nemeses": ["TVT", "Skadi", "Hero(in)"],
        }
        return jsonify({"payload": payload})
    else:
        return jsonify({"error": missing_credentials})


if __name__ == '__main__':
    app.run(debug=False, host="0.0.0.0", port=5000)

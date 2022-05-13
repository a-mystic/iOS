from flask import Flask, json, jsonify, request
app = Flask(__name__)
number = 100
greeting = "greet swift"

@app.route('/',methods = ['GET'])
def hello_world():
    return jsonify({'greeting':greeting,'number' : number})

if __name__ == '__main__':
    app.run(debug=True)

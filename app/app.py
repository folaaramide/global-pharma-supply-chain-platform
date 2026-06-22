from flask import Flask, jsonify, request
from flask_cors import CORS
import pymysql
import os

app = Flask(__name__)

CORS(app)

db = pymysql.connect(

    host=os.environ["DB_HOST"],

    user=os.environ["DB_USER"],

    password=os.environ["DB_PASSWORD"],

    database=os.environ["DB_NAME"]

)


@app.route("/")
def home():

    return "Global Pharma Supply Chain API Running"


@app.route("/shipments")
def shipments():

    cur = db.cursor(pymysql.cursors.DictCursor)

    cur.execute("SELECT * FROM shipments")

    data = cur.fetchall()

    return jsonify(data)


@app.route("/warehouses")
def warehouses():

    cur = db.cursor(pymysql.cursors.DictCursor)

    cur.execute("SELECT * FROM warehouses")

    data = cur.fetchall()

    return jsonify(data)


@app.route("/incidents")
def incidents():

    cur = db.cursor(pymysql.cursors.DictCursor)

    cur.execute("SELECT * FROM incidents")

    data = cur.fetchall()

    return jsonify(data)


@app.route("/report_incident", methods=["POST"])
def report_incident():

    data = request.json

    cur = db.cursor()

    cur.execute(

        """

        INSERT INTO incidents

        (

        incident_type,

        shipment_id,

        severity,

        description

        )

        VALUES

        (

        %s,

        %s,

        %s,

        %s

        )

        """,

        (

            data["incident_type"],

            data["shipment_id"],

            data["severity"],

            data["description"]

        )

    )

    db.commit()

    return jsonify(

        {

            "message": "Incident Created"

        }

    )


if __name__ == "__main__":

    app.run(

        host="0.0.0.0",

        port=5000

    )
from flask import Blueprint, jsonify
from config import connect_db

bp = Blueprint('airports', __name__, url_prefix='/api/airports')

@bp.route('', methods=['GET'])
def get_all_airports():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Airport;")
        airports = cursor.fetchall()
        return jsonify(airports)
    finally:
        cursor.close()
        db.close()

@bp.route('/<airportCode>', methods=['GET'])
def get_airport(airportCode):
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Airport WHERE airport_code = %s;", (airportCode,))
        airport = cursor.fetchone()
        return jsonify(airport) if airport else jsonify({"error": "Airport not found"}), 404
    finally:
        cursor.close()
        db.close()

from flask import Blueprint, jsonify, request
from config import connect_db

bp = Blueprint('flights', __name__, url_prefix='/api/flights')

@bp.route('', methods=['GET'])
def get_all_flights():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Flight;")
        flights = cursor.fetchall()
        return jsonify(flights)
    finally:
        cursor.close()
        db.close()

@bp.route('/<string:flightNumber>', methods=['GET'])
def get_flight(flightNumber):
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Flight WHERE flight_number = %s;", (flightNumber,))
        flight = cursor.fetchone()
        return jsonify(flight) if flight else jsonify({"error": "Flight not found"}), 404
    finally:
        cursor.close()
        db.close()

@bp.route('', methods=['POST'])
def create_flight():
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("""
            INSERT INTO Flight (flight_number, departure_time, arrival_time, origin_airport_code, 
                                destination_airport_code, airline_code, aircraft_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s);
        """, (data['flight_number'], data['departure_time'], data['arrival_time'], 
              data['origin_airport_code'], data['destination_airport_code'], 
              data['airline_code'], data['aircraft_id']))
        db.commit()
        return jsonify({"flight_number": data['flight_number']}), 201
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@bp.route('/<string:flightNumber>', methods=['PUT'])
def update_flight(flightNumber):
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("""
            UPDATE Flight 
            SET departure_time = %s, arrival_time = %s, 
                origin_airport_code = %s, destination_airport_code = %s, 
                airline_code = %s, aircraft_id = %s 
            WHERE flight_number = %s;
        """, (data['departure_time'], data['arrival_time'], 
              data['origin_airport_code'], data['destination_airport_code'], 
              data['airline_code'], data['aircraft_id'], flightNumber))
        db.commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Flight not found"}), 404
        return jsonify({"message": "Flight updated successfully"})
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()




@bp.route('/search', methods=['GET'])
def search_flights():
    origin = request.args.get('origin')
    destination = request.args.get('destination')
    
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        if origin and destination:
            # Search by both origin and destination
            query = "SELECT * FROM Flight WHERE origin_airport_code = %s AND destination_airport_code = %s"
            cursor.execute(query, (origin, destination))
        elif origin:
            # Search only by origin
            query = "SELECT * FROM Flight WHERE origin_airport_code = %s"
            cursor.execute(query, (origin,))
        elif destination:
            # Search only by destination
            query = "SELECT * FROM Flight WHERE destination_airport_code = %s"
            cursor.execute(query, (destination,))
        else:
            # No parameters provided, return all flights
            cursor.execute("SELECT * FROM Flight;")
        
        flights = cursor.fetchall()
        return jsonify(flights)
    finally:
        cursor.close()
        db.close()

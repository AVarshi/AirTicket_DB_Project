from flask import Blueprint, jsonify, request
from config import connect_db

bp = Blueprint('seats', __name__, url_prefix='/api/seats')

@bp.route('', methods=['GET'])
def get_all_seats():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Seat;")
        seats = cursor.fetchall()
        return jsonify(seats)
    finally:
        cursor.close()
        db.close()

@bp.route('/<string:flightNumber>/<string:seatNumber>', methods=['GET'])
def get_seat(flightNumber, seatNumber):
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Seat WHERE flight_number = %s AND seat_number = %s;", (flightNumber, seatNumber))
        seat = cursor.fetchone()
        return jsonify(seat) if seat else (jsonify({"error": "Seat not found"}), 404)
    finally:
        cursor.close()
        db.close()

@bp.route('', methods=['POST'])
def create_seat():
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("INSERT INTO Seat (seat_number, flight_number, class_id, is_available) VALUES (%s, %s, %s, %s);",
                       (data['seat_number'], data['flight_number'], data['class_id'], data.get('is_available', 1)))
        db.commit()
        seat_number = cursor.lastrowid
        return jsonify({"seat_number": seat_number}), 201
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@bp.route('/<string:flightNumber>/<string:seatNumber>', methods=['PUT'])
def update_seat(flightNumber, seatNumber):
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("UPDATE Seat SET class_id = %s, is_available = %s WHERE flight_number = %s AND seat_number = %s;",
                       (data['class_id'], data['is_available'], flightNumber, seatNumber))
        db.commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Seat not found"}), 404
        return jsonify({"message": "Seat updated successfully"})
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@bp.route('/<string:flightNumber>/<string:seatNumber>', methods=['DELETE'])
def delete_seat(flightNumber, seatNumber):
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("DELETE FROM Seat WHERE flight_number = %s AND seat_number = %s;", (flightNumber, seatNumber))
        db.commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Seat not found"}), 404
        return jsonify({"message": "Seat deleted successfully"})
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()
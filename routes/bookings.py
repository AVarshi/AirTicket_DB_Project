from flask import Blueprint, jsonify, request
from config import connect_db

bp = Blueprint('bookings', __name__, url_prefix='/api/bookings')

@bp.route('', methods=['GET'])
def get_all_bookings():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Booking;")
        bookings = cursor.fetchall()
        return jsonify(bookings)
    finally:
        cursor.close()
        db.close()

@bp.route('/<int:bookingId>', methods=['GET'])
def get_booking(bookingId):
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Booking WHERE booking_number = %s;", (bookingId,))
        booking = cursor.fetchone()
        return jsonify(booking) if booking else jsonify({"error": "Booking not found"}), 404
    finally:
        cursor.close()
        db.close()

@bp.route('', methods=['POST'])
def create_booking():
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("INSERT INTO Booking (booking_number, customer_id, booking_date, status) VALUES (%s, %s, %s, %s);", 
                       (data['booking_number'], data['customer_id'], data['booking_date'], data['status']))
        db.commit()
        return jsonify({"booking_number": data['booking_number']}), 201
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@bp.route('/<int:bookingId>', methods=['PUT'])
def update_booking(bookingId):
    data = request.json
    db = connect_db()
    cursor = db.cursor()

    try:
        # Check if the booking exists before attempting to update
        cursor.execute("SELECT * FROM Booking WHERE booking_number = %s;", (bookingId,))
        booking = cursor.fetchone()
        
        if booking is None:
            return jsonify({"error": "Booking not found"}), 404
        
        # Proceed with the update if the booking exists
        cursor.execute("UPDATE Booking SET customer_id = %s, booking_date = %s, status = %s WHERE booking_number = %s;", 
                       (data['customer_id'], data['booking_date'], data['status'], bookingId))
        db.commit()
        
        # Check if the update made any changes
        if cursor.rowcount == 0:
            return jsonify({"message": "No changes made to the booking"}), 200

        return jsonify({"message": "Booking updated successfully"}), 200

    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@bp.route('/search', methods=['GET'])
def search_bookings():
    status = request.args.get('status')
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        if status:
            cursor.execute("SELECT * FROM Booking WHERE status = %s;", (status,))
        else:
            cursor.execute("SELECT * FROM Booking;")
        bookings = cursor.fetchall()
        return jsonify(bookings)
    finally:
        cursor.close()
        db.close()
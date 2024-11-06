from flask import Blueprint, jsonify, request
from config import connect_db

bp = Blueprint('tickets', __name__, url_prefix='/api/tickets')

@bp.route('', methods=['GET'])
def get_all_tickets():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Ticket;")
        tickets = cursor.fetchall()
        return jsonify(tickets)
    finally:
        cursor.close()
        db.close()

@bp.route('/<int:ticketNumber>', methods=['GET'])
def get_ticket(ticketNumber):
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Ticket WHERE ticket_number = %s;", (ticketNumber,))
        ticket = cursor.fetchone()
        return jsonify(ticket) if ticket else (jsonify({"error": "Ticket not found"}), 404)
    finally:
        cursor.close()
        db.close()

@bp.route('', methods=['POST'])
def create_ticket():
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("""
            INSERT INTO Ticket (ticket_number, booking_number, passenger_id, flight_number, 
                                seat_number, class_id, trip_type_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s);
        """, (data['ticket_number'], data['booking_number'], data['passenger_id'], 
              data['flight_number'], data['seat_number'], data['class_id'], 
              data['trip_type_id']))
        db.commit()
        return jsonify({"ticket_number": data['ticket_number']}), 201
    except Exception as e:
        db.rollback()
        return (jsonify({"error": str(e)}), 500)
    finally:
        cursor.close()
        db.close()

@bp.route('/<int:ticketNumber>', methods=['PUT'])
def update_ticket(ticketNumber):
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("""
            UPDATE Ticket 
            SET booking_number = %s, passenger_id = %s, flight_number = %s, 
                seat_number = %s, class_id = %s, trip_type_id = %s 
            WHERE ticket_number = %s;
        """, (data['booking_number'], data['passenger_id'], 
              data['flight_number'], data['seat_number'], 
              data['class_id'], data['trip_type_id'], ticketNumber))
        db.commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Ticket not found"}), 404
        return jsonify({"message": "Ticket updated successfully"})
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@bp.route('/search', methods=['GET'])
def search_tickets():
    booking_number = request.args.get('bookingNumber')
    
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        if booking_number:
            # Search by booking_number
            query = "SELECT * FROM Ticket WHERE booking_number = %s"
            cursor.execute(query, (booking_number,))
        else:
            # No booking_number provided, return all tickets
            cursor.execute("SELECT * FROM Ticket;")
        
        tickets = cursor.fetchall()
        return jsonify(tickets)
    finally:
        cursor.close()
        db.close()
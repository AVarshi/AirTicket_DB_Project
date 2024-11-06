from flask import Blueprint, jsonify, request
from config import connect_db

bp = Blueprint('search', __name__, url_prefix='/api/search')

@bp.route('/bookings', methods=['GET'])
def search_bookings():
    date = request.args.get('date')
    status = request.args.get('status')
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        # Adjust query to account for optional parameters
        query = "SELECT * FROM Booking WHERE 1=1"
        params = []
        
        if date:
            query += " AND booking_date = %s"
            params.append(date)
        if status:
            query += " AND status = %s"
            params.append(status)
        
        cursor.execute(query, tuple(params))
        bookings = cursor.fetchall()
        return jsonify(bookings)
    finally:
        cursor.close()
        db.close()

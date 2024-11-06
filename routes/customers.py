from flask import Blueprint, jsonify, request
from config import connect_db

bp = Blueprint('customers', __name__, url_prefix='/api/customers')

@bp.route('', methods=['GET'])
def get_all_customers():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Customer;")
        customers = cursor.fetchall()
        return jsonify(customers)
    finally:
        cursor.close()
        db.close()

@bp.route('/<int:customerId>', methods=['GET'])
def get_customer(customerId):
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Customer WHERE customer_id = %s;", (customerId,))
        customer = cursor.fetchone()
        return jsonify(customer) if customer else jsonify({"error": "Customer not found"}), 404
    finally:
        cursor.close()
        db.close()


@bp.route('', methods=['POST'])
def create_customer():
    data = request.json
    db = connect_db()
    cursor = db.cursor()
    try:
        # Include 'customer_id' in the INSERT statement
        cursor.execute("""
            INSERT INTO Customer (customer_id, first_name, last_name, email, phone, date_of_birth)
            VALUES (%s, %s, %s, %s, %s, %s);
        """, (data['customer_id'], data['first_name'], data['last_name'], data['email'], data.get('phone'), data.get('date_of_birth')))
        db.commit()
        return jsonify({"customer_id": data['customer_id']}), 201
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()



@bp.route('/<int:customerId>', methods=['PUT'])
def update_customer(customerId):
    data = request.json
    db = connect_db()
    cursor = db.cursor()

    try:
        # Check if the customer exists before attempting to update
        cursor.execute("SELECT * FROM Customer WHERE customer_id = %s;", (customerId,))
        customer = cursor.fetchone()

        if customer is None:
            return jsonify({"error": "Customer not found"}), 404

        # Proceed with the update if the customer exists
        cursor.execute("""
            UPDATE Customer 
            SET first_name = %s, last_name = %s, email = %s, phone = %s, date_of_birth = %s 
            WHERE customer_id = %s;
        """, (data['first_name'], data['last_name'], data['email'], data.get('phone'), data.get('date_of_birth'), customerId))
        
        db.commit()

        if cursor.rowcount == 0:
            return jsonify({"message": "No changes made to the customer"}), 200

        return jsonify({"message": "Customer updated successfully"}), 200

    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)})
    finally:
        cursor.close()
        db.close()



@bp.route('/search', methods=['GET'])
def search_customers():
    name = request.args.get('name')
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    try:
        if name:
            # Use wildcard search to match partial names
            query = "SELECT * FROM Customer WHERE first_name LIKE %s OR last_name LIKE %s"
            cursor.execute(query, (f"%{name}%", f"%{name}%"))
        else:
            # If 'name' is not provided, return all customers
            cursor.execute("SELECT * FROM Customer;")
        
        customers = cursor.fetchall()
        return jsonify(customers)
    finally:
        cursor.close()
        db.close()
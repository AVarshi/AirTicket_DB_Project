from flask import Flask, jsonify, request
from config import connect_db, close_db
from routes import bookings, customers, flights, airports, tickets, seats, search

app = Flask(__name__)

# Register blueprints for modular routes
app.register_blueprint(bookings.bp)
app.register_blueprint(customers.bp)
app.register_blueprint(flights.bp)
app.register_blueprint(airports.bp)
app.register_blueprint(tickets.bp)
app.register_blueprint(seats.bp)
app.register_blueprint(search.bp)

@app.teardown_appcontext
def teardown_db(exception):
    close_db()

if __name__ == "__main__":
    app.run(debug=True)

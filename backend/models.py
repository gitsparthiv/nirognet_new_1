# models.py
from app import db # Import the 'db' object that was created in app.py

# This class will represent the 'users' table in your database.
class User(db.Model):
    __tablename__ = 'users' # The actual table name in the database

    # Define the columns of the table
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now())

    # An optional helper method to make printing user objects easier for debugging
    def __repr__(self):
        return f"<User {self.id}: {self.name}>"
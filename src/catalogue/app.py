from flask import Flask, jsonify

app = Flask(__name__)

PRODUCTS = [
    {
        "id": "home-workout-kit",
        "name": "Home Workout Starter Kit",
        "description": "Essential equipment for strength training and home workouts.",
        "price": 59.99,
        "currency": "GBP",
    },
    {
        "id": "yoga-mobility-kit",
        "name": "Yoga & Mobility Kit",
        "description": "Equipment designed to support stretching, balance and mobility exercises.",
        "price": 44.99,
        "currency": "GBP",
    },
    {
        "id": "training-recovery-bundle",
        "name": "Training & Recovery Bundle",
        "description": "Training and recovery accessories for everyday fitness routines.",
        "price": 79.99,
        "currency": "GBP",
    },
]


@app.get("/health")
def health():
    return jsonify({"status": "healthy"})


@app.get("/products")
def list_products():
    return jsonify(PRODUCTS)


@app.get("/products/<product_id>")
def get_product(product_id):
    product = next(
        (item for item in PRODUCTS if item["id"] == product_id),
        None,
    )

    if product is None:
        return jsonify({"error": "Product not found"}), 404

    return jsonify(product)

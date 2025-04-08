from pymongo import MongoClient
from time import time

client = MongoClient("mongodb://localhost:27017")

db = client["performance_test"]

collection = db["sales"]

start_time = time()

data = list(collection.find({"category": "Electronics"}))

end_time = time()

print(f"Time taken: {end_time-start_time:.4f}")


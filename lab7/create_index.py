from pymongo import MongoClient
from time import time

client = MongoClient("mongodb://localhost:27017")

db = client["performance_test"]

collection = db["sales"]

# collection.drop_index("category_1")

collection.create_index([("category", 1)])
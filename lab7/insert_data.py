from pymongo import MongoClient
import random
import datetime

client = MongoClient("mongodb://localhost:27017")

db = client["performance_test"]

collection = db["sales"]

categories = ["Electronics", "Clothing", "Books", "Home", "Sports"]

documents = [
	{
    	"customer_id": random.randint(1, 1000),  # Випадковий ідентифікатор покупця (1-1000)
    	"category": random.choice(categories),   # Випадкова категорія з `categories`
    	"amount": random.uniform(5, 500),   	# Випадкова сума покупки (від $5 до $500)
    	"timestamp": datetime.datetime(2024, random.randint(1, 12), random.randint(1, 28)) 
    	# Випадкова дата у 2024 році (будь-який місяць і день до 28)
	}
	for _ in range(100000)  # Генерація 100 000 документів
]

# collection.insert_many(documents)


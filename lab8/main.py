import redis

r = redis.Redis(host='localhost', port=6379, db=0)

r.incr("visits")
r.lpush("tasks", "new_task")

tasks = r.lrange("tasks", 0, -1)

print("Tasks:", [task.decode() for task in tasks])


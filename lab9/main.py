import redis

r = redis.Redis(host='localhost', port=6379, db=0)


while True:
    msg = input("Enter message for 'chanel' (or 'exit'): ")
    if msg.lower() == 'exit':
        break
    r.publish('chanel', msg)
-- Лабораторна робота №3
-- З дисципліни: Бази даних та інформаційні системи
-- Студента групи МІТ-31 Пугача Назара

-- 1. Вибірка всіх користувачів
SELECT * FROM users;

-- 2. Вибірка всіх житлових об'єктів певного користувача
SELECT * FROM residential_objects WHERE user_id = 1;

-- 3. Вибірка всіх користувачів, чий email містить '@example.com'
SELECT * FROM users WHERE email LIKE '%@example.com';

-- 4. Кількість житлових об'єктів у системі
SELECT COUNT(*) FROM residential_objects;

-- 5. Загальне споживання води по всіх об'єктах
SELECT SUM(water_consumption_per_month) FROM residential_objects;

-- 6. Середнє споживання електроенергії
SELECT AVG(electricity_consumption_per_month) FROM residential_objects;

-- 7. Мінімальне та максимальне споживання газу
SELECT MIN(gas_consumption_per_month), MAX(gas_consumption_per_month) FROM residential_objects;

-- 8. INNER JOIN: Список платежів з іменами користувачів
SELECT p.id, u.name, p.amount FROM payments p
INNER JOIN users u ON p.user_id = u.id;

-- 9. LEFT JOIN: Всі користувачі та їхні платежі
SELECT u.name, p.amount FROM users u
LEFT JOIN payments p ON u.id = p.user_id;

-- 10. RIGHT JOIN: Всі платежі та користувачі (якщо є)
SELECT u.name, p.amount FROM users u
RIGHT JOIN payments p ON u.id = p.user_id;

-- 11. FULL JOIN: Всі користувачі та всі платежі
SELECT u.name, p.amount FROM users u
FULL JOIN payments p ON u.id = p.user_id;

-- 12. CROSS JOIN: Усі можливі комбінації користувачів і послуг
SELECT u.name, s.name FROM users u
CROSS JOIN services s;

-- 13. SELF JOIN: Користувачі з однаковими іменами
SELECT u1.name, u2.email FROM users u1
JOIN users u2 ON u1.name = u2.name AND u1.id <> u2.id;

-- 14. Підзапит у WHERE: Користувачі з платежами понад 100
SELECT * FROM users WHERE id IN (SELECT user_id FROM payments WHERE amount > 100);

-- 15. Підзапит у SELECT: Середня сума платежів
SELECT id, (SELECT AVG(amount) FROM payments) AS avg_payment FROM users;

-- 16. EXISTS: Користувачі, які мають платежі
SELECT * FROM users WHERE EXISTS (SELECT 1 FROM payments WHERE users.id = payments.user_id);

-- 17. NOT EXISTS: Користувачі без платежів
SELECT * FROM users WHERE NOT EXISTS (SELECT 1 FROM payments WHERE users.id = payments.user_id);

-- 18. UNION: Унікальні імена користувачів та постачальників
SELECT name FROM users UNION SELECT name FROM suppliers;

-- 19. INTERSECT: Спільні імена користувачів і постачальників
SELECT name FROM users INTERSECT SELECT name FROM suppliers;

-- 20. EXCEPT: Імена користувачів, яких немає серед постачальників
SELECT name FROM users EXCEPT SELECT name FROM suppliers;

-- 21. CTE: Платежі понад 50
WITH high_payments AS (
    SELECT * FROM payments WHERE amount > 50
)
SELECT * FROM high_payments;

-- 22. Віконна функція: Сума платежів кожного користувача
SELECT user_id, amount, SUM(amount) OVER (PARTITION BY user_id) AS total_per_user
FROM payments;

-- 23. Віконна функція: Номер платежу кожного користувача
SELECT id, user_id, amount, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY payment_date) AS payment_num
FROM payments;

-- 24. Вибірка платежів з обмеженням до 5 записів
SELECT * FROM payments LIMIT 5;

-- 25. Вибірка платежів, відсортованих за датою
SELECT * FROM payments ORDER BY payment_date DESC;

-- 26. Групування платежів за статусом
SELECT status, COUNT(*) FROM payments GROUP BY status;

-- 27. Вибірка постачальників з їхніми тарифами
SELECT suppliers.name, tariffs.price FROM suppliers
JOIN tariffs ON suppliers.id = tariffs.supplier_id;

-- 28. Середня ціна тарифів для кожної послуги
SELECT service_id, AVG(price) FROM tariffs GROUP BY service_id;

-- 29. Користувачі з більш ніж одним житловим об'єктом
SELECT user_id FROM residential_objects GROUP BY user_id HAVING COUNT(*) > 1;

-- 30. Вибірка платежів, зроблених через "Credit Card"
SELECT * FROM payments WHERE payment_method = 'Credit Card';

-- 31. Пошук користувачів за частковою відповідністю імені
SELECT * FROM users WHERE name ILIKE '%john%';

-- 32. Найдорожчий тариф на кожну послугу
SELECT DISTINCT ON (service_id) service_id, price FROM tariffs ORDER BY service_id, price DESC;

-- 33. Вибірка платежів, зроблених у певний рік
SELECT * FROM payments WHERE EXTRACT(YEAR FROM payment_date) = 2025;

-- 34. Розрахунок загальної суми платежів за кожного користувача
SELECT user_id, SUM(amount) FROM payments GROUP BY user_id;

-- 35. Вибірка житлових об'єктів із споживанням газу понад 50
SELECT * FROM residential_objects WHERE gas_consumption_per_month > 50;

-- 36. Оновлення тарифу для певної послуги
UPDATE tariffs SET price = price * 1.05 WHERE service_id = 1;

-- 37. Видалення платежів зі статусом "Paid"
DELETE FROM payments WHERE status = 'Paid';

-- 38. Вибірка останнього платежу кожного користувача
SELECT DISTINCT ON (user_id) * FROM payments ORDER BY user_id, payment_date DESC;

-- 39. Вибірка тарифів, що нижчі за середній
SELECT * FROM tariffs WHERE price < (SELECT AVG(price) FROM tariffs);

-- 40. Користувачі, які заплатили більше за середнє значення платежу
SELECT * FROM users WHERE id IN (SELECT user_id FROM payments WHERE amount > (SELECT AVG(amount) FROM payments));

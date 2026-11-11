-- 18. Найдите производителей самых дешевых цветных принтеров.
-- Вывести: maker, price.
-- Использовать ORDER BY; решать после ознакомления с JOIN.
SELECT   DISTINCT Product.maker,
                  Printer.price
FROM     Product
         INNER JOIN
         Printer
         ON Printer.model = Product.model
WHERE    Printer.color = 'y'
         AND Printer.price = (SELECT   TOP (1) price
                              FROM     Printer
                              WHERE    color = 'y'
                                       AND price IS NOT NULL
                              ORDER BY price ASC)
ORDER BY Printer.price ASC;

-- 24. Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.
WITH   all_products
AS     (SELECT model,
               price
        FROM   PC
        UNION ALL
        SELECT model,
               price
        FROM   Laptop
        UNION ALL
        SELECT model,
               price
        FROM   Printer)
SELECT DISTINCT model
FROM   all_products
WHERE  price = (SELECT MAX(price)
                FROM   all_products);

-- 77. Определить дни, когда было выполнено максимальное число рейсов из Ростова ('Rostov'). Вывод: число рейсов, дата.
SELECT   TOP (1) WITH TIES COUNT(DISTINCT Pass_in_trip.trip_no) AS flight_count,
                           Pass_in_trip.date
FROM     Trip
         INNER JOIN
         Pass_in_trip
         ON Pass_in_trip.trip_no = Trip.trip_no
WHERE    Trip.town_from = 'Rostov'
GROUP BY Pass_in_trip.date
ORDER BY COUNT(DISTINCT Pass_in_trip.trip_no) DESC;
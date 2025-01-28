-- створення бази даних
CREATE DATABASE lab1_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- створення таблиць
CREATE TABLE public.lots
(
    lot_id serial,
    name character varying NOT NULL,
    starting_price integer,
    PRIMARY KEY (lot_id)
);

ALTER TABLE IF EXISTS public.lots
    OWNER to postgres;

CREATE TABLE public.users
(
    user_id serial,
    name character varying NOT NULL,
    PRIMARY KEY (user_id)
);

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;

CREATE TABLE public.bids
(
    bid_id serial,
    user_id integer NOT NULL,
    lot_id integer NOT NULL,
    value integer,
    PRIMARY KEY (bid_id),
    CONSTRAINT lot_id FOREIGN KEY (lot_id)
        REFERENCES public.lots (lot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT user_id FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.bids
    OWNER to postgres;

-- вставка даних
INSERT INTO
	LOTS (NAME, STARTING_PRICE)
VALUES
	('Iron', 200);

INSERT INTO
	LOTS (NAME)
VALUES
	('Clock');

INSERT INTO
	USERS (NAME)
VALUES
	('Heralt'),
	('Ciri');

INSERT INTO
	BIDS (LOT_ID, USER_ID, VALUE)
VALUES
	(1, 1, 300),
	(1, 2, 320),
	(1, 1, 250)

-- вибірка даних
SELECT * FROM BIDS;

SELECT * FROM USERS;

SELECT * FROM LOTS;

-- оновлення даних
UPDATE bids SET value = 330 WHERE bid_id = 1;

-- видалення даних
DELETE FROM bids WHERE value = 320;
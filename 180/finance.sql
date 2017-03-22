--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.transactions_id_seq;
DROP TABLE public.transactions;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transactions (
    id integer NOT NULL,
    paid_in numeric(13,2) NOT NULL,
    paid_out numeric(13,2),
    date date NOT NULL,
    transaction_type character(25) NOT NULL,
    description character varying(255) NOT NULL
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO transactions VALUES (1, 0.00, 64.54, '2013-01-01', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (2, 0.00, 59.90, '2013-01-02', 'debit                    ', 'Amazon Book Purchase');
INSERT INTO transactions VALUES (3, 0.00, 40.00, '2013-01-03', 'debit                    ', 'ATM Withdrawal');
INSERT INTO transactions VALUES (4, 0.00, 240.00, '2013-01-04', 'debit                    ', 'Bar Drinks');
INSERT INTO transactions VALUES (5, 0.00, 150.00, '2013-01-05', 'debit                    ', 'Computer Equipment');
INSERT INTO transactions VALUES (6, 0.00, 1.99, '2013-01-06', 'debit                    ', 'Digital Movie Rental');
INSERT INTO transactions VALUES (7, 0.00, 630.00, '2013-01-07', 'debit                    ', 'Generic Telecoms ISP');
INSERT INTO transactions VALUES (8, 0.00, 4.50, '2013-01-08', 'debit                    ', 'MicroServer Rental 1 hour usage');
INSERT INTO transactions VALUES (9, 0.00, 30.00, '2013-01-09', 'debit                    ', 'Restaurant Dinner');
INSERT INTO transactions VALUES (10, 0.00, 70.00, '2013-01-10', 'debit                    ', 'Screencast Subscription');
INSERT INTO transactions VALUES (11, 0.00, 105.70, '2013-01-11', 'debit                    ', 'Shared Hosting Service');
INSERT INTO transactions VALUES (12, 0.00, 280.00, '2013-01-12', 'debit                    ', 'Social Network Premium Membership');
INSERT INTO transactions VALUES (13, 0.00, 64.54, '2013-01-01', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (14, 0.00, 10.00, '2013-01-02', 'debit                    ', 'Bar Drinks');
INSERT INTO transactions VALUES (15, 0.00, 64.54, '2013-01-03', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (16, 0.00, 64.54, '2013-01-04', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (17, 0.00, 64.54, '2013-01-05', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (18, 0.00, 64.54, '2013-01-06', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (19, 0.00, 64.54, '2013-01-07', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (20, 0.00, 64.54, '2013-01-08', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (21, 0.00, 64.54, '2013-01-09', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (22, 0.00, 3.99, '2013-01-10', 'debit                    ', 'Digital Movie Rental');
INSERT INTO transactions VALUES (23, 0.00, 64.54, '2013-01-11', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (24, 0.00, 64.54, '2013-01-12', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (25, 0.00, 64.54, '2013-01-13', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (26, 0.00, 64.54, '2013-01-14', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (27, 0.00, 64.54, '2013-01-15', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (28, 0.00, 10.00, '2013-01-16', 'debit                    ', 'Bar Drinks');
INSERT INTO transactions VALUES (29, 0.00, 64.54, '2013-01-17', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (30, 0.00, 64.54, '2013-01-18', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (31, 0.00, 10.00, '2013-01-19', 'debit                    ', 'MicroServer Rental 1 hour usage');
INSERT INTO transactions VALUES (32, 0.00, 64.54, '2013-01-20', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (33, 0.00, 64.54, '2013-01-21', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (34, 0.00, 64.54, '2013-01-22', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (35, 0.00, 64.54, '2013-01-23', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (36, 0.00, 64.54, '2013-01-24', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (37, 0.00, 64.54, '2013-01-25', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (38, 0.00, 64.54, '2013-01-26', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (39, 0.00, 64.54, '2013-01-27', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (40, 0.00, 64.54, '2013-01-28', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (41, 0.00, 64.54, '2013-01-29', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (42, 0.00, 64.54, '2013-01-30', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (43, 0.00, 64.54, '2013-01-31', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (44, 0.00, 64.54, '2013-02-01', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (45, 0.00, 64.54, '2013-02-02', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (46, 0.00, 64.54, '2013-02-03', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (47, 0.00, 64.54, '2013-02-04', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (48, 0.00, 64.54, '2013-02-05', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (49, 0.00, 64.54, '2013-02-06', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (50, 0.00, 64.54, '2013-02-07', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (51, 0.00, 64.54, '2013-02-08', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (52, 0.00, 64.54, '2013-02-09', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (53, 0.00, 64.54, '2013-02-10', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (54, 0.00, 64.54, '2013-02-11', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (55, 0.00, 64.54, '2013-02-12', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (56, 0.00, 64.54, '2013-02-13', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (57, 0.00, 64.54, '2013-02-14', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (58, 0.00, 64.54, '2013-02-15', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (59, 0.00, 64.54, '2013-02-16', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (60, 0.00, 64.54, '2013-02-17', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (61, 0.00, 64.54, '2013-02-18', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (62, 0.00, 64.54, '2013-02-19', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (63, 0.00, 64.54, '2013-02-20', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (64, 0.00, 64.54, '2013-02-21', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (65, 0.00, 64.54, '2013-02-22', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (66, 0.00, 64.54, '2013-02-23', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (67, 0.00, 64.54, '2013-02-24', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (68, 0.00, 64.54, '2013-02-25', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (69, 0.00, 64.54, '2013-02-26', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (70, 0.00, 64.54, '2013-02-27', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (71, 0.00, 64.54, '2013-02-28', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (72, 0.00, 64.54, '2013-03-01', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (73, 0.00, 64.54, '2013-03-02', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (74, 0.00, 64.54, '2013-03-03', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (75, 0.00, 64.54, '2013-03-04', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (76, 0.00, 64.54, '2013-03-05', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (77, 0.00, 64.54, '2013-03-06', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (78, 0.00, 64.54, '2013-03-07', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (79, 0.00, 64.54, '2013-03-08', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (80, 0.00, 64.54, '2013-03-09', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (81, 0.00, 64.54, '2013-03-10', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (82, 0.00, 64.54, '2013-03-11', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (83, 0.00, 64.54, '2013-03-12', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (84, 0.00, 64.54, '2013-03-13', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (85, 0.00, 64.54, '2013-03-14', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (86, 0.00, 64.54, '2013-03-15', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (87, 0.00, 64.54, '2013-03-16', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (88, 0.00, 64.54, '2013-03-17', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (89, 0.00, 2.99, '2013-03-18', 'debit                    ', 'Screencast Subscription');
INSERT INTO transactions VALUES (90, 0.00, 64.54, '2013-03-19', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (91, 0.00, 64.54, '2013-03-20', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (92, 0.00, 64.54, '2013-03-21', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (93, 0.00, 64.54, '2013-03-22', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (94, 0.00, 64.54, '2013-03-23', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (95, 0.00, 64.54, '2013-03-24', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (96, 0.00, 64.54, '2013-03-25', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (97, 0.00, 64.54, '2013-03-26', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (98, 0.00, 64.54, '2013-03-27', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (99, 0.00, 64.54, '2013-03-28', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (100, 0.00, 280.00, '2013-03-29', 'debit                    ', 'Social Network Premium Membership');
INSERT INTO transactions VALUES (101, 0.00, 64.54, '2013-03-30', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (102, 0.00, 64.54, '2013-03-31', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (103, 0.00, 64.54, '2013-04-01', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (104, 0.00, 64.54, '2013-04-02', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (105, 0.00, 64.54, '2013-04-03', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (106, 0.00, 64.54, '2013-04-04', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (107, 0.00, 64.54, '2013-04-05', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (108, 0.00, 64.54, '2013-04-06', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (109, 0.00, 64.54, '2013-04-07', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (110, 0.00, 64.54, '2013-04-08', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (111, 0.00, 64.54, '2013-04-09', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (112, 0.00, 64.54, '2013-04-10', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (113, 0.00, 64.54, '2013-04-11', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (114, 0.00, 64.54, '2013-04-12', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (115, 0.00, 64.54, '2013-04-13', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (116, 0.00, 64.54, '2013-04-14', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (117, 0.00, 64.54, '2013-04-15', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (118, 0.00, 64.54, '2013-04-16', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (119, 0.00, 64.54, '2013-04-17', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (120, 0.00, 64.54, '2013-04-18', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (121, 0.00, 64.54, '2013-04-19', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (122, 0.00, 64.54, '2013-04-20', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (123, 0.00, 64.54, '2013-04-21', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (124, 0.00, 64.54, '2013-04-22', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (125, 0.00, 1.99, '2013-04-23', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (126, 0.00, 1.99, '2013-04-24', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (127, 0.00, 1.99, '2013-04-25', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (128, 0.00, 1.99, '2013-04-26', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (129, 0.00, 1.99, '2013-04-27', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (130, 0.00, 1.99, '2013-04-28', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (131, 0.00, 1.99, '2013-04-29', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (132, 0.00, 1.99, '2013-04-30', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (133, 0.00, 1.99, '2013-05-01', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (134, 0.00, 1.99, '2013-05-02', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (135, 0.00, 1.99, '2013-05-03', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (136, 0.00, 1.99, '2013-05-04', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (137, 0.00, 1.99, '2013-05-05', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (138, 0.00, 1.99, '2013-05-06', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (139, 0.00, 1.99, '2013-05-07', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (140, 0.00, 1.99, '2013-05-08', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (141, 0.00, 1.99, '2013-05-09', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (142, 0.00, 1.99, '2013-05-10', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (143, 0.00, 1.99, '2013-05-11', 'debit                    ', 'Online Shopping');
INSERT INTO transactions VALUES (144, 0.00, 1.99, '2013-06-11', 'debit                    ', 'Online Shopping');


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('transactions_id_seq', 144, true);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


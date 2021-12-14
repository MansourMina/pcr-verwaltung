--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_city_id_seq OWNER TO postgres;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;


--
-- Name: laboranten; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laboranten (
    lab_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    gebdatum date,
    tel character varying(20),
    benutzername character varying(50) DEFAULT 'mina.mansour'::character varying NOT NULL,
    password character varying(30) DEFAULT '1234'::character varying NOT NULL,
    image character varying,
    typ character varying DEFAULT 'Verwalter'::character varying NOT NULL,
    email character varying(50) DEFAULT 'mansour.m02@htlwienwest.at'::character varying NOT NULL
);


ALTER TABLE public.laboranten OWNER TO postgres;

--
-- Name: personen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personen (
    testperson_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    gebdatum date NOT NULL,
    tel character varying(13) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.personen OWNER TO postgres;

--
-- Name: personen_testperson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personen_testperson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personen_testperson_id_seq OWNER TO postgres;

--
-- Name: personen_testperson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personen_testperson_id_seq OWNED BY public.personen.testperson_id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tests (
    qr_id character varying(20) NOT NULL,
    "gültig_von" date,
    "gültig_bis" date,
    result character varying(10),
    testperson_id integer,
    lab_id integer,
    status character varying(20) DEFAULT 'unbearbeitet'::character varying NOT NULL,
    city_id integer NOT NULL
);


ALTER TABLE public.tests OWNER TO postgres;

--
-- Name: cities city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- Name: personen testperson_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personen ALTER COLUMN testperson_id SET DEFAULT nextval('public.personen_testperson_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (city_id, name) FROM stdin;
5	oberösterreich
7	voralberg
4	steiermark
1	salzburg
8	burgenland
2	tirol
3	kärnten
6	niederösterreich
9	vienna
\.


--
-- Data for Name: laboranten; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laboranten (lab_id, first_name, last_name, gebdatum, tel, benutzername, password, image, typ, email) FROM stdin;
138271	Mina	Mansour	2021-12-06	43434434343	mina-mansour22	587fe08819	images/max.jpeg	Admin,Verwalter	mansour.m02@htlwienwest.at
182470	Mina	Miedler	2021-12-06	32323233	mina-miedler	d3594cd00e	images/filip.jpeg	Verwalter,Admin	mansour.m02@htlwienwest.at
26	Moritz	Miedler	1995-01-27	+436763102722	moritz-miedler	1234	images/moritz.jpeg	Verwalter	mansour.m02@htlwienwest.at
24	Sebastian	Lang	2003-04-20	+436763043977	sebastian-lang	1234	images/sebi.jpeg	Verwalter	mansour.m02@htlwienwest.at
27	Ivan 	Orsolic	1989-10-05	+436647136144	ivan-orsolic	1234	images/ivan.jpeg	Verwalter	mansour.m02@htlwienwest.at
25	Max	Blam	2002-11-21	+436763068311	max-blam	1234	images/max.jpeg	Admin, Verwalter	mansour.m02@htlwienwest.at
513167	Victor	Pawlek	2021-12-14	454545454545	victor-pawlek	b14ab96ffe	\N	Verwalter,Admin	pawlek.v03@htlwienwest.at
579619	Thomas	Psik	2021-12-13	343242342342	thomas-psik	1234	images/haroon.jpeg	Verwalter	thomas.psik@htlwienwest.at
\.


--
-- Data for Name: personen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personen (testperson_id, first_name, last_name, gebdatum, tel, email) FROM stdin;
5	Alida	Kiernan	2000-03-10	+436768787377	mansour.m02@htlwienwest.at
10	Ede	Balaam	1994-09-05	+436762379644	mansour.m02@htlwienwest.at
1	Easter	Pressnell	1998-05-20	+436769770979	mansour.m02@htlwienwest.at
3	Grazia	Blasetti	1992-12-06	+436761525835	mansour.m02@htlwienwest.at
2	Sigismundo	Childs	2005-08-10	+436649444188	mansour.m02@htlwienwest.at
4	Lucilia	Chevins	1998-05-12	+436648581841	mansour.m02@htlwienwest.at
7	Emilie	Murby	1994-02-19	+436765767973	mansour.m02@htlwienwest.at
6	Joyce	Gannicleff	2000-08-25	+436647450409	mansour.m02@htlwienwest.at
9	Glynn	Miskin	2002-09-09	+436768168430	mansour.m02@htlwienwest.at
8	Millie	Bursnoll	2002-08-02	+436644209939	mansour.m02@htlwienwest.at
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tests (qr_id, "gültig_von", "gültig_bis", result, testperson_id, lab_id, status, city_id) FROM stdin;
3202853708	2021-03-20	2021-08-04	\N	1	\N	unbearbeitet	6
5963715253	2021-06-30	2021-08-09	\N	8	\N	unbearbeitet	5
5537448416	2021-08-31	2021-03-03	\N	7	\N	unbearbeitet	1
5120911269	2021-08-26	2021-06-09	\N	6	\N	unbearbeitet	6
2454524791	2021-09-27	2021-12-01	\N	5	\N	unbearbeitet	3
0604244762	2020-12-09	2021-10-09	\N	9	\N	unbearbeitet	6
8990447852	2021-03-25	2021-05-17	\N	7	\N	unbearbeitet	7
6443209125	2020-12-03	2021-09-17	\N	5	\N	unbearbeitet	7
5090389284	2021-10-16	2021-06-17	\N	4	\N	unbearbeitet	5
2222816513	2020-12-13	2021-06-20	\N	2	\N	unbearbeitet	3
0637977653	2021-04-26	2021-10-01	\N	6	\N	unbearbeitet	2
5231092592	2021-03-26	2021-11-14	\N	5	\N	unbearbeitet	8
0253722853	2021-01-10	2021-10-16	\N	1	\N	unbearbeitet	8
6550610788	2020-12-29	2021-04-07	\N	3	\N	unbearbeitet	4
1108118216	2020-12-25	2021-01-12	\N	8	\N	unbearbeitet	8
2474427988	2021-06-05	2021-09-09	\N	7	\N	unbearbeitet	4
7620035087	2021-03-23	2021-04-08	\N	7	\N	unbearbeitet	1
3295048770	2021-04-19	2021-01-13	\N	1	\N	unbearbeitet	5
7780508250	2021-11-16	2021-02-22	\N	1	\N	unbearbeitet	3
1236879384	2020-12-16	2021-05-26	\N	5	\N	unbearbeitet	7
6352258980	2021-08-27	2021-04-07	\N	7	\N	unbearbeitet	1
7120947818	2021-06-27	2021-07-23	\N	4	\N	unbearbeitet	6
5583986786	2021-11-22	2021-03-06	\N	3	\N	unbearbeitet	8
5378505844	2021-06-14	2021-08-06	\N	6	\N	unbearbeitet	2
4934621008	2021-07-14	2021-06-13	\N	4	\N	unbearbeitet	6
1028816154	2021-05-26	2021-05-22	\N	3	\N	unbearbeitet	7
2118761856	2021-01-30	2021-05-26	\N	5	\N	unbearbeitet	3
9666997983	2021-03-06	2021-11-11	\N	5	\N	unbearbeitet	5
5649634289	2021-11-22	2021-01-01	\N	7	\N	unbearbeitet	3
5182955731	2021-07-24	2021-01-22	\N	4	\N	unbearbeitet	2
6952665455	2021-08-13	2021-08-30	\N	5	\N	unbearbeitet	7
8733010056	2021-12-01	2021-08-20	\N	1	\N	unbearbeitet	7
1058577255	2021-02-09	2021-05-29	\N	4	\N	unbearbeitet	5
5498111304	2020-12-06	2021-01-09	negativ	7	\N	bearbeitet	9
9306611277	2021-09-23	2021-06-06	\N	3	\N	unbearbeitet	6
4638391834	2021-05-13	2021-08-27	\N	7	\N	unbearbeitet	7
2760867692	2021-10-01	2021-12-01	positiv	10	579619	bearbeitet	9
6665737594	2021-02-13	2021-02-01	\N	8	\N	unbearbeitet	2
0609167456	2021-11-11	2021-08-10	\N	10	\N	unbearbeitet	5
6553741328	2021-08-11	2021-03-04	negativ	1	579619	bearbeitet	9
3819503676	2021-07-13	2021-09-07	positiv	5	579619	bearbeitet	9
7559355064	2021-08-25	2021-07-30	negativ	8	579619	bearbeitet	9
1972594699	2021-07-10	2021-04-03	unbekannt	7	182470	bearbeitet	9
6454986721	2021-09-10	2021-07-21	\N	4	\N	unbearbeitet	3
6757357844	2021-02-06	2021-10-19	\N	3	\N	unbearbeitet	3
3795424879	2021-06-24	2021-11-08	\N	8	\N	unbearbeitet	3
8550756644	2021-03-05	2020-12-19	\N	6	\N	unbearbeitet	3
2737075580	2021-03-15	2021-09-07	\N	8	\N	unbearbeitet	8
8679917583	2021-07-20	2021-02-20	\N	7	\N	unbearbeitet	2
4316033417	2021-08-01	2021-09-23	\N	7	\N	unbearbeitet	7
6159160990	2021-05-19	2021-09-11	\N	5	\N	unbearbeitet	8
4272850806	2021-11-27	2021-11-05	\N	3	\N	unbearbeitet	4
7562817820	2021-05-10	2021-02-05	\N	3	\N	unbearbeitet	2
4017970486	2021-10-27	2021-06-08	\N	4	\N	unbearbeitet	4
0308470427	2021-01-20	2021-06-08	\N	6	\N	unbearbeitet	3
1084075830	2021-07-11	2021-11-13	\N	8	\N	unbearbeitet	1
1566304067	2021-10-07	2021-07-02	\N	1	\N	unbearbeitet	2
3834960411	2021-04-01	2021-06-08	\N	8	\N	unbearbeitet	6
9034905748	2021-09-09	2021-03-11	\N	9	\N	unbearbeitet	4
0084734957	2021-01-23	2021-11-09	\N	9	\N	unbearbeitet	1
4225428141	2021-11-15	2021-06-22	\N	5	\N	unbearbeitet	2
3228229092	2021-09-06	2021-04-01	\N	4	\N	unbearbeitet	2
3917825783	2021-08-20	2021-01-20	\N	8	\N	unbearbeitet	4
1544139233	2021-01-16	2021-11-12	\N	8	\N	unbearbeitet	6
9729256497	2021-10-14	2021-08-27	\N	5	\N	unbearbeitet	9
0503812595	2021-03-16	2021-11-02	\N	10	\N	unbearbeitet	3
2392607583	2021-07-15	2021-07-31	\N	8	\N	unbearbeitet	7
6316052642	2021-11-03	2021-08-18	\N	5	\N	unbearbeitet	7
0315463511	2021-10-23	2021-04-26	\N	7	\N	unbearbeitet	7
0372535992	2021-02-19	2021-07-22	\N	2	\N	unbearbeitet	5
0521237505	2021-08-16	2021-05-21	\N	5	\N	unbearbeitet	2
5739242827	2021-07-10	2021-08-14	\N	3	\N	unbearbeitet	1
3956025482	2021-05-12	2020-11-30	\N	3	\N	unbearbeitet	1
5218766437	2021-03-26	2021-10-27	\N	4	\N	unbearbeitet	3
3923050550	2021-10-31	2021-06-30	\N	4	\N	unbearbeitet	9
7099468871	2021-05-25	2021-07-22	\N	6	\N	unbearbeitet	2
3910287352	2021-03-12	2021-09-15	\N	2	\N	unbearbeitet	1
1079835466	2021-04-03	2021-04-21	\N	3	\N	unbearbeitet	4
8840660445	2021-02-05	2021-10-15	\N	10	\N	unbearbeitet	9
5394621640	2021-10-10	2021-10-13	\N	7	\N	unbearbeitet	6
2910726584	2021-04-20	2021-01-11	\N	4	\N	unbearbeitet	1
1560953152	2021-10-13	2021-03-03	\N	4	\N	unbearbeitet	2
7913997435	2021-01-22	2021-11-11	\N	4	\N	unbearbeitet	2
5818240274	2021-09-16	2021-10-11	\N	9	\N	unbearbeitet	2
8324371613	2021-12-02	2021-04-21	\N	6	\N	unbearbeitet	2
8868326299	2021-02-07	2021-10-17	\N	4	\N	unbearbeitet	7
6443739809	2021-11-21	2020-12-12	\N	10	\N	unbearbeitet	2
7759092296	2021-09-11	2021-07-02	\N	1	\N	unbearbeitet	4
3019050413	2021-08-04	2021-09-13	\N	9	\N	unbearbeitet	8
6437845252	2021-03-12	2021-01-07	\N	3	\N	unbearbeitet	8
1402973608	2021-07-12	2021-11-27	\N	1	\N	unbearbeitet	4
9422592550	2021-09-17	2021-09-10	\N	3	\N	unbearbeitet	6
9229265608	2021-09-12	2021-03-25	\N	1	\N	unbearbeitet	4
6589270074	2021-10-09	2021-06-14	\N	2	\N	unbearbeitet	6
3033698204	2021-01-12	2021-06-14	\N	5	\N	unbearbeitet	7
5106893186	2021-08-31	2021-08-19	\N	2	\N	unbearbeitet	8
4884554620	2021-10-26	2021-09-06	\N	1	\N	unbearbeitet	1
0508022851	2021-10-27	2021-11-02	\N	7	\N	unbearbeitet	6
0590072927	2021-05-21	2021-06-28	\N	6	\N	unbearbeitet	2
6483751109	2021-04-03	2021-08-31	\N	8	\N	unbearbeitet	2
5935037513	2021-11-22	2021-02-25	\N	9	\N	unbearbeitet	5
7985176683	2021-04-23	2021-10-01	\N	5	\N	unbearbeitet	3
1117470768	2021-10-27	2021-05-13	\N	4	\N	unbearbeitet	3
3167178671	2021-05-25	2021-07-04	\N	8	\N	unbearbeitet	3
3894098082	2021-10-17	2021-04-02	\N	7	\N	unbearbeitet	6
2307787410	2021-04-17	2021-11-06	\N	5	\N	unbearbeitet	4
1366495209	2021-05-28	2021-08-19	\N	3	\N	unbearbeitet	8
9571118044	2021-01-20	2021-04-10	\N	1	\N	unbearbeitet	7
\.


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 18, true);


--
-- Name: personen_testperson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personen_testperson_id_seq', 1, false);


--
-- Name: cities cities_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pk PRIMARY KEY (city_id);


--
-- Name: laboranten laboranten_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboranten
    ADD CONSTRAINT laboranten_pkey PRIMARY KEY (lab_id);


--
-- Name: laboranten laboranten_tel_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboranten
    ADD CONSTRAINT laboranten_tel_key UNIQUE (tel);


--
-- Name: personen personen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personen
    ADD CONSTRAINT personen_pkey PRIMARY KEY (testperson_id);


--
-- Name: personen personen_tel_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personen
    ADD CONSTRAINT personen_tel_key UNIQUE (tel);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (qr_id);


--
-- Name: laboranten_benutzername_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX laboranten_benutzername_uindex ON public.laboranten USING btree (benutzername);


--
-- Name: tests tests_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);


--
-- Name: tests tests_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES public.laboranten(lab_id) ON DELETE SET NULL;


--
-- Name: tests tests_testperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_testperson_id_fkey FOREIGN KEY (testperson_id) REFERENCES public.personen(testperson_id);


--
-- Name: TABLE cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.cities TO testuser;


--
-- Name: TABLE laboranten; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE ON TABLE public.laboranten TO testuser;


--
-- Name: TABLE personen; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.personen TO testuser;


--
-- Name: TABLE tests; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,DELETE,UPDATE ON TABLE public.tests TO testuser;


--
-- PostgreSQL database dump complete
--


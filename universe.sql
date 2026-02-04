--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C
.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    distance_ly integer NOT NULL,
    redshift numeric(6,4),
    has_radio_emission boolean NOT NULL,
    description text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: mission; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.mission (
    mission_id integer NOT NULL,
    name character varying(30) NOT NULL,
    mission_code character varying(10) NOT NULL,
    budget_mln_usd integer NOT NULL,
    duration_days integer NOT NULL,
    is_manned boolean NOT NULL
);


ALTER TABLE public.mission OWNER TO freecodecamp;

--
-- Name: mission_mission_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.mission_mission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mission_mission_id_seq OWNER TO freecodecamp;

--
-- Name: mission_mission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.mission_mission_id_seq OWNED BY public.mission.mission_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer NOT NULL,
    distance_to_planet_km integer NOT NULL,
    orbital_eccentricity numeric(5,4) NOT NULL,
    is_spherical boolean DEFAULT true,
    age_mln_years integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_id integer NOT NULL,
    distance_to_earth_km bigint NOT NULL,
    relative_mass numeric(7,2) NOT NULL,
    has_rings boolean,
    age_mln_years integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer NOT NULL,
    distance_ly numeric(10,2) NOT NULL,
    is_visible_naked_eye boolean NOT NULL,
    solar_brightness integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::
regclass);


--
-- Name: mission mission_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission ALTER COLUMN mission_id SET DEFAULT nextval('public.mission_mission_id_se
q'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass
);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::
regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass
);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Via Lattea', 0, 0.0000, true, 'La nostra galassia di casa.');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 2540000, -0.0010, false, 'In rotta di collisione con no
i.');
INSERT INTO public.galaxy VALUES (3, 'Triangolo', 2730000, -0.0006, false, 'Terza galassia del Gruppo Loc
ale.');
INSERT INTO public.galaxy VALUES (4, 'Centaurus A', 12000000, 0.0018, true, 'Nota per il suo forte nucleo
 radio.');
INSERT INTO public.galaxy VALUES (5, 'Messier 87', 53500000, 0.0044, true, 'Contiene un buco nero superma
ssiccio.');
INSERT INTO public.galaxy VALUES (6, 'Sombrero', 29300000, 0.0034, false, 'Forma caratteristica a disco.'
);


--
-- Data for Name: mission; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.mission VALUES (1, 'Apollo 11', 'AP-11', 355, 8, true);
INSERT INTO public.mission VALUES (2, 'Voyager 1', 'VY-01', 865, 17000, false);
INSERT INTO public.mission VALUES (3, 'Perseverance', 'PS-20', 2700, 1000, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 3, 384400, 0.0549, true, 4510);
INSERT INTO public.moon VALUES (2, 'Phobos', 4, 9377, 0.0151, true, 4500);
INSERT INTO public.moon VALUES (3, 'Deimos', 4, 23460, 0.0003, true, 4500);
INSERT INTO public.moon VALUES (4, 'Io', 5, 421700, 0.0041, true, 4500);
INSERT INTO public.moon VALUES (5, 'Europa', 5, 670900, 0.0090, true, 4500);
INSERT INTO public.moon VALUES (6, 'Ganimede', 5, 1070400, 0.0013, true, 4500);
INSERT INTO public.moon VALUES (7, 'Callisto', 5, 1882700, 0.0074, true, 4500);
INSERT INTO public.moon VALUES (8, 'Metis', 5, 128000, 0.0000, true, 4500);
INSERT INTO public.moon VALUES (9, 'Adrastea', 5, 129000, 0.0015, true, 4500);
INSERT INTO public.moon VALUES (10, 'Amaltea', 5, 181400, 0.0032, true, 4500);
INSERT INTO public.moon VALUES (11, 'Titano', 6, 1221870, 0.0288, true, 4500);
INSERT INTO public.moon VALUES (12, 'Encelado', 6, 237948, 0.0047, true, 4500);
INSERT INTO public.moon VALUES (13, 'Mimas', 6, 185539, 0.0202, true, 4500);
INSERT INTO public.moon VALUES (14, 'Rea', 6, 527108, 0.0013, true, 4500);
INSERT INTO public.moon VALUES (15, 'Dione', 6, 377396, 0.0022, true, 4500);
INSERT INTO public.moon VALUES (16, 'Teti', 6, 294619, 0.0001, true, 4500);
INSERT INTO public.moon VALUES (17, 'Titania', 7, 435910, 0.0011, true, 4500);
INSERT INTO public.moon VALUES (18, 'Oberon', 7, 583520, 0.0014, true, 4500);
INSERT INTO public.moon VALUES (19, 'Tritone', 8, 354759, 0.0000, true, 4500);
INSERT INTO public.moon VALUES (20, 'Nereide', 8, 5513818, 0.7507, true, 4500);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercurio', 1, 91700000, 0.06, false, 4500);
INSERT INTO public.planet VALUES (2, 'Venere', 1, 41400000, 0.81, false, 4500);
INSERT INTO public.planet VALUES (3, 'Terra', 1, 0, 1.00, false, 4500);
INSERT INTO public.planet VALUES (4, 'Marte', 1, 78300000, 0.11, false, 4500);
INSERT INTO public.planet VALUES (5, 'Giove', 1, 628700000, 317.80, true, 4500);
INSERT INTO public.planet VALUES (6, 'Saturno', 1, 1275000000, 95.16, true, 4500);
INSERT INTO public.planet VALUES (7, 'Urano', 1, 2724000000, 14.54, true, 4500);
INSERT INTO public.planet VALUES (8, 'Nettuno', 1, 4351000000, 17.15, true, 4500);
INSERT INTO public.planet VALUES (9, 'Proxima b', 3, 2147483647, 1.07, false, 4850);
INSERT INTO public.planet VALUES (10, 'Proxima c', 3, 2147483647, 7.00, true, 4850);
INSERT INTO public.planet VALUES (11, 'Sirio b-1', 2, 2147483647, 120.00, true, 242);
INSERT INTO public.planet VALUES (12, 'Vega-b', 4, 2147483647, 20.00, false, 455);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sole', 1, 0.00, true, 1);
INSERT INTO public.star VALUES (2, 'Sirio', 1, 8.60, true, 25);
INSERT INTO public.star VALUES (3, 'Proxima Centauri', 1, 4.24, false, 0);
INSERT INTO public.star VALUES (4, 'Vega', 1, 25.00, true, 40);
INSERT INTO public.star VALUES (5, 'V101', 2, 2540000.00, false, 1000000);
INSERT INTO public.star VALUES (6, 'B324', 3, 2730000.00, false, 2000000);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: mission_mission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.mission_mission_id_seq', 3, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: mission mission_mission_code_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_mission_code_key UNIQUE (mission_code);


--
-- Name: mission mission_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_name_key UNIQUE (name);


--
-- Name: mission mission_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_pkey PRIMARY KEY (mission_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

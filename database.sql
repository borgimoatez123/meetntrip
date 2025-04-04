-- Drop and Create Database
DROP DATABASE IF EXISTS meetntrip;
CREATE DATABASE meetntrip;
USE meetntrip;

-- User Table
CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    motDePasse VARCHAR(255),
    telephone VARCHAR(20),
    role VARCHAR(50), -- Admin, client, sponsor
    compteValide BOOLEAN,
    montant DECIMAL(10, 2) DEFAULT NULL,
    image VARCHAR(255),
    status VARCHAR(255) -- bloque, islogin
);

-- Flights Table
CREATE TABLE flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(100) NOT NULL,
    airline VARCHAR(100),
    departure_time TIME,
    back_time TIME,
    type VARCHAR(100),
    aeroports TEXT,
    price DECIMAL(10, 2)
);

-- Hotels Table
CREATE TABLE hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    name VARCHAR(100),
    price_per_night DECIMAL(10, 2),
    rating INT,
    description TEXT
);

-- Conference Location Table
CREATE TABLE conference_location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    capacity INT,
    price_per_day DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Event Table
CREATE TABLE evenement (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    nombreInvite INT NOT NULL,
    dateDebut DATETIME NOT NULL,
    dateFin DATETIME NOT NULL,
    description TEXT,
    city VARCHAR(255) NOT NULL, -- liste de pays
    budgetPrevu DECIMAL(10, 2) NOT NULL,
    activities TEXT,
    imagePath VARCHAR(255),
    validated BOOLEAN NOT NULL DEFAULT FALSE,
    status VARCHAR(50) NOT NULL, -- reserver or paier
    userid INT,
    FOREIGN KEY (userid) REFERENCES User(id)
);

-- Employer Table
CREATE TABLE employer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    job VARCHAR(100),
    cin_image VARCHAR(255),  -- Changed from 'image' to VARCHAR for file paths
    passport_image VARCHAR(255),
    nationality VARCHAR(100), -- Corrected spelling from 'nationally'
    age INT,
    id_evement INT,          -- Added column for foreign key
    FOREIGN KEY (id_evement) REFERENCES evenement(id)
);

-- Transport Table
CREATE TABLE transport (
    transport_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT,
    hotel_id INT,
    transport_id INT,
    conference_location_id INT,
    user_name VARCHAR(255) NOT NULL,
    booking_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    airlines VARCHAR(255),
    departure_time TIME,
    back_time TIME,
    flight_price DECIMAL(10, 2),
    hotel_name VARCHAR(255),
    hotel_location VARCHAR(255),
    hotel_price_per_night DECIMAL(10, 2),
    hotel_rating DECIMAL(3, 2),
    conference_name VARCHAR(255),
    conference_price_per_day DECIMAL(10, 2),
    transport_type VARCHAR(100),
    transport_price DECIMAL(10, 2),
    transport_description TEXT,
    priceTotal DECIMAL(10, 2),
    name_evement VARCHAR(255),
    numberof_invites INT,
    start_evement DATETIME,
    end_evement DATETIME,
    Special_requests TEXT,
    id_evement INT,
    userid INT, -- Added missing userid column
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (transport_id) REFERENCES transport(transport_id),
    FOREIGN KEY (conference_location_id) REFERENCES conference_location(location_id),
    FOREIGN KEY (id_evement) REFERENCES evenement(id),
    FOREIGN KEY (userid) REFERENCES User(id)
);

-- Payment Table
CREATE TABLE paiement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_titulaire VARCHAR(255) NOT NULL,
    id_reservation INT NOT NULL,
    id_evement INT NOT NULL,
    numero_carte VARCHAR(16) NOT NULL,
    date_expiration DATE NOT NULL,
    cvv INT,
    montant DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_evement) REFERENCES evenement(id),
    FOREIGN KEY (id_reservation) REFERENCES bookings(booking_id)
);

-- Sponsorship Request Table
CREATE TABLE DemandeSponsoring (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sponsor VARCHAR(255),
    event_id INT,
    statut VARCHAR(50),
    justification TEXT,
    FOREIGN KEY (event_id) REFERENCES evenement(id)
);

-- Response Table
CREATE TABLE reponse (
    id_reponse INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    commentaire VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL
);

-- Complaint Table
CREATE TABLE reclamation (
    id_reclamation INT AUTO_INCREMENT PRIMARY KEY,
    updated DATE NOT NULL,
    commentaire VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255) NOT NULL
);
INSERT INTO flights (destination, airline, departure_time, back_time, type, aeroports, price)
VALUES
-- Paris (Charles de Gaulle)
('Paris', 'Tunisair', '08:00:00', '18:00:00', 'Economy', 'Tunis-Carthage ↔ Charles de Gaulle', 450.00),
('Paris', 'Air France', '10:30:00', '20:30:00', 'Business', 'Tunis-Carthage ↔ Charles de Gaulle', 900.00),
('Paris', 'Nouvelair', '13:15:00', '21:15:00', 'First Class', 'Enfidha ↔ Charles de Gaulle', 1200.00),
('Paris', 'Lufthansa', '15:45:00', '22:45:00', 'Economy', 'Monastir ↔ Charles de Gaulle', 500.00),
('Paris', 'Emirates', '18:00:00', '23:59:00', 'Business', 'Tunis-Carthage ↔ Charles de Gaulle', 1000.00),

-- New York (JFK)
('New York', 'Tunisair', '06:00:00', '20:00:00', 'Economy', 'Tunis-Carthage ↔ JFK', 850.00),
('New York', 'Delta Airlines', '09:00:00', '22:00:00', 'Business', 'Tunis-Carthage ↔ JFK', 1600.00),
('New York', 'United Airlines', '12:30:00', '23:30:00', 'First Class', 'Monastir ↔ JFK', 2500.00),
('New York', 'Air France', '15:15:00', '01:45:00', 'Economy', 'Enfidha ↔ JFK', 900.00),
('New York', 'Emirates', '20:45:00', '03:00:00', 'Business', 'Tunis-Carthage ↔ JFK', 2000.00),

-- Dubai (Dubai International)
('Dubai', 'Emirates', '07:30:00', '19:30:00', 'Economy', 'Tunis-Carthage ↔ Dubai International', 700.00),
('Dubai', 'FlyDubai', '10:45:00', '21:00:00', 'Business', 'Monastir ↔ Dubai International', 1300.00),
('Dubai', 'Turkish Airlines', '14:00:00', '23:00:00', 'First Class', 'Tunis-Carthage ↔ Dubai International', 2200.00),
('Dubai', 'Qatar Airways', '17:30:00', '02:15:00', 'Economy', 'Enfidha ↔ Dubai International', 800.00),
('Dubai', 'Lufthansa', '21:15:00', '04:30:00', 'Business', 'Tunis-Carthage ↔ Dubai International', 1500.00),

-- London (Heathrow)
('London', 'British Airways', '08:15:00', '18:30:00', 'Economy', 'Tunis-Carthage ↔ Heathrow', 600.00),
('London', 'EasyJet', '11:30:00', '20:45:00', 'Business', 'Monastir ↔ Heathrow', 1200.00),
('London', 'Lufthansa', '13:45:00', '23:15:00', 'First Class', 'Tunis-Carthage ↔ Heathrow', 2000.00),
('London', 'Ryanair', '16:30:00', '01:30:00', 'Economy', 'Enfidha ↔ Heathrow', 700.00),
('London', 'Qatar Airways', '19:00:00', '03:45:00', 'Business', 'Tunis-Carthage ↔ Heathrow', 1400.00),

-- Istanbul (Istanbul Airport)
('Istanbul', 'Turkish Airlines', '07:00:00', '22:00:00', 'Economy', 'Tunis-Carthage ↔ Istanbul Airport', 500.00),
('Istanbul', 'Pegasus Airlines', '09:45:00', '23:45:00', 'Business', 'Monastir ↔ Istanbul Airport', 1100.00),
('Istanbul', 'Qatar Airways', '12:00:00', '01:30:00', 'First Class', 'Tunis-Carthage ↔ Istanbul Airport', 1800.00),
('Istanbul', 'Emirates', '15:30:00', '04:00:00', 'Economy', 'Enfidha ↔ Istanbul Airport', 600.00),
('Istanbul', 'Lufthansa', '18:45:00', '06:15:00', 'Business', 'Tunis-Carthage ↔ Istanbul Airport', 1300.00),

-- Rome (Fiumicino)
('Rome', 'Alitalia', '08:30:00', '18:00:00', 'Economy', 'Tunis-Carthage ↔ Fiumicino', 400.00),
('Rome', 'Tunisair', '10:45:00', '20:00:00', 'Business', 'Monastir ↔ Fiumicino', 800.00),
('Rome', 'Air France', '12:15:00', '21:30:00', 'First Class', 'Tunis-Carthage ↔ Fiumicino', 1200.00),
('Rome', 'Lufthansa', '15:00:00', '23:00:00', 'Economy', 'Enfidha ↔ Fiumicino', 500.00),
('Rome', 'Turkish Airlines', '18:30:00', '01:00:00', 'Business', 'Tunis-Carthage ↔ Fiumicino', 950.00),

-- Madrid (Barajas)
('Madrid', 'Iberia', '09:00:00', '19:30:00', 'Economy', 'Tunis-Carthage ↔ Barajas', 450.00),
('Madrid', 'Vueling', '11:45:00', '21:45:00', 'Business', 'Monastir ↔ Barajas', 850.00),
('Madrid', 'Tunisair', '14:15:00', '22:00:00', 'First Class', 'Tunis-Carthage ↔ Barajas', 1300.00),
('Madrid', 'Air Europa', '17:00:00', '23:30:00', 'Economy', 'Enfidha ↔ Barajas', 600.00),
('Madrid', 'Lufthansa', '20:00:00', '01:45:00', 'Business', 'Tunis-Carthage ↔ Barajas', 1000.00),

-- Tokyo (Narita)
('Tokyo', 'Japan Airlines', '05:00:00', '22:00:00', 'Economy', 'Tunis-Carthage ↔ Narita', 1300.00),
('Tokyo', 'ANA', '08:30:00', '23:45:00', 'Business', 'Monastir ↔ Narita', 2500.00),
('Tokyo', 'Qatar Airways', '11:15:00', '01:30:00', 'First Class', 'Tunis-Carthage ↔ Narita', 3500.00),
('Tokyo', 'Emirates', '14:00:00', '03:15:00', 'Economy', 'Enfidha ↔ Narita', 1500.00),
('Tokyo', 'Turkish Airlines', '18:00:00', '05:00:00', 'Business', 'Tunis-Carthage ↔ Narita', 2700.00),

-- Beijing (Beijing Capital)
('Beijing', 'Air China', '06:30:00', '20:45:00', 'Economy', 'Tunis-Carthage ↔ Beijing Capital', 1400.00),
('Beijing', 'China Eastern', '09:00:00', '22:30:00', 'Business', 'Monastir ↔ Beijing Capital', 2600.00),
('Beijing', 'Qatar Airways', '12:45:00', '00:00:00', 'First Class', 'Tunis-Carthage ↔ Beijing Capital', 3600.00),
('Beijing', 'Emirates', '16:00:00', '02:15:00', 'Economy', 'Enfidha ↔ Beijing Capital', 1600.00),
('Beijing', 'Turkish Airlines', '19:15:00', '04:30:00', 'Business', 'Tunis-Carthage ↔ Beijing Capital', 2800.00),

-- Sydney (Kingsford Smith)
('Sydney', 'Qantas', '07:00:00', '22:00:00', 'Economy', 'Tunis-Carthage ↔ Kingsford Smith', 1800.00),
('Sydney', 'Emirates', '10:30:00', '23:45:00', 'Business', 'Monastir ↔ Kingsford Smith', 3000.00),
('Sydney', 'Singapore Airlines', '13:15:00', '01:30:00', 'First Class', 'Tunis-Carthage ↔ Kingsford Smith', 4500.00),
('Sydney', 'Qatar Airways', '15:45:00', '03:15:00', 'Economy', 'Enfidha ↔ Kingsford Smith', 1900.00),
('Sydney', 'Turkish Airlines', '18:00:00', '05:00:00', 'Business', 'Tunis-Carthage ↔ Kingsford Smith', 3200.00),

-- Riyadh (King Khalid)
('Riyadh', 'Saudia', '07:00:00', '19:00:00', 'Economy', 'Tunis-Carthage ↔ King Khalid', 600.00),
('Riyadh', 'Flynas', '10:30:00', '21:30:00', 'Business', 'Monastir ↔ King Khalid', 1200.00),
('Riyadh', 'Qatar Airways', '14:15:00', '23:45:00', 'First Class', 'Tunis-Carthage ↔ King Khalid', 2100.00),
('Riyadh', 'Emirates', '17:45:00', '01:00:00', 'Economy', 'Enfidha ↔ King Khalid', 700.00),
('Riyadh', 'Turkish Airlines', '20:00:00', '02:00:00', 'Business', 'Tunis-Carthage ↔ King Khalid', 1500.00),

-- Ottawa (Ottawa Macdonald-Cartier)
('Ottawa', 'Air Canada', '06:30:00', '20:30:00', 'Economy', 'Tunis-Carthage ↔ Ottawa Macdonald-Cartier', 900.00),
('Ottawa', 'WestJet', '09:45:00', '22:45:00', 'Business', 'Monastir ↔ Ottawa Macdonald-Cartier', 1800.00),
('Ottawa', 'United Airlines', '13:00:00', '00:30:00', 'First Class', 'Tunis-Carthage ↔ Ottawa Macdonald-Cartier', 2800.00),
('Ottawa', 'British Airways', '16:15:00', '02:00:00', 'Economy', 'Enfidha ↔ Ottawa Macdonald-Cartier', 1000.00),
('Ottawa', 'Lufthansa', '19:30:00', '03:30:00', 'Business', 'Tunis-Carthage ↔ Ottawa Macdonald-Cartier', 2200.00);

INSERT INTO hotels (city, location, name, price_per_night, rating, description)
VALUES
-- Paris (15 hotels)
('Paris', 'Paris', 'Le Grand Paris', 150.00, 5, 'A luxurious 5-star hotel offering stunning views of the Eiffel Tower and exceptional service.'),
('Paris', 'Paris', 'Hotel Eiffel Bliss', 145.50, 5, 'An elegant boutique hotel located steps away from the iconic Eiffel Tower.'),
('Paris', 'Paris', 'Champs Elysees Retreat', 155.75, 5, 'A high-end retreat near the Champs Elysees, perfect for shopping and sightseeing.'),
('Paris', 'Paris', 'Louvre Luxury Inn', 120.00, 4, 'A stylish inn within walking distance of the world-famous Louvre Museum.'),
('Paris', 'Paris', 'Seine River Stay', 115.25, 4, 'A charming riverside hotel offering serene views of the Seine River.'),
('Paris', 'Paris', 'Montmartre Haven', 118.90, 4, 'A cozy haven nestled in the artistic Montmartre district.'),
('Paris', 'Paris', 'Notre Dame View', 90.50, 3, 'A budget-friendly option with a great view of Notre Dame Cathedral.'),
('Paris', 'Paris', 'Parisian Charm', 85.75, 3, 'Experience authentic Parisian charm at this centrally located hotel.'),
('Paris', 'Paris', 'Cafe de Flore Inn', 88.20, 3, 'A quaint inn inspired by the historic Cafe de Flore.'),
('Paris', 'Paris', 'Bastille Budget', 65.00, 2, 'Affordable accommodations near the vibrant Bastille neighborhood.'),
('Paris', 'Paris', 'Marais Rest', 60.30, 2, 'A simple yet comfortable stay in the trendy Marais district.'),
('Paris', 'Paris', 'Left Bank Lodge', 62.15, 2, 'A cozy lodge on the Left Bank, ideal for travelers on a budget.'),
('Paris', 'Paris', 'Gare du Nord Stay', 45.00, 1, 'Basic accommodations conveniently located near Gare du Nord train station.'),
('Paris', 'Paris', 'Simple Paris', 40.25, 1, 'No-frills lodging for travelers seeking affordability in the heart of Paris.'),
('Paris', 'Paris', 'Hostel de France', 42.80, 1, 'A lively hostel perfect for backpackers exploring the city.'),

-- New York (15 hotels)
('New York', 'New York', 'Manhattan Skyline', 200.00, 5, 'A luxurious hotel offering breathtaking views of the Manhattan skyline.'),
('New York', 'New York', 'Central Park Plaza', 210.50, 5, 'An opulent plaza hotel overlooking the lush greenery of Central Park.'),
('New York', 'New York', 'Empire State Lux', 205.75, 5, 'Stay in style at this hotel near the iconic Empire State Building.'),
('New York', 'New York', 'Times Square Inn', 160.00, 4, 'A modern inn located in the bustling heart of Times Square.'),
('New York', 'New York', 'Brooklyn Heights', 155.25, 4, 'A serene retreat in the picturesque Brooklyn Heights area.'),
('New York', 'New York', 'Hudson River Rest', 158.90, 4, 'Relax by the Hudson River at this tranquil hotel.'),
('New York', 'New York', 'SoHo Stay', 120.50, 3, 'A trendy stay in the artsy SoHo district, known for its galleries and shops.'),
('New York', 'New York', 'Midtown Comfort', 115.75, 3, 'Comfortable accommodations in the heart of Midtown Manhattan.'),
('New York', 'New York', 'Chelsea Lodge', 118.20, 3, 'A cozy lodge in Chelsea, close to restaurants and nightlife.'),
('New York', 'New York', 'Queens Retreat', 80.00, 2, 'A budget-friendly retreat in Queens, perfect for families.'),
('New York', 'New York', 'Bronx Budget', 75.30, 2, 'Affordable lodging in the vibrant Bronx borough.'),
('New York', 'New York', 'Harlem Haven', 78.15, 2, 'A welcoming haven in the culturally rich Harlem neighborhood.'),
('New York', 'New York', 'NYC Basic', 55.00, 1, 'Simple accommodations for travelers on a tight budget.'),
('New York', 'New York', 'Downtown Dorm', 50.25, 1, 'A no-frills dorm-style stay in Lower Manhattan.'),
('New York', 'New York', 'Uptown Sleep', 52.80, 1, 'Basic lodging in Uptown Manhattan, close to public transit.'),

-- Dubai (15 hotels)
('Dubai', 'Dubai', 'Burj Al Arab Stay', 500.00, 5, 'Experience unparalleled luxury at the iconic Burj Al Arab.'),
('Dubai', 'Dubai', 'Desert Rose Resort', 510.50, 5, 'A lavish resort inspired by the beauty of the Arabian desert.'),
('Dubai', 'Dubai', 'Palm Jumeirah Lux', 505.75, 5, 'Stay in style on the man-made Palm Jumeirah island.'),
('Dubai', 'Dubai', 'Sheikh Zayed Inn', 300.00, 4, 'A sophisticated inn near the majestic Sheikh Zayed Road.'),
('Dubai', 'Dubai', 'Dubai Marina Rest', 295.25, 4, 'Relax in the upscale Dubai Marina district.'),
('Dubai', 'Dubai', 'JBR Beach Hotel', 298.90, 4, 'A beachfront hotel in the popular Jumeirah Beach Residence area.'),
('Dubai', 'Dubai', 'Old Dubai Charm', 180.50, 3, 'Discover the charm of Old Dubai at this affordable hotel.'),
('Dubai', 'Dubai', 'Souk Stay', 175.75, 3, 'A vibrant stay near the traditional souks of Deira.'),
('Dubai', 'Dubai', 'Deira Comfort', 178.20, 3, 'Comfortable accommodations in the bustling Deira district.'),
('Dubai', 'Dubai', 'Budget Oasis', 100.00, 2, 'A budget-friendly oasis in the heart of Dubai.'),
('Dubai', 'Dubai', 'Al Barsha Lodge', 95.30, 2, 'A cozy lodge in the Al Barsha neighborhood, close to malls.'),
('Dubai', 'Dubai', 'City Walk Rest', 98.15, 2, 'A modern rest stop in the trendy City Walk area.'),
('Dubai', 'Dubai', 'Simple Dubai', 70.00, 1, 'Basic lodging for travelers seeking simplicity and affordability.'),
('Dubai', 'Dubai', 'Hostel Sands', 65.25, 1, 'A lively hostel near the golden sands of Dubai''s beaches.'),
('Dubai', 'Dubai', 'Desert Dorm', 68.80, 1, 'A budget dormitory-style stay for adventurers exploring the desert.'),

-- London (15 hotels)
('London', 'London', 'The Shard View', 180.00, 5, 'Enjoy panoramic views of London from this hotel near The Shard.'),
('London', 'London', 'Buckingham Palace Inn', 185.50, 5, 'A regal inn located steps away from Buckingham Palace.'),
('London', 'London', 'Westminster Lux', 182.75, 5, 'Luxurious accommodations in the historic Westminster area.'),
('London', 'London', 'Covent Garden Stay', 140.00, 4, 'A stylish stay in the vibrant Covent Garden district.'),
('London', 'London', 'Thames Riverside', 135.25, 4, 'Relax by the Thames River at this serene hotel.'),
('London', 'London', 'Kensington Rest', 138.90, 4, 'A refined retreat in the upscale Kensington neighborhood.'),
('London', 'London', 'Soho Comfort', 100.50, 3, 'Comfortable accommodations in the lively Soho area.'),
('London', 'London', 'Camden Lodge', 95.75, 3, 'A cozy lodge in the eclectic Camden Town district.'),
('London', 'London', 'Shoreditch Inn', 98.20, 3, 'A trendy inn in the artsy Shoreditch neighborhood.'),
('London', 'London', 'East End Budget', 70.00, 2, 'Affordable lodging in London''s historic East End.'),
('London', 'London', 'Brixton Stay', 65.30, 2, 'A simple stay in the multicultural Brixton area.'),
('London', 'London', 'Hackney Haven', 68.15, 2, 'A welcoming haven in the creative Hackney district.'),
('London', 'London', 'Simple London', 50.00, 1, 'No-frills accommodations for budget-conscious travelers.'),
('London', 'London', 'Hostel Thames', 45.25, 1, 'A lively hostel near the scenic Thames River.'),
('London', 'London', 'City Dorm', 48.80, 1, 'Basic dormitory-style lodging in central London.'),

-- Istanbul (15 hotels)
('Istanbul', 'Istanbul', 'Hagia Sophia Lux', 120.00, 5, 'Luxury accommodations near the historic Hagia Sophia.'),
('Istanbul', 'Istanbul', 'Bosphorus Bliss', 125.50, 5, 'A blissful stay with stunning views of the Bosphorus Strait.'),
('Istanbul', 'Istanbul', 'Sultanahmet Stay', 122.75, 5, 'A lavish stay in the heart of the Sultanahmet district.'),
('Istanbul', 'Istanbul', 'Grand Bazaar Inn', 90.00, 4, 'A charming inn steps away from the bustling Grand Bazaar.'),
('Istanbul', 'Istanbul', 'Taksim Square Rest', 85.25, 4, 'Relax in style at this hotel near Taksim Square.'),
('Istanbul', 'Istanbul', 'Galata Tower View', 88.90, 4, 'Enjoy panoramic views of Galata Tower from this hotel.'),
('Istanbul', 'Istanbul', 'Beyoglu Comfort', 65.50, 3, 'Comfortable accommodations in the vibrant Beyoglu district.'),
('Istanbul', 'Istanbul', 'Uskudar Lodge', 60.75, 3, 'A cozy lodge on the Asian side of Istanbul.'),
('Istanbul', 'Istanbul', 'Kadikoy Stay', 63.20, 3, 'A trendy stay in the lively Kadikoy neighborhood.'),
('Istanbul', 'Istanbul', 'Budget Bazaar', 45.00, 2, 'Affordable lodging near Istanbul''s famous bazaars.'),
('Istanbul', 'Istanbul', 'Old City Rest', 40.30, 2, 'A simple rest stop in the historic Old City.'),
('Istanbul', 'Istanbul', 'Simple Istanbul', 42.15, 2, 'Basic accommodations for travelers on a budget.'),
('Istanbul', 'Istanbul', 'Hostel Spice', 30.00, 1, 'A lively hostel with a focus on cultural exchange.'),
('Istanbul', 'Istanbul', 'Dorm Bosphorus', 25.25, 1, 'A budget dormitory-style stay near the Bosphorus.'),
('Istanbul', 'Istanbul', 'Basic Sultan', 28.80, 1, 'No-frills lodging in the Sultanahmet district.'),

-- Rome (15 hotels)
('Rome', 'Rome', 'Colosseum Lux', 140.00, 5, 'Luxurious accommodations with views of the ancient Colosseum.'),
('Rome', 'Rome', 'Vatican View', 145.50, 5, 'A regal hotel offering stunning views of the Vatican City.'),
('Rome', 'Rome', 'Pantheon Palace', 142.75, 5, 'Stay in style at this palace hotel near the Pantheon.'),
('Rome', 'Rome', 'Trastevere Inn', 110.00, 4, 'A charming inn in the bohemian Trastevere district.'),
('Rome', 'Rome', 'Spanish Steps Stay', 105.25, 4, 'A stylish stay near the iconic Spanish Steps.'),
('Rome', 'Rome', 'Piazza Navona Rest', 108.90, 4, 'Relax in the heart of Rome at this hotel near Piazza Navona.'),
('Rome', 'Rome', 'Campo de Fiori', 80.50, 3, 'A cozy hotel in the lively Campo de Fiori area.'),
('Rome', 'Rome', 'Roman Forum Lodge', 75.75, 3, 'A historic lodge near the ancient Roman Forum.'),
('Rome', 'Rome', 'Testaccio Comfort', 78.20, 3, 'Comfortable accommodations in the foodie-friendly Testaccio district.'),
('Rome', 'Rome', 'Budget Roma', 55.00, 2, 'Affordable lodging for travelers exploring Rome.'),
('Rome', 'Rome', 'Esquilino Rest', 50.30, 2, 'A simple rest stop in the Esquilino neighborhood.'),
('Rome', 'Rome', 'Simple Rome', 52.15, 2, 'Basic accommodations for budget-conscious travelers.'),
('Rome', 'Rome', 'Hostel Tiber', 40.00, 1, 'A lively hostel near the Tiber River.'),
('Rome', 'Rome', 'Dorm Italia', 35.25, 1, 'A budget dormitory-style stay in central Rome.'),
('Rome', 'Rome', 'Basic Roman', 38.80, 1, 'No-frills lodging for travelers seeking simplicity.'),

-- Madrid (15 hotels)
('Madrid', 'Madrid', 'Plaza Mayor Lux', 130.00, 5, 'Luxurious accommodations in the heart of Plaza Mayor.'),
('Madrid', 'Madrid', 'Royal Palace Inn', 135.50, 5, 'A regal inn located near the majestic Royal Palace.'),
('Madrid', 'Madrid', 'Gran Via Stay', 132.75, 5, 'Stay in style on Madrid''s famous Gran Via street.'),
('Madrid', 'Madrid', 'Retiro Park Rest', 100.00, 4, 'Relax in the serene Retiro Park district.'),
('Madrid', 'Madrid', 'Prado Museum View', 95.25, 4, 'A stylish hotel near the world-renowned Prado Museum.'),
('Madrid', 'Madrid', 'Sol Comfort', 98.90, 4, 'Comfortable accommodations in the bustling Sol area.'),
('Madrid', 'Madrid', 'Chueca Lodge', 70.50, 3, 'A cozy lodge in the vibrant Chueca neighborhood.'),
('Madrid', 'Madrid', 'Lavapies Stay', 65.75, 3, 'A trendy stay in the multicultural Lavapies district.'),
('Madrid', 'Madrid', 'Malasana Inn', 68.20, 3, 'A hip inn in the bohemian Malasana area.'),
('Madrid', 'Madrid', 'Budget Madrid', 50.00, 2, 'Affordable lodging for travelers exploring Madrid.'),
('Madrid', 'Madrid', 'Atocha Rest', 45.30, 2, 'A simple rest stop near Atocha Train Station.'),
('Madrid', 'Madrid', 'Simple Spain', 48.15, 2, 'Basic accommodations for budget-conscious travelers.'),
('Madrid', 'Madrid', 'Hostel Plaza', 35.00, 1, 'A lively hostel in the heart of Madrid.'),
('Madrid', 'Madrid', 'Dorm Madrid', 30.25, 1, 'A budget dormitory-style stay for backpackers.'),
('Madrid', 'Madrid', 'Basic Espana', 33.80, 1, 'No-frills lodging for travelers seeking simplicity.'),

-- Tokyo (15 hotels)
('Tokyo', 'Tokyo', 'Shibuya Sky Lux', 200.00, 5, 'Luxurious accommodations with stunning views of Shibuya Sky.'),
('Tokyo', 'Tokyo', 'Asakusa Bliss', 205.50, 5, 'A blissful stay in the historic Asakusa district.'),
('Tokyo', 'Tokyo', 'Ginza Palace', 202.75, 5, 'Stay in style at this palace hotel in the upscale Ginza area.'),
('Tokyo', 'Tokyo', 'Shinjuku Inn', 150.00, 4, 'A stylish inn in the bustling Shinjuku district.'),
('Tokyo', 'Tokyo', 'Akihabara Rest', 145.25, 4, 'Relax in the tech-savvy Akihabara neighborhood.'),
('Tokyo', 'Tokyo', 'Roppongi Stay', 148.90, 4, 'A trendy stay in the lively Roppongi district.'),
('Tokyo', 'Tokyo', 'Ueno Comfort', 100.50, 3, 'Comfortable accommodations near Ueno Park.'),
('Tokyo', 'Tokyo', 'Harajuku Lodge', 95.75, 3, 'A cozy lodge in the fashionable Harajuku area.'),
('Tokyo', 'Tokyo', 'Ikebukuro Inn', 98.20, 3, 'A vibrant inn in the bustling Ikebukuro district.'),
('Tokyo', 'Tokyo', 'Budget Tokyo', 70.00, 2, 'Affordable lodging for travelers exploring Tokyo.'),
('Tokyo', 'Tokyo', 'Odaiba Rest', 65.30, 2, 'A simple rest stop in the futuristic Odaiba area.'),
('Tokyo', 'Tokyo', 'Simple Japan', 68.15, 2, 'Basic accommodations for budget-conscious travelers.'),
('Tokyo', 'Tokyo', 'Hostel Sakura', 50.00, 1, 'A lively hostel inspired by Japan''s cherry blossoms.'),
('Tokyo', 'Tokyo', 'Dorm Tokyo', 45.25, 1, 'A budget dormitory-style stay for backpackers.'),
('Tokyo', 'Tokyo', 'Basic Nihon', 48.80, 1, 'No-frills lodging for travelers seeking simplicity.'),

-- Beijing (15 hotels)
('Beijing', 'Beijing', 'Forbidden City Lux', 150.00, 5, 'Luxurious accommodations near the historic Forbidden City.'),
('Beijing', 'Beijing', 'Great Wall Inn', 155.50, 5, 'A regal inn offering proximity to the Great Wall of China.'),
('Beijing', 'Beijing', 'Tiananmen Stay', 152.75, 5, 'Stay in style near Tiananmen Square.'),
('Beijing', 'Beijing', 'Wangfujing Rest', 110.00, 4, 'Relax in the bustling Wangfujing shopping district.'),
('Beijing', 'Beijing', 'Hutong Haven', 105.25, 4, 'A cozy haven in Beijing''s traditional hutong neighborhoods.'),
('Beijing', 'Beijing', 'Sanlitun Comfort', 108.90, 4, 'Comfortable accommodations in the trendy Sanlitun area.'),
('Beijing', 'Beijing', 'Dongcheng Lodge', 80.50, 3, 'A cozy lodge in the Dongcheng district.'),
('Beijing', 'Beijing', 'Xicheng Stay', 75.75, 3, 'A simple stay in the historic Xicheng area.'),
('Beijing', 'Beijing', 'Chaoyang Inn', 78.20, 3, 'A vibrant inn in the modern Chaoyang district.'),
('Beijing', 'Beijing', 'Budget Beijing', 55.00, 2, 'Affordable lodging for travelers exploring Beijing.'),
('Beijing', 'Beijing', 'Shijingshan Rest', 50.30, 2, 'A basic rest stop in the Shijingshan district.'),
('Beijing', 'Beijing', 'Simple China', 52.15, 2, 'No-frills accommodations for budget-conscious travelers.'),
('Beijing', 'Beijing', 'Hostel Dragon', 40.00, 1, 'A lively hostel inspired by Chinese dragon culture.'),
('Beijing', 'Beijing', 'Dorm Peking', 35.25, 1, 'A budget dormitory-style stay in Beijing.'),
('Beijing', 'Beijing', 'Basic Zhongguo', 38.80, 1, 'Simple lodging for travelers seeking affordability.'),

-- Sydney (15 hotels)
('Sydney', 'Sydney', 'Opera House Lux', 220.00, 5, 'Luxurious accommodations with stunning views of the Sydney Opera House.'),
('Sydney', 'Sydney', 'Harbour Bridge Inn', 225.50, 5, 'A regal inn offering proximity to the iconic Harbour Bridge.'),
('Sydney', 'Sydney', 'Bondi Beach Stay', 222.75, 5, 'Stay in style near the world-famous Bondi Beach.'),
('Sydney', 'Sydney', 'Darling Harbour Rest', 170.00, 4, 'Relax in the vibrant Darling Harbour area.'),
('Sydney', 'Sydney', 'The Rocks Haven', 165.25, 4, 'A historic haven in the charming Rocks district.'),
('Sydney', 'Sydney', 'Surry Hills Comfort', 168.90, 4, 'Comfortable accommodations in the trendy Surry Hills neighborhood.'),
('Sydney', 'Sydney', 'Paddington Lodge', 120.50, 3, 'A cozy lodge in the upscale Paddington area.'),
('Sydney', 'Sydney', 'Newtown Stay', 115.75, 3, 'A vibrant stay in the eclectic Newtown district.'),
('Sydney', 'Sydney', 'Manly Inn', 118.20, 3, 'A stylish inn near the beautiful Manly Beach.'),
('Sydney', 'Sydney', 'Budget Sydney', 80.00, 2, 'Affordable lodging for travelers exploring Sydney.'),
('Sydney', 'Sydney', 'Kings Cross Rest', 75.30, 2, 'A simple rest stop in the lively Kings Cross area.'),
('Sydney', 'Sydney', 'Simple Aussie', 78.15, 2, 'Basic accommodations for budget-conscious travelers.'),
('Sydney', 'Sydney', 'Hostel Outback', 60.00, 1, 'A lively hostel inspired by Australia''s outback culture.'),
('Sydney', 'Sydney', 'Dorm Down Under', 55.25, 1, 'A budget dormitory-style stay for backpackers.'),
('Sydney', 'Sydney', 'Basic Sydney', 58.80, 1, 'No-frills lodging for travelers seeking simplicity.'),

-- Riyadh (15 hotels)
('Riyadh', 'Riyadh', 'Kingdom Centre Lux', 250.00, 5, 'Luxurious accommodations in the iconic Kingdom Centre tower.'),
('Riyadh', 'Riyadh', 'Al Rajhi Stay', 255.50, 5, 'A regal stay near the prestigious Al Rajhi Mosque.'),
('Riyadh', 'Riyadh', 'Riyadh Season Inn', 252.75, 5, 'Stay in style during Riyadh''s vibrant entertainment season.'),
('Riyadh', 'Riyadh', 'Olaya Street Rest', 180.00, 4, 'Relax in the upscale Olaya Street district.'),
('Riyadh', 'Riyadh', 'Diriyah Haven', 175.25, 4, 'A serene haven near the historic Diriyah area.'),
('Riyadh', 'Riyadh', 'Al Malaz Comfort', 178.90, 4, 'Comfortable accommodations in the Al Malaz neighborhood.'),
('Riyadh', 'Riyadh', 'Sulaimaniyah Lodge', 120.50, 3, 'A cozy lodge in the Sulaimaniyah district.'),
('Riyadh', 'Riyadh', 'Al Wizarat Stay', 115.75, 3, 'A simple stay near the government ministries area.'),
('Riyadh', 'Riyadh', 'Al Murabba Inn', 118.20, 3, 'A charming inn in the Al Murabba district.'),
('Riyadh', 'Riyadh', 'Budget Riyadh', 80.00, 2, 'Affordable lodging for travelers exploring Riyadh.'),
('Riyadh', 'Riyadh', 'Al Naseem Rest', 75.30, 2, 'A basic rest stop in the Al Naseem area.'),
('Riyadh', 'Riyadh', 'Simple Saudi', 78.15, 2, 'No-frills accommodations for budget-conscious travelers.'),
('Riyadh', 'Riyadh', 'Hostel Desert', 60.00, 1, 'A lively hostel inspired by Saudi Arabia''s desert culture.'),
('Riyadh', 'Riyadh', 'Dorm Riyadh', 55.25, 1, 'A budget dormitory-style stay for backpackers.'),
('Riyadh', 'Riyadh', 'Basic Arabia', 58.80, 1, 'Simple lodging for travelers seeking affordability.'),

-- Ottawa (15 hotels)
('Ottawa', 'Ottawa', 'Parliament Hill Lux', 160.00, 5, 'Luxurious accommodations with stunning views of Parliament Hill.'),
('Ottawa', 'Ottawa', 'Rideau Canal Inn', 165.50, 5, 'A regal inn located near the scenic Rideau Canal.'),
('Ottawa', 'Ottawa', 'ByWard Market Stay', 162.75, 5, 'Stay in style in the vibrant ByWard Market district.'),
('Ottawa', 'Ottawa', 'Westboro Rest', 120.00, 4, 'Relax in the trendy Westboro neighborhood.'),
('Ottawa', 'Ottawa', 'Gatineau Haven', 115.25, 4, 'A serene haven across the river in Gatineau.'),
('Ottawa', 'Ottawa', 'Centretown Comfort', 118.90, 4, 'Comfortable accommodations in the heart of Centretown.'),
('Ottawa', 'Ottawa', 'Sandy Hill Lodge', 80.50, 3, 'A cozy lodge in the student-friendly Sandy Hill area.'),
('Ottawa', 'Ottawa', 'The Glebe Stay', 75.75, 3, 'A vibrant stay in the lively Glebe neighborhood.'),
('Ottawa', 'Ottawa', 'Ottawa River Inn', 78.20, 3, 'A charming inn with views of the Ottawa River.'),
('Ottawa', 'Ottawa', 'Budget Ottawa', 60.00, 2, 'Affordable lodging for travelers exploring Ottawa.'),
('Ottawa', 'Ottawa', 'Vanier Rest', 55.30, 2, 'A simple rest stop in the Vanier district.'),
('Ottawa', 'Ottawa', 'Simple Canada', 58.15, 2, 'Basic accommodations for budget-conscious travelers.'),
('Ottawa', 'Ottawa', 'Hostel Maple', 45.00, 1, 'A lively hostel inspired by Canadian maple culture.'),
('Ottawa', 'Ottawa', 'Dorm Ottawa', 40.25, 1, 'A budget dormitory-style stay for backpackers.'),
('Ottawa', 'Ottawa', 'Basic North', 43.80, 1, 'No-frills lodging for travelers seeking simplicity.');
INSERT INTO conference_location (name, city, address, capacity, price_per_day)
VALUES
-- Paris (7 venues)
('Paris Convention Center', 'Paris', '2 Place de la Porte Maillot, 75017 Paris, France', 500, 1500.00),
('Eiffel Summit Hall', 'Paris', 'Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France', 300, 1200.50),
('Louvre Conference Space', 'Paris', 'Rue de Rivoli, 75001 Paris, France', 200, 900.75),
('Seine Riverside Venue', 'Paris', 'Quai de la Tournelle, 75005 Paris, France', 150, 750.00),
('Montmartre Meeting Room', 'Paris', 'Place du Tertre, 75018 Paris, France', 100, 600.25),
('Champs Elysees Forum', 'Paris', 'Avenue des Champs-Élysées, 75008 Paris, France', 80, 500.50),
('Parisian Expo Hall', 'Paris', '1 Place de la Porte de Versailles, 75015 Paris, France', 400, 1300.00),

-- New York (7 venues)
('NYC Grand Hall', 'New York', '655 W 34th St, New York, NY 10001, USA', 600, 2000.00),
('Times Square Events', 'New York', '1567 Broadway, New York, NY 10036, USA', 350, 1600.50),
('Manhattan Summit', 'New York', 'Central Park S, New York, NY 10019, USA', 250, 1400.75),
('Brooklyn Conference Hub', 'New York', '1000 Surf Ave, Brooklyn, NY 11224, USA', 180, 1100.00),
('Hudson Meeting Space', 'New York', '455 W 18th St, New York, NY 10011, USA', 120, 850.25),
('Central Park Venue', 'New York', 'Central Park Conservancy, New York, NY 10023, USA', 90, 700.50),
('Empire Expo Center', 'New York', '31st St & 12th Ave, New York, NY 10001, USA', 450, 1800.00),

-- Dubai (7 venues)
('Dubai World Forum', 'Dubai', 'Dubai Internet City, Dubai, United Arab Emirates', 700, 2500.00),
('Burj Conference Suite', 'Dubai', '1 Sheikh Mohammed bin Rashid Blvd, Dubai, United Arab Emirates', 400, 2000.50),
('Palm Jumeirah Hall', 'Dubai', 'Crescent Rd - Palm Jumeirah, Dubai, United Arab Emirates', 300, 1700.75),
('Desert Oasis Venue', 'Dubai', 'Al Qudra Rd, Dubai, United Arab Emirates', 200, 1400.00),
('Marina Meeting Center', 'Dubai', 'Dubai Marina Walk, Dubai, United Arab Emirates', 150, 1100.25),
('Sheikh Zayed Space', 'Dubai', 'Sheikh Zayed Rd, Dubai, United Arab Emirates', 100, 900.50),
('Dubai Expo Pavilion', 'Dubai', 'Expo Road, Dubai South, Dubai, United Arab Emirates', 500, 2200.00),

-- London (7 venues)
('London Excel Center', 'London', 'Royal Victoria Dock, 1 Western Gateway, London E16 1XL, UK', 550, 1800.00),
('Thames Riverside Hall', 'London', 'South Bank, London SE1 7PB, UK', 320, 1500.50),
('Westminster Summit', 'London', 'Parliament Square, London SW1P 3JX, UK', 220, 1300.75),
('Covent Garden Venue', 'London', 'Covent Garden Piazza, London WC2E 8RF, UK', 160, 1000.00),
('Kensington Conference', 'London', 'Kensington High St, London W8 5SA, UK', 110, 800.25),
('Soho Meeting Room', 'London', 'Soho Square, London W1D 3QF, UK', 85, 650.50),
('City of London Expo', 'London', 'Guildhall Yard, London EC2V 5AE, UK', 400, 1600.00),

-- Istanbul (7 venues)
('Bosphorus Grand Hall', 'Istanbul', 'Ortaköy Mahallesi, Çırağan Cd., 34349 Beşiktaş/İstanbul, Turkey', 450, 1200.00),
('Hagia Sophia Venue', 'Istanbul', 'Ayasofya Meydanı, Sultanahmet, 34122 Fatih/İstanbul, Turkey', 280, 1000.50),
('Taksim Conference Hub', 'Istanbul', 'Taksim Sq, Gümüşsuyu, Beyoğlu/İstanbul, Turkey', 200, 850.75),
('Sultanahmet Space', 'Istanbul', 'Alemdar Mh., Divanyolu Cd., 34122 Fatih/İstanbul, Turkey', 140, 700.00),
('Galata Meeting Room', 'Istanbul', 'Galata Tower, Bereketzade Mh., 34421 Beyoğlu/İstanbul, Turkey', 100, 550.25),
('Beyoglu Forum', 'Istanbul', 'İstiklal Cd., 34430 Beyoğlu/İstanbul, Turkey', 80, 450.50),
('Istanbul Expo Center', 'Istanbul', 'Yeşilköy Mh., Havaalanı Yolu Cd., 34149 Bakırköy/İstanbul, Turkey', 350, 1100.00),

-- Rome (7 venues)
('Rome Congress Hall', 'Rome', 'Piazza della Repubblica, 00185 Roma RM, Italy', 400, 1300.00),
('Colosseum Events', 'Rome', 'Piazza del Colosseo, 00184 Roma RM, Italy', 250, 1100.50),
('Vatican Summit Space', 'Rome', 'St. Peter''s Square, Vatican City', 180, 950.75),
('Trastevere Venue', 'Rome', 'Piazza di Santa Maria in Trastevere, 00153 Roma RM, Italy', 130, 800.00),
('Pantheon Meeting Room', 'Rome', 'Piazza della Rotonda, 00186 Roma RM, Italy', 90, 650.25),
('Piazza Navona Hall', 'Rome', 'Piazza Navona, 00186 Roma RM, Italy', 70, 500.50),
('Roman Forum Expo', 'Rome', 'Via della Salara Vecchia, 00186 Roma RM, Italy', 300, 1200.00),

-- Madrid (7 venues)
('Madrid Arena', 'Madrid', 'Av. de Portugal, s/n, 28011 Madrid, Spain', 420, 1400.00),
('Plaza Mayor Hall', 'Madrid', 'Plaza Mayor, 28012 Madrid, Spain', 260, 1200.50),
('Retiro Conference Space', 'Madrid', 'Parque del Retiro, 28009 Madrid, Spain', 190, 1000.75),
('Gran Via Venue', 'Madrid', 'Gran Vía, 28013 Madrid, Spain', 140, 850.00),
('Prado Meeting Center', 'Madrid', 'Calle de Ruiz de Alarcón, 23, 28014 Madrid, Spain', 100, 700.25),
('Sol Forum', 'Madrid', 'Puerta del Sol, 28013 Madrid, Spain', 80, 550.50),
('Madrid Expo Pavilion', 'Madrid', 'Campo de las Naciones, 28042 Madrid, Spain', 340, 1300.00),

-- Tokyo (7 venues)
('Tokyo International Forum', 'Tokyo', '3-5-1 Marunouchi, Chiyoda City, Tokyo 100-0001, Japan', 600, 2000.00),
('Shinjuku Summit Hall', 'Tokyo', '1 Chome-19-1 Kabukicho, Shinjuku City, Tokyo 160-0021, Japan', 350, 1700.50),
('Ginza Conference Space', 'Tokyo', '4 Chome-2-12 Ginza, Chuo City, Tokyo 104-0061, Japan', 250, 1500.75),
('Akihabara Venue', 'Tokyo', '4 Chome-3-3 Sotokanda, Chiyoda City, Tokyo 101-0021, Japan', 180, 1200.00),
('Shibuya Meeting Room', 'Tokyo', '2 Chome-21-1 Shibuya, Shibuya City, Tokyo 150-0002, Japan', 120, 950.25),
('Roppongi Events', 'Tokyo', '6 Chome-10-1 Roppongi, Minato City, Tokyo 106-0032, Japan', 90, 800.50),
('Tokyo Expo Center', 'Tokyo', '3 Chome-11-1 Ariake, Koto City, Tokyo 135-0063, Japan', 450, 1800.00),

-- Beijing (7 venues)
('Beijing National Hall', 'Beijing', 'No. 1 Fuxing Road, Haidian District, Beijing, China', 500, 1600.00),
('Forbidden City Venue', 'Beijing', '4 Jingshan Front St, Dongcheng District, Beijing, China', 300, 1400.50),
('Tiananmen Summit', 'Beijing', 'Tiananmen Square, Dongcheng District, Beijing, China', 220, 1200.75),
('Wangfujing Space', 'Beijing', 'Wangfujing Street, Dongcheng District, Beijing, China', 160, 1000.00),
('Hutong Conference', 'Beijing', 'Nanluoguxiang, Dongcheng District, Beijing, China', 110, 850.25),
('Sanlitun Meeting Room', 'Beijing', 'Sanlitun Road, Chaoyang District, Beijing, China', 85, 700.50),
('Beijing Expo Pavilion', 'Beijing', 'Yicheng Road, Fengtai District, Beijing, China', 400, 1500.00),

-- Sydney (7 venues)
('Sydney Convention Centre', 'Sydney', '14 Darling Dr, Sydney NSW 2000, Australia', 550, 1900.00),
('Opera House Events', 'Sydney', 'Bennelong Point, Sydney NSW 2000, Australia', 320, 1600.50),
('Harbour Bridge Hall', 'Sydney', 'Milsons Point NSW 2061, Australia', 240, 1400.75),
('Bondi Beach Venue', 'Sydney', 'Campbell Parade, Bondi Beach NSW 2026, Australia', 170, 1100.00),
('Darling Harbour Space', 'Sydney', '2 Murray St, Pyrmont NSW 2009, Australia', 120, 900.25),
('The Rocks Forum', 'Sydney', 'The Rocks NSW 2000, Australia', 90, 750.50),
('Sydney Expo Hall', 'Sydney', '1 Atchison St, St Leonards NSW 2065, Australia', 420, 1700.00),

-- Riyadh (7 venues)
('Riyadh Conference Palace', 'Riyadh', 'King Fahd Rd, Al Olaya, Riyadh 12212, Saudi Arabia', 600, 2200.00),
('Kingdom Centre Hall', 'Riyadh', 'King Fahd Rd, Al Olaya, Riyadh 12311, Saudi Arabia', 350, 1800.50),
('Olaya Summit Space', 'Riyadh', 'Olaya Street, Al Olaya, Riyadh 12212, Saudi Arabia', 250, 1500.75),
('Diriyah Venue', 'Riyadh', 'Diriyah, Riyadh 13711, Saudi Arabia', 180, 1200.00),
('Al Malaz Meeting Room', 'Riyadh', 'Al Malaz, Riyadh 12823, Saudi Arabia', 130, 950.25),
('Sulaimaniyah Events', 'Riyadh', 'Sulaimaniyah, Riyadh 12311, Saudi Arabia', 100, 800.50),
('Riyadh Expo Center', 'Riyadh', 'Exit 9, King Khalid Rd, Riyadh 13211, Saudi Arabia', 450, 2000.00),

-- Ottawa (7 venues)
('Ottawa Congress Centre', 'Ottawa', '55 Colonel By Dr, Ottawa, ON K1N 9J2, Canada', 400, 1500.00),
('Parliament Hill Hall', 'Ottawa', 'Wellington St, Ottawa, ON K1A 0A9, Canada', 250, 1300.50),
('Rideau Canal Venue', 'Ottawa', 'Rideau Canal Eastern Pathway, Ottawa, ON K1S 5B6, Canada', 180, 1100.75),
('ByWard Market Space', 'Ottawa', 'ByWard Market Square, Ottawa, ON K1N 7X7, Canada', 140, 900.00),
('Centretown Meeting Room', 'Ottawa', 'Somerset St W, Ottawa, ON K2P 0J8, Canada', 100, 750.25),
('Westboro Forum', 'Ottawa', 'Richmond Rd, Ottawa, ON K2A 0A8, Canada', 80, 600.50),
('Ottawa Expo Pavilion', 'Ottawa', '250 City Centre Ave, Ottawa, ON K1R 6K7, Canada', 320, 1400.00);
INSERT INTO transport (type, price, description)
VALUES
-- Public Transport
('Bus', 2.50, 'Affordable public bus service with routes across the city.'),
('Subway', 3.00, 'Fast and efficient subway system connecting major areas.'),
('Tram', 2.75, 'Convenient tram service ideal for short-distance travel.'),
('Ferry', 5.00, 'Scenic ferry rides for commuters near waterways.'),

-- Private Transport
('Taxi', 15.00, 'Convenient door-to-door taxi service available 24/7.'),
('Ride-Sharing', 12.50, 'Modern ride-sharing services like Uber or Lyft.'),
('Bicycle Rental', 8.00, 'Eco-friendly bicycle rental for urban exploration.'),
('Scooter Rental', 10.00, 'Electric scooter rentals for quick city commutes.'),

-- Luxury Transport
('Limousine', 100.00, 'Luxurious limousine service for special occasions.'),
('Private Car', 75.00, 'Comfortable private car service with a personal driver.'),
('Helicopter', 500.00, 'Exclusive helicopter transfers for rapid long-distance travel.'),
('Private Jet', 1000.00, 'High-end private jet service for international trips.'),

-- Specialized Transport
('Shuttle Bus', 20.00, 'Shared shuttle bus service for airport or event transfers.'),
('Tour Bus', 30.00, 'Guided tour buses for sightseeing excursions.'),
('Cargo Truck', 50.00, 'Heavy-duty cargo trucks for transporting goods.'),
('Delivery Van', 25.00, 'Compact delivery vans for local package delivery.');
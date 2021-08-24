/*Projekt Léon Lopetrone, Elia Schenker*/
DROP DATABASE IF EXISTS Triwago;
CREATE DATABASE Triwago;
USE Triwago;

/*Tabellen und Referenzen kreiren*/

CREATE TABLE Land(
  land_id SERIAL PRIMARY KEY,
  land_name VARCHAR(255)
);

CREATE TABLE Ort(
  ort_id SERIAL PRIMARY KEY,
  ort_name VARCHAR(255),
  plz SMALLINT,
  land_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY(land_id) REFERENCES Land(land_id) ON DELETE CASCADE
);

CREATE TABLE Sehenswuerdigkeit(
  sehenswuerdigkeit_id SERIAL PRIMARY KEY,
  sehenswuerdigkeit_name VARCHAR(255),
  ort_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY(ort_id) REFERENCES Ort(ort_id) ON DELETE CASCADE
);

CREATE TABLE Adresse(
  adresse_id SERIAL PRIMARY KEY,
  adresse VARCHAR(255),
  ort_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY(ort_id) REFERENCES Ort(ort_id) ON DELETE CASCADE
);

CREATE TABLE Kunde(
  kunde_id SERIAL PRIMARY KEY,
  vorname VARCHAR(255),
  nachname VARCHAR(255),
  adresse_id BIGINT UNSIGNED NOT NULL,
  age SMALLINT NOT NULL,
  telefonnummer VARCHAR(255),
  FOREIGN KEY(adresse_id) REFERENCES Adresse(adresse_id)
);

CREATE TABLE Besitzer(
  besitzer_id SERIAL PRIMARY KEY,
  vorname VARCHAR(255) NOT NULL,
  nachname VARCHAR(255) NOT NULL
);

CREATE TABLE Hotel(
  hotel_id SERIAL PRIMARY KEY,
  hotel_name VARCHAR(255) NOT NULL,
  adresse_id BIGINT UNSIGNED NOT NULL,
  besitzer_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (adresse_id) REFERENCES Adresse(adresse_id) ON DELETE CASCADE,
  FOREIGN KEY (besitzer_id) REFERENCES Besitzer(besitzer_id) ON DELETE CASCADE
);

CREATE TABLE Parkplatz(
  parkplatz_id SERIAL PRIMARY KEY,
  kunde_id BIGINT UNSIGNED NOT NULL,
  hotel_id BIGINT UNSIGNED NOT NULL,
  nummer SMALLINT NOT NULL,
  FOREIGN KEY(kunde_id) REFERENCES Kunde(kunde_id),
  FOREIGN KEY(hotel_id) REFERENCES Hotel(hotel_id)
);



CREATE TABLE Fahrzeug(
  fahrzeug_id SERIAL PRIMARY KEY,
  kennzeichen VARCHAR(255) NOT NULL,
  fahrzeug_art ENUM('Auto', 'Motorrad') NOT NULL,
  marke VARCHAR(255) NOT NULL
);

CREATE TABLE Flug(
  flug_id SERIAL PRIMARY KEY,
  datum DATE NOT NULL,
  economy_preis DECIMAL NOT NULL,
  first_preis DECIMAL NOT NULL,
  business_preis DECIMAL NOT NULL,
  ort_id_von BIGINT UNSIGNED NOT NULL,
  ort_id_bis BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (ort_id_von) REFERENCES Ort(ort_id) ON DELETE CASCADE,
  FOREIGN KEY (ort_id_bis) REFERENCES Ort(ort_id) ON DELETE CASCADE
);


CREATE TABLE Job(
  job_id SERIAL PRIMARY KEY,
  job_name VARCHAR(255) NOT NULL
);

CREATE TABLE Arbeiter(
  arbeiter_id SERIAL PRIMARY KEY,
  vorname VARCHAR(255) NOT NULL,
  nachname VARCHAR(255) NOT NULL,
  lohn DECIMAL NOT NULL,
  job_id BIGINT UNSIGNED NOT NULL,
  hotel_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (job_id) REFERENCES Job(job_id),
  FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id) ON DELETE CASCADE
);

CREATE TABLE Appartement(
  appartement_id SERIAL PRIMARY KEY,
  hotel_id BIGINT UNSIGNED NOT NULL,
  preis SMALLINT NOT NULL,
  zimmer_nummer SMALLINT NOT NULL UNIQUE,
  FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id) ON DELETE CASCADE
);

CREATE TABLE Buchung_Fahrzeug(
  buchung_fahrzeug_id SERIAL PRIMARY KEY,
  fahrzeug_id BIGINT UNSIGNED NOT NULL,
  kunde_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (fahrzeug_id) REFERENCES Fahrzeug(fahrzeug_id) ON DELETE CASCADE,
  FOREIGN KEY (kunde_id) REFERENCES Kunde(kunde_id) ON DELETE CASCADE
);

CREATE TABLE Buchung_Flug(
  buchung_flug_id SERIAL PRIMARY KEY,
  flug_id BIGINT UNSIGNED NOT NULL,
  kunde_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (flug_id) REFERENCES Flug(flug_id) ON DELETE CASCADE,
  FOREIGN KEY (kunde_id) REFERENCES Kunde(kunde_id) ON DELETE CASCADE
);

CREATE TABLE Bewertung(
  bewertung_id SERIAL PRIMARY KEY,
  hotel_id BIGINT UNSIGNED NOT NULL,
  kunde_id BIGINT UNSIGNED NOT NULL,
  stars INT(1) NOT NULL,
  bewertung_text VARCHAR(255),
  bewertung_datum DATE,
  FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id) ON DELETE CASCADE,
  FOREIGN KEY (kunde_id) REFERENCES Kunde(kunde_id) ON DELETE CASCADE
);

CREATE TABLE Buchung_hotel(
  buchung_hotel_id SERIAL PRIMARY KEY,
  anfangs_datum DATE NOT NULL,
  end_datum DATE NOT NULL,
  preis SMALLINT NOT NULL,
  kunde_id BIGINT UNSIGNED NOT NULL,
  appartement_id BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (appartement_id) REFERENCES Appartement(appartement_id) ON DELETE CASCADE,
  FOREIGN KEY (kunde_id) REFERENCES Kunde(kunde_id) ON DELETE CASCADE
);

/*Die Tabellen mit Daten füllen*/

INSERT INTO Land (land_name) VALUES('Abkhazia'), ('Afghanistan'), ('Akrotiri and Dhekelia'), ('Albania'), ('Algeria'), ('American Samoa'), ('Andorra'), ('Angola'), ('Anguilla'), ('Antigua and Barbuda'), ('Argentina'), ('Armenia'), ('Aruba'), ('Ascension Island'), ('Australia'),
('Austria'), ('Azerbaijan'), ('Bahamas'), ('Bahrain'), ('Bangladesh'), ('Barbados'), ('Belarus'), ('Belgium'), ('Belize'), ('Benin'), ('Bermuda'), ('Bhutan'), ('Bolivia'), ('Bolivia'), ('Bosnia and Herzegovina'),
('Botswana'), ('Brazil'), ('British Virgin Islands'), ('Brunei'), ('Bulgaria'), ('Burkina Faso'), ('Burundi'), ('Cambodia'), ('Cameroon'), ('Canada'), ('Cape Verde'), ('Cayman Islands'), ('Central African Republic'), ('Chad'), ('Chile'),
('China'), ('Christmas Island'), ('Cocos (Keeling) Islands'), ('Colombia'), ('Comoros'), ('Cook Islands'), ('Costa Rica'), ('Croatia'), ('Cuba'), ('Curacao'), ('Cyprus'), ('Czech Republic'), ('Cote dIvoire'), ('Democratic Republic of the Congo'), ('Denmark'),
('Djibouti'), ('Dominica'), ('Dominican Republic'), ('East Timor Timor-Leste'), ('Easter Island'), ('Ecuador'), ('Egypt'), ('El Salvador'), ('Equatorial Guinea'), ('Eritrea'), ('Estonia'), ('Ethiopia'), ('Falkland Islands'), ('Faroe Islands'), ('Federated States of Micronesia'),
('Fiji'), ('Finland'), ('France'), ('French Guiana'), ('French Polynesia'), ('Gabon'), ('Gambia'), ('Georgia'), ('Germany'), ('Ghana'), ('Gibraltar'), ('Greece'), ('Greenland'), ('Grenada'), ('Guam'),
('Guatemala'), ('Guernsey'), ('Guinea'), ('Guinea-Bissau'), ('Guyana'), ('Haiti'), ('Honduras'), ('Hungary'), ('Iceland'), ('India'), ('Indonesia'), ('Iran'), ('Iraq'), ('Ireland'), ('Isle of Man'),
('Israel'), ('Italy'), ('Jamaica'), ('Japan'), ('Jersey'), ('Jordan'), ('Kazakhstan'), ('Kenya'), ('Kiribati'), ('Kosovo'), ('Kuwait'), ('Kyrgyzstan'), ('Laos'), ('Latvia'), ('Lebanon'),
('Lesotho'), ('Liberia'), ('Libya'), ('Liechtenstein'), ('Lithuania'), ('Luxembourg'), ('Macedonia'), ('Madagascar'), ('Malawi'), ('Malaysia'), ('Maldives'), ('Mali'), ('Malta'), ('Marshall Islands'), ('Mauritania'),
('Mauritius'), ('Mexico'), ('Moldova'), ('Monaco'), ('Mongolia'), ('Montenegro'), ('Montserrat'), ('Morocco'), ('Mozambique'), ('Myanmar'), ('Nagorno-Karabakh Republic'), ('Namibia'), ('Nauru'), ('Nepal'), ('Netherlands'),
('New Caledonia'), ('New Zealand'), ('Nicaragua'), ('Niger'), ('Nigeria'), ('Niue'), ('Norfolk Island'), ('North Korea'), ('Northern Cyprus'), ('United Kingdom Northern Ireland'), ('Northern Mariana Islands'), ('Norway'), ('Oman'), ('Pakistan'), ('Palau'),
('Palestine'), ('Panama'), ('Papua New Guinea'), ('Paraguay'), ('Peru'), ('Philippines'), ('Pitcairn Islands'), ('Poland'), ('Portugal'), ('Puerto Rico'), ('Qatar'), ('Republic of China (Taiwan)'), ('Republic of the Congo'), ('Romania'), ('Russia'),
('Rwanda'), ('Saint Barthelemy'), ('Saint Helena'), ('Saint Kitts and Nevis'), ('Saint Lucia'), ('Saint Martin'), ('Saint Pierre and Miquelon'), ('Saint Vincent and the Grenadines'), ('Samoa'), ('San Marino'), ('Saudi Arabia'), ('Scotland'), ('Senegal'), ('Serbia'), ('Seychelles'),
('Sierra Leone'), ('Singapore'), ('Sint Maarten'), ('Slovakia'), ('Slovenia'), ('Solomon Islands'), ('Somalia'), ('Somaliland'), ('South Africa'), ('South Georgia and the South Sandwich Islands'), ('South Korea'), ('South Ossetia'), ('South Sudan'), ('Spain'), ('Sri Lanka'),
('Sudan'), ('Suriname'), ('Swaziland'), ('Sweden'), ('Switzerland'), ('Syria'), ('Sao Tome and Principe'), ('Tajikistan'), ('Tanzania'), ('Thailand'), ('Togo'), ('Tonga'), ('Transnistria'), ('Trinidad and Tobago'), ('Tristan da Cunha'),
('Tunisia'), ('Turkey'), ('Turkmenistan'), ('Turks and Caicos Islands'), ('Tuvalu'), ('Uganda'), ('Ukraine'), ('United Arab Emirates'), ('England'), ('United States'), ('United States Virgin Islands'), ('Uruguay'), ('Uzbekistan'), ('Vanuatu'), ('Vatican City'),
('Venezuela'), ('Vietnam'), ('Wales'), ('Wallis and Futuna'), ('Western Sahara'), ('Yemen'), ('Zambia'), ('Zimbabwe');

INSERT INTO Ort (ort_name, land_id) VALUES('Sukhumi', 1), ('Kabul', 2), ('Episkopi Cantonment', 3), ('Tirana', 4), ('Algiers', 5), ('Pago Pago', 6), ('Andorra la Vella', 7), ('Luanda', 8), ('The Valley', 9), ('St. Johns', 10), ('Buenos Aires', 11), ('Yerevan', 12), ('Oranjestad', 13), ('Georgetown', 14), ('Canberra', 15),
('Vienna', 16), ('Baku', 17), ('Nassau', 18), ('Manama', 19), ('Dhaka', 20), ('Bridgetown', 21), ('Minsk', 22), ('Brussels', 23), ('Belmopan', 24), ('Porto-Novo', 25), ('Hamilton', 26), ('Thimphu', 27), ('Sucre', 28), ('La Paz', 29), ('Sarajevo', 30),
('Gaborone', 31), ('Brasilia', 32), ('Road Town', 33), ('Bandar Seri Begawan', 34), ('Sofia', 35), ('Ouagadougou', 36), ('Bujumbura', 37), ('Phnom Penh', 38), ('Yaounde', 39), ('Ottawa', 40), ('Praia', 41), ('George Town', 42), ('Bangui', 43), ('NDjamena', 44), ('Santiago', 45),
('Beijing', 46), ('Flying Fish Cove', 47), ('West Island', 48), ('Bogota', 49), ('Moroni', 50), ('Avarua', 51), ('San Jose', 52), ('Zagreb', 53), ('Havana', 54), ('Willemstad', 55), ('Nicosia', 56), ('Prague', 57), ('Yamoussoukro', 58), ('Kinshasa', 59), ('Copenhagen', 60),
('Djibouti', 61), ('Roseau', 62), ('Santo Domingo', 63), ('Dili', 64), ('Hanga Roa', 65), ('Quito', 66), ('Cairo', 67), ('San Salvador', 68), ('Malabo', 69), ('Asmara', 70), ('Tallinn', 71), ('Addis Ababa', 72), ('Stanley', 73), ('Torshavn', 74), ('Palikir', 75),
('Suva', 76), ('Helsinki', 77), ('Paris', 78), ('Cayenne', 79), ('Papeete', 80), ('Libreville', 81), ('Banjul', 82), ('Tbilisi', 83), ('Berlin', 84), ('Accra', 85), ('Gibraltar', 86), ('Athens', 87), ('Nuuk', 88), ('St. Georges', 89), ('Hagatna', 90),
('Guatemala City', 91), ('St. Peter Port', 92), ('Conakry', 93), ('Bissau', 94), ('Georgetown', 95), ('Port-au-Prince', 96), ('Tegucigalpa', 97), ('Budapest', 98), ('Reykjavik', 99), ('New Delhi', 100), ('Jakarta', 101), ('Tehran', 102), ('Baghdad', 103), ('Dublin', 104), ('Douglas', 105),
('Jerusalem', 106), ('Rome', 107), ('Kingston', 108), ('Tokyo', 109), ('St. Helier', 110), ('Amman', 111), ('Astana', 112), ('Nairobi', 113), ('Tarawa', 114), ('Pristina', 115), ('Kuwait City', 116), ('Bishkek', 117), ('Vientiane', 118), ('Riga', 119), ('Beirut', 120),
('Maseru', 121), ('Monrovia', 122), ('Tripoli', 123), ('Vaduz', 124), ('Vilnius', 125), ('Luxembourg', 126), ('Skopje', 127), ('Antananarivo', 128), ('Lilongwe', 129), ('Kuala Lumpur', 130), ('Male', 131), ('Bamako', 132), ('Valletta', 133), ('Majuro', 134), ('Nouakchott', 135),
('Port Louis', 136), ('Mexico City', 137), ('Chisinau', 138), ('Monaco', 139), ('Ulaanbaatar', 140), ('Podgorica', 141), ('Plymouth', 142), ('Rabat', 143), ('Maputo', 144), ('Naypyidaw', 145), ('Stepanakert', 146), ('Windhoek', 147), ('Yaren', 148), ('Kathmandu', 149), ('Amsterdam', 150),
('Noumea', 151), ('Wellington', 152), ('Managua', 153), ('Niamey', 154), ('Abuja', 155), ('Alofi', 156), ('Kingston', 157), ('Pyongyang', 158), ('Nicosia', 159), ('Belfast', 160), ('Saipan', 161), ('Oslo', 162), ('Muscat', 163), ('Islamabad', 164), ('Ngerulmud', 165),
('Jerusalem', 166), ('Panama City', 167), ('Port Moresby', 168), ('Asuncion', 169), ('Lima', 170), ('Manila', 171), ('Adamstown', 172), ('Warsaw', 173), ('Lisbon', 174), ('San Juan', 175), ('Doha', 176), ('Taipei', 177), ('Brazzaville', 178), ('Bucharest', 179), ('Moscow', 180),
('Kigali', 181), ('Gustavia', 182), ('Jamestown', 183), ('Basseterre', 184), ('Castries', 185), ('Marigot', 186), ('St. Pierre', 187), ('Kingstown', 188), ('Apia', 189), ('San Marino', 190), ('Riyadh', 191), ('Edinburgh', 192), ('Dakar', 193), ('Belgrade', 194), ('Victoria', 195),
('Freetown', 196), ('Singapore', 197), ('Philipsburg', 198), ('Bratislava', 199), ('Ljubljana', 200), ('Honiara', 201), ('Mogadishu', 202), ('Hargeisa', 203), ('Pretoria', 204), ('Grytviken', 205), ('Seoul', 206), ('Tskhinvali', 207), ('Juba', 208), ('Madrid', 209), ('Sri Jayawardenapura Kotte', 210),
('Khartoum', 211), ('Paramaribo', 212), ('Mbabane', 213), ('Stockholm', 214), ('Bern', 215), ('Damascus', 216), ('Sao Tome', 217), ('Dushanbe', 218), ('Dodoma', 219), ('Bangkok', 220), ('Lome', 221), ('Nukualofa', 222), ('Tiraspol', 223), ('Port of Spain', 224), ('Edinburgh of the Seven Seas', 225),
('Tunis', 226), ('Ankara', 227), ('Ashgabat', 228), ('Cockburn Town', 229), ('Funafuti', 230), ('Kampala', 231), ('Kiev', 232), ('Abu Dhabi', 233), ('London', 234), ('Washington D.C.', 235), ('Charlotte Amalie', 236), ('Montevideo', 237), ('Tashkent', 238), ('Port Vila', 239), ('Vatican City', 240),
('Caracas', 241), ('Hanoi', 242), ('Cardiff', 243), ('Mata-Utu', 244), ('El Aaiun', 245), ('Sanaa', 246), ('Lusaka', 247), ('Harare', 248);

INSERT INTO Fahrzeug (kennzeichen, fahrzeug_art, marke)
VALUES('YY18714','Motorrad','Ducatti'),('YE58120','Motorrad','Honda'),('OQ30526','Motorrad','Honda'),('UI71598','Auto','McLaren'),('KV97932','Auto','Kia'),('CF40897','Motorrad','Suzuki'),('MJ48909','Auto','Porsche')
,('OG99453','Motorrad','Yamaha'),('DI94534','Auto','McLaren'),('UV73745','Auto','Fiat'),('KP80408','Auto','SEAT'),('YI71467','Auto','Hyundai'),('QA20454','Auto','Fiat'),('UC39331','Auto','Fiat'),
('KQ21864','Auto','Kia'),('SD13326','Auto','Opel'),('IH39061','Motorrad','KTM'),('SZ37547','Auto','Renault'),('LC56277','Auto','Renault'),('CY31912','Auto','Toyota'),('XS92507','Auto','Toyota'),
('VO43756','Auto','Jeep'),('NU36891','Auto','McLaren'),('LH84095','Auto','Ford'),('JY42085','Motorrad','Honda'),('FG62659','Motorrad','KTM'),('OZ54004','Motorrad','Kawasaki'),('ZL32661','Motorrad','BMW'),
('FL55038','Auto','Renault'),('ZG54950','Auto','Renault'),('CJ32742','Auto','BMW'),('TG46871','Motorrad','Ducatti'),('RF75734','Motorrad','Suzuki'),('DG79981','Auto','BMW'),('IL58059','Auto','Nissan'),
('NR33670','Auto','Opel'),('JD88596','Motorrad','Harley-Davidson'),('PX58894','Auto','VW'),('JT96735','Motorrad','Suzuki'),('CP66939','Motorrad','Honda'),('KW50399','Motorrad','Piaggio'),('PY59986','Motorrad','Ducatti'),
('BG83914','Motorrad','BMW'),('UU76029','Auto','SEAT'),('QB89794','Motorrad','Suzuki'),('AU64942','Auto','Mercedes'),('SC16931','Auto','Hyundai'),('ZL24271','Motorrad','KTM'),('RW71748','Auto','Nissan'),
('BX72765','Auto','SEAT'),('LQ82265','Auto','Opel'),('NZ29132','Motorrad','KTM'),('EY21515','Auto','Porsche'),('IB22490','Auto','Kia'),('CD78819','Auto','Peugeot'),('HY23707','Auto','Ferrari'),
('VX52950','Auto','Kia'),('DT88835','Auto','Hyundai'),('TC47966','Motorrad','KTM'),('TW87164','Motorrad','Kawasaki'),('NA77732','Auto','Mercedes'),('WD52058','Auto','Jaguar'),('LC63566','Auto','Renault'),
('QH29273','Auto','Ferrari'),('IR30690','Motorrad','Yamaha'),('JV39974','Auto','Toyota'),('NQ81206','Auto','BMW'),('VC49016','Auto','Porsche'),('KI70706','Motorrad','Harley-Davidson'),('LO83132','Auto','Opel'),
('LZ66417','Auto','Mercedes'),('QY16339','Auto','Mercedes'),('EG42982','Auto','VW'),('TV32532','Auto','Nissan'),('WI91075','Auto','Hyundai'),('GI61358','Auto','Audi'),('DQ47213','Auto','Audi'),
('QT21214','Motorrad','Piaggio'),('JX22536','Auto','McLaren'),('GQ20728','Motorrad','Suzuki'),('DC61454','Auto','Toyota'),('AF46404','Auto','Lamborghini'),('XG64592','Motorrad','Harley-Davidson'),('SP67566','Motorrad','KTM'),
('EI49629','Motorrad','Ducatti'),('IL30554','Motorrad','Piaggio'),('FH23563','Motorrad','Ducatti'),('IK38284','Auto','Ferrari'),('RJ69948','Auto','SEAT'),('HB35786','Auto','Audi'),('JM13572','Auto','Fiat'),
('NI39144','Auto','Renault'),('DO36296','Auto','SEAT'),('JK10371','Motorrad','Harley-Davidson'),('ES83252','Motorrad','Honda'),('GZ43829','Auto','Opel'),('TI65351','Motorrad','Suzuki'),('TF95597','Auto','Honda'),
('FW13104','Motorrad','Harley-Davidson'),('WY17193','Auto','McLaren'),('HP34667','Motorrad','Kawasaki'),('TE40141','Auto','Hyundai'),('EN98213','Motorrad','Ducatti'),('IE28597','Motorrad','KTM'),('AN18041','Motorrad','BMW'),
('OG35337','Auto','Jaguar'),('KU32036','Auto','Audi'),('CQ87894','Motorrad','KTM'),('IF63346','Auto','Ford'),('EV29556','Auto','Jaguar'),('QS85914','Auto','VW'),('GD91908','Motorrad','Harley-Davidson'),
('NG93280','Motorrad','Harley-Davidson'),('KS78738','Motorrad','Honda'),('PA28175','Motorrad','Kawasaki'),('HB51319','Auto','Fiat'),('KS59167','Auto','Porsche'),('NO36901','Auto','VW'),('XP45402','Motorrad','Yamaha'),
('LY33260','Auto','Fiat'),('PN70193','Auto','Renault'),('UO50371','Motorrad','Suzuki'),('XV57678','Auto','SEAT'),('EX84006','Motorrad','Suzuki'),('RT49345','Motorrad','KTM'),('UA64874','Auto','SEAT'),
('HZ92878','Motorrad','Ducatti'),('WX82988','Motorrad','Kawasaki'),('NK78761','Motorrad','Kawasaki'),('VT76286','Motorrad','Suzuki'),('NU12417','Motorrad','Honda'),('WY31355','Motorrad','Honda'),('MD45024','Motorrad','Honda'),
('MG11347','Motorrad','Yamaha'),('DS24584','Auto','Ford'),('LC77480','Motorrad','Kawasaki'),('GE34896','Motorrad','BMW'),('VW91019','Auto','Hyundai'),('YR43136','Motorrad','Suzuki'),('RG30450','Motorrad','Yamaha'),
('SY52367','Auto','BMW'),('NA14485','Motorrad','Kawasaki'),('WO51226','Motorrad','Ducatti'),('LG94818','Motorrad','Kawasaki'),('OI74177','Auto','Opel'),('TI15443','Motorrad','Yamaha'),('JJ43868','Auto','Mercedes'),
('ET33427','Auto','Nissan'),('OK23837','Auto','Jaguar'),('GV34041','Auto','Porsche'),('SK37917','Motorrad','KTM'),('SQ61299','Motorrad','Kawasaki'),('EU35287','Motorrad','Honda'),('EK77591','Auto','BMW'),
('ZN41493','Motorrad','BMW'),('UQ48171','Auto','Fiat'),('PP14941','Motorrad','Honda'),('PX78564','Auto','Fiat'),('LZ66235','Auto','VW'),('EP88933','Motorrad','KTM'),('LN42397','Motorrad','Ducatti'),
('TH69178','Motorrad','Yamaha'),('KP65977','Auto','Lamborghini'),('VH92479','Auto','Peugeot'),('VV91497','Auto','Renault'),('US84482','Motorrad','Suzuki'),('AY48348','Motorrad','Ducatti'),('PU37194','Motorrad','Suzuki'),
('OS52803','Motorrad','Piaggio'),('XX55238','Motorrad','Suzuki'),('QY48915','Motorrad','Honda'),('JP82192','Auto','Fiat'),('FI44571','Motorrad','Honda'),('DX50942','Motorrad','Honda'),('NN54553','Auto','Fiat'),
('LW86279','Auto','Hyundai'),('GJ34089','Motorrad','Piaggio'),('SG46815','Motorrad','BMW'),('JO50267','Auto','Audi'),('RH50955','Motorrad','BMW'),('PS72007','Motorrad','Ducatti'),('UU56129','Motorrad','Kawasaki'),
('PR26368','Motorrad','Ducatti'),('HK78359','Motorrad','BMW'),('BV46539','Motorrad','Honda'),('BM43313','Auto','Skoda'),('XJ55441','Auto','Ferrari'),('LS34464','Auto','BMW'),('CA10539','Auto','VW'),
('QZ28170','Motorrad','KTM'),('BS16740','Motorrad','Kawasaki'),('RO19534','Auto','Peugeot'),('MC43050','Motorrad','Yamaha'),('GE76118','Auto','Honda'),('IL90843','Motorrad','Suzuki'),('CI60191','Motorrad','Kawasaki'),
('QA13883','Auto','Skoda'),('WT49215','Auto','Toyota'),('OC33862','Motorrad','BMW'),('AL83374','Motorrad','Kawasaki');


INSERT INTO Besitzer (vorname, nachname)
VALUES ('Lavina','Nester'),('Steven','Chappell'),('Lawrence','Jones'),('Pearl','Mintz'),('Ashley','Dobbin'),('Ruben','Martin'),('Dana','Soto'),('Laura','Brown'),('Matthew','Padilla'),('Lacy','Campbell'),
('Rebecca','Watkins'),('Ruth','Davis'),('Rena','Moscoso'),('Gregory','Dahl'),('Lauren','Willis'),('Daniel','Lowell'),('Jennifer','Vaughn'),('Debra','Becerra'),('Alice','Hallum'),('David','Rose'),
('Henry','Thrift'),('Kristen','Hatley'),('James','Marks'),('Velma','Gilkerson'),('Annie','Reavis'),('Jeanne','Whitley'),('Seth','Mauro'),('Parker','Spillett'),('Alberta','Jones'),('Tim','Brister'),
('Terry','Eastman'),('Richard','Veer'),('Errol','Onstott'),('Robert','Block'),('Debra','Zimmerman'),('Fredrick','Watkins'),('Dennis','Gildner'),('Jennie','Herrin'),('Jeffery','Yun'),('Joe','Clowes'),
('Jeff','Walker'),('Callie','Batty'),('Sandra','Robinson'),('Christopher','Vanderpool'),('Mary','Mcmichael'),('Joseph','Sullivan'),('Robert','Moore'),('Hugh','Mayes'),('Gerald','Norton'),('Pamela','Bufford');

INSERT INTO Job (job_name)
VALUES ('Manager'),('Praktikant'),('Putzkolonne'),('Sekretariat'),('Empfang'),
('Koch'),('Zimmerservice'),('Security'),('Nachtwache');

INSERT INTO Flug (datum, economy_preis, first_preis, business_preis, ort_id_von, ort_id_bis)
VALUES ('2019-09-23',88,154,186,148,96),('2021-12-18',83,120,224,85,190),('2021-03-03',68,137,163,244,127),('2017-08-14',102,122,276,127,73),('2019-08-06',97,155,203,172,15),('2021-07-22',105,132,237,45,206),
('2015-02-09',95,153,226,127,88),('2017-08-17',94,135,283,105,142),('2016-04-20',62,144,182,5,186),('2019-010-30',91,149,206,40,26),('2015-03-06',80,157,219,218,56),('2019-04-02',96,158,178,24,163),
('2019-04-03',85,124,200,190,15),('2021-01-11',75,156,232,66,204),('2016-09-29',81,160,232,185,182),('2020-04-19',70,150,206,104,18),('2018-12-06',71,123,219,82,69),('2019-02-18',76,145,254,113,39),
('2017-07-20',108,141,285,106,215),('2018-11-04',78,154,216,71,121),('2021-04-010',65,153,240,90,221),('2018-07-06',77,147,207,23,148),('2015-01-19',70,152,262,186,19),('2018-03-010',92,142,275,171,5),
('2015-01-24',111,137,272,116,151),('2016-010-08',85,146,197,134,110),('2016-06-18',118,150,222,170,72),('2016-12-19',84,120,286,73,112),('2020-010-18',70,127,247,203,225),('2019-05-010',86,126,168,49,31),
('2016-11-28',66,143,245,129,53),('2015-01-01',92,141,204,120,42),('2018-01-02',101,149,211,66,117),('2018-11-17',94,123,223,219,158),('2015-11-28',111,158,166,187,226),('2021-04-11',100,143,235,68,127),
('2016-010-12',111,133,296,151,61),('2015-010-22',88,125,194,145,188),('2020-08-28',69,143,202,97,207),('2020-11-15',110,127,289,194,119),('2016-08-02',98,124,263,112,143),('2018-11-28',82,153,236,223,63),
('2020-03-28',99,125,283,115,5),('2016-06-22',113,149,298,73,89),('2019-02-13',69,157,204,183,239),('2019-11-07',102,133,175,167,185),('2019-03-12',66,135,179,104,74),('2020-07-31',105,147,215,144,9),
('2018-06-12',86,150,270,18,164),('2020-06-17',109,146,167,82,210),('2019-010-19',120,133,218,58,58),('2017-11-17',97,146,249,56,99),('2020-09-07',109,129,182,166,233),('2018-02-13',110,143,288,50,144),
('2017-11-18',82,140,194,92,58),('2018-08-04',61,135,267,16,176),('2020-11-23',72,124,285,60,220),('2020-05-010',72,124,233,11,1),('2019-07-24',112,132,229,48,145),('2021-12-01',94,145,258,205,244),
('2020-010-15',111,132,171,240,182),('2020-07-12',113,121,288,113,234),('2018-02-21',75,147,185,22,133),('2020-09-29',115,152,297,212,198),('2016-05-14',63,146,266,10,15),('2018-010-26',110,130,285,137,134),
('2021-01-15',71,145,268,165,70),('2020-08-14',90,152,252,176,27),('2018-06-27',99,142,268,227,225),('2019-07-31',111,120,178,127,179),('2021-12-05',116,123,262,81,46),('2019-01-010',68,130,230,97,155),
('2020-03-18',93,124,175,129,40),('2017-07-06',106,129,206,247,27),('2021-12-28',77,151,230,30,94),('2020-08-12',113,155,291,142,131),('2020-05-26',91,126,262,236,33),('2016-05-03',113,133,169,141,141),
('2018-06-01',65,155,263,183,103),('2017-11-17',81,131,296,94,10),('2020-02-13',118,135,265,179,38),('2020-010-30',115,124,233,14,19),('2018-11-15',81,125,242,80,221),('2018-06-30',90,138,262,227,59),
('2016-03-25',108,145,293,66,196),('2015-07-03',113,120,167,126,232),('2015-02-02',85,126,286,223,68),('2021-09-01',101,123,166,197,191),('2017-05-09',82,138,201,48,247),('2018-07-09',74,158,188,14,161),
('2018-07-19',108,125,254,149,152),('2020-01-17',109,128,252,91,136),('2018-07-01',102,124,166,175,84),('2021-03-28',68,151,238,227,196),('2019-08-30',99,157,254,88,15),('2018-010-15',112,125,275,58,157),
('2016-11-010',113,126,241,125,216),('2017-05-16',76,146,277,105,224),('2019-02-15',70,151,180,235,158),('2020-06-11',90,137,176,150,144),('2015-11-16',114,122,188,178,220),('2018-12-21',63,155,263,17,119),
('2016-05-02',102,128,300,83,129),('2017-05-24',67,148,199,190,75),('2019-08-14',111,149,202,112,208),('2021-11-20',105,126,258,44,68),('2018-03-25',109,130,251,100,29),('2021-03-15',61,149,205,53,139),
('2015-04-07',99,123,168,9,15),('2017-04-02',103,147,165,177,182),('2020-08-17',106,154,193,81,109),('2016-08-17',69,130,284,130,147),('2019-07-04',77,125,251,115,132),('2017-11-22',88,142,183,229,171),
('2020-03-05',85,137,250,135,85),('2021-09-02',104,151,186,111,17),('2017-11-04',115,158,190,155,46),('2020-05-03',90,145,299,96,79),('2020-06-22',106,130,225,53,192),('2019-08-06',65,122,244,125,43),
('2018-03-19',96,160,249,111,30),('2015-02-07',116,134,250,161,136),('2019-12-26',84,144,161,204,235),('2016-09-27',74,132,164,197,207),('2018-02-09',93,132,241,243,148),('2021-07-13',71,143,286,197,62),
('2018-08-04',99,145,248,128,93),('2018-010-04',107,123,257,60,143),('2021-05-26',102,159,199,31,155),('2015-04-28',84,143,174,110,137),('2017-04-11',108,131,276,79,73),('2015-01-30',85,155,212,5,143),
('2019-06-18',113,157,166,44,89),('2020-05-20',100,154,252,246,51),('2020-06-30',66,158,201,243,65),('2017-11-05',112,123,254,9,131),('2020-08-28',112,149,280,156,119),('2020-07-31',67,124,232,84,165),
('2015-03-22',119,159,243,226,196),('2020-04-19',77,130,292,104,211),('2016-05-24',79,158,216,72,56),('2021-08-27',103,126,182,123,37),('2016-08-21',116,138,175,148,35),('2019-11-15',116,159,218,247,166),
('2020-05-25',62,140,286,243,39),('2021-01-23',94,121,269,171,142),('2017-02-25',85,129,247,146,44),('2020-02-20',68,141,212,215,169),('2016-07-13',119,123,277,177,112),('2017-11-13',106,124,164,134,149),
('2021-02-27',66,147,283,243,103),('2016-01-06',68,122,297,49,126),('2015-09-02',103,120,170,85,141),('2016-07-26',111,135,242,138,118),('2018-07-23',73,128,293,144,121),('2015-12-09',72,156,207,41,107),
('2020-01-27',78,125,185,135,175),('2018-010-07',77,141,286,242,93),('2018-06-13',71,120,163,233,92),('2018-08-23',119,122,292,99,25),('2018-04-06',101,139,296,56,97),('2017-02-26',110,129,269,232,16),
('2015-05-09',62,159,276,88,176),('2018-02-01',113,143,227,177,12),('2015-03-27',75,143,287,2,4),('2016-01-24',98,134,268,211,109),('2016-03-07',107,132,236,72,31),('2021-03-18',100,159,207,135,63),
('2021-04-17',113,152,213,113,239),('2017-04-25',109,138,291,41,217),('2015-07-01',60,121,223,72,92),('2015-08-28',75,136,264,66,135),('2017-04-17',90,128,247,160,87),('2020-12-05',108,131,198,126,169),
('2016-07-16',90,120,255,241,223),('2018-09-01',104,155,276,172,226),('2021-09-28',73,138,185,74,160),('2019-08-16',84,143,162,231,240),('2017-09-17',67,126,203,83,139),('2019-02-16',67,150,256,110,98),
('2016-010-12',106,134,277,227,139),('2016-07-23',61,136,284,38,27),('2020-11-18',77,156,232,129,119),('2019-08-15',110,134,254,114,183),('2018-09-19',120,136,186,71,218),('2017-02-13',88,142,223,76,210),
('2018-04-20',119,137,210,64,16),('2018-03-30',120,122,162,40,247),('2015-12-010',101,138,203,101,153),('2018-11-06',73,128,217,164,65),('2017-05-11',83,137,219,4,81),('2019-05-11',104,128,271,19,156),
('2019-08-05',74,120,283,230,234),('2018-07-25',83,132,245,100,66),('2019-09-11',63,123,219,150,171),('2015-11-25',77,131,247,193,33),('2019-09-16',99,138,265,19,125),('2015-06-17',96,128,242,126,3),
('2016-02-07',67,121,229,27,47),('2016-010-07',85,130,265,226,85);

INSERT INTO Sehenswuerdigkeit (sehenswuerdigkeit_name, ort_id)
VALUES ('Sokhumi Botanical Garden', 1), ('Plaza de Mayo', 11), ('Victory Square', 22), ('Atomium', 23), ('Chinesische Mauer', 46), ('Eiffelturm', 78), ('Louvre', 78), ('Gyeongbokgung', 206), ('Castelo de Sao Jorge', 174), ('Big Ben', 234),
('Tower Bridge', 234), ('London Eye', 234), ('Palace of Westminster', 234);

INSERT INTO Adresse (adresse, ort_id)
VALUES ('Boesch 62', 1),('Via Stazione 149', 2),('Quadra 134', 3),('Via Altisio 71', 4),('Langwiesstrasse 144', 5),('Via Stauffacher 134', 6),('In Stierwisen 40', 7),('Via delle Vigne 72', 8),('Wiesenstrasse 84', 9),('Gartenhof 96', 10),('Via Stazione 10', 11),
('Glennerstrasse 63', 12),('Loorenstrasse 96', 13),('Via Luzzas 142', 14),('Fortunastrasse 30', 15),('Clius 10', 16),('Via dalla Staziun 119', 17),('Clius 100', 18),('Clius 46', 19),
('Rosenweg 17', 20),('Via Stauffacher 130', 21),('Forrenboehlstrasse 78', 22),('Lungolago 56', 23),('Avenue d Ouchy 101', 24),('Allmenrueti 89', 25),('Boesch 47', 26),('Via Camischolas sura 73', 27),('Kronwiesenweg 28', 28),('Damunt 144', 29),('Raegetenstrasse 50', 30),
('Lichtmattstrasse 109', 31),('Sondanella 119', 32),('Scheidweg 69', 33),('Seefeldstrasse 46', 34),('Lichtmattstrasse 2', 35),('Schuetzenweg 52', 36),('Gerbiweg 128', 37),('Boesch 75', 38),
('Langwiesstrasse 43', 39),('Via Schliffras 20', 40),('Stradun 25', 41),('Via dalla Staziun 37', 42),('Rasenstrasse 143', 43),('Via Verbano 42', 44),('Brucknerweg 69', 45),('Bergrain 126', 46),('Quadra 94', 47),('In Stierwisen 99', 48),('Wiesenstrasse 88', 49),
('Allmenrueti 107', 50),('In Stierwisen 48', 51),('Loorenstrasse 10', 52),('Muehle 138', 53),('Plattenstrasse 129', 54),('Kirchstrasse 85', 55),('Via Stazione 11', 56),('Bergrain 65', 57),
('Kornquaderweg 67', 58),('Kornquaderweg 65', 59),('Sonnenweg 81', 60),('Spinatsch 85', 61),('Breitenstrasse 84', 62),('Fortunastrasse 41', 63),('Brucknerweg 108', 64),('Boesch 32', 65),('ueerklisweg 21', 66),('Bergrain 94', 67),('Sonnenweg 48', 68),
('Grossmatt 119', 69),('Semperweg 87', 70),('Rasenstrasse 150', 71),('Sonnenweg 15', 72),('Dreibuendenstrasse 126', 73),('Im Wingert 29', 74),('Via Stauffacher 5', 75),('Untere Aegerten 96', 76),
('Gartenhof 1', 77),('Erlenweg 10', 78),('Herrenberg 116', 79),('Vallerstrasse 47', 80),('Via Muraccio 57', 81),('Bahnhofplatz 56', 82),('Avenue d Ouchy 57', 83),('Puentstrasse 26', 84),('Boesch 86', 85),('Toesstalstrasse 80', 86),('Plattenstrasse 106', 87),
('Kornquaderweg 149', 88),('Postfach 135', 89),('Brunnacherstrasse 83', 90),('Semperweg 89', 91),('Wingertweg 90', 92),('Kappelergasse 34', 93),('Brunnacherstrasse 79', 94),('Seefeldstrasse 119', 95),
('Vallerstrasse 102', 96),('Brunnacherstrasse 119', 97),('Schuepisstrasse 107', 98),('Betburweg 29', 99),('Obere Bahnhofstrasse 6', 100),('Piazza Rezzonico 75', 101),('Obere Haltenstrasse 29', 102),('Piazza Indipendenza 2', 103),('Casa Gielgia 93', 104),('Loorenstrasse 105', 105),('Sonnenbergstr 94', 106),
('Schuetzenweg 76', 107),('Via Stauffacher 28', 108),('Wingertweg 42', 109),('Scheidweg 3', 110),('Via Altisio 125', 111),('Sonnenweg 90', 112),('Sondanella 36', 113),('Wolfensbergstrasse 134', 114),
('Caltgadira 22', 115),('Via delle Vigne 134', 116),('Scheidweg 112', 117),('Via Altisio 24', 118),('Dreibuendenstrasse 98', 119),('Wolfensbergstrasse 94', 120),('Via Vigizzi 72', 121),('Jakobstrasse 97', 122),('Kronwiesenweg 28', 123),('Lichtmattstrasse 29', 124),('Langwiesstrasse 85', 125),
('Auerstrasse 20', 126),('Zuerichstrasse 89', 127),('Valeestrasse 125', 128),('Sonnenbergstr 88', 129),('Kirchstrasse 37', 130),('Muehle 73', 131),('Pfaffacherweg 142', 132),('Via Camischolas sura 94', 133),
('Via Verbano 32', 134),('Boldistrasse 5', 135),('Brucknerweg 139', 136),('Im Wingert 25', 137),('Luetzelfluehstrasse 78', 138),('Brunnacherstrasse 140', 139),('Schuepisstrasse 121', 140),('Jakobstrasse 49', 141),('Via Stazione 97', 142),('Untere Aegerten 35', 143),('Wingertweg 127', 144),
('Wolfensbergstrasse 57', 145),('Schuetzenweg 82', 146),('Dreibuendenstrasse 75', 147),('Casut 145', 148),('Kronwiesenweg 66', 149),('Untere Aegerten 8', 150),('Via Verbano 131', 151),('Gartenhof 66', 152),
('Luetzelfluehstrasse 112', 153),('Forrenboehlstrasse 46', 154),('Zuerichstrasse 133', 155),('Lichtmattstrasse 50', 156),('Auerstrasse 147', 157),('Mattenstrasse 49', 158),('Muelhauserstrasse 33', 159),('Rosenweg 31', 160),('Erlenweg 135', 161),('Wingertweg 19', 162),('Luetzelfluehstrasse 99', 163),
('Boesch 106', 164),('Wolfensbergstrasse 18', 165),('Damunt 64', 166),('Lichtmattstrasse 138', 167),('Casa Posrclas 84', 168),('Herrenberg 80', 169),('Valeestrasse 25', 170),('Untere Aegerten 92', 171),
('Gartenhof 136', 172),('Wolfensbergstrasse 88', 173),('Quadra 99', 174),('Forrenboehlstrasse 78', 175),('Via Albarelle 136', 176),('Semperweg 113', 177),('Plattenstrasse 51', 178),('Gerbiweg 150', 179),('Wiesenstrasse 139', 180),('Boesch 37', 181),('Untere Aegerten 126', 182),
('Casa Gielgia 58', 183),('Via Luzzas 3', 184),('Werkstrasse 136', 185),('Strickstrasse 143', 186),('Zuerichstrasse 120', 187),('Piazza Indipendenza 140', 188),('Via Camischolas sura 5', 189),('Auerstrasse 9', 190),
('Allmenrueti 144', 191),('Zuerichstrasse 82', 192),('Auerstrasse 25', 193),('Schulstrasse 93', 194),('Langwiesstrasse 40', 195),('ueerklisweg 66', 196),('Via delle Vigne 13', 197),('Landstrasse 150', 198),('Mattenstrasse 141', 199),('Brunnenstrasse 92', 200),('Obere Bahnhofstrasse 143', 201),
('Mattenstrasse 71', 202),('Sonnenbergstr 21', 203),('Landstrasse 106', 204),('Via Verbano 81', 205),('Toesstalstrasse 22', 206),('Muelhauserstrasse 86', 207),('Herrenberg 97', 208),('Brunnacherstrasse 79', 209),
('Pfaffacherweg 26', 210),('Kappelergasse 83', 211),('Sondanella 136', 212),('Via Stauffacher 119', 213),('ueerklisweg 110', 214),('Lichtmattstrasse 84', 215),('Untere Aegerten 86', 216),('Via Pestariso 115', 217),('Puentstrasse 104', 218),('Breitenstrasse 67', 219),('Forrenboehlstrasse 103', 220),
('Piazza Rezzonico 104', 221),('Breitenstrasse 100', 222),('Rasenstrasse 1', 223),('Valeestrasse 101', 224),('Via Luzzas 121', 225),('Brunnacherstrasse 125', 226),('Kopfhoelzistrasse 22', 227),('Allmenrueti 78', 228),
('Erlenweg 130', 229),('Mittlerer Thalackerweg 107', 230),('Seefeldstrasse 14', 231),('Obere Bahnhofstrasse 98', 232),('Via Stazione 97', 233),('Obere Bahnhofstrasse 120', 234),('Raegetenstrasse 12', 235),('Via Verbano 134', 236),('Dreibuendenstrasse 123', 237),('Brucknerweg 44', 238),('Scheidweg 130', 239),
('Kirchstrasse 86', 240),('Via dalla Staziun 65', 241),('Puentstrasse 10', 242),('Scheidweg 113', 243),('Forrenboehlstrasse 147', 244),('Brunnacherstrasse 83', 245),('Erlenweg 91', 246),('Wingertweg 96', 247);

INSERT INTO Hotel (hotel_name, adresse_id, besitzer_id)
VALUES ('Hilton', 1, 1),('Emirates Hotel Tower', 2, 2),('The Address Downtown Dubai', 3, 3),('Mandalay Bay', 4, 4),('Wynn', 5, 5),('Excalibur', 6, 6),('Circus Circus', 7, 7),('Flamingo', 8, 8),
('The Mirage', 9, 9),('The Dawn', 10, 10),('Romantico', 11, 11),('Amber', 12, 12),('Flamongo', 13, 13),('Rounder', 14, 14),('hansueli Hotel', 15, 15),('GGpound', 16, 16),
('Somehower', 17, 17),('Elsewhere', 18, 18),('EBBS', 19, 19),('Hotel Estrel', 20, 20),('Cobra', 21, 21),('CVV', 22, 22),('BFH', 23, 23),('Anderwise', 24, 24),
('Kundra', 25, 25),('Maluna-Me', 26, 26),('Otherwise', 27, 27),('flawless', 28, 28),('Hotel Fahrni', 29, 29),('Ben Hover', 30, 30),('Faver', 31, 31),('Andorso', 32, 32),
('hansruedi Hotel', 33, 33),('Hotel Among them', 34, 34),('Eisenjower', 35, 35),('Amdromeda', 36, 36),('Urusem', 37, 37),('Operanda', 38, 38),('Hangelia', 39, 39),('Helvetica Bay', 40, 40),
('Brynn', 41, 41),('Hotel Hundus', 42, 42),('Circus Picus', 43, 43),('Tango Mango', 44, 44),('The Raider', 45, 45),('Hound Stable', 46, 46),('SUS', 47, 47),('Zumbadom', 48, 48),
('Stockerhouse', 49, 49),('Allgate', 50, 50);


INSERT INTO Arbeiter (vorname, nachname, lohn, job_id, hotel_id)
VALUES('Joseph','Malone',3134,5,22),('Ariana','Bard',4870,1,19),('Terry','Cooley',4284,7,33),('Maria','Powell',4049,4,13),('Gilbert','Carr',2063,6,14),('James','Normand',3025,6,50),
('Alexis','Hollyfield',4536,5,43),('Kim','Manuel',2045,2,37),('Joan','Denson',2991,3,3),('Marybeth','Sharp',4611,1,41),('Diane','Clark',4866,8,28),('Henry','Ayala',3289,1,42),
('Alberta','Robinson',2609,3,13),('Julio','Valdez',3693,8,25),('Rex','Demby',2878,5,35),('Philip','Peterson',2048,1,29),('Juana','Antilla',2773,5,3),('Kevin','Warner',4648,3,4),
('Edward','Webb',3060,4,16),('Dewey','Reynolds',4589,1,28),('Roberta','Mcglaughlin',2733,4,45),('Sabrina','Mitchell',2877,2,27),('Anita','Carpenter',2359,3,36),('Sonya','Leising',4896,3,37),
('Henry','Roberts',4922,9,46),('Sarah','Williams',4502,8,45),('Richard','Mcconnell',2920,9,33),('James','Vargason',3814,6,46),('Kay','Ward',4579,2,3),('Charles','Martin',2765,7,3),
('John','Stamp',2114,9,20),('James','Swenson',4549,3,16),('Jason','Cousin',4845,7,41),('Hee','Nolin',2447,3,31),('Ellen','Wilshire',2336,5,31),('Cindy','Zellinger',3141,1,39),
('Susan','Dillion',4241,7,31),('Alfonso','Thompson',3258,1,12),('Earl','Broadway',4085,6,47),('Leroy','Rushing',2645,8,30),('Kathleen','Knox',3128,4,33),('Constance','Gorham',3149,7,42),
('Jose','Stroud',2769,9,13),('Bryan','Campbell',4283,1,44),('Christopher','Parkinson',4182,4,46),('Gabriel','Hill',4359,2,46),('Cheryl','Strack',3886,3,11),('Gonzalo','Federick',3904,9,21),
('Robert','Caccavale',3157,3,17),('Wendy','Paschall',3969,8,28),('Julian','Lesher',3300,1,13),('Jonna','Hall',2021,8,14),('Keith','Haynes',4006,7,8),('Derrick','Lopez',2663,4,1),
('Paul','Fleming',2182,4,7),('Michael','Marin',4848,7,45),('Anna','Combass',4038,5,49),('Anna','Bovell',3405,9,34),('Keith','Rich',2924,6,36),('Gary','Hasenberg',2806,1,11),
('Robert','Gray',4563,9,31),('Terrance','Thompson',2750,7,9),('Lorraine','Millhouse',2368,5,13),('Hal','Mcclure',3621,4,16),('Danielle','Rogers',2274,5,49),('Ebony','Wal',4303,8,11),
('Jeffery','Denson',4463,6,26),('Kelly','Swift',2524,6,11),('Lori','Martinez',3168,6,23),('Ronni','Walker',2627,4,49),('Lance','Riley',4462,6,18),('Raleigh','Skiles',3634,6,39),
('Robin','Souza',4371,6,8),('Eric','Hutchinson',3512,9,35),('Cynthia','Robinson',4397,9,31),('Harriet','Stiltner',3878,3,20),('Colleen','Guthrie',2899,8,15),('James','Vanoy',2474,3,43),
('Susan','Diaz',2990,2,26),('Nicholas','Searles',3368,9,7),('Judith','Tarbox',4829,6,20),('Carolyn','Landrus',4933,7,5),('Jesus','Salazar',3829,9,4),('Marylee','Nestle',4953,9,5),
('Paul','Kertzman',3968,6,48),('Charles','Pontiff',3892,2,19),('Larry','Pitman',2999,2,4),('Robert','Gaines',4913,3,33),('Joy','Davison',2610,4,46),('Shauna','Hooper',4968,4,21),
('Carolyn','Lancaster',3517,5,44),('Norma','Clough',4011,5,2),('Gloria','Ragsdale',3756,8,46),('Carol','Arroyo',3579,3,50),('Alysa','Long',3578,2,8),('Robert','Hill',4506,4,48),
('Jacob','Withers',3384,6,4),('Julie','Sistrunk',4654,6,1),('David','Kehew',2629,2,42),('Marie','Valley',4845,3,1),('Alex','Bradley',3142,5,37),('Merle','Hazzard',2609,5,7),
('Scott','Coleman',3122,3,29),('Scott','Carey',4720,2,3),('Thomas','Biggs',2693,4,11),('Shirley','Brown',4115,2,46),('Deborah','Pierrot',3655,3,28),('Irene','Porterfield',4047,9,24),
('Millicent','Jones',3773,1,17),('Caprice','Guajardo',2939,7,4),('Kelly','Jones',3140,7,41),('Nicolasa','Belanger',2944,4,45),('Phoebe','Williams',2726,7,19),('Socorro','Still',3467,9,14),
('Milton','Ramirez',2098,8,23),('Paul','Mize',3113,2,3),('Marianne','Champagne',3682,5,46),('Wally','Berhe',2419,7,34),('Joyce','Fuqua',3493,5,10),('Brenda','Keel',4283,3,5),
('Fermin','Skeen',2747,2,3),('Perla','Hurst',3511,3,15),('Karen','Felton',4539,3,19),('Charles','Smith',4336,1,35),('Teresa','Higgins',4894,5,29),('Sidney','Bookwalter',4775,5,44),
('Harry','Lee',3407,5,2),('Crystal','Christou',3682,6,3),('Kenneth','Fike',3864,7,18),('Jeremy','Clark',2713,3,40),('Kathleen','Henrich',4981,3,26),('Charles','Vilven',2361,7,37),
('Lisa','Eisman',2580,2,28),('Mary','Smith',2547,5,12),('Tanya','Prichard',2051,3,30),('Michelle','Norman',4197,6,13),('Carolyn','Panzarino',2591,5,26),('Jennifer','Hurse',4279,7,23),
('Brandon','Vanpelt',4859,1,2),('Brooks','Rothe',4318,4,49),('James','Ferguson',2033,7,33),('Dorothy','Colliver',4917,8,5),('Jennifer','Lehman',4703,1,45),('Trudy','Lindemann',4913,8,46),
('Cathy','Carter',3693,3,17),('Tina','Fisher',2004,6,21),('George','Vahle',2039,3,38),('Jesus','Story',2635,7,25),('Christine','Kallenberg',4467,3,11),('Kenneth','Ballard',2887,4,1),
('James','Hoffstetter',3139,8,29),('Jessie','Sample',4886,2,44),('Douglas','Hunter',3977,9,50),('Eugene','Feinstein',2552,2,28),('Marion','Cecil',2506,5,15),('Jesse','Williams',4725,2,20),
('Mark','Goldberg',4921,3,13),('Peggy','Ortiz',2931,5,50),('Alvin','Fowler',4748,3,17),('Thomas','Rutledge',2091,5,7),('Nicole','Mueller',4305,1,15),('Wendy','Schubert',2450,5,43),
('Micheal','Wieczorek',4050,3,1),('Kellie','Hilton',2479,4,50),('Robert','Gambill',3479,5,39),('Marie','Mattlin',3407,5,6),('James','Rutkowski',4442,4,47),('Doris','Godwin',3308,1,1),
('Gwen','Peloquin',3211,8,28),('Ralph','Cooper',2532,8,46),('Sarah','Dilks',2763,2,50),('Danielle','Lum',2245,4,20),('Kim','Yearout',4117,3,41),('Steve','Mcclure',2369,3,4),
('Jonathan','Hetrick',4647,5,30),('Larry','Pena',2709,6,18),('Michael','Rivera',4272,7,28),('Terry','Corum',3682,5,49),('Shirley','Harris',3841,5,29),('Michael','Guenther',3306,5,12),
('John','Martin',4307,9,13),('Frances','Boykin',3739,3,19),('Derek','Vanduyn',3119,3,38),('Evelia','Egan',2386,2,45),('Eric','Luna',3689,3,31),('Ernest','Thompson',4253,4,25),
('Freddy','Pooler',2713,3,2),('Trina','Evans',4871,5,33),('John','Haar',4857,4,38),('Jay','Fuller',2621,4,12),('Mary','Swank',3866,1,19),('Billy','Allen',3042,2,1),
('Gail','Long',2930,5,28),('Nancy','Gonzalez',4933,5,13),('Monique','Alexander',3503,4,11),('Diane','Covington',3441,8,15),('Belle','Brake',3836,2,8),('Michael','Broyles',4790,7,4),
('Miguel','Harty',2166,4,14),('Robert','Adams',2149,9,28),('Anthony','Ng',2033,7,48),('Matthew','Johnson',4520,3,39),('Corey','Colon',2557,3,48),('Donald','Workman',3288,8,21),
('Otis','Papineau',2832,1,16),('Reva','Rodriguez',4426,7,43),('Aurora','Steen',2082,4,40),('Adele','Valencia',2028,2,27),('Nga','Cole',4938,7,37),('Donna','Carn',3487,1,6),
('Shauna','Cooper',2195,4,48),('Allen','Cunningham',3630,6,34),('Lorna','Mcdaniel',4757,2,40),('Jose','Cuesta',3689,9,40),('Kathleen','Quinones',2191,7,40),('Claire','Marinello',4795,8,15),
('Nancy','Stanford',2366,4,4),('Bernice','Angelocci',2377,2,24),('Mattie','Engelhart',4513,8,32),('Jennifer','Hall',4407,7,34),('Francis','Langford',4664,4,30),('Veda','Bush',2680,2,30),
('Robert','Stewart',3490,1,26),('Leslie','Donovan',3286,1,8),('Tracey','Guy',2652,5,6),('Aida','Gomez',4437,1,12),('Ileana','Lundberg',4654,2,36),('Courtney','Ryan',4319,8,4),
('Laura','Oberry',2548,1,4),('Marlene','Richardson',2036,6,25),('Joseph','Ryan',3221,1,35),('Thomas','Durr',2421,1,37),('Russell','Owens',4678,2,30),('Anna','Martin',3541,4,42),
('Pamela','Carlson',3810,6,38),('Courtney','Mcintyre',3358,4,12),('Conrad','Fisher',3736,8,6),('Sharon','Kemp',4176,3,30),('Suzanne','Smith',2755,3,4),('Gerald','Nelson',3965,9,22),
('Sam','Woodward',3108,3,40),('April','Boyd',2423,6,20),('Sarah','Hopson',4569,2,40),('Paul','Luciano',3338,4,45),('Rufus','Rhodes',3577,1,19),('Madeline','Clark',4043,5,12),
('Deborah','Post',2460,8,24),('Jason','Jacobson',2528,1,23),('William','Mosley',3354,5,13),('Maxine','Newman',4173,6,31),('Tanya','Maurer',2262,2,21),('Sabrina','Kirby',2212,1,45),
('Tammy','Loera',2375,8,49),('Bryan','Boettcher',3434,9,45),('Yolanda','Vadenais',4164,7,16),('Helen','Moore',4810,6,9),('Sarah','Nebarez',2536,5,41),('Rita','John',4425,6,15),
('Edwin','Nakamura',4970,1,48),('Monica','Reid',4646,6,32),('Opal','Wray',4249,7,27),('Richard','Terry',4457,6,16),('Harry','Chance',2271,6,33),('Shirley','Summer',3782,4,44),
('Mitchell','Ham',3383,6,26),('Clifford','Czajkowski',2430,4,34),('Michael','Petersen',2993,9,44),('Eric','Mata',3854,2,21),('Virgil','Rayfield',2782,5,43),('Deborah','Moreau',2081,5,12),
('Lawrence','Nelms',3569,8,14),('Jason','Simon',2662,7,44),('Dennis','Cormier',4232,9,8),('Edwin','Smith',4508,8,26),('Diana','Williams',4637,4,10),('Thomas','Marinelli',3991,1,15),
('Anne','Landrum',4011,8,39),('Clifton','Ashcraft',4506,6,1),('Emily','Seal',3396,6,48),('Lynne','Melgar',3115,9,14),('Glenda','Hurt',4722,2,17),('Rayford','Boisvert',2609,2,48),
('Chris','Johnson',2367,1,18),('Elise','Santos',2038,3,37),('Charles','Permenter',2892,5,27),('Tonya','Walkingstick',3538,7,37),('William','Quinn',2241,1,5),('Sally','Caster',2155,4,43),
('Carol','Guajardo',2724,7,13),('Paula','Lee',3853,2,49),('Billy','Burgess',4346,7,5),('Enrique','Cosgrove',4952,3,32),('Dorothy','Harris',2647,8,18),('Eileen','Hill',4628,6,35),
('Alan','Wietzel',4773,2,27),('Allan','Peel',2549,5,23),('Gertrude','Mcavoy',3870,5,42),('Deborah','Ragland',3893,3,12),('Darrel','Labarre',2908,4,48),('Gregory','Harris',2832,1,23);

INSERT INTO Kunde (vorname, nachname, adresse_id, age, telefonnummer)
VALUES('Gail','Budge',1,39,'0794693446'),('Patrick','Vian',2,34,'0799953658'),('Mae','Millard',3,73,'0798720294'),('Wanda','Decambra',4,39,'0796797693'),('Shirley','Flowers',5,69,'0792620343'),
('Benjamin','Fernandes',6,27,'0795415392'),('Antoinette','Cruz',7,38,'0794919467'),('Armando','Winkler',8,48,'0796328201'),('Jamie','Psuik',9,31,'0799250039'),('Ruben','Rowe',10,68,'0797711077'),
('Gail','Powless',11,23,'0798679775'),('Anthony','Bouillon',12,61,'0799702524'),('Willa','Snoddy',13,79,'0791041464'),('Opal','Sims',14,65,'0794013880'),('Teresa','Hundley',15,48,'0796499641'),
('Laura','Anderson',16,73,'0795811565'),('Violet','Emberling',17,58,'0797470774'),('Crystal','Lovelady',18,64,'0796335750'),('Maria','Hartly',19,64,'0793189187'),('Lisa','Bashore',20,28,'0798460813'),
('Robert','Jones',21,29,'0795871531'),('Dennis','Barrett',22,27,'0791256526'),('Mary','Weinzierl',23,45,'0798075667'),('Teresa','Wolery',24,18,'0799067611'),('Rhonda','Cathey',25,53,'0794488182'),
('Sharon','Zepeda',26,41,'0798038698'),('Marshall','Glass',27,28,'0791988002'),('Sheri','Brooks',28,41,'0796551802'),('Carl','Pearce',29,25,'0795103254'),('Carol','Dotson',30,56,'0795994127'),
('Angela','Clark',31,76,'0798250215'),('Martha','Gibson',32,78,'0791917499'),('Ronald','Leister',33,24,'0795904061'),('Joseph','Perry',34,39,'0796231495'),('Johnathon','Wise',35,69,'0796924955'),
('Annie','Davis',36,76,'0793165969'),('Keith','Lahay',37,62,'0794566552'),('Merle','Butter',38,35,'0793496066'),('Dean','Cox',39,74,'0792419557'),('Kenneth','Mota',40,72,'0796852779'),
('Augusta','Underwood',41,41,'0796460182'),('Kathleen','Chapman',42,18,'0797148953'),('John','Lewis',43,36,'0798425467'),('Inez','Brooks',44,69,'0792149514'),('Sylvia','Crisp',45,62,'0795815609'),
('Shirley','Smith',46,60,'0797529197'),('Mary','Scally',47,19,'0791657857'),('Tara','Steele',48,46,'0795970278'),('Jeff','Henderson',49,76,'0791194869'),('Karen','Guintanilla',50,50,'0797544097'),
('Mitchell','Glover',51,77,'0792630479'),('Quintin','Needels',52,34,'0795007793'),('Daniel','Phillips',53,29,'0798450303'),('Pedro','Mixon',54,68,'0796907838'),('Leslie','Moore',55,59,'0791989410'),
('David','Brock',56,69,'0791277131'),('Phyllis','Ashcraft',57,59,'0797252336'),('Amy','Stone',58,60,'0795803037'),('Charles','Franco',59,50,'0797370498'),('Carolyn','Schulz',60,49,'0792534609'),
('Fred','Neil',61,64,'0799223720'),('James','Harris',62,53,'0797516483'),('Henry','Montanez',63,36,'0797584762'),('Rosa','Wood',64,47,'0791797894'),('Grady','Burchess',65,48,'0793217436'),
('Diana','Solem',66,52,'0799260070'),('Juanita','Jackson',67,46,'0796840391'),('Rex','Banks',68,58,'0796926747'),('Marion','Craig',69,40,'0793868433'),('Lawrence','Martin',70,72,'0795148181'),
('William','Rivera',71,58,'0793641481'),('William','Corscadden',72,38,'0797928894'),('Richard','Cookson',73,48,'0796468883'),('Katherine','Brinkley',74,26,'0798305125'),('Susan','Rances',75,25,'0797067412'),
('Joshua','Douglas',76,44,'0796925897'),('Shannon','Avalos',77,47,'0799554017'),('Thomas','Gardner',78,35,'0795156796'),('Mary','Davis',79,34,'0794156251'),('Christina','Carlisle',80,65,'0795804297'),
('Agnes','Ramos',81,77,'0793613210'),('Carrie','Trump',82,38,'0793876753'),('Marianne','Adan',83,39,'0796903068'),('Joseph','Meyer',84,49,'0791445766'),('Kathryn','Corbridge',85,24,'0795698102'),
('Mercedes','Logsdon',86,34,'0795055580'),('Elaine','Stuart',87,66,'0793006464'),('Michael','James',88,70,'0797735132'),('William','Hewitt',89,37,'0798728952'),('Freda','Washington',90,72,'0795117271'),
('Kristen','Dikes',91,37,'0796148845'),('Marcus','Baker',92,44,'0799596544'),('Harold','Anderson',93,53,'0791580791'),('Holly','Ballard',94,57,'0795866495'),('Jeffery','Hussey',95,39,'0798821263'),
('Nancy','Wyman',96,35,'0792333737'),('Dale','Freeman',97,61,'0799019166'),('David','Duggan',98,27,'0794948582'),('Shirley','Jones',99,19,'0792208322'),('Donna','Krikorian',100,36,'0792993540'),
('Darlene','Williams',101,27,'0792398992'),('Alison','Rivera',102,57,'0791337971'),('Linda','Blake',103,36,'0796487140'),('Carlos','Yost',104,51,'0795955955'),('Lisa','Peel',105,78,'0795870630'),
('Herman','Minton',106,68,'0794933782'),('Roberto','Scherer',107,66,'0793742934'),('Micheal','Bryant',108,70,'0793736689'),('Joan','Kelly',109,55,'0798473824'),('Bessie','Rice',110,57,'0799290532'),
('Joyce','Nelson',111,67,'0792502903'),('Deborah','Holmes',112,80,'0799038264'),('Mildred','Hutchinson',113,51,'0796147816'),('Candice','Jones',114,37,'0791983570'),('Anna','Valles',115,43,'0792264371'),
('Bessie','Cross',116,57,'0799700151'),('Thomas','Stahl',117,21,'0791875626'),('Frances','Mcdaniel',118,76,'0795894473'),('Tammy','Mcneil',119,41,'0799313874'),('Jason','Ross',120,24,'0793439729'),
('Emil','Sanchez',121,58,'0791493373'),('Jose','Doolittle',122,56,'0795895087'),('Vera','Jones',123,42,'0796160595'),('Corina','Mccullough',124,36,'0798932690'),('Teresa','Davis',125,65,'0799366341'),
('George','Rennels',126,35,'0799763378'),('Vonda','Williams',127,65,'0791125391'),('Latasha','Jimenez',128,77,'0795324412'),('Irving','Nunez',129,53,'0795850629'),('Leo','Porter',130,60,'0793614728'),
('Christopher','Stiger',131,38,'0796623255'),('Nathaniel','Donnell',132,20,'0798005027'),('Randolph','Mcdermott',133,50,'0799916137'),('Maria','Hess',134,28,'0793329314'),('Margaret','Lymon',135,60,'0793355809'),
('Paul','Kunert',136,45,'0796396450'),('Mary','Smith',137,36,'0794829479'),('Jordan','Eskind',138,23,'0791511958'),('Renee','Clifford',139,63,'0793151108'),('Joel','Beagle',140,62,'0798366708'),
('Darlene','Little',141,70,'0799467810'),('Joann','Hutson',142,41,'0793714662'),('Esther','Kradel',143,78,'0796587571'),('Sarah','Woodhouse',144,55,'0799034560'),('Kandace','Jackson',145,76,'0798193649'),
('Lisa','Mckay',146,39,'0799076943'),('Martha','Compton',147,31,'0798929953'),('Wade','Hudson',148,22,'0792731855'),('Yukiko','Langeness',149,54,'0792777443'),('Joan','Davidson',150,31,'0799673454'),
('Tyra','Westervelt',151,51,'0795558944'),('Joseph','Higgins',152,70,'0796151251'),('David','Rodriguez',153,25,'0799486939'),('Noe','Carpenter',154,73,'0794861177'),('Jessica','Henkes',155,18,'0799544667'),
('Scott','Miller',156,73,'0798831408'),('Timothy','Griffith',157,52,'0797404678'),('Jonathan','Brown',158,56,'0792519025'),('Tonya','Ellis',159,46,'0792349206'),('John','Wood',160,29,'0797934431'),
('Clementine','Caballero',161,79,'0799301429'),('Cassandra','Brien',162,55,'0793755981'),('Stella','Howard',163,78,'0796821959'),('Van','Means',164,60,'0799298925'),('Jessica','Mcmurry',165,70,'0795447966'),
('Jason','Mason',166,31,'0791252026'),('Leo','Belcher',167,57,'0792568232'),('Lois','Schuman',168,76,'0791885242'),('Jill','Risner',169,78,'0795500995'),('John','Kuehl',170,33,'0797735479'),
('Charles','Rainey',171,71,'0793372601'),('Mark','Rasche',172,18,'0791822726'),('Julia','Paige',173,31,'0798680555'),('Robert','Craven',174,62,'0794825957'),('Jeffrey','Gant',175,76,'0796740911'),
('Ronald','Williams',176,75,'0794219493'),('Jodi','Corvera',177,69,'0796934802'),('Tabitha','Urie',178,39,'0793979086'),('Martha','Cronin',179,32,'0795368617'),('Chad','Lozey',180,50,'0794676859'),
('Darrin','Brougham',181,58,'0799185085'),('Loraine','Stevens',182,66,'0794391691'),('Christine','Houser',183,29,'0799002544'),('Jason','Raines',184,67,'0796348613'),('Jeff','Franklin',185,35,'0799511706'),
('Gerald','Randolph',186,47,'0793058956'),('Jeri','Hodges',187,64,'0799861331'),('John','Sanderson',188,74,'0793705449'),('Maria','Yang',189,36,'0798188677'),('Richard','Amundson',190,74,'0794709999'),
('Ida','Yokley',191,73,'0794780452'),('Clyde','King',192,44,'0797735860'),('Paul','Lockhart',193,69,'0792145549'),('Daniel','Bowman',194,57,'0793863214'),('Lance','Brown',195,77,'0791463954'),
('Toby','Benavidez',196,45,'0799672190'),('Rudolf','Buzard',197,66,'0795766516'),('Kathryn','Davis',198,53,'0798084846'),('Lenore','Lor',199,42,'0793523440'),('Helen','Ragsdale',200,40,'0798312745'),
('Rebecca','Robinson',201,53,'0794567891'),('Walter','Warner',202,38,'0795146808'),('Christopher','Holcomb',203,75,'0794400233'),('William','Brown',204,74,'0797283130'),('Brandon','Wolff',205,30,'0798801245'),
('Lynn','Lewis',206,41,'0793581061'),('Shawn','Berry',207,44,'0796452240'),('Jewel','Stacy',208,67,'0798111543'),('Rena','Mills',209,59,'0794274888'),('Jason','Ingram',210,44,'0798532578'),
('Patrick','Hodge',211,41,'0797609088'),('Sue','Swilling',212,42,'0798943177'),('Ronald','Wells',213,77,'0796509517'),('Craig','Walls',214,72,'0791947959'),('Norma','Binder',215,55,'0792713796'),
('Emily','Moretz',216,36,'0795337130'),('John','Brockman',217,78,'0798551387'),('Pamela','Price',218,67,'0795884707'),('Michele','Hernandez',219,72,'0799466184'),('Johnathon','Degiulio',220,55,'0794982348'),
('Gregory','Conley',221,41,'0791941255'),('Wendy','Barone',222,26,'0796994626'),('Steven','Tran',223,62,'0794656759'),('Linda','Doi',224,49,'0793688914'),('Joseph','Hebert',225,57,'0798478343'),
('Patricia','Perry',226,76,'0797186292'),('Jason','Lamaster',227,47,'0797895772'),('Lee','Wood',228,22,'0794704263'),('Mary','Foster',229,22,'0795688185'),('Christopher','Ontiveros',230,64,'0793363740'),
('Roger','Colucci',231,56,'0794243878'),('Jerome','Dejong',232,21,'0795843129'),('Jessica','Polin',233,78,'0794666022'),('Michael','Carroll',234,75,'0798506230'),('James','Price',235,71,'0798581374'),
('Nicole','Frye',236,61,'0791075692'),('Kathleen','Burris',237,75,'0796441956'),('Sean','Duncan',238,73,'0794690169'),('Barbara','Hughes',239,78,'0799665781'),('Heather','Allen',240,75,'0795929002'),
('Wayne','Haycraft',241,72,'0791295607'),('Kortney','Feldman',242,32,'0798878505'),('Guadalupe','Dingess',243,18,'0797734332'),('Cameron','Clayton',244,64,'0794898892'),('David','Fairchild',245,37,'0793708974'),
('Clifton','Terrell',246,77,'0792879143'),('Wilbur','Cipriani',247,59,'0796853196');

INSERT INTO Bewertung(hotel_id, kunde_id, stars, bewertung_text, bewertung_datum) VALUES(11, 64, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2018-4-20'),
(50, 170, 5, 'Keine Probleme','2021-3-5'),(36, 31, 2, '','2020-12-25'),(15, 215, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2020-4-5'),(9, 27, 2, '','2018-1-21'),(30, 20, 1, 'Service war schlecht und das Zimmer dreckig','2019-9-8'),(22, 6, 3, 'Nichts besonderes','2018-8-15'),(4, 5, 1, 'Personal extrem unhoeflich','2019-6-11'),(49, 35, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2020-10-5'),(42, 213, 1, 'Extrem Schlecht','2018-6-13'),(39, 120, 1, 'Service war schlecht und das Zimmer dreckig','2021-10-6'),
(37, 94, 5, 'Keine Probleme','2017-4-20'),(4, 7, 2, '','2018-1-9'),(11, 97, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2021-10-7'),(30, 171, 2, '','2017-7-20'),(9, 228, 2, '','2019-8-9'),(41, 158, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2017-6-16'),(1, 183, 3, '','2021-9-12'),(16, 215, 3, 'Ziemlich durchschnittliches Hotel','2019-1-19'),(29, 181, 5, '','2018-9-24'),(30, 32, 3, 'Service und Zimmer war okay.','2017-4-4'),
(45, 187, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2020-6-8'),(30, 241, 3, '','2020-3-14'),(5, 19, 3, 'Ziemlich durchschnittliches Hotel','2018-10-15'),(27, 31, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2020-8-20'),(46, 99, 1, 'Service war schlecht und das Zimmer dreckig','2020-11-18'),(33, 241, 3, '','2018-9-8'),(7, 44, 5, 'Alles Top','2021-12-16'),(44, 32, 5, 'Alles Top','2019-6-18'),(48, 175, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2017-4-12'),(12, 9, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2021-3-21'),
(8, 87, 2, '','2020-12-18'),(41, 171, 5, 'Gutes Hotel','2018-2-25'),(27, 192, 3, 'Ziemlich durchschnittliches Hotel','2018-9-15'),(29, 148, 5, 'Keine Probleme','2017-12-24'),(9, 183, 3, 'Service und Zimmer war okay.','2018-10-17'),(7, 181, 3, '','2019-4-18'),(49, 43, 1, 'Service war schlecht und das Zimmer dreckig','2017-5-20'),(1, 147, 5, 'Tolle Aussicht und Service Top','2021-9-17'),(18, 116, 1, 'Service war schlecht und das Zimmer dreckig','2021-4-17'),(22, 221, 1, 'Personal extrem unhoeflich','2021-5-13'),
(41, 179, 3, '','2018-12-23'),(31, 149, 2, '','2018-9-17'),(32, 117, 3, '','2018-8-14'),(43, 174, 5, 'Alles Top','2021-11-20'),(29, 49, 2, '','2019-1-14'),(15, 118, 5, 'Tolle Aussicht und Service Top','2021-7-17'),(12, 215, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2018-5-9'),(40, 46, 3, '','2018-2-1'),(25, 169, 4, 'Alles okay, aber es gab kein Roomservice','2018-10-17'),(44, 145, 1, 'Das Hotel hat eine Renovation noetig','2017-3-14'),
(45, 178, 5, 'Keine Probleme, super!','2019-10-7'),(31, 118, 1, 'Extrem Schlecht','2019-6-4'),(36, 194, 5, 'Alles Top','2021-6-21'),(28, 226, 1, 'Extrem Schlecht','2019-12-22'),(29, 223, 2, '','2021-12-25'),(30, 247, 1, 'Das Hotel hat eine Renovation noetig','2021-12-12'),(10, 80, 2, '','2018-9-23'),(9, 183, 5, 'Bestes Hotel, indem ich je war.','2021-8-3'),(46, 246, 1, 'Extrem Schlecht','2021-10-10'),(44, 134, 5, 'Keine Probleme','2021-12-2'),
(34, 237, 4, 'Alles okay, aber es gab kein Roomservice','2019-5-23'),(49, 42, 2, '','2018-12-6'),(32, 193, 3, '','2020-3-17'),(31, 160, 3, 'Ziemlich durchschnittliches Hotel','2019-6-1'),(44, 98, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2017-1-23'),(38, 58, 5, 'Bestes Hotel, indem ich je war.','2021-3-16'),(5, 5, 1, 'Das Hotel hat eine Renovation noetig','2017-9-17'),(20, 129, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2017-10-20'),(14, 210, 4, 'Alles okay, aber es gab kein Roomservice','2019-8-22'),(38, 110, 5, 'Alles super!','2017-10-13'),
(22, 65, 4, 'Alles okay, aber es gab kein Roomservice','2021-6-14'),(49, 21, 2, '','2020-11-10'),(38, 247, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2019-11-9'),(34, 69, 3, 'Nichts besonderes','2019-7-11'),(2, 201, 2, '','2018-11-6'),(33, 234, 3, 'Nichts besonderes','2018-4-18'),(32, 183, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2021-7-15'),(35, 113, 2, '','2019-5-19'),(24, 188, 3, '','2020-6-18'),(33, 236, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2018-9-13'),
(44, 22, 1, 'Das Hotel hat eine Renovation noetig','2017-1-2'),(42, 43, 5, 'Gutes Hotel','2021-12-14'),(45, 88, 5, 'Keine Probleme','2017-9-1'),(8, 233, 2, '','2021-6-24'),(33, 19, 2, '','2017-6-9'),(41, 10, 2, '','2021-12-23'),(49, 87, 2, '','2019-5-7'),(28, 147, 3, 'Ziemlich durchschnittliches Hotel','2018-8-7'),(24, 244, 2, '','2017-12-7'),(42, 39, 2, '','2020-8-12'),
(44, 137, 2, '','2020-4-11'),(2, 132, 2, '','2020-2-13'),(1, 165, 1, 'Extrem Schlecht','2019-7-7'),(43, 150, 4, 'Alles okay, aber es gab kein Roomservice','2017-11-1'),(31, 196, 1, 'Service war schlecht und das Zimmer dreckig','2018-5-3'),(47, 83, 2, '','2018-2-3'),(47, 232, 5, 'Alles Top','2017-9-2'),(2, 129, 5, 'Keine Probleme','2019-8-19'),(13, 221, 1, 'Service war schlecht und das Zimmer dreckig','2020-11-25'),(49, 26, 1, 'Schlecht','2018-9-4'),
(49, 88, 2, '','2019-1-5'),(14, 132, 5, 'Bestes Hotel, indem ich je war.','2020-7-22'),(14, 217, 3, 'Nichts besonderes','2018-6-20'),(19, 233, 1, 'Schlecht','2019-3-23'),(6, 108, 3, 'Nichts besonderes','2019-2-18'),(44, 130, 3, '','2019-12-6'),(17, 54, 1, 'Personal extrem unhoeflich','2018-12-23'),(38, 133, 5, 'Alles super!','2017-12-6'),(36, 33, 2, '','2018-8-10'),(15, 38, 3, 'Service und Zimmer war okay.','2020-10-15'),
(7, 13, 1, 'Schlecht','2019-6-6'),(35, 213, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2017-8-4'),(6, 78, 2, '','2020-9-8'),(15, 61, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2021-4-13'),(26, 85, 3, '','2021-10-12'),(30, 110, 2, '','2017-6-16'),(30, 187, 3, 'Nichts besonderes','2021-12-18'),(27, 245, 1, 'Personal extrem unhoeflich','2017-4-20'),(1, 230, 3, '','2017-2-19'),(9, 230, 1, 'Schlecht','2018-8-15'),
(18, 2, 1, 'Das Hotel hat eine Renovation noetig','2020-1-8'),(9, 241, 2, '','2017-8-1'),(3, 153, 3, '','2019-5-1'),(3, 64, 1, 'Schlecht','2019-5-7'),(46, 207, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2020-12-25'),(34, 176, 3, 'Ziemlich durchschnittliches Hotel','2017-5-6'),(38, 19, 3, '','2021-1-4'),(38, 170, 5, 'Alles super!','2017-1-18'),(28, 155, 2, '','2019-11-22'),(24, 46, 3, 'Nichts besonderes','2019-2-8'),
(7, 79, 5, 'Bestes Hotel, indem ich je war.','2017-5-6'),(44, 13, 1, 'Schlecht','2021-6-3'),(16, 87, 1, 'Das Hotel hat eine Renovation noetig','2019-8-8'),(27, 80, 1, 'Personal extrem unhoeflich','2021-4-14'),(10, 28, 1, 'Service war schlecht und das Zimmer dreckig','2017-4-10'),(29, 176, 3, 'Nichts besonderes','2021-4-25'),(48, 60, 2, '','2021-5-10'),(25, 65, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2017-2-8'),(1, 54, 5, 'Tolle Aussicht und Service Top','2018-8-13'),(19, 44, 5, 'Keine Probleme','2020-9-18'),
(18, 217, 3, 'Nichts besonderes','2020-5-13'),(6, 169, 1, 'Service war schlecht und das Zimmer dreckig','2021-6-1'),(41, 59, 5, '','2020-6-17'),(36, 51, 3, 'Nichts besonderes','2019-9-2'),(43, 234, 2, '','2018-4-1'),(5, 12, 1, 'Das Hotel hat eine Renovation noetig','2021-11-24'),(19, 212, 4, 'Alles okay, aber es gab kein Roomservice','2017-4-24'),(46, 178, 2, '','2021-8-23'),(43, 51, 1, 'Das Hotel hat eine Renovation noetig','2018-6-1'),(48, 107, 5, 'Bestes Hotel, indem ich je war.','2021-3-15'),
(29, 121, 3, '','2018-1-5'),(4, 12, 5, 'Alles Top','2018-10-21'),(36, 3, 3, 'Nichts besonderes','2019-10-17'),(12, 38, 1, 'Service war schlecht und das Zimmer dreckig','2021-11-3'),(15, 94, 4, 'Alles okay, aber es gab kein Roomservice','2021-2-19'),(42, 10, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2019-6-16'),(23, 195, 4, 'Alles okay, aber es gab kein Roomservice','2019-6-24'),(4, 133, 1, 'Personal extrem unhoeflich','2018-11-21'),(30, 153, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2020-12-8'),(44, 229, 3, 'Nichts besonderes','2021-5-8'),
(10, 43, 2, '','2018-1-3'),(48, 247, 2, '','2021-8-23'),(18, 69, 1, 'Schlecht','2021-3-21'),(26, 77, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2018-8-25'),(19, 235, 3, 'Service und Zimmer war okay.','2018-1-1'),(6, 208, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2020-11-21'),(16, 220, 3, 'Nichts besonderes','2019-1-8'),(48, 15, 3, 'Nichts besonderes','2017-8-19'),(27, 165, 3, 'Nichts besonderes','2021-12-14'),(24, 131, 1, 'Service war schlecht und das Zimmer dreckig','2017-6-7'),
(13, 124, 2, '','2021-12-7'),(7, 114, 2, '','2017-3-15'),(45, 124, 4, 'Alles okay, aber es gab kein Roomservice','2021-9-21'),(21, 116, 2, '','2017-10-3'),(14, 172, 1, 'Extrem Schlecht','2020-4-12'),(46, 211, 5, 'Keine Probleme','2019-11-20'),(50, 194, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2018-7-20'),(15, 127, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2020-3-17'),(33, 234, 2, '','2021-2-25'),(42, 74, 5, 'Keine Probleme, super!','2018-2-18'),
(26, 32, 2, '','2021-12-22'),(28, 49, 3, 'Ziemlich durchschnittliches Hotel','2017-12-21'),(2, 137, 1, 'Das Hotel hat eine Renovation noetig','2018-6-23'),(37, 96, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2018-11-13'),(46, 29, 3, '','2017-1-19'),(44, 221, 2, '','2020-10-4'),(44, 35, 5, 'Alles Top','2017-3-4'),(22, 154, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2021-3-13'),(7, 55, 3, 'Nichts besonderes','2020-9-25'),(11, 186, 5, 'Tolle Aussicht und Service Top','2017-4-21'),
(42, 174, 5, 'Alles Top','2018-2-4'),(13, 173, 1, 'Personal extrem unhoeflich','2019-3-13'),(10, 212, 4, 'Alles okay, aber es gab kein Roomservice','2021-7-1'),(44, 137, 1, 'Das Hotel hat eine Renovation noetig','2019-6-11'),(37, 118, 5, 'Alles super!','2019-3-7'),(23, 189, 5, 'Alles super!','2021-2-13'),(45, 3, 2, '','2018-1-1'),(13, 95, 1, 'Schlecht','2019-1-8'),(22, 177, 2, '','2017-8-14'),(16, 243, 5, 'Bestes Hotel, indem ich je war.','2018-5-24'),
(33, 44, 1, 'Personal extrem unhoeflich','2018-10-25'),(10, 171, 5, 'Tolle Aussicht und Service Top','2021-10-2'),(46, 44, 5, 'Bestes Hotel, indem ich je war.','2018-12-10'),(29, 90, 3, '','2021-2-16'),(37, 165, 2, '','2017-10-5'),(18, 190, 2, '','2020-5-8'),(48, 169, 4, 'Alles okay, aber es gab kein Roomservice','2019-11-25'),(43, 114, 1, 'Service war schlecht und das Zimmer dreckig','2021-4-22'),(18, 173, 3, 'Ziemlich durchschnittliches Hotel','2020-5-9'),(24, 30, 2, '','2017-11-11'),
(30, 217, 3, '','2021-4-15'),(29, 119, 1, 'Schlecht','2020-3-17'),(7, 216, 5, 'Alles super!','2020-12-19'),(28, 23, 2, '','2020-10-7'),(30, 47, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2017-11-21'),(49, 115, 2, '','2018-4-16'),(4, 120, 1, 'Personal extrem unhoeflich','2017-8-6'),(37, 67, 1, 'Das Hotel hat eine Renovation noetig','2019-8-9'),(40, 185, 3, 'Nichts besonderes','2021-12-18'),(15, 29, 3, 'Nichts besonderes','2019-11-18'),
(21, 134, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2021-9-11'),(5, 191, 1, 'Service war schlecht und das Zimmer dreckig','2018-9-7'),(48, 160, 5, 'Gutes Hotel','2021-8-2'),(9, 15, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2018-9-8'),(6, 206, 5, 'Bestes Hotel','2017-12-2'),(45, 157, 2, '','2018-5-12'),(23, 60, 1, 'Extrem Schlecht','2017-12-23'),(14, 136, 1, 'Das Hotel hat eine Renovation noetig','2018-5-19'),(39, 37, 2, '','2021-11-3'),(43, 118, 1, 'Service war schlecht und das Zimmer dreckig','2017-11-4'),
(10, 7, 3, '','2017-5-23'),(25, 126, 4, 'Hotel war super, unsere Aussicht war jedoch nicht aussreichend.','2018-2-23'),(30, 58, 1, 'Service war schlecht und das Zimmer dreckig','2019-1-22'),(26, 154, 3, 'Ziemlich durchschnittliches Hotel','2017-4-14'),(21, 238, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2020-10-11'),(22, 153, 1, 'Schlecht','2018-6-25'),(21, 71, 2, '','2017-5-2'),(45, 153, 3, 'Service und Zimmer war okay.','2021-3-18'),(21, 14, 3, 'Ziemlich durchschnittliches Hotel','2018-6-14'),(27, 59, 4, 'Alles okay, aber es gab kein Roomservice','2021-10-20'),
(25, 54, 5, 'Gutes Hotel','2018-8-14'),(7, 159, 4, 'Aussicht war super, aber das Zimmer war etwas klein','2018-7-11'),(21, 5, 4, 'Alles okay, aber es gab kein Roomservice','2020-8-7'),(35, 191, 2, '','2017-2-6'),(36, 94, 5, '','2017-10-9'),(48, 178, 3, '','2021-8-21'),(2, 145, 2, '','2020-11-17'),(31, 227, 1, 'Personal extrem unhoeflich','2017-4-6'),(46, 69, 1, 'Personal extrem unhoeflich','2020-11-2');

INSERT INTO Appartement(hotel_id, preis, zimmer_nummer) VALUES(18, 529, 0),
(17, 553, 1),(16, 275, 2),(32, 125, 3),(21, 428, 4),(15, 218, 5),(49, 563, 6),(47, 436, 7),(13, 495, 8),(7, 223, 9),(20, 263, 10),
(19, 569, 11),(1, 351, 12),(27, 68, 13),(42, 479, 14),(44, 467, 15),(49, 458, 16),(4, 270, 17),(8, 553, 18),(44, 347, 19),(40, 442, 20),
(28, 575, 21),(10, 472, 22),(35, 69, 23),(41, 405, 24),(43, 592, 25),(45, 322, 26),(37, 493, 27),(50, 344, 28),(8, 171, 29),(23, 464, 30),
(24, 223, 31),(10, 328, 32),(37, 235, 33),(20, 157, 34),(20, 562, 35),(39, 292, 36),(44, 490, 37),(17, 291, 38),(19, 595, 39),(30, 204, 40),
(24, 525, 41),(30, 72, 42),(40, 287, 43),(2, 439, 44),(6, 326, 45),(34, 162, 46),(22, 293, 47),(21, 349, 48),(6, 217, 49),(28, 89, 50),
(31, 517, 51),(46, 211, 52),(13, 208, 53),(36, 269, 54),(2, 370, 55),(15, 517, 56),(44, 461, 57),(50, 443, 58),(5, 497, 59),(24, 219, 60),
(15, 188, 61),(42, 268, 62),(29, 87, 63),(41, 545, 64),(37, 303, 65),(18, 397, 66),(8, 312, 67),(4, 599, 68),(33, 514, 69),(29, 433, 70),
(49, 415, 71),(1, 487, 72),(1, 396, 73),(27, 361, 74),(26, 214, 75),(8, 493, 76),(8, 387, 77),(27, 219, 78),(9, 148, 79),(21, 512, 80),
(1, 89, 81),(32, 387, 82),(16, 423, 83),(20, 102, 84),(7, 508, 85),(1, 95, 86),(37, 214, 87),(30, 384, 88),(47, 570, 89),(50, 159, 90),
(30, 483, 91),(26, 304, 92),(12, 242, 93),(6, 156, 94),(25, 85, 95),(17, 169, 96),(16, 109, 97),(7, 586, 98),(50, 465, 99),(50, 257, 100),
(40, 385, 101),(15, 371, 102),(38, 323, 103),(23, 232, 104),(29, 379, 105),(21, 514, 106),(16, 258, 107),(41, 566, 108),(26, 406, 109),(4, 485, 110),
(26, 150, 111),(38, 368, 112),(41, 243, 113),(38, 324, 114),(25, 500, 115),(17, 568, 116),(42, 401, 117),(18, 95, 118),(41, 299, 119),(23, 287, 120),
(44, 446, 121),(44, 449, 122),(16, 278, 123),(9, 553, 124),(7, 252, 125),(13, 218, 126),(14, 428, 127),(24, 81, 128),(26, 492, 129),(2, 317, 130),
(49, 370, 131),(12, 595, 132),(2, 527, 133),(13, 422, 134),(24, 136, 135),(10, 548, 136),(12, 213, 137),(48, 553, 138),(21, 233, 139),(7, 542, 140),
(19, 129, 141),(10, 218, 142),(9, 81, 143),(14, 599, 144),(30, 378, 145),(15, 504, 146),(2, 447, 147),(35, 147, 148),(41, 473, 149),(49, 207, 150),
(49, 479, 151),(12, 552, 152),(15, 369, 153),(9, 513, 154),(24, 377, 155),(38, 510, 156),(11, 401, 157),(5, 115, 158),(46, 123, 159),(45, 108, 160),
(18, 422, 161),(27, 343, 162),(36, 512, 163),(12, 388, 164),(20, 584, 165),(33, 185, 166),(10, 353, 167),(41, 208, 168),(16, 290, 169),(17, 383, 170),
(10, 221, 171),(42, 501, 172),(6, 217, 173),(49, 547, 174),(7, 595, 175),(9, 519, 176),(31, 528, 177),(5, 312, 178),(13, 153, 179),(38, 309, 180),
(21, 320, 181),(3, 541, 182),(17, 522, 183),(3, 584, 184),(4, 146, 185),(21, 287, 186),(3, 140, 187),(41, 66, 188),(46, 331, 189),(14, 470, 190),
(45, 470, 191),(34, 415, 192),(29, 568, 193),(11, 576, 194),(14, 452, 195),(32, 398, 196),(45, 402, 197),(39, 508, 198),(5, 158, 199),(16, 219, 200),
(5, 388, 201),(33, 186, 202),(8, 541, 203),(16, 77, 204),(11, 143, 205),(29, 134, 206),(2, 465, 207),(1, 308, 208),(43, 114, 209),(33, 64, 210),
(41, 286, 211),(39, 428, 212),(24, 427, 213),(25, 351, 214),(29, 420, 215),(36, 375, 216),(12, 313, 217),(16, 303, 218),(9, 127, 219),(6, 433, 220),
(26, 230, 221),(31, 194, 222),(48, 425, 223),(4, 532, 224),(3, 438, 225),(45, 255, 226),(8, 369, 227),(24, 528, 228),(4, 428, 229),(50, 520, 230),
(22, 65, 231),(47, 489, 232),(50, 495, 233),(36, 224, 234),(43, 329, 235),(30, 469, 236),(48, 431, 237),(25, 388, 238),(23, 505, 239),(3, 119, 240),
(11, 439, 241),(18, 273, 242),(16, 145, 243),(10, 511, 244),(42, 300, 245),(8, 580, 246),(4, 515, 247),(41, 358, 248),(8, 510, 249),(17, 319, 250),
(6, 533, 251),(37, 139, 252),(9, 455, 253),(38, 262, 254),(32, 548, 255),(20, 534, 256),(3, 459, 257),(27, 65, 258),(33, 175, 259),(8, 111, 260),
(16, 351, 261),(27, 576, 262),(21, 399, 263),(4, 199, 264),(26, 486, 265),(32, 583, 266),(24, 484, 267),(13, 510, 268),(48, 180, 269),(16, 580, 270),
(9, 375, 271),(39, 285, 272),(9, 436, 273),(32, 392, 274),(23, 540, 275),(15, 404, 276),(28, 456, 277),(32, 256, 278),(36, 246, 279),(4, 469, 280),
(19, 353, 281),(34, 359, 282),(29, 592, 283),(45, 148, 284),(12, 404, 285),(50, 319, 286),(42, 305, 287),(33, 407, 288),(49, 536, 289),(26, 368, 290),
(50, 110, 291),(10, 338, 292),(16, 167, 293),(16, 177, 294),(2, 180, 295),(49, 486, 296),(2, 220, 297),(2, 277, 298),(33, 463, 299);

INSERT INTO Buchung_hotel(anfangs_datum, end_datum, preis, kunde_id, appartement_id) VALUES
('2018-2-17', '2017-1-20', 480, 1, 11),('2020-7-17', '2019-11-20', 960, 2, 23),('2020-11-5', '2018-7-8', 425, 3, 27),('2018-4-5', '2017-5-20', 257, 4, 22),('2018-5-12', '2020-8-22', 468, 5, 3),
('2019-2-5', '2017-2-20', 112, 6, 32),('2018-12-24', '2020-12-14', 432, 7, 39),('2021-1-4', '2020-5-19', 754, 8, 28),('2020-7-13', '2021-5-2', 446, 9, 45),('2020-4-22', '2021-10-21', 888, 10, 6),
('2018-11-21', '2021-10-1', 994, 11, 11),('2020-8-15', '2019-2-18', 391, 12, 50),('2018-7-2', '2018-6-24', 677, 13, 28),('2018-7-23', '2021-12-13', 458, 14, 39),('2018-10-2', '2018-5-21', 210, 15, 20),
('2018-5-8', '2020-7-1', 701, 16, 39),('2018-6-21', '2020-12-22', 161, 17, 45),('2019-9-14', '2018-9-25', 280, 18, 11),('2021-1-25', '2021-2-13', 834, 19, 36),('2019-4-2', '2017-5-5', 291, 20, 43),
('2019-9-11', '2019-5-24', 907, 21, 28),('2019-1-25', '2017-6-13', 825, 22, 43),('2020-4-23', '2018-6-13', 913, 23, 13),('2018-6-25', '2017-7-19', 762, 24, 47),('2021-10-16', '2017-4-25', 287, 25, 36),
('2017-7-9', '2018-5-11', 258, 26, 10),('2018-7-9', '2020-3-8', 594, 27, 41),('2020-10-24', '2019-12-25', 270, 28, 2),('2017-7-7', '2020-10-1', 599, 29, 29),('2017-9-15', '2021-11-14', 885, 30, 49),
('2018-11-5', '2019-2-23', 804, 31, 28),('2017-1-4', '2020-4-3', 562, 32, 28),('2018-3-23', '2020-3-23', 396, 33, 24),('2017-5-21', '2018-9-17', 436, 34, 31),('2018-7-12', '2018-3-12', 772, 35, 13),
('2017-12-10', '2017-10-7', 258, 36, 18),('2020-2-24', '2017-9-11', 705, 37, 39),('2018-7-9', '2018-12-19', 362, 38, 2),('2021-8-20', '2018-1-22', 327, 39, 10),('2018-2-5', '2021-12-6', 377, 40, 3),
('2018-12-17', '2017-11-19', 756, 41, 38),('2021-8-2', '2018-4-10', 538, 42, 14),('2019-2-15', '2021-3-19', 965, 43, 38),('2017-6-1', '2021-10-7', 960, 44, 7),('2018-3-5', '2021-5-16', 788, 45, 36),
('2018-6-3', '2021-12-10', 610, 46, 3),('2020-4-11', '2021-9-2', 771, 47, 39),('2019-9-19', '2020-6-25', 994, 48, 33),('2019-7-8', '2019-1-15', 615, 49, 20),('2021-3-7', '2020-12-22', 843, 50, 8),
('2017-12-1', '2017-8-8', 539, 51, 20),('2019-6-8', '2021-2-22', 961, 52, 46),('2019-4-4', '2017-9-22', 365, 53, 7),('2021-12-11', '2020-1-17', 176, 54, 29),('2020-8-4', '2019-4-16', 585, 55, 10),
('2018-2-5', '2019-10-25', 117, 56, 35),('2019-6-15', '2021-12-18', 157, 57, 26),('2017-10-5', '2018-8-25', 818, 58, 23),('2018-7-19', '2020-3-12', 631, 59, 16),('2020-7-6', '2021-1-24', 454, 60, 3),
('2017-3-6', '2018-11-21', 905, 61, 30),('2019-8-15', '2020-8-15', 373, 62, 49),('2017-5-10', '2019-8-7', 745, 63, 22),('2019-8-2', '2021-4-24', 919, 64, 16),('2019-4-23', '2019-6-15', 884, 65, 14),
('2018-7-12', '2020-4-16', 268, 66, 5),('2019-7-10', '2017-8-2', 859, 67, 34),('2018-1-22', '2020-3-25', 723, 68, 43),('2017-2-17', '2018-8-7', 581, 69, 1),('2021-12-3', '2019-7-15', 819, 70, 29),
('2020-7-5', '2018-1-9', 147, 71, 19),('2020-10-9', '2021-2-14', 236, 72, 20),('2020-11-17', '2020-4-8', 482, 73, 23),('2018-10-7', '2017-1-21', 144, 74, 14),('2018-5-14', '2020-6-9', 829, 75, 2),
('2019-5-12', '2020-6-25', 649, 76, 32),('2021-8-10', '2021-8-9', 788, 77, 31),('2020-6-2', '2017-4-16', 568, 78, 28),('2018-6-11', '2018-6-12', 201, 79, 23),('2019-1-10', '2019-5-19', 772, 80, 49),
('2021-8-15', '2017-1-25', 143, 81, 11),('2020-7-24', '2019-10-20', 528, 82, 32),('2017-3-12', '2019-12-11', 471, 83, 45),('2021-10-23', '2018-2-24', 733, 84, 14),('2017-4-10', '2018-6-2', 787, 85, 47),
('2018-12-8', '2020-12-15', 875, 86, 22),('2017-3-21', '2020-6-15', 948, 87, 7),('2017-3-5', '2017-4-25', 313, 88, 1),('2020-7-10', '2017-11-1', 233, 89, 10),('2020-6-2', '2021-9-21', 638, 90, 11),
('2020-1-15', '2019-7-25', 913, 91, 10),('2019-4-12', '2019-3-9', 356, 92, 6),('2018-6-10', '2018-2-13', 871, 93, 29),('2019-12-24', '2019-10-20', 242, 94, 8),('2019-12-15', '2017-4-25', 587, 95, 26),
('2021-11-8', '2021-11-17', 758, 96, 18),('2020-6-20', '2017-11-11', 367, 97, 25),('2018-2-23', '2020-8-23', 994, 98, 34),('2020-6-4', '2017-12-23', 249, 99, 32),('2021-3-19', '2020-10-13', 382, 100, 44),
('2020-1-6', '2018-9-23', 732, 101, 47),('2019-2-16', '2018-9-13', 616, 102, 31),('2017-2-1', '2017-10-7', 747, 103, 4),('2019-8-5', '2018-10-14', 697, 104, 50),('2017-9-14', '2018-7-25', 451, 105, 3),
('2019-2-11', '2021-6-12', 194, 106, 28),('2020-8-3', '2021-2-13', 893, 107, 22),('2019-10-1', '2021-1-24', 689, 108, 19),('2021-2-11', '2020-4-10', 964, 109, 45),('2018-7-17', '2017-9-10', 125, 110, 6),
('2021-3-6', '2021-2-6', 576, 111, 42),('2017-12-23', '2019-5-23', 770, 112, 21),('2020-2-11', '2019-8-12', 997, 113, 1),('2017-3-16', '2018-2-5', 275, 114, 36),('2019-7-18', '2021-6-3', 844, 115, 40),
('2021-5-25', '2021-2-18', 779, 116, 7),('2020-8-13', '2021-4-22', 810, 117, 44),('2019-4-5', '2018-1-20', 180, 118, 49),('2020-10-6', '2018-4-8', 496, 119, 22),('2017-1-5', '2020-3-9', 445, 120, 2),
('2018-9-14', '2021-9-22', 117, 121, 48),('2021-9-1', '2018-8-20', 871, 122, 9),('2021-7-24', '2020-12-15', 547, 123, 17),('2019-7-24', '2020-1-25', 219, 124, 19),('2020-6-9', '2021-11-10', 339, 125, 2),
('2018-2-12', '2018-6-10', 850, 126, 42),('2017-12-8', '2019-4-14', 914, 127, 41),('2020-2-1', '2018-5-24', 808, 128, 34),('2020-12-12', '2018-6-13', 706, 129, 6),('2017-10-2', '2020-10-8', 904, 130, 7),
('2019-11-16', '2021-1-8', 707, 131, 6),('2021-4-12', '2020-11-18', 592, 132, 4),('2021-5-18', '2021-4-9', 815, 133, 7),('2017-3-7', '2021-2-7', 508, 134, 50),('2017-5-12', '2019-4-21', 809, 135, 32),
('2019-3-25', '2018-9-18', 939, 136, 44),('2017-7-18', '2021-11-10', 199, 137, 28),('2019-5-9', '2018-10-15', 446, 138, 14),('2020-6-11', '2020-7-24', 322, 139, 42),('2019-6-24', '2021-4-10', 242, 140, 24),
('2018-10-13', '2021-11-17', 333, 141, 30),('2019-11-19', '2021-6-17', 628, 142, 14),('2019-3-15', '2020-2-10', 590, 143, 16),('2017-6-20', '2020-1-8', 973, 144, 11),('2021-4-22', '2018-9-9', 424, 145, 20),
('2021-12-23', '2020-12-10', 844, 146, 15),('2019-8-18', '2019-8-20', 456, 147, 18),('2019-1-4', '2019-10-5', 206, 148, 42),('2018-3-1', '2020-7-8', 764, 149, 19),('2018-8-18', '2019-8-9', 465, 150, 20),
('2019-7-17', '2021-3-7', 234, 151, 35),('2019-4-4', '2020-1-4', 735, 152, 42),('2021-4-1', '2017-1-15', 328, 153, 39),('2020-1-13', '2021-1-20', 771, 154, 34),('2018-11-20', '2020-4-13', 267, 155, 21),
('2019-12-11', '2020-4-13', 274, 156, 6),('2020-12-11', '2020-10-4', 714, 157, 48),('2018-2-24', '2019-5-5', 902, 158, 3),('2017-10-17', '2019-1-17', 793, 159, 5),('2018-12-8', '2019-6-11', 789, 160, 1),
('2017-2-4', '2018-12-11', 551, 161, 35),('2018-6-3', '2017-11-14', 160, 162, 15),('2020-7-25', '2020-3-15', 252, 163, 35),('2019-8-19', '2019-6-25', 900, 164, 44),('2021-8-7', '2019-12-22', 808, 165, 31),
('2020-7-1', '2019-3-5', 589, 166, 7),('2019-12-19', '2018-2-22', 448, 167, 15),('2019-9-9', '2018-3-10', 303, 168, 46),('2019-12-14', '2018-5-17', 284, 169, 41),('2019-6-17', '2018-4-21', 325, 170, 47),
('2019-7-20', '2019-2-25', 945, 171, 11),('2017-4-18', '2020-2-4', 958, 172, 25),('2021-12-11', '2018-6-22', 535, 173, 28),('2019-4-2', '2020-7-6', 242, 174, 39),('2021-1-9', '2018-11-5', 461, 175, 28),
('2019-4-5', '2017-3-13', 282, 176, 48),('2020-5-23', '2020-3-9', 181, 177, 18),('2020-4-11', '2021-1-14', 218, 178, 31),('2020-6-20', '2017-7-23', 889, 179, 39),('2021-3-17', '2020-6-5', 772, 180, 22),
('2017-7-9', '2018-8-18', 668, 181, 1),('2020-1-17', '2017-11-11', 883, 182, 39),('2018-8-1', '2018-8-21', 396, 183, 30),('2019-6-1', '2019-7-6', 122, 184, 47),('2021-5-13', '2018-12-9', 940, 185, 16),
('2017-9-21', '2020-9-14', 361, 186, 47),('2017-3-15', '2021-2-21', 997, 187, 17),('2017-11-2', '2018-3-3', 434, 188, 49),('2017-8-4', '2019-11-20', 763, 189, 22),('2020-5-7', '2020-3-22', 993, 190, 18),
('2019-3-12', '2020-12-12', 150, 191, 21),('2017-2-14', '2019-1-13', 811, 192, 29),('2018-9-12', '2021-6-1', 947, 193, 33),('2018-8-22', '2019-4-9', 650, 194, 23),('2018-1-9', '2020-5-23', 771, 195, 41),
('2018-8-3', '2020-3-18', 784, 196, 3),('2018-9-4', '2019-5-19', 936, 197, 44),('2017-3-20', '2020-12-14', 456, 198, 5),('2018-12-1', '2021-7-23', 430, 199, 4),('2019-4-1', '2020-9-3', 887, 200, 42),
('2017-8-20', '2019-12-22', 841, 201, 8),('2020-1-3', '2018-1-10', 757, 202, 11),('2018-7-16', '2019-9-18', 237, 203, 16),('2017-1-12', '2020-2-12', 458, 204, 29),('2018-5-9', '2017-3-21', 922, 205, 10),
('2020-6-7', '2020-2-11', 690, 206, 20),('2020-3-10', '2020-5-15', 576, 207, 16),('2017-8-14', '2021-6-17', 906, 208, 14),('2020-12-18', '2021-12-15', 589, 209, 9),('2021-7-13', '2018-9-7', 781, 210, 49),
('2017-5-17', '2019-7-13', 201, 211, 41),('2019-9-2', '2017-9-13', 141, 212, 8),('2017-7-11', '2021-12-17', 877, 213, 2),('2017-2-14', '2021-11-16', 795, 214, 13),('2019-9-13', '2018-2-19', 896, 215, 48),
('2021-3-18', '2021-1-24', 705, 216, 4),('2019-9-5', '2017-12-13', 715, 217, 16),('2018-10-9', '2020-7-12', 328, 218, 45),('2017-2-12', '2019-1-5', 894, 219, 31),('2017-8-5', '2019-6-25', 613, 220, 46),
('2017-8-8', '2017-12-18', 457, 221, 28),('2018-4-11', '2020-11-19', 282, 222, 48),('2021-5-11', '2019-9-17', 833, 223, 11),('2019-4-2', '2020-6-22', 871, 224, 1),('2019-6-18', '2020-10-3', 507, 225, 8),
('2019-4-16', '2017-6-11', 626, 226, 2),('2017-4-2', '2021-10-12', 255, 227, 17),('2021-12-7', '2021-12-10', 546, 228, 37),('2017-5-13', '2019-12-11', 443, 229, 24),('2019-3-3', '2021-6-9', 778, 230, 14),
('2020-11-8', '2020-5-11', 727, 231, 31),('2021-6-24', '2020-12-10', 570, 232, 24),('2021-9-3', '2017-5-3', 464, 233, 40),('2017-11-7', '2017-1-21', 336, 234, 30),('2018-9-13', '2021-8-10', 888, 235, 27),
('2017-5-10', '2019-8-2', 630, 236, 5),('2018-6-9', '2018-9-17', 701, 237, 25),('2020-3-16', '2021-10-4', 706, 238, 6),('2018-5-6', '2021-11-11', 991, 239, 7)
;

INSERT INTO Parkplatz(kunde_id, hotel_id, nummer) VALUES
(124, 11, 29),(68, 16, 13),(47, 5, 70),(97, 43, 35),(38, 17, 91),(102, 50, 20),(5, 22, 47),(91, 43, 87),(104, 1, 80),(110, 13, 84),
(120, 35, 58),(64, 35, 53),(29, 20, 73),(68, 9, 52),(76, 31, 82),(149, 1, 83),(21, 39, 37),(140, 29, 41),(86, 48, 58),(48, 50, 39),
(126, 15, 11),(31, 37, 90),(47, 19, 86),(38, 32, 84),(76, 21, 8),(100, 13, 49),(46, 48, 53),(121, 30, 84),(88, 30, 19),(36, 36, 22),
(94, 19, 74),(26, 19, 13),(126, 20, 79),(60, 41, 97),(97, 24, 80),(17, 26, 57),(29, 23, 91),(144, 44, 24),(108, 30, 61),(26, 46, 85),
(93, 36, 82),(70, 35, 5),(52, 22, 92),(118, 40, 19),(119, 21, 8),(40, 30, 59),(22, 44, 85),(86, 26, 78),(80, 34, 92),(16, 37, 32),
(95, 34, 57),(125, 6, 82),(79, 48, 44),(51, 37, 58),(20, 17, 79),(68, 33, 42),(10, 20, 79),(132, 46, 5),(14, 4, 32),(21, 34, 36),
(94, 39, 10),(141, 2, 16),(137, 23, 42),(53, 36, 61),(68, 12, 85),(31, 28, 18),(34, 27, 4),(92, 15, 90),(49, 44, 23),(144, 31, 74),
(86, 39, 61),(141, 10, 28),(55, 14, 58),(138, 4, 71),(16, 27, 96),(17, 1, 51),(13, 39, 67),(70, 14, 18),(67, 39, 89),(118, 16, 98),
(42, 14, 4),(131, 27, 89),(72, 22, 98),(133, 43, 78),(76, 14, 87),(92, 40, 38),(116, 46, 15),(117, 10, 45),(48, 16, 25),(99, 5, 77),
(127, 9, 6),(76, 49, 74),(85, 6, 56),(47, 35, 9),(66, 3, 79),(150, 22, 34),(110, 14, 80),(120, 10, 67),(31, 6, 9),(131, 14, 19),
(113, 13, 48),(78, 20, 96),(60, 13, 5),(132, 43, 19),(146, 21, 41),(75, 14, 64),(145, 39, 98),(61, 18, 12),(72, 35, 47),(42, 32, 29),
(141, 26, 30),(16, 25, 84),(145, 50, 24),(8, 4, 73),(12, 3, 36),(96, 1, 10),(9, 38, 35),(135, 3, 19),(12, 46, 40),(33, 15, 81),
(15, 35, 60),(55, 33, 25),(94, 37, 90),(43, 49, 42),(103, 24, 89),(120, 29, 33),(57, 45, 98),(81, 45, 12),(110, 21, 28),(7, 30, 24),
(114, 20, 56),(134, 27, 87),(69, 32, 91),(117, 31, 4),(143, 23, 37),(88, 24, 93),(64, 43, 94),(115, 22, 33),(17, 42, 16),(102, 36, 52),
(100, 9, 56),(45, 41, 16),(77, 37, 3),(44, 40, 48),(142, 47, 75),(31, 13, 27),(100, 18, 18),(49, 18, 5),(47, 28, 63),(143, 34, 74),
(95, 34, 86),(146, 2, 8),(110, 38, 24),(64, 42, 10),(76, 6, 48),(80, 3, 41),(61, 48, 32),(148, 17, 36),(118, 9, 86),(65, 38, 96),
(144, 34, 60),(70, 46, 64),(108, 36, 31),(55, 32, 48),(140, 18, 62),(45, 20, 37),(55, 1, 29),(67, 47, 77),(56, 17, 24),(83, 36, 41),
(114, 39, 33),(118, 9, 83),(136, 36, 24),(54, 49, 97),(12, 4, 37),(142, 39, 90),(137, 50, 25),(129, 22, 90),(42, 18, 91),(14, 15, 40),
(147, 29, 19),(119, 44, 45),(45, 47, 10),(122, 41, 86),(138, 29, 88),(34, 6, 85),(49, 27, 49),(47, 18, 48),(148, 34, 35),(140, 49, 72),
(70, 12, 11),(11, 32, 34),(53, 44, 61),(9, 31, 24),(128, 46, 65),(102, 14, 6),(113, 15, 58),(16, 38, 29),(4, 43, 39)
;

INSERT INTO Buchung_Fahrzeug( fahrzeug_id, kunde_id) VALUES
(79, 179),
(59, 17),(122, 33),(77, 161),(30, 134),(173, 89),(144, 196),(185, 168),(161, 161),(152, 185),(70, 147),
(88, 211),(68, 136),(106, 125),(50, 46),(75, 109),(180, 65),(36, 66),(64, 32),(171, 97),(48, 101),
(155, 99),(68, 132),(88, 54),(145, 92),(141, 152),(70, 48),(96, 6),(40, 88),(52, 29),(64, 117),
(111, 145),(113, 124),(197, 50),(154, 213),(15, 188),(66, 228),(116, 143),(171, 51),(165, 27),(30, 65),
(61, 13),(185, 167),(165, 75),(4, 61),(190, 91),(15, 2),(182, 148),(152, 17),(28, 150),(73, 77),
(17, 126),(31, 124),(32, 219),(185, 218),(125, 213),(16, 210),(139, 23),(150, 182),(47, 108),(129, 78),
(121, 183),(127, 74),(19, 142),(107, 106),(174, 201),(176, 28),(28, 197),(77, 135),(184, 48),(109, 127),
(37, 152),(11, 62),(54, 166),(53, 101),(121, 155),(120, 18),(190, 2),(6, 234),(122, 82),(158, 124),
(16, 2),(126, 230),(80, 215),(141, 196),(60, 220),(6, 195),(134, 221),(12, 25),(173, 209),(156, 201),
(182, 219),(132, 58),(175, 180),(186, 213),(32, 59),(17, 202),(64, 152),(61, 171),(198, 55);

INSERT INTO Buchung_Flug (flug_id, kunde_id)
VALUES(41,60),(82,49),(200,4),(60,53),(83,163),(103,146),(9,13),(131,195),(153,110),(63,189),(192,137),(54,211),(98,83),(167,95),(74,167),(188,120),
(147,84),(183,151),(39,192),(34,85),(100,169),(165,136),(185,148),(26,237),(135,179),(171,117),(195,160),(167,44),(181,85),(97,146),(92,45),(91,154),
(141,120),(180,62),(142,36),(50,99),(91,120),(128,3),(79,225),(64,113),(80,188),(119,133),(118,136),(143,160),(1,15),(187,180),(186,162),(89,64),
(61,245),(66,132),(90,162),(16,65),(181,22),(20,108),(173,97),(62,189),(140,214),(161,199),(156,94),(14,213),(143,50),(94,159),(48,147),(152,198),
(3,14),(41,207),(110,233),(123,91),(191,69),(95,82),(60,103),(66,18),(20,68),(172,134),(196,48),(171,146),(70,25),(168,4),(51,71),(188,122),
(43,205),(25,181),(102,70),(35,147),(131,81),(125,26),(123,45),(76,58),(31,3),(36,116),(107,24),(121,245),(123,130),(183,18),(75,133),(16,128),
(63,150),(45,17),(193,36),(104,232),(169,106),(132,58),(87,26),(103,66),(133,95),(182,95),(188,73),(46,242),(35,200),(64,211),(104,178),(36,76),
(45,116),(86,105),(79,78),(177,208),(119,112),(37,129),(193,16),(132,93),(169,144),(185,151),(134,242),(127,135),(73,198),(84,82),(9,126),(72,125),
(40,227),(152,80),(146,81),(125,26),(29,94),(93,57),(135,245),(31,133),(179,211),(185,52),(137,214),(82,56),(178,48),(34,194),(188,240),(143,147),
(98,104),(87,32),(47,179),(192,187),(5,195),(141,36),(115,66),(72,39),(71,9),(117,92),(57,56),(195,79),(151,85),(191,43),(107,97),(11,151),
(165,105),(165,44),(4,83),(2,23),(32,29),(113,102),(2,232),(191,208),(153,170),(111,246),(157,64),(103,147),(51,104),(125,147),(156,177),(69,11),
(27,211),(165,98),(150,1),(9,120),(103,34),(77,210),(99,151),(190,65),(3,55),(159,94),(20,239),(65,217),(134,17),(65,238),(149,89),(106,110),
(180,57),(145,53),(198,81),(125,120),(131,78),(19,106),(46,85),(16,129),(143,216),(61,125),(191,51),(80,216),(104,77),(24,224),(96,99),(145,114),
(114,34),(164,28),(200,94),(82,5),(10,90),(160,150),(45,102),(73,91),(62,198),(118,126),(132,54),(33,87),(131,23),(29,111),(15,72),(151,162),
(76,80),(115,34),(58,173),(169,175),(173,176),(84,102),(57,34),(185,244),(185,13),(127,61),(19,200),(58,148),(117,122),(110,118),(159,126),(144,21),
(51,218),(78,31),(145,239),(164,51),(68,236),(133,110),(60,222),(96,92),(71,7),(92,21),(98,41),(187,241),(136,78),(152,171),(109,86),(69,168),
(50,91),(155,93),(6,228),(157,114),(95,73),(157,79),(136,220),(174,135),(50,109),(180,41),(66,238),(49,152),(154,106),(129,107),(9,13),(124,72),
(70,46),(170,170),(104,122),(179,62),(175,189),(48,17),(179,86),(90,198),(80,2),(66,56),(150,223),(156,56),(136,209),(186,11),(169,231),(103,64),
(184,173),(86,91),(198,232),(80,70),(23,226),(130,11),(32,137),(83,186),(157,244),(194,61),(20,68),(200,82),(115,193),(192,209),(147,77),(130,42),
(153,187),(109,115),(10,163),(182,155),(178,222),(63,182),(187,139),(189,163),(70,14),(159,230),(179,162),(110,103),(82,184),(52,142),(138,181),
(80,69),(11,156),(59,78),(151,37),(166,166),(57,89),(43,200),(152,170),(88,67),(159,171),(188,52),(1,149),(111,4),(67,19),(83,179),(159,54),
(110,200),(103,68),(69,164),(155,82),(65,42),(170,114),(129,197),(8,190),(68,222),(140,170),(53,57),(114,239),(135,90),(182,127),(13,70),(163,115),
(10,71),(31,183),(192,145),(33,43),(173,92),(55,8),(139,123),(3,224),(51,164),(102,152),(94,200),(184,242),(101,108),(42,5),(34,160),(117,227),
(46,167),(119,204),(35,141),(125,31),(95,87),(74,146),(187,103),(2,123),(76,1),(193,100),(180,165),(74,210),(109,189),(85,146),(162,203),(10,67),
(33,180),(174,108),(92,8),(52,182),(109,84),(59,103),(184,209),(60,93),(15,45),(148,57),(127,10),(63,153),(189,29),(81,17),(36,60),(156,203),
(180,225),(113,182),(112,104),(35,116),(24,107),(71,53),(191,154),(143,88),(114,195),(22,76),(182,166),(136,68),(196,130),(111,11),(153,208),(188,136),
(102,151),(168,142),(70,7),(123,158),(73,98),(58,22),(160,37),(131,146),(186,104),(166,107),(81,62),(191,213),(131,236),(181,210),(54,207),(68,49),
(194,37),(118,227),(170,59),(45,205),(90,172),(141,142),(114,81),(175,111),(167,60),(67,172),(4,210),(191,245),(24,93),(196,113),(156,244),(58,173),
(17,145),(102,152),(73,244),(190,163),(161,75),(49,36),(110,115),(8,37),(77,206),(120,69),(62,54),(192,242),(109,81),(34,158),(68,95),(54,227),
(52,122),(121,114),(90,62),(133,83),(129,24),(91,184),(161,177),(110,61),(50,90),(18,22),(182,53),(65,109),(115,134),(138,71),(178,142),(149,49),
(170,23),(33,229),(154,156),(135,244),(162,140),(2,187),(109,176),(27,91),(141,155),(189,245),(49,7),(193,5),(167,1),(196,57),(70,1),(63,139),
(15,199),(165,230),(96,46),(76,168),(68,244),(141,162),(183,147),(76,222),(160,78),(147,176),(127,198),(186,231),(6,246),(124,67),(162,48),(56,113),
(164,1),(75,66),(120,34),(30,36),(4,231),(93,194),(141,116),(91,225),(139,201),(5,45),(118,205),(150,109),(156,172),(143,182),(156,163),(145,181),
(133,119),(49,63),(41,229),(138,57),(86,58),(30,178),(65,98),(167,42),(173,236),(75,29),(29,51),(184,86),(194,180),(77,190),(26,223),(190,150),
(95,13),(197,192),(17,37),(127,30),(70,151),(15,80),(199,61),(82,185),(54,3),(143,125),(104,4),(162,12),(62,120),(109,159),(2,37),(191,175),
(109,85),(121,152),(3,127),(118,94),(33,225),(16,157),(66,222),(157,168),(76,76),(26,12),(5,231),(45,111),(18,197),(41,101),(148,151),(102,33),
(37,164),(197,27),(195,199),(57,1),(12,172),(183,194),(117,144),(18,162),(194,134),(147,244),(173,88),(122,227),(39,176),(175,57),(161,188),(120,31),
(28,163),(36,84),(45,207),(169,104),(177,44),(92,84),(150,148),(171,31),(174,186);


/*SQL Abfragen*/

/*
Abfrage 1:
Das Resultat zeigt alle Hotels und deren durchschnittliche Bewertung, basierend auf Bewertungen der letzten 122 Monate (gerechnet ab aktuellem Tagesdatum). Sortiert nach der Bewertung absteigend
*/
SELECT Hotel.hotel_name AS Hotel_Name, AVG(Bewertung.stars) AS Durchschnittliche_Bewertung
FROM Hotel
INNER JOIN Bewertung ON Bewertung.hotel_id = Hotel.hotel_id
WHERE DATE(Bewertung.bewertung_datum) > DATE_SUB(CURDATE(), INTERVAL 122 MONTH) GROUP BY Hotel.hotel_id;

/*
Abfrage 2:
Das Resultat zeigt pro Destination (Stadt oder Region) die Anzahl Hotels, den Durchschnitt der Bewertungen dieser Hotels und wieviele Buchungen auf dem Portal zu der Stadt/Region bereits getätigt wurden
*/
SELECT ort_name, COUNT(DISTINCT Buchung_hotel.buchung_hotel_id) AS Anzahl_Buchungen, AVG(stars) AS Durchschnittliche_Bewertung, COUNT(DISTINCT Hotel.hotel_id) AS Anzahl_Hotels
FROM Buchung_hotel
INNER JOIN Appartement ON Buchung_hotel.appartement_id = Appartement.appartement_id
INNER JOIN Hotel ON Appartement.hotel_id = Hotel.hotel_id
INNER JOIN Adresse ON Adresse.adresse_id = Hotel.adresse_id
INNER JOIN Ort ON Adresse.ort_id = Ort.ort_id
INNER JOIN Bewertung ON Bewertung.hotel_id = Hotel.hotel_id
GROUP BY Ort.ort_id;

/*
Abfrage 3:
Das Resultat zeigt zu allen Abflugs- und Ankunftsorten (= Flughäfen) die Summe der Passagiere, welche über das Portal einen Flug gebucht haben. Sortiert nach der Summe absteigend
*/
SELECT a.ort_name AS von, b.ort_name AS bis, count(kunde_id) AS Anzahl_Passagiere
FROM Buchung_Flug
INNER JOIN Flug ON Flug.flug_id = Buchung_Flug.flug_id
INNER JOIN Ort a ON a.ort_id = Flug.ort_id_von
INNER JOIN Ort b ON b.ort_id = Flug.ort_id_bis
GROUP BY Buchung_Flug.flug_id
ORDER BY COUNT(kunde_id) DESC;

/*
Abfrage 4:
Das Resultat zeigt die 10 Hotels, welche in den letzten 12 Monaten die höchste Buchungsquote gerechnet an den Anzahl übernachtungen haben. Sortiert nach der Buchungsquote absteigend
*/
SELECT Hotel.hotel_name, count(Buchung_hotel.buchung_hotel_id) AS Anzahl_Buchungen
FROM Hotel
INNER JOIN Appartement ON Appartement.hotel_id = Hotel.hotel_id
INNER JOIN Buchung_hotel ON Buchung_hotel.appartement_id = Appartement.appartement_id
WHERE DATE (Buchung_hotel.anfangs_datum) > DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY Hotel.hotel_id
ORDER BY Anzahl_Buchungen DESC;

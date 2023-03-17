--Script automatically executed on startup by Hibernate
--revision 1

drop all objects;

create TABLE bank (
    id bigint NOT NULL AUTO_INCREMENT,
    name varchar(255),
    shortname varchar(16),
    PRIMARY KEY (id)
);

create TABLE account (
    id bigint NOT NULL AUTO_INCREMENT,
    corporate BOOLEAN,
    name varchar(255),
    shortname varchar(16),
    balance float,
    bank_id bigint,
    PRIMARY KEY (id),
    FOREIGN KEY (bank_id) REFERENCES bank(id)
);

create TABLE transfer (
    id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
    src_account_id bigint NOT NULL,
    dest_account_id bigint NOT NULL,
    units float,
    internal BOOLEAN,
    FOREIGN KEY (src_account_id) REFERENCES account(id),
    FOREIGN KEY (dest_account_id) REFERENCES account(id)
);

create TABLE currency (
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(255),
  shortname varchar(4)
);

create TABLE country (
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(255),
  shortname varchar(4),
  currency_id bigint,
  FOREIGN KEY (currency_id) REFERENCES currency(id)
);

create TABLE city (
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(255),
  shortname varchar(4),
  country_id bigint,
  FOREIGN KEY (country_id) REFERENCES country(id)
);

create TABLE credit (
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  account_id bigint NOT NULL,
  bank_id bigint NOT NULL,
  amount float,
  currency_id bigint NOT NULL,
  FOREIGN KEY (account_id) REFERENCES account(id),
  FOREIGN KEY (bank_id) REFERENCES bank(id),
  FOREIGN KEY (currency_id) REFERENCES currency(id)
);

create TABLE credit_card(
   id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
   account_id bigint NOT NULL,
   is_active BOOLEAN,
   bank_id bigint NOT NULL,
   currency_id bigint,
   balance float,
   credit_limit float,
   FOREIGN KEY (account_id) REFERENCES account(id),
   FOREIGN KEY (bank_id) REFERENCES bank(id),
   FOREIGN KEY (currency_id) REFERENCES currency(id)
);

create TABLE debit_card(
   id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
   account_id bigint NOT NULL,
   is_active BOOLEAN,
   bank_id bigint NOT NULL,
   currency_id bigint NOT NULL,
   balance float,
   FOREIGN KEY (account_id) REFERENCES account(id),
   FOREIGN KEY (bank_id) REFERENCES bank(id),
   FOREIGN KEY (currency_id) REFERENCES currency(id)
);

create TABLE real_estate(
 id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
 address VARCHAR(255),
 city_id bigint,
 FOREIGN KEY (city_id) REFERENCES city(id)
);

create TABLE log(
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  created TIMESTAMP not null,
  file_path varchar(1024)
);

insert into bank(id, shortname, name) values (1001, 'A', 'Agilent Technologies');
insert into account(id, corporate, shortname, name, balance, bank_id) values (2001, TRUE, 'MUSA', 'Murphy USA Inc', 2001.24, 1001);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2002, true, 'RAD', 'Rite Aid Corp', 0.7100, 1001);
insert into transfer(id, src_account_id, dest_account_id, units, internal) values (3001, 2002, 2001, 123.44, TRUE);
insert into currency(id, name, shortname) values (30001, 'Polish Zloty', 'PLN');
insert into country(id, name, shortname, currency_id) values (10001, 'Poland', 'PL', 30001);
insert into city(id, name, shortname, country_id) values (20001, 'Wroclaw', 'WRO', 10001);
insert into credit(id, account_id, bank_id, amount, currency_id) values (40001, 2001, 1001, 1.00, 30001);
insert into credit_card (id, account_id, is_active, bank_id, currency_id, balance, credit_limit) values (100001, 2001, TRUE, 1001, 30001, 123455.33, 350000);
insert into debit_card (id, account_id, is_active, bank_id, currency_id, balance) values (100001, 2001, TRUE, 1001, 30001, 455.33);
insert into real_estate(id, address, city_id) values (55001, 'Powstancow Slaskich 33', 20001);
insert into log(id, created, file_path) values (130101, '2019-10-15 00:00:01', null);

insert into bank(id, shortname, name) values(1002, 'AAC', 'Aac Holdings Inc');
insert into bank(id, shortname, name) values(1003, 'AAN', 'Aarons Inc');
insert into bank(id, shortname, name) values(1004, 'AAP', 'Advance Auto Parts Inc');
insert into bank(id, shortname, name) values(1005, 'AAT', 'American Assets Trust');
insert into bank(id, shortname, name) values(1006, 'AB', 'Alliancebernstein Holding LP');
insert into bank(id, shortname, name) values(1007,'ABB', 'Abb Ltd');
insert into bank(id, shortname, name) values(1008,'ABBV', 'Abbvie Inc');
insert into bank(id, shortname, name) values(1009,'ABC', 'Amerisourcebergen Corp');
insert into bank(id, shortname, name) values(1010,'AA', 'Alcoa Corp');
insert into bank(id, shortname, name) values(1011, 'ABEV', 'Ambev S.A.');
insert into bank(id, shortname, name) values(1012,'ABG', 'Asbury Automotive Group Inc');
insert into bank(id, shortname, name) values(1013,'ABM', 'ABM Industries Incorporated');
insert into bank(id, shortname, name) values(1014,'B', 'Barnes Group');
insert into bank(id, shortname, name) values(1015,'BA', 'Boeing Company');
insert into bank(id, shortname, name) values(1016,'BABA', 'Alibaba Group Holding');
insert into bank(id, shortname, name) values(1017,'BAC', 'Bank of America Corp');
insert into bank(id, shortname, name) values(1018,'BAC-A', 'Bank of America Corp Pfd A');
insert into bank(id, shortname, name) values(1019,'BAC-B', 'Bank of America Corp. Dep Shs Repstg');
insert into bank(id, shortname, name) values(1020,'BAC-C', 'Bank of America Corp Pfd C');
insert into bank(id, shortname, name) values(1021, 'BAC-E', 'Bank of America Corp Dep R');
insert into bank(shortname, name) values('BAC-K', 'Bank of America Corp Dep Shs Repstg');
insert into bank(shortname, name) values('BAC-L', 'Bank of America Corp Pfd L');
insert into bank(id, shortname, name) values(1024, 'BAC-W', 'Bank of America Corp Pfd W');
insert into bank(id, shortname, name) values(1025, 'BAC-Y', 'Bank of America Corp Pfd Y');
insert into bank(shortname, name) values('BAC.A', 'Bank of America Corp Cl A');
insert into bank(shortname, name) values('BAF', 'Blackrock Income Inv Quality Trust');
insert into bank(id, shortname, name) values(1028, 'BAH', 'Booz Allen Hamilton Holding Corp');
insert into bank(id, shortname, name) values(1029, 'BAK', 'Braskem S.A.');
insert into bank(id, shortname, name) values(1030, 'BAM', 'Brookfield Asset Management Inc');
insert into bank(id, shortname, name) values(1031, 'BAN-D', 'Bank of California Inc Pref Share Series');
insert into bank(shortname, name) values('BAN-E', 'Banc of California Inc');
insert into bank(shortname, name) values('BANC', 'First Pactrust Bancorp');
insert into bank(shortname, name) values('BAP', 'Credicorp Ltd');
insert into bank(shortname, name) values('BAS', 'Basic Energy Services');
insert into bank(shortname, name) values('BAX', 'Baxter International Inc');
insert into bank(shortname, name) values('MS-K', 'Morgan Stanley Dep Shs Repstg');
insert into bank(shortname, name) values('MSA', 'Msa Safety Inc');
insert into bank(shortname, name) values('MSB', 'Mesabi Trust');
insert into bank(shortname, name) values('MSC', 'Studio City Intl Holdings Ltd ADR');
insert into bank(id, shortname, name) values(1041, 'GOOGL', 'Google Inc.');
insert into bank(shortname, name) values('MSD', 'Morgan Stanley Emerging Markets Debt');
insert into bank(shortname, name) values('MSF', 'Morgan Stanley Emerging Markets Fund Inc');
insert into bank(shortname, name) values('MSG', 'The Madison Square Garden Comp');
insert into bank(shortname, name) values('MSGN', 'Msg Networks Inc');
insert into bank(shortname, name) values('MSI', 'Motorola Solutions');
insert into bank(shortname, name) values('MSL', 'Midsouth Bancorp');
insert into bank(shortname, name) values('MSM', 'Msc Industrial Direct Company');
insert into bank(shortname, name) values('MT', 'Arcelormittal');
insert into bank(shortname, name) values('MTB', 'M&T Bank Corp');
insert into bank(shortname, name) values('MTB-C', 'M&T Bank Corporation Fixed Rate');
insert into bank(id, shortname, name) values(1052, 'MTB.P', 'M&T Bank Corporation Fixed Rate');

insert into account(corporate, shortname, name, balance, bank_id) values (true, 'RAMP', 'Liveramp Holdings Inc.', 38.35, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2003, true, 'RBA', 'Ritchie Bros. Auctioneers Inc', 31.33, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'RBC', 'Regal-Beloit Corp', 69.18, 1021);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2005, true, 'XAN', 'Exantas Capital Corp', 9.760, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XAN-C', 'Exantas Capital Corp. Pfd', 23.85, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XEC', 'Cimarex Energy Co', 59.52, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XFLT', 'Xai Octagon Floating Alt Income Term', 7.300, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XHR', 'Xenia Hotels & Resorts Inc', 16.66, 1002);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2010, true, 'MZA', 'Muniyield Arizona Fund', 103, 1041);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2011, true, 'MX', 'Magnachip Semiconductor Corp', 84, 1041);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2012, true, 'MXF', 'Mexico Fund', 334, 1006);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2013, true, 'R', 'Ryder System', 46.23, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2014, true, 'RA', 'Brookfield Real Assets Income Fund Inc', 18.33, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2015, true, 'RACE', 'Ferrari N.V.', 97.87, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2016, true, 'XIN', 'Xinyuan Real Estate Co Ltd', 3.800, 1003);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XOM', 'Exxon Mobil Corp', 66.30, 1004);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XOXO', 'Xoxo Group Inc', 35.00, 1005);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XPO', 'Xpo Logistics Inc', 51.79, 1006);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XRF', 'China Rapid Finance Limited ADR', 1.200, 1007);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XRX', 'Xerox Corp', 19.48, 1008);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XYF', 'X Financial', 5.200, 1009);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'XYL', 'Xylem Inc', 61.74, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'RBS', 'Royal Bank Scotland Group Plc', 5.250, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'RBS-S', 'Royal Bank Scotland', 25.17, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'RC', 'Ready Capital Corp.', 13.97, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'RCA', 'Ready Capital Corp. 7.00%', 24.46, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UA', 'Under Armour Inc Class C Comm', 15.79, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UAA', 'Under Armour', 17.36, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UAN', 'Cvr Partners LP', 3.390, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UBA', 'Urstadt Biddle Properties Inc', 19.94, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UBP', 'Urstadt Biddle Properties Inc', 15.72, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UBP-G', 'Urstadt Biddle Properties Inc', 24.77, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UBP-H', 'Urstadt Biddle Properties Inc Pfd.', 23.67, 1012);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UBS', 'UBS Group Ag', 12.08, 1013);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UDR', 'United Dominion Realty Trust', 40.80, 1014);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UE', 'Urban Edge Properties', 16.84, 1015);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UFI', 'Unifi Inc', 22.331, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UFS', 'Domtar Corp', 35.2, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2040, true, 'UGI', 'Ugi Corp', 56.21, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UGP', 'Ultrapar Participacoes S.A.', 12.78, 1019);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UHS', 'Universal Health Services', 115.0, 1020);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UHT', 'Universal Health Realty Income Trust', 61.07, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UIS', 'Unisys Corp', 11.08, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2045, true, 'UL', 'Unilever Plc', 52.62, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2046, true, 'UMC', 'United Microelectronics Corp', 1.790, 1024);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2047, true, 'UMH', 'Umh Properties', 11.92, 1025);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2048, true, 'UMH-B', 'Umh Properties Inc', 25.63, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2049, true, 'UMH-C', 'Umh Properties Inc', 23.18, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UMH-D', 'Umh Properties Inc Cum Red Pfd Ser D', 22.00, 1028);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UN', 'Unilever Nv', 53.96, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNF', 'Unifirst Corp', 136.7, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNH', 'Unitedhealth Group Inc', 237.9, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNM', 'Unumprovident Corp', 28.07, 1001);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNMA', 'Unum Group 6.250% Junior Subordinated', 22.95, 1002);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNP', 'Union Pacific Corp', 132.5, 1003);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNT', 'Unit Corp', 14.17, 1004);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UNVR', 'Univar Inc', 16.92, 1005);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UPS', 'United Parcel Service', 93.35, 1006);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'URI', 'United Rentals', 99.57, 1007);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USA', 'Liberty All-Star Equity Fund', 5.000, 1008);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USAC', 'USA Compression Partners LP', 13.01, 1009);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USB', 'U.S. Bancorp', 44.64, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USB-A', 'U.S. Bancorp Depositary Shares', 770.0, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USB-H', 'U.S. Bancorp Dep Sh', 18.67, 1012);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USB-M', 'U.S. Bancorp', 26.70, 1013);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USB-O', 'U.S. Bancorp', 22.94, 1014);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USB-P', 'US Bancorp [De] Depositary Shs Repstg', 24.59, 1015);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USDP', 'USD Partners LP', 10.43, 1016);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USFD', 'US Foods Holding', 30.33, 1017);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USG', 'USG Corp', 42.90, 1018);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USM', 'United States Cellular Corp', 49.69, 1019);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USNA', 'Usana Health Sciences Inc', 113.4, 1020);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'USPH', 'U.S. Physical Therapy', 100.58, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UTI', 'Universal Technical Institute Inc', 3.485, 1024);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UTL', 'Unitil Corp', 51.95, 1025);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UTX', 'United Technologies Corp', 105.7, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UVE', 'Universal Insurance Holdings Inc', 37.13, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UVV', 'Universal Corp', 56.10, 1028);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UZA', 'United States Cellular Corp', 22.40, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UZB', 'United States Cellular Corpora', 24.14, 1020);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'UZC', 'United States Cellular Corpora', 24.52, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'L', 'Loews Corp', 43.87, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LAC', 'Lithium Americas Corp', 2.950, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LAD', 'Lithia Motors', 71.10, 1024);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LADR', 'Ladder Capital Corp', 15.25, 1025);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LAIX', 'Laix Inc. ADR', 7.840, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LAZ', 'Lazard Ltd', 35.23, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LB', 'L Brands Inc', 25.19, 1028);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LC', 'Lendingclub Corp', 2.620, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LDL', 'Lydall Inc', 19.81, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LEE', 'Lee Enterprises Inc', 2.035, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LEG', 'Leggett & Platt Inc', 35.02, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LEJU', 'Leju Holdings Ltd', 1.280, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LEN', 'Lennar Corp', 38.92, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LEN.B', 'Lennar Corp Cl B', 31.27, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LFC', 'China Life Insurance Company Ltd', 10.40, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGC', 'Legacy Acquisition Corp', 9.800, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGC.U', 'Legacy Acquisition Corp Units', 10.10, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGC.W', 'Legacy Acquisition Corp. WT', 0.3100, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.A', 'Lions Gate Banque Cl A', 14.76, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.B', 'Lions Gate Banque Cl B', 21313.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.H', 'Lions Gate Banque Cl2 Associated', 21312213.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.D', 'Lions Gate Banque Cl3 Associated', 143342223.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.E', 'Lions Gate Banque Cl4 Associated', 14334643523.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.F', 'Lions Gate Banque Cl5 Associated', 1643523.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.G', 'Lions Gate Banque Cl6 B', 1543944334.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGF.X', 'Lions Gate Banque Cl7 B', 15944334.04, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LGI', 'Lazard Global Total Return and', 13.01, 1028);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LH', 'Laboratory Corporation of America', 123.4, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LHC', 'Leo Holdings Corp. Class A', 9.700, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LHC.U', 'Leo Holdings Corp. Units Each Consisting', 10.21, 1025);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LHC.W', 'Leo Holdings Corp Warrants', 1.170, 1024);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LHO', 'Lasalle Hotel Properties', 32.49, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LHO-I', 'Lasalle Hotel Properties', 23.49, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LHO-J', 'Lasalle Hotel Properties', 22.35, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LII', 'Lennox International', 209.6, 1020);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LIN', 'Linde Plc', 153.4, 1019);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LITB', 'Lightinthebox Holding Co. Ltd', 1.465, 1018);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LKM', 'Link Motion Inc', 0.2400, 1017);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LKSD', 'Lsc Communications Inc', 7.250, 1016);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LL', 'Lumber Liquidators Holdings Inc', 10.110, 1015);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LLL', 'L-3 Communications Holdings', 166.7, 1014);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LLY', 'Eli Lilly and Company', 109.4, 1013);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LM', 'Legg Mason Inc', 24.20, 1012);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LMHA', 'Legg Mason Inc', 23.95, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LMHB', 'Legg Mason Inc', 20.02, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LMT', 'Lockheed Martin Corp', 254.6, 1009);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LN', 'Line Corp', 32.88, 1008);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LNC', 'Lincoln National Corp', 49.77, 1007);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LNC.W', 'Lincoln National Corp', 55.50, 1006);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LND', 'Brasilagro Brazi ADR', 4.090, 1005);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LNN', 'Lindsay Corp', 91.94, 1004);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LNT', 'Alliant Energy Corp', 43.59, 1003);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LOMA', 'Loma Negra Comp Indu Argentina Sociedad', 10.030, 1002);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LOR', 'Lazard World Dividend &', 8.170, 1003);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LOW', 'Lowes Companies', 88.38, 1004);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LPG', 'Dorian Lpg Ltd', 6.010, 1005);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LPI', 'Laredo Petroleum Holdings Inc', 3.300, 1006);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LPL', 'Lg Display Co. Ltd', 8.150, 1007);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LPT', 'Liberty Property Trust', 41.98, 1008);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LPX', 'Louisiana-Pacific Corp', 21.32, 1009);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LRN', 'K12 Inc', 22.84, 1010);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LSI', 'Life Storage', 95.80, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTC', 'Ltc Properties', 42.90, 1012);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTHM', 'Livent Corporation', 13.09, 1013);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTM', 'Latam Airlines Group S.A.', 9.860, 1014);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTN', 'Union Acquisition Corp', 10.05, 1015);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTN.P', 'Union Acquisition Corp Rights', 0.3600, 1016);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTN.U', 'Union Acquisition Corp', 10.70, 1017);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LTN.W', 'Union Acquisition Corp. Warrant', 0.2600, 1018);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LUB', 'Lubys Inc', 1.440, 1019);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LUV', 'Southwest Airlines Company', 45.69, 1020);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LVS', 'Las Vegas Sands', 49.35, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LW', 'Lamb Weston Holdings Inc', 74.43, 1021);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LXFR', 'Luxfer Holdings Plc', 16.78, 1029);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LXFT', 'Luxoft Holding Inc', 30.65, 1024);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LXP', 'Lexington Realty Trust', 8.140, 1011);
insert into account(corporate, shortname, name, balance, bank_id) values (true, 'LXP-C', 'Lexington Realty Tru', 48.75, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2160, true, 'LXU', 'Lsb Industries Inc', 5.560, 1021);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2161, true, 'LYB', 'Lyondellbasell Industries Nv', 80.61, 1028);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2162, true, 'LYG', 'Lloyds Banking Group Plc', 2.510, 1011);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2163, true, 'LYV', 'Live Nation Entertainment', 48.65, 1030);
insert into account(id, corporate, shortname, name, balance, bank_id) values (2164, true, 'LZB', 'La-Z-Boy Inc', 26.06, 1029);

insert into account(corporate, shortname, name, balance, bank_id) values (false, 'Jan', 'Kovalsky', 261.06, 1029);

insert into transfer(src_account_id, dest_account_id, units, internal) values (2005, 2003, 6633, FALSE);
insert into transfer(src_account_id, dest_account_id, units, internal) values (9, 2002, 81, FALSE);
insert into transfer(src_account_id, dest_account_id, units, internal) values (9, 2002, 8100, TRUE);
insert into transfer(src_account_id, dest_account_id, units, internal) values (8, 2002, 8103, FALSE);
insert into transfer(src_account_id, dest_account_id, units, internal) values (8, 2013, 8102, TRUE);

insert into currency(id, name, shortname) values (30002, 'Juan', '¥');
insert into currency(id, name, shortname) values (30003, 'US Dollar', 'USD');
insert into currency(id, name, shortname) values (30004, 'Yen', '¥');
insert into currency(id, name, shortname) values (30005, 'Pound', '£');
insert into currency(id, name, shortname) values (30006, 'Euro', 'EUR');
insert into currency(id, name, shortname) values (30007, 'Zloty', 'PLN');

insert into country(id, name, shortname, currency_id) values (10002, 'China', 'CN', 30002);
insert into country(id, name, shortname, currency_id) values (10003, 'United States', 'US', 30003);
insert into country(id, name, shortname, currency_id) values (10004, 'Japan', 'JAP', 30004);
insert into country(id, name, shortname, currency_id) values (10005, 'United Kingdom', 'UK', 30005);
insert into country(id, name, shortname, currency_id) values (10006, 'Portugal', 'POR', 30006);
insert into country(id, name, shortname, currency_id) values (10007, 'Spain', 'ES', 30006);
insert into country(name, shortname, currency_id) values ('France', 'FR', 30006);
insert into country(name, shortname, currency_id) values ('Italy', 'IT', 30006);
insert into country(name, shortname, currency_id) values ('Germany', 'DE', 30006);
insert into country(name, shortname, currency_id) values ('Poland', 'PL', 30007);

insert into city( name, shortname, country_id) values ('Bejing', 'BEG', 10002);
insert into city( name, shortname, country_id) values ('Shanghai', 'SHA', 10002);
insert into city( name, shortname, country_id) values ('New York', 'NY', 10003);
insert into city( name, shortname, country_id) values ('Boston', 'BOS', 10003);
insert into city( name, shortname, country_id) values ('Washington', 'WSH', 10003);

insert into debit_card (account_id, is_active, bank_id, currency_id, balance) values (2002, TRUE, 1001, 30001, 4155.33);
insert into debit_card (account_id, is_active, bank_id, currency_id, balance) values (2002, TRUE, 1002, 30001, 45.33);
insert into debit_card (account_id, is_active, bank_id, currency_id, balance) values (2003, TRUE, 1002, 30001, 45.33);

insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2002, FALSE, 1001, 30001, 0.22, 350000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2002, TRUE, 1002, 30006, 4993245.22, 5100245);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (4, TRUE, 1002, 30006, 4239932.40, 6000932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (6, TRUE, 1001, 30006, 149932, 390000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (6, TRUE, 1021, 30001, 343, 350);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2160, TRUE, 1013, 30005, 495.22, 500245);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2161, TRUE, 1029, 30005, 422.40, 600932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2162, TRUE, 1029, 30006, 129932, 390000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2163, TRUE, 1029, 30001, 0.22, 350000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2164, TRUE, 1002, 30006, 4993245.22, 5100245);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2040, TRUE, 1029, 30006, 4239932.40, 6000932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2045, FALSE, 1029, 30006, 149932, 390000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2046, TRUE, 1001, 30001, 343, 350);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2049, TRUE, 1029, 30005, 422.40, 600932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2046, TRUE, 1029, 30006, 129932, 390000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2160, TRUE, 1029, 30006, 4239932.40, 6000932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2164, TRUE, 1029, 30006, 4993245.22, 5100245);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2040, TRUE, 1029, 30006, 4239932.40, 6000932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2045, FALSE, 1029, 30006, 149932, 390000);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2046, FALSE, 1041, 30001, 343, 350);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2047, FALSE, 1029, 30005, 495.22, 500245);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2049, FALSE, 1029, 30005, 422.40, 600932);
insert into credit_card (account_id, is_active, bank_id, currency_id, balance, credit_limit) values (2046, FALSE, 1052, 30006, 129932, 390000);

insert into log(created, file_path) values ('2019-12-02 14:39:47', 'log1.txt');

--revision 2

create TABLE person(
   id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
   NIN varchar(15) NOT NULL, --National Identification Number e.g PESEL for Poland
   lastname varchar(255) NOT NULL,
   name varchar(16),
   address_id bigint,
   nationality_id bigint,
   FOREIGN KEY (address_id) REFERENCES real_estate(id),
   FOREIGN KEY (nationality_id) REFERENCES country(id)
);

create TABLE customer(
   id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
   lastname varchar(255) NOT NULL,
   name varchar(16) NOT NULL,
   address_id bigint NOT NULL,
   FOREIGN KEY (address_id) REFERENCES real_estate(id)
);

create TABLE car_insurance(
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customer_id bigint,
  FOREIGN KEY (customer_id) REFERENCES customer(id)
);

create TABLE car(
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
   brand varchar(100),
   car_model varchar(100),
   fuel char(3),

   color varchar(10),
   owner_id bigint,
   insurance_id bigint,
   previous_crashes boolean,

   FOREIGN KEY (owner_id) REFERENCES person(id),
   FOREIGN KEY (insurance_id) REFERENCES car_insurance(id)
);

create TABLE insurance_company(
	id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
	company_name varchar(255) NOT NULL
);

create TABLE life_insurance(
	id bigint NOT NULL AUTO_INCREMENT,
	person_id bigint,
	company_id bigint,

	FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (company_id) REFERENCES insurance_company(id)
);

create TABLE fiscal_office(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(100),
    address_id bigint,

    FOREIGN KEY (address_id) REFERENCES real_estate(id)
);

create TABLE pension_fund(
   id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
   name varchar(100)
);

create TABLE mobile_phone(
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  local_number char(9) NOT NULL,
  country_prefix varchar(5) NOT NULL
);

create TABLE mobile_phone_charges(
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  phone_id bigint NOT NULL,

  FOREIGN KEY (phone_id) REFERENCES mobile_phone(id)
);

create TABLE currency_exchange_transfers(
  id bigint NOT NULL PRIMARY KEY AUTO_INCREMENT,
  from_currency bigint NOT NULL,
  to_currency bigint NOT NULL,
  amount real NOT NULL,
  rate real NOT NULL,
  transfer_date TIMESTAMP not null,

  FOREIGN KEY (from_currency) REFERENCES currency(id),
  FOREIGN KEY (to_currency) REFERENCES currency(id)
);

insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL81072370013', 'Zawadzki', 'Szymon', 10002, 55001);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL55050795518', 'Nowak', 'Marcin', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL92010764410', 'Czech', 'Jakub', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL49072286510', 'Makowski', 'Ryszard', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL63073160301', 'Maniak', 'Alina', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL73090374900', 'Ziemier', 'Maja', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('US?', 'Drake', 'Jason', 10003,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('US?', 'Johnson', 'Jason', 10003,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL93073118905', 'Burska', 'Klara', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL77021263305', 'Gilewicz', 'Katarzyna', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL55010707519', 'Nawrot', 'Zenon', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL99013137715', 'Nowakowski', 'Arkadiusz', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('US241-19-4855', 'Hood', 'Wilfredo L.', 10003,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL93073180113', 'Nawrocki', 'Przemyslaw', 10002,null);
insert into person (NIN, lastname, name, nationality_id, address_id) values ('PL69111240310', 'Juskiewicz', 'Zbigniew', 10002,null);

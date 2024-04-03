	--veritaban� olu�tur
CREATE DATABASE foy3;

use foy3;

	--f�ydeki birimler tablosunu olu�turma
CREATE TABLE birimler (
    birim_id INT PRIMARY KEY,
    birim_ad NVARCHAR(50) NOT NULL,
);
	--f�ydeki calisanlar tablosunu olu�turma
CREATE TABLE calisanlar (
    calisan_id INT PRIMARY KEY,
    ad CHAR(25),
    soyad CHAR(25),
	maas INT,
	katilmaTarihi DATETIME,
	calisan_birim_id INT NOT NULL,
    FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
);
	--f�ydeki unvan tablosunu olu�turma
CREATE TABLE unvan (
	unvan_calisan_id INT NOT NULL,
	unvan_calisan CHAR(25),
	unvan_tarih DATETIME,
	FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id)
);
	--f�ydeki ikramiye tablosunu olu�turma
CREATE TABLE ikramiye (
	ikramiye_calisan_id INT NOT NULL,
	ikramiye_ucret INT,
	ikramiye_tarih DATETIME,
	FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id)
);

	--f�ydeki tablolar� istenilen �ekilde doldurmak i�in gereken sorgular
INSERT INTO birimler(birim_id,birim_ad) VALUES (1,'Yaz�l�m');
INSERT INTO birimler(birim_id,birim_ad) VALUES (2,'Donan�m');
INSERT INTO birimler(birim_id,birim_ad) VALUES (3,'G�venlik');
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(1,'�smail','��eri',100000,'2014-02-20',1);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(2,'Hami','Sat�lm��',80000,'2014-06-11',1);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(3,'Durmu�','�ahin',300000,'2014-02-20',2);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(4,'Ka�an','Yazar',500000,'2014-02-20',3);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(5,'Meryem','Soysald�',500000,'2014-06-11',3);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(6,'Duygu','Ak�ehir',200000,'2014-06-11',2);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(7,'K�bra','Seyhan',75000,'2014-01-20',1);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(8,'G�lcan','Y�ld�z',90000,'2014-04-11',3);
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(1,5000,'2016-02-20');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(2,3000,'2016-06-11');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(3,4000,'2016-02-20');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(1,4500,'2016-02-20');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(2,3500,'2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(1,'Y�netici','2016-02-20');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(2,'Personel','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(8,'Personel','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(5,'M�d�r','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(4,'Y�netici Yard�mc�s�','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(7,'Personel','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(6,'Tak�m Lideri','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(3,'Tak�m Lideri','2016-06-11');


--cevap 3
SELECT ad,soyad,maas FROM calisanlar WHERE calisan_birim_id IN (SELECT birim_id FROM birimler WHERE birim_ad = 'Yaz�l�m' OR birim_ad = 'Donan�m');

--cevap 4
SELECT ad,soyad,maas FROM calisanlar WHERE maas = (SELECT MAX(maas) FROM calisanlar);

--cevap 5
SELECT birim_ad,COUNT(calisan_id) FROM birimler , calisanlar WHERE birim_id = calisan_birim_id GROUP BY birim_ad

--cevap 6
SELECT unvan_calisan, COUNT(unvan_calisan_id) FROM unvan GROUP BY unvan_calisan HAVING COUNT(unvan_calisan_id) > 1;

--cevap 7
SELECT ad, soyad, maas FROM calisanlar WHERE maas BETWEEN 50000 AND 100000;

--cevap 8
SELECT ad, soyad, birim_ad, unvan_calisan, ikramiye_ucret FROM calisanlar 
INNER JOIN birimler ON calisan_birim_id = birim_id
INNER JOIN unvan ON calisan_id = unvan_calisan_id
INNER JOIN ikramiye ON calisan_id = ikramiye_calisan_id;

--cevap 9
SELECT ad, soyad, unvan_calisan FROM calisanlar
INNER JOIN unvan ON calisan_id = unvan_calisan_id
WHERE unvan_calisan IN ('Y�netici', 'M�d�r');

--cevap 10
SELECT ad, soyad, maas FROM calisanlar
INNER JOIN birimler ON calisan_birim_id = birim_id
WHERE maas IN (
  SELECT MAX(maas) FROM calisanlar
  GROUP BY calisan_birim_id
)

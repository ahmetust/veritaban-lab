	--veritabaný oluþtur
CREATE DATABASE foy3;

use foy3;

	--föydeki birimler tablosunu oluþturma
CREATE TABLE birimler (
    birim_id INT PRIMARY KEY,
    birim_ad NVARCHAR(50) NOT NULL,
);
	--föydeki calisanlar tablosunu oluþturma
CREATE TABLE calisanlar (
    calisan_id INT PRIMARY KEY,
    ad CHAR(25),
    soyad CHAR(25),
	maas INT,
	katilmaTarihi DATETIME,
	calisan_birim_id INT NOT NULL,
    FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
);
	--föydeki unvan tablosunu oluþturma
CREATE TABLE unvan (
	unvan_calisan_id INT NOT NULL,
	unvan_calisan CHAR(25),
	unvan_tarih DATETIME,
	FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id)
);
	--föydeki ikramiye tablosunu oluþturma
CREATE TABLE ikramiye (
	ikramiye_calisan_id INT NOT NULL,
	ikramiye_ucret INT,
	ikramiye_tarih DATETIME,
	FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id)
);

	--föydeki tablolarý istenilen þekilde doldurmak için gereken sorgular
INSERT INTO birimler(birim_id,birim_ad) VALUES (1,'Yazýlým');
INSERT INTO birimler(birim_id,birim_ad) VALUES (2,'Donaným');
INSERT INTO birimler(birim_id,birim_ad) VALUES (3,'Güvenlik');
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(1,'Ýsmail','Ýþeri',100000,'2014-02-20',1);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(2,'Hami','Satýlmýþ',80000,'2014-06-11',1);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(3,'Durmuþ','Þahin',300000,'2014-02-20',2);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(4,'Kaðan','Yazar',500000,'2014-02-20',3);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(5,'Meryem','Soysaldý',500000,'2014-06-11',3);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(6,'Duygu','Akþehir',200000,'2014-06-11',2);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(7,'Kübra','Seyhan',75000,'2014-01-20',1);
INSERT INTO calisanlar(calisan_id,ad,soyad,maas,katilmaTarihi,calisan_birim_id) Values(8,'Gülcan','Yýldýz',90000,'2014-04-11',3);
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(1,5000,'2016-02-20');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(2,3000,'2016-06-11');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(3,4000,'2016-02-20');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(1,4500,'2016-02-20');
INSERT INTO ikramiye(ikramiye_calisan_id,ikramiye_ucret,ikramiye_tarih) Values(2,3500,'2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(1,'Yönetici','2016-02-20');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(2,'Personel','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(8,'Personel','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(5,'Müdür','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(4,'Yönetici Yardýmcýsý','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(7,'Personel','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(6,'Takým Lideri','2016-06-11');
INSERT INTO unvan(unvan_calisan_id,unvan_calisan,unvan_tarih) Values(3,'Takým Lideri','2016-06-11');


--cevap 3
SELECT ad,soyad,maas FROM calisanlar WHERE calisan_birim_id IN (SELECT birim_id FROM birimler WHERE birim_ad = 'Yazýlým' OR birim_ad = 'Donaným');

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
WHERE unvan_calisan IN ('Yönetici', 'Müdür');

--cevap 10
SELECT ad, soyad, maas FROM calisanlar
INNER JOIN birimler ON calisan_birim_id = birim_id
WHERE maas IN (
  SELECT MAX(maas) FROM calisanlar
  GROUP BY calisan_birim_id
)

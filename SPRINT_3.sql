#creacion de tabla credit_card

/*CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR(15) PRIMARY KEY,
    iban VARCHAR(40) NOT NULL,
    pan VARCHAR(20) NOT NULL,
    pin VARCHAR(5) NOT NULL,
    cvv VARCHAR(5) NOT NULL,
    expiring_date  VARCHAR (20)
);*/




SELECT * FROM TRANSACTION;
select * from company;
select * from credit_card;
ALTER TABLE transaction
ADD FOREIGN KEY (credit_card_id) REFERENCES credit_card (id);

#EXERCICI_2
#El departament de Recursos Humans ha identificat un error en el número de compte de l'usuari amb ID CcU-2938.
#La informació que ha de mostrar-se per a aquest registre és: R323456312213576817699999. Recorda mostrar que el canvi es va realitzar.

SELECT *
FROM credit_card;

UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';

SELECT * FROM credit_card WHERE id = 'CcU-2938';

#exercici 3 ;En la taula "transaction" ingressa un nou usuari amb la següent informació:

select * from company;
select * from transaction;
select * from credit_card;

ALTER TABLE transaction
ADD FOREIGN KEY (credit_card_id) REFERENCES credit_card (id);

insert into  company (id)
values('b-9999');

insert into credit_card (id, iban, pan,pin, cvv, expiring_date) values('Ccu-9999','0000000000000000','00000000000','0000','000','01/01/2030');

insert into transaction  (id,credit_card_id,company_id,user_id,lat,longitude,timestamp,amount,declined)
values('108B1D1D-5B23-A76C-55EF-C568E49A99DD','CcU-9999','b-9999',999,829.999,-117.999, CURRENT_TIMESTAMP,111.11,0)
ON DUPLICATE KEY UPDATE id = id;

# YA ESTÁ EL NUEVO USUARIO INCLUIDO, LO COMPROBAMOS:
select *
from transaction
where id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD';

select *
from company
where id =('b-9999');

#ecxercici 4 Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_*card. Recorda mostrar el canvi realitzat.
 select *
 from credit_card;
 
alter table credit_card
drop column pan;

select *
from credit_card;

#nivell 2:
#1-Elimina de la taula transaction el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.
select*
from transaction;

delete from transaction
where id='02C6201E-D90A-1859-B4EE-88D2986D3B02';

select * from transaction 
where id='02C6201E-D90A-1859-B4EE-88D2986D3B02';

#2La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. 
#S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. 
#Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació: Nom de la companyia. 
#Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia. Presenta la vista creada, 
#ordenant les dades de major a menor mitjana de compra.

create or replace view VistaMarketing AS
select c.company_name as nom_de_la_companyia, c.phone as telefon_de_contacte,c.country as Pais_de_residencia,AVG(t.amount) as mitjana_de_compra
from company c
join transaction t
on c.id=t.company_id
GROUP BY c.company_name,c.phone,c.country
order by mitjana_de_compra desc;

select *
from VistaMarketing; 



#3Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"

select *
from VistaMarketing
where Pais_de_residencia = 'Germany'
order by nom_de_la_companyia;

#NIVELL3
#1 DIAGRAMA.alterem la tabla COMPANY I LI TREIEM EL CAMPO WEBSITE:
select *
from company;
alter table company
drop column website;
select*
from company;


## per fer el diagrama i per que quedi tal i com està al exemple:

SELECT * FROM credit_card;
alter table credit_card
ADD COLUMN FECHA_ACTUAL DATETIME DEFAULT NOW();
ALTER TABLE credit_card
MODIFY COLUMN id VARCHAR(20) not null,
modify column iban varchar(50) not null,
modify column pin varchar (4),
modify column cvv int,
modify column expiring_date varchar (20);

select * from credit_card;






#2 crear una vista anomenada "InformeTecnico" 
#creamos la tabla USER:

 /*CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255),
        FOREIGN KEY(id) REFERENCES transaction(user_id)        
    );*/


select * from user;
select * from transaction;
select * from credit_card;
select * from company;
create or replace view InformeTecnico as
select t.id as id_transaccio,concat (u.name,' ', u.surname) as nom_usuari,cr.iban as iban, c.company_name as nom_companyia
from transaction t
join company c on c.id=t.company_id
join credit_card cr on  cr.id=t.credit_card_id
join user u on u.id=t.user_id
group by t.id, cr.iban, c.company_name
order by id_transaccio desc;
select *
from InformeTecnico;














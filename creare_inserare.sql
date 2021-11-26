drop table bilet;
drop table cota;
drop table meci;
drop table stadion;
drop table jucator;
drop table echipa;
drop table tranzactie;
drop table cont;

create table cont(
    id_cont int primary key,
    nume varchar(20) not null,
    prenume varchar(20) not null,
    KYC varchar(25) not null,
    data_cont date not null,
    nr_card nchar(16),
    sold_cont float default 0
);

create table tranzactie(
    id_tranzactie int primary key,
    id_cont int references cont(id_cont),
    suma_tranzactie float not null,
    status_tranzactie varchar(15),
    data_tranzactie date not null,
    tip_tranzactie varchar(20) not null
);

create table echipa(
    id_echipa int primary key,
    data_infiintare date,
    loc_clasament int,
    este_gazda char(1),
    nume_echipa varchar(20)
);

create table jucator(
    id_jucator int primary key,
    id_echipa int references echipa(id_echipa),
    nume varchar(20) not null,
    prenume varchar(20) not null,
    numar int not null,
    pozitie varchar(10) not null
);

create table stadion(
    id_stadion int primary key,
    nume_stadion varchar(30) not null,
    oras varchar(30)
);

create table meci(
    id_meci int primary key,
    id_stadion int references stadion(id_stadion),
    id_echipa_gazda int references echipa(id_echipa),
    id_echipa_oaspete int references echipa(id_echipa),
    rezultat_meci char(15) not null
);

create table cota(
    id_cota int primary key,
    id_meci int references meci(id_meci),
    rezultat_pariat char(1) not null,
    cota float not null
);

create table bilet(
    id_bilet int primary key,
    id_cota int references cota(id_cota),
    id_tranzactie int references tranzactie(id_tranzactie),
    suma_pariata float,
    status_bilet varchar(25),
    castig_potential float
);


create sequence cont_id
    start with 1
    increment by 1;
insert into cont (id_cont,nume,prenume,KYC,data_cont,nr_card,sold_cont) values (cont_id.nextval,'Dorian','Popa','aprobat',to_date('17/12/2020', 'DD/MM/YYYY'),'4532728617068338',243.21);
insert into cont (id_cont,nume,prenume,KYC,data_cont,nr_card,sold_cont) values (cont_id.nextval,'Florea','Ionel','aprobat',to_date('03/01/2021', 'DD/MM/YYYY'),'5374534102831901',1302.34);
insert into cont (id_cont,nume,prenume,KYC,data_cont,nr_card,sold_cont) values (cont_id.nextval,'Ignea','Dan','neaprobat',to_date('15/01/2021', 'DD/MM/YYYY'),'',null);
insert into cont (id_cont,nume,prenume,KYC,data_cont,nr_card,sold_cont) values (cont_id.nextval,'Badic','Mihai','in curs de verificare',to_date('26/01/2021', 'DD/MM/YYYY'),'',null);
insert into cont (id_cont,nume,prenume,KYC,data_cont,nr_card,sold_cont) values (cont_id.nextval,'Voicu','Florin','aprobat',to_date('12/02/2021', 'DD/MM/YYYY'),'5196542859842290',543.45);
drop sequence
cont_id;

create sequence tranzactie_id
    start with 1
    increment by 1;
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,1,243.21,'finalizata',to_date('20/12/2020', 'DD/MM/YYYY'),'alimentare cont');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,2,1302.34,'finalizata',to_date('04/01/2021', 'DD/MM/YYYY'),'alimentare cont');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,2,242.45,'nefinalizata',to_date('04/01/2021', 'DD/MM/YYYY'),'alimentare cont');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,5,543.45,'finalizata',to_date('13/02/2021', 'DD/MM/YYYY'),'alimentare cont');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,1,23,'finalizata',to_date('21/12/2020', 'DD/MM/YYYY'),'plata bilet');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,2,43.93,'finalizata',to_date('05/01/2021', 'DD/MM/YYYY'),'plata bilet');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,2,33,'finalizata',to_date('06/01/2021', 'DD/MM/YYYY'),'plata bilet');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,5,86,'finalizata',to_date('14/02/2021', 'DD/MM/YYYY'),'plata bilet');
insert into tranzactie(id_tranzactie,id_cont,suma_tranzactie,status_tranzactie,data_tranzactie,tip_tranzactie) values (tranzactie_id.nextval,5,28,'finalizata',to_date('15/02/2021', 'DD/MM/YYYY'),'plata bilet');
drop sequence
tranzactie_id;

create sequence echipa_id
    start with 1
    increment by 1;
insert into echipa(id_echipa,data_infiintare,loc_clasament,este_gazda,nume_echipa) values (echipa_id.nextval,to_date('16/05/1880', 'DD/MM/YYYY'),3,'1','Manchester City');
insert into echipa(id_echipa,data_infiintare,loc_clasament,este_gazda,nume_echipa) values (echipa_id.nextval,to_date('19/02/1910', 'DD/MM/YYYY'),5,'0','Everton');
insert into echipa(id_echipa,data_infiintare,loc_clasament,este_gazda,nume_echipa) values (echipa_id.nextval,to_date('03/05/1988', 'DD/MM/YYYY'),9,'1','Real Madrid');
insert into echipa(id_echipa,data_infiintare,loc_clasament,este_gazda,nume_echipa) values (echipa_id.nextval,to_date('23/11/1952', 'DD/MM/YYYY'),12,'0','Chelsea');
drop sequence
echipa_id;

create sequence jucator_id
    start with 1
    increment by 1;
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Santana','Ederson',31,'portar');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Zinchenko','Oleksandr',11,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Dias','Ruben',3,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Stones','John',5,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Walker','Kyle',2,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Foden','Phil',47,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Luiz','Fernando',25,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'De Bruyne','Kevin',17,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Sterling','Raheem',7,'atacant');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Jesus','Gabriel',9,'atacant');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,1,'Mahrez','Riyad',26,'atacant');

insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Pickford','Jordan',1,'portar');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Holgate','Maso',4,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Keane','Michael',5,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Godfrey','Ben',22,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Digne','Lucas',12,'fundas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Doucoure','Abdoulaye',16,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Allan','Harris',6,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Davies','Tom',26,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Sigurdsson','Gylfi',10,'mijlocas');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Calvert-Lewin','Dominic',9,'atacant');
insert into jucator(id_jucator,id_echipa,nume,prenume,numar,pozitie) values (jucator_id.nextval,2,'Richarlison','Rick',7,'atacant');
drop sequence
jucator_id;

create sequence stadion_id
    start with 1
    increment by 1;
insert into stadion(id_stadion,nume_stadion,oras) values (stadion_id.nextval,'Stadionul Azteca','Mexico City');
insert into stadion(id_stadion,nume_stadion,oras) values (stadion_id.nextval,'Stadionul Azadi','');
insert into stadion(id_stadion,nume_stadion,oras) values (stadion_id.nextval,'Stadionul Wembley','Londra');
insert into stadion(id_stadion,nume_stadion,oras) values (stadion_id.nextval,'Stadionul Rose Bowl','Pasadena');
insert into stadion(id_stadion,nume_stadion,oras) values (stadion_id.nextval,'Stadionul Rungrado May Day','Phenian');
drop sequence
stadion_id;

create sequence meci_id
    start with 1
    increment by 1;
insert into meci(id_meci,id_stadion,id_echipa_gazda,id_echipa_oaspete,rezultat_meci) values(meci_id.nextval,1,1,2,'X');
insert into meci(id_meci,id_stadion,id_echipa_gazda,id_echipa_oaspete,rezultat_meci) values(meci_id.nextval,2,3,4,'in desfasurare');
drop sequence
meci_id;

create sequence cota_id
    start with 1
    increment by 1;
insert into cota(id_cota,id_meci,rezultat_pariat,cota) values (cota_id.nextval,1,'1',4.80);
insert into cota(id_cota,id_meci,rezultat_pariat,cota) values (cota_id.nextval,1,'2',1.85);
insert into cota(id_cota,id_meci,rezultat_pariat,cota) values (cota_id.nextval,1,'X',3.30);
insert into cota(id_cota,id_meci,rezultat_pariat,cota) values (cota_id.nextval,2,'1',2.20);
insert into cota(id_cota,id_meci,rezultat_pariat,cota) values (cota_id.nextval,2,'2',1.30);
insert into cota(id_cota,id_meci,rezultat_pariat,cota) values (cota_id.nextval,2,'X',3.25);
drop sequence
cota_id;

create sequence bilet_id
    start with 1
    increment by 1;
-- castigul potential este 0 deoarece urmeaza sa fie updatat la cerinta 12
-- biletele cu statusul castigator urmeaza sa fie updatate la cerinta 12
insert into bilet(id_bilet,id_cota,id_tranzactie,suma_pariata,status_bilet,castig_potential) values (bilet_id.nextval,3,5,23,'',0);
insert into bilet(id_bilet,id_cota,id_tranzactie,suma_pariata,status_bilet,castig_potential) values (bilet_id.nextval,2,6,97.93,'necastigator',0);
insert into bilet(id_bilet,id_cota,id_tranzactie,suma_pariata,status_bilet,castig_potential) values (bilet_id.nextval,3,7,33,'',0);
insert into bilet(id_bilet,id_cota,id_tranzactie,suma_pariata,status_bilet,castig_potential) values (bilet_id.nextval,4,8,86,'meci in desfasurare',0);
insert into bilet(id_bilet,id_cota,id_tranzactie,suma_pariata,status_bilet,castig_potential) values (bilet_id.nextval,3,9,28,'',0);
drop sequence
bilet_id;

commit;

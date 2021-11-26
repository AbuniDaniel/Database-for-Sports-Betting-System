-- 11)
-- operatia join pe cel putin 4 tabele
select *
from jucator j
left join echipa e on j.id_echipa = e.id_echipa
left join meci m on m.id_echipa_gazda = e.id_echipa
left join stadion s on s.id_stadion = m.id_stadion;

-- filtrare la nivel de linii (afiseaza liniile unde tranzactiile sunt mai mari de 50 de lei, doar tranzactiile finalizate cu succes si doar cele în care se alimenteaza contul)
select c.id_cont, c.nume, c.prenume, t.suma_tranzactie
from cont c, tranzactie t
where c.id_cont = t.id_cont and t.suma_tranzactie > 50 and t.status_tranzactie not like '%ne%' and t.tip_tranzactie like '%alimentare%';

-- subcereri sincronizate in care intervin cel putin 3 tabele (afiseaza meciurile care au acelasi rezultat final ca cele din tabelul COTA)
select *
from meci m
where id_meci in
(select id_meci
from cota
where rezultat_pariat = m.rezultat_meci);

-- subcereri nesincronizate in care intervin cel putin 3 tabele (arata jucatorii ai primului meci din echipa gazda)
select *
from jucator
where id_echipa in 
(select id_echipa 
from echipa 
where id_echipa in 
(select id_echipa_gazda 
from meci 
where id_meci = 1));

-- grupri de date, functii grup, filtrare la nivel de grupuri (grupeaza dupa pozitia jucatorilor din prima echipa)
select count(id_jucator), pozitie
from jucator
where id_echipa = 1
group by pozitie;

-- ordonari (ordonez crescator dupa numarul jucatorilor din prima echipa)
select nume, prenume, numar
from jucator
where id_echipa = 1
order by numar asc;

-- 2 functii pe siruri de caractere
select concat(nume,prenume), length(concat(nume,prenume)) as "lungimea numelui si a prenumelui"
from dual, jucator;

-- 2 functii pe date calendaristice (calculeaza diferenta dintre data curenta si data infiintarii a echipelor)
select nume_echipa,
floor(months_between(to_date(sysdate, 'DD/MM/YY'), data_infiintare)/12) as ani_diferenta_data_curenta
from dual, echipa;

-- nvl (in cazul in care 'nr_card' are valoarea 'NULL' o sa fie completata cu 'Nu a fost adaugat card')
select nume, prenume, NVL(nr_card, 'Nu a fost adaugat card') as "NR_CARD"
from cont;

-- decode (se adauga un bonus la castigul potential dupa cazuri)
select id_bilet, id_tranzactie, status_bilet, castig_potential,
    decode(status_bilet, 'castigator', castig_potential * 1.10,
                         'necastigator', castig_potential * 1.01,
                         'meci in desfasurare', castig_potential * 1.25,
           castig_potential) "Castigul potential dupa bonus"
from bilet;

-- case (pentru anumite conditii precizez ce tip de castig potential au biletele)
select id_bilet, id_tranzactie, status_bilet, castig_potential,
    case when castig_potential < 100 then 'Castig mic'
         when castig_potential between 100 and 200 then 'Castig mediu'
         when castig_potential > 200 then 'Castig mare'
    end "Tipul de castig"
from bilet
order by castig_potential;

-- utilizarea a cel putin 1 bloc de cerere (clauza WITH) (afisez id-ul biletelor si castigul potential celor care au castigul potential 
-- peste media tuturor castigurilor potentiale a biletelor si le ordoneaza descrescator
with temporaryTable(averageValue) as
(select avg(castig_potential)
from bilet)
select id_bilet, castig_potential
from bilet b, temporaryTable
where b.castig_potential > temporaryTable.averageValue
order by castig_potential desc;

-- 12) Implementarea a 3 operatii de actualizare sau suprimare a datelor utilizand subcereri.
-- updateaza castigul potential care este calculat in felul urmator: cota * suma_pariata
update bilet b
set b.castig_potential = b.suma_pariata *
(select c.cota
from cota c
where b.id_cota = c.id_cota
);

select * from bilet;

-- updateaza statusul biletelor castigatoare
update bilet b
set b.status_bilet = 'castigator'
where id_cota =
(select id_cota
from cota c
where id_meci in 
(select id_meci
from meci
where c.rezultat_pariat = rezultat_meci));

select * from bilet;

-- updateaza suma pariata pentru toate tipurile de tranzactii facute pentru bilete
update bilet b
set b.suma_pariata = 1.25 *
(select t.suma_tranzactie
from tranzactie t
where b.id_tranzactie = t.id_tranzactie and t.tip_tranzactie like '%bilet%'
);

select * from bilet;

-- 13) Crearea unei secvente ce va fi utilizata in inserarea inregistrarilor in tabele (punctul 10).

-- le-am scris pe toate in fisierul in care inserez tabelele


-- 14) Crearea unei vizualizari compuse. Dati un exemplu de operatie LMD permisa pe vizualizarea respectiva si un exemplu de operatie LMD nepermisa.

-- operatie LMD permisa
create or replace view bilete_castigatoare as
select id_bilet ID, suma_pariata SPARIATA, status_bilet SBILET, castig_potential CASTIG
from bilet
where status_bilet = 'castigator';

-- operatie LMD nepermisa
create or replace view bilete_castigatoaree as
select id_bilet ID, suma_pariata SPARIATA, status_bilet SBILET, castig_potential CASTIG
from bilet
where status_bilet = 'castigator'
group by status_bilet;


-- 15) Crearea unui index care sa optimizeze o cerere de tip cautare cu 2 criterii. Specificati cererea.
create index bilet_index
on bilet(suma_pariata, castig_potential);

select count(*)
from bilet
where suma_pariata > 30 and castig_potential > 100;

-- 16) Formulati in limbaj natural si implementati in SQL: o cerere ce utilizeaza operatia outerjoin pe minimum 4 tabele si doua cereri ce utilizeaza operatia division
-- full outer join-ul reuneste toate tabelele. Am afisat doar cateva date din toate cele 4 tabele unite
select j.nume, j.prenume, e.nume_echipa, m.rezultat_meci, s.nume_stadion
from jucator j
full outer join echipa e on j.id_echipa = e.id_echipa
full outer join meci m on m.id_echipa_gazda = e.id_echipa
full outer join stadion s on s.id_stadion = m.id_stadion
where j.id_echipa = 1;

-- doua cereri ce utilizeaza operatia division
-- afiseaza conturile care nu au efectuat nicio tranzactie
select id_cont
from cont
minus
select id_cont
from tranzactie;

-- afiseaza stadioanele pe care nu se joaca niciun meci
select id_stadion
from stadion
minus
select id_stadion
from meci;

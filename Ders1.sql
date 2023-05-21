-- $$
/*
	test
	test2
*/
-- ******** DEĞİŞKEN TANIMLAMA ********
do $$ -- anonymous block. -> Dolar: Özel karakterler öncesinde tırnak için
declare
	counter integer := 1; -- counter adında bir değişken oluşturuldu. Default değeri 1 olarak atandı.
	first_name varchar(50) := 'Bahadır';
	last_name varchar(50) := 'Günüvar';
	payment numeric(4,2) := 20.50; -- 20.50 -->  numeric(precision,scale)
begin
	--raise notice 'İsim: %  Soyisim: %', first_name, last_name;
	-- Mehmet Fatih 20.5 USD ödeme aldı.
	raise notice 'Counter: % İsim: % Soyisim: % Ödeme: %', first_name, last_name , payment;
end $$;


/*
	Task 1 : değişkenler oluşturarak ekrana " Ahmet ve Mehmet beyler 120 tl ye bilet aldılar. "
	cümlesini ekrana yazdırınız.
*/
do $$
declare
	first_person varchar(50) := 'Ahmet';
	second_person varchar(50) := 'Mehmet';
	payment numeric(3) := 120;
begin
	raise notice '% ve % beyler % TL ye bilet aldilar.',
	first_person,
	second_person,
	payment;
end $$;	


-- ********* BEKLETME KOMUTU ***********

do $$
declare
	created_at time := now(); -- time -> data type, now() -> olusturuldugu zaman
begin
	raise notice '%', created_at;
	perform pg_sleep(5); -- 5 saniye bekle!
	raise notice '%', created_at;
end $$;	


-- ************* TABLODAN DATA TIPINI KOPYALAMA **************

do $$
declare
	f_title film.title%type; -- text
	
	sure film.length%type;
	
begin
	-- 1 ID'li filmin ismini getirelim
	SELECT title
	FROM film
	INTO f_title -- Uncharted
	WHERE id=1;
	
	raise notice 'Film Başlığı: %', f_title;
	
	
	SELECT length
	FROM film
	INTO sure
	WHERE id=1;
	
	raise notice 'Film süresi: %', sure;
	
	
end $$;










	
	
	
	
	
	
	
	
	
	
	
	
	
	
	







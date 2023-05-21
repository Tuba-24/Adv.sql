-- Gün: 2
-- ******** ROW TYPE ********
-- ID'si 1 olan aktörün tüm bilgilerini alalım
do $$
declare
	selected_actor actor%rowtype; -- Rowtype: Seçili row'un tüm bilgilerini depolayabilmek için kullanılır.
begin
	SELECT *
	FROM actor
	INTO selected_actor
	WHERE id=1;
	
	raise notice '% %', selected_actor.first_name, selected_actor.last_name;
end $$;
-- ******** RECORD TYPE ********
-- Film tablosundan id'si 2 olan data'nın yalnızca id, title ve type bilgisini al
do $$
declare
	rec record;
begin
	SELECT id,title,type
	FROM film
	INTO rec
	WHERE id=2;
	
	raise notice 'ID: %, Film İsmi: %, Tür: %', rec.id, rec.title, rec.type;
end $$;
--- ******** İÇ İÇE BLOK YAPILARI ********
do $$
<<tepeblok>>
declare -- Tepedeki blok, outer block olarak geçiyor.
	counter integer := 0;
begin
	counter := counter+1; -- counter: 1
	raise notice 'Tepe Blok, Counter Değeri: %', counter;
	declare -- Inner Block başlangıcı
		counter integer :=0;
	begin
		counter := counter+10; -- counter: 10
		raise notice 'İç, Counter Değeri: %', counter;
		
		raise notice 'Dış Bloktaki Counter Değeri: %', tepeblok.counter;
	
	end; -- Inner Block sonu
	
	raise notice 'Tepe Blok, Counter Değeri: %', counter;
	
	
end $$; -- Outer Block sonu.
-- ******** CONSTANT DEĞERLER ********
-- KDV değerini sabit değer yap.
do $$
declare
	-- selling_price := net_price * 0.1;
	kdv constant numeric := 0.1; -- constant değer, sabit değer. Begin içerisinde tekrar değiştirilemez.
begin
	
	raise notice 'KDV: %', kdv;
	
	--kdv := 10;
	
end $$;
-- CONSTANT'ların değişmediğinin kanıt örneği
do $$
declare
	olusturulma constant integer := 17;
begin
	raise notice 'Olusturulma zamanı: %', olusturulma;
	
	--olusturulma := 18;
	
	raise notice 'Yeni Olusturulma zamanı: %', olusturulma;
	
end $$;
-- //////////////// Control Yapıları ////////////////
-- ******** If Statement ********
-- syntax
/*
	IF condition THEN -- eğer ... ise/o halde -> işlemler'i yap.
		işlemler
	END IF;
*/
-- Task: 1 ID'li filmi bulmaya çalış, bulunursa "Bulundu" yazısını print et.
-- ID'yi bir variable ile alın.
-- Bulunursa: found
-- Bulunmazsa: not found
-- If - found
do $$
declare
	selected_film film%rowtype; -- Film objesi kullanılacak
	input_film_id film.id%type := 1; -- Kullanıcının girdiği id numarası
begin
	
	SELECT * FROM film
	INTO selected_film
	WHERE id=input_film_id;
 	
	-- Bulduğumuz filmin title'ını getir
	--raise notice '%', selected_film.title;
	
	if found then
		raise notice 'Bulundu: %', selected_film.title;
	end if;
end $$;
-- If - not found
do $$
declare
	selected_film film%rowtype; -- Film objesi kullanılacak
	input_film_id film.id%type := 10; -- Kullanıcının girdiği id numarası
begin
	
	SELECT * FROM film
	INTO selected_film
	WHERE id=input_film_id;
 	
	-- Bulduğumuz filmin title'ını getir
	--raise notice '%', selected_film.title;
	
	if not found then
		raise notice 'Bulunamadı! ----> %', input_film_id;
	end if;
end $$;
-- ********* IF - ELSE *********
/*
	IF condition THEN
		işlemler;
	ELSE
		alternatif işlemler;
	END IF;
*/
-- Task: 1 ID'li film bulunabilirse, title bilgisini yazdır, yoksa BULUNAMADI yazdır.
do $$
declare
	selected_film film%rowtype; -- Film objesi kullanılacak
	input_film_id film.id%type := 10; -- Kullanıcının girdiği id numarası
begin
	
	SELECT * FROM film
	INTO selected_film
	WHERE id=input_film_id;
 	
	-- Bulduğumuz filmin title'ını getir
	--raise notice '%', selected_film.title;
	
	if found then
		raise notice 'Bulundu: %', selected_film.title;
	else
		raise notice 'Bulunamadı: %', input_film_id;
	end if;
end $$;
	
-- ******** IF - ELSE IF - ELSE
-- syntax:
/*
	IF condition THEN
		işlemler;
	ELSEIF condition_2 THEN
		işlemler;
	ELSEIF condition_3 THEN
		işlemler;
	ELSE
		işlemler;
	END IF;
*/
/*
	Task:
	
	1 ID'li film bulunursa:
	
		Süresi 50 dakikanın altında ise "Kısa",
		50 ile 120 arasında ise "Ortalama",
		120 dakikadan fazla ise "Uzun"
		print edelim.
*/
do $$
declare
	oFilm film%rowtype;
	lenDescription varchar(50);
	film_id film.id%type;
begin
	SELECT * FROM film
	INTO oFilm
	WHERE id=film_id;
	
	if not found then
		raise notice 'Film bulunamadı!';
	else
		if oFilm.length>0 and oFilm.length<50 then
			lenDescription := 'Kısa';
		elseif oFilm.length>50 and oFilm.length<120 then
			lenDescription := 'Ortalama';
		elseif oFilm.length>120 then
			lenDescription := 'Uzun';
		else
			lenDescription := 'Tanımlanamıyor.';
		end if;
		
		raise notice '% filminin süresi: %', oFilm.title, lenDescription;
		
	end if;
	
end $$;
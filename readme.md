**Projekt z SQL - Data o mzdách a cenách potravin a jejich zpracování pomocí SQL**

1. **Zadání projektu: Zjistit dostupnost základních potravin široké veřejnosti a jejich porovnání s příjmy v rámci České Republiky.** 

**Použité datové sady:** 

czechia\_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR. 

czechia\_payroll\_calculation – Číselník kalkulací v tabulce mezd. czechia\_payroll\_industry\_branch – Číselník odvětví v tabulce mezd. czechia\_payroll\_unit – Číselník jednotek hodnot v tabulce mezd. czechia\_payroll\_value\_type – Číselník typů hodnot v tabulce mezd. 

czechia\_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR. 

czechia\_price\_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok 

Při vytváření primární tabulky **t\_milan\_boleslav\_project\_SQL\_primary\_**final jsem použil některá omezení, která vycházejí z potřeb zadání: 

cp.value\_type\_code = 5958 -> Průměrná hrubá mzda na zaměstnance 

AND cp.calculation\_code = 200 -> přepočtené hodnoty mezd 

AND cp.unit\_code = 200 -> zajímají nás data o mzdách 

AND cp.industry\_branch\_code IS NOT NULL -> vyřazení neznámých odvětví 

AND cp.payroll\_year BETWEEN 2006 AND 2018 -> sjednocení průniku let v tabulkách mezd a cen potravin (czechia\_payroll a czechia\_price.) 

Sekundární tabulku **t\_milan\_boleslav\_project\_sql\_secondary\_final** jsem vytvořil pouze pro Českou Republiku, protože ceny potravin a platů známe také jen pro ČR a pro zodpovězení otázek je to dostačující.  

2. **Výzkumné otázky:** 
1. *Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?* 

Výsledkem je 25 záznamů, ve kterých došlo k poklesu ročního příjmu a to v různých odvětvích. Nejčastěji zasaženým odvětvím byla - Těžba a dobývání. Velkým překvapením pro mě byl pokles příjmu i v odvětví - Informační a komunikační činnosti v roce 2013. 

2. *Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?* 

Z výsledků je patrné že i když průměrné platy v roce 2018 se zvýšily oproti roku 2006, jejich nárůst nebyl dostačující na to, aby pokryl růst cen chleba. Zatímco v roce 2006 jsme si za průměrný roční příjem mohli koupit 10 750ks chleba, tak v roce 2018 už jen 10 374ks. U mléka je situace opačná, tam jsme si polepšili. V roce 2006 jsme si mohli koupit 12 005 litrů mléka a v roce 2018 už 12 678 litrů.

3. *Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?* 

Pokud to budeme brát z hlediska meziročního rozdílu cen tak nejlépe jsou na tom Rajská jablka červená kulatá, která mezi lety 2006 a 2007 zlevnila o více jak 40%. Pokud jde opravdu pouze o zdražení, tak tam došlo k nejmenšímu nárůstu u položky: Rostlinný roztíratelný tuk, který také mezi lety 2006 a 2007 podražil pouze o cca 0,075%. Některé položky se meziročně někdy nezměnily jako např.: Pšeničná mouka hladká mezi léty 2017 a 2018 

4. *Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?* 

Vzhledem k tomu že máme data o cenách zboží dostupná až od roku 2006, můžeme meziroční porovnání udělat až od roku 2007. Ve sledovaném období takový rok nenastal. Nejvyššího rozdílu mezi růstem cen a mezd bylo dosaženo v roce 2013, kdy ceny potravin vzrostly o zhruba 6% více než ceny mezd. Naopak největší kupní síla obyvatel v ČR byla v roce 2009.  

Z detailního výsledku je patrné, že největší nárůst cen potravin byl v roce 2007 a to konkrétně u paprik kde nárůst činil oproti roku 2006 skoro 50%. V témže roce byl nejnižší nárůst platů v odvětví Zásobování vodou, Činnosti související s odpady a sanacemi a to pouze okolo 5% 

5. *Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?* 

V daném vzorku dat nevidím přímou závislost mezi růstem HDP a růstem cen zboží či platů. Co by se dalo říci je, že pokud HDP výrazně vzrostlo tak jak tomu bylo v letech 2006 a 2007, následně vzrostly výrazně i platy a cena zboží. Ke stejné situaci došlo i v roce 2018 kdy po výrazném nárůstu HDP 

v předchozím roce, došlo opět k výraznému zvýšení platů. Cena zboží v tomto roce vzrostla celkem zanedbatelně, pouze o 2% ale v roce minulém, tedy 2017, vzrostla o skoro 9%, což je nejvíce, v námi porovnatelné období. 

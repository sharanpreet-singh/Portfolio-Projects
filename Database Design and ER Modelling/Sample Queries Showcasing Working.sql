--Query For Obtaining vaccinations administered for any two given dates
SELECT v1.date as [Observation Date 1 (OD1)], v1.location as [Country Name (CN)], v1.daily_vaccinations as [Administrated Vaccine on OD1 (VOD1)],
 v2.date as [Observation Date 2 (OD2)],v2.daily_vaccinations as [Administrated Vaccine on OD2 (VOD2)], v1.daily_vaccinations-v2.daily_vaccinations as [Difference of Totals (VOD1-VOD2)]
FROM Vaccinations v1 JOIN Vaccinations v2 ON v1.location = v2.location
WHERE v1.date = '23-02-2021' and v2.date ='05-04-2021';

--Query for finding countries and their cumulative doses
SELECT location as Country, SUM(daily_vaccinations) as [Cumulative Doses]
FROM Vaccinations
Group By location
HAVING SUM(daily_vaccinations) > (Select AVG(daily_vaccinations) FROM Vaccinations);

--Top 10 countries with the most vaccination types
SELECT l1.location as Country, v1.vaccines as [Vaccine Type]
FROM Locations l1 JOIN Vaccines v1 ON l1.vaccine_id = v1.vaccine_id
GROUP BY l1.location, v1.vaccine_id
HAVING l1.location IN (Select  location From Locations Group by location ORDER BY COUNT(vaccine_id)  DESC LIMIT 10)
ORDER BY COUNT(v1.vaccines);

--Vaccinations administered by Source
SELECT s1.source_name as [Source Name], SUM(v1.daily_vaccinations) as [Total Administrated Vaccines], s1.source_website as [Source URL]
FROM Source s1 JOIN Locations l1 ON s1.source_id = l1.source_id
JOIN Countries c1 ON l1.location = c1.location 
JOIN Vaccinations v1 ON c1.location = v1.location
GROUP BY  s1.source_website, s1.source_name;

--Comparison of vaccination administration
SELECT date as Date, Australia, [United States], England, China 
FROM 
(
    Select date, people_fully_vaccinated as Australia 
    FROM Vaccinations 
    Where date LIKE '%2022%' and iso_code =='AUS' )  a

JOIN (
    SELECT date, people_fully_vaccinated AS [United States]
    FROM Vaccinations
    WHERE date LIKE '%2022%' and iso_code == 'USA') b ON a.date == b.date

JOIN (
    SELECT date, people_fully_vaccinated AS England
    FROM Vaccinations
    WHERE date LIKE '%2022%' and iso_code == 'OWID_ENG') c ON b.date == c.date

JOIN (
    SELECT date, people_fully_vaccinated AS China
    FROM Vaccinations
    WHERE date LIKE '%2022%' and iso_code == 'CHN') d ON c.date == d.date;


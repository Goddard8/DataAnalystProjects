select * from coviddeaths
order by 3,4;

/*select * from covidvaccinations
order by 3,4*/

-- select the data that we are going to be using
select location, date, total_cases, new_cases,total_deaths,population from coviddeaths
order by 1,2;

-- looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country
select location,date,total_cases,total_deaths,((total_deaths/total_cases)* 100) as 'Death percentage'  from coviddeaths
where location like	'%Philippines%'
order by 1,2;

-- looking at the total cases vs population

select location, date, population,total_cases,((total_cases/population)*100)as 'Case percentage' from coviddeaths
where location like '%Philippines%'
order by 1,2; 

-- looking at countries w/ highest infection rate compared to population
select location,population,max(total_cases) as highestinfectioncount,max((total_cases/population)*100) as percentofpopulationinfected from coviddeaths
group by location,population
order by percentofpopulationinfected desc;

-- showing countries with the highest death count per population 

SELECT location, MAX(CAST(total_deaths AS signed)) AS TotalDeathCount
FROM coviddeaths
where continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- break things down by continent
-- showing the continents with the highest death count

select continent, max(cast(total_deaths as signed)) as totaldeathcount
from coviddeaths
where continent is not null
group by continent
order by totaldeathcount desc;

-- global numbers 
select sum(new_cases) as total_cases,sum(cast(new_deaths as signed))as total_deaths,sum(cast(new_deaths as signed))/sum(new_cases)*100 as DeathPercentage
from coviddeaths
where continent is not null	
order by 1,2;

-- looking at total population  vs vaccination

select dea.continent, dea.location, dea.date,dea.population,vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated from coviddeaths dea 
join covidvaccinations vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
order by 2,3;

-- USE CTE
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS signed)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
    FROM coviddeaths dea
    JOIN covidvaccinations vac ON dea.location = vac.location AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated,
(RollingPeopleVaccinated / Population) * 100 AS VaccinationPercentage
FROM PopvsVac;

-- TEMP TABLE
DROP TABLE IF EXISTS Percentpopulationvaccinated;
CREATE TABLE Percentpopulationvaccinated (
    continent NVARCHAR(255) CHARACTER SET utf8mb4,
    location NVARCHAR(255) CHARACTER SET utf8mb4,
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO Percentpopulationvaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT *, (RollingPeopleVaccinated / population) * 100 AS VaccinationPercentage
FROM Percentpopulationvaccinated;

-- creating view to store data for later visualizations
create view Percentpopulationvaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
-- order by 2,3; 

select * from percentpopulationvaccinated;
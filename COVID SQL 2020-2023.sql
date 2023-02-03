/*
Covid 19 Data Exploration
From 2/2020 - 3/2023
Requirements: Microsoft SQL Server 2022, Microsoft SQL Server Management Studio (SSMS)
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

-Credit: Alex the Analyst Code Along Project 1/4
*/

-- Check the CovidDeaths table
SELECT *
FROM CovidDeaths$;

-- Check the CovidVaccinations Table
SELECT *
FROM CovidVaccinations$
ORDER BY location, date;

-- Check table by column name
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'CovidDeaths$';

-- Select Data that we are going to be starting with
Select location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths$
ORDER BY location, date;

-- Total Cases vs Total Deaths
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_perc
FROM CovidDeaths$
ORDER BY death_perc DESC;

-- Total Cases vs Population
-- Total Cases vs Total Deaths
Select Location, Population, total_cases, (total_cases/population)*100 as pop_infected_perc, (total_deaths/total_cases)*100 AS death_perc
FROM CovidDeaths$
GROUP BY location, population, total_cases, total_deaths
ORDER BY pop_infected_perc DESC;

-- Countries with Highest Infection Rate compared to Population
SELECT Location, Population, MAX(total_cases) as highest_cases,  Max((total_cases/population))*100 as pop_infected_perc, MAX((total_deaths/total_cases))*100 AS death_perc
FROM CovidDeaths$
GROUP BY location, population
ORDER BY pop_infected_perc DESC;

-- Countries with Highest Death Count per Population
SELECT Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM CovidDeaths$
WHERE continent is not null 
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population
SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM CovidDeaths$
WHERE continent is not null 
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as death_perc
FROM CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2 DESC;

/* Join the two table together using OUTER JOIN and Save them into a new table 'CovidDV'
*/

-- The following code is for MySQL, will not work for SSMS
-- DROP TABLE IF EXISTS CovidDV;
-- CREATE TABLE CovidDV AS


-- 'SELECT * INTO new_table' worked for SSMS
DROP TABLE IF EXISTS CovidDV;
SELECT CovidVaccinations$.*,
total_cases,
new_cases,
new_cases_smoothed,
total_deaths,
new_deaths,
new_deaths_smoothed,
total_cases_per_million,
new_cases_per_million,
new_cases_smoothed_per_million,
total_deaths_per_million,
new_deaths_per_million,
new_deaths_smoothed_per_million,
reproduction_rate,
icu_patients,
icu_patients_per_million,
hosp_patients,
hosp_patients_per_million,
weekly_icu_admissions,
weekly_icu_admissions_per_million,
weekly_hosp_admissions,
weekly_hosp_admissions_per_million 
INTO CovidDV
FROM CovidDeaths$ 
JOIN CovidVaccinations$
ON CovidDeaths$.location = CovidVaccinations$.location AND CovidDeaths$.date = CovidVaccinations$.date;

-- Check the new table CovidDV
SELECT *
FROM CovidDV

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT continent, location, date, population, new_vaccinations, 
-- From the original code along, Alex use 'int' but the code won't work, we need to use 'BIGINT'
	SUM(CONVERT(BIGINT, new_vaccinations)) OVER (PARTITION BY location ORDER BY location, date) as RollingPeopleVaccinated
FROM CovidDV
WHERE continent IS NOT NULL;

-- Using CTE to perform Calculation on Partition By in previous query
WITH PopvsVac AS
(
Select continent, location, date, population, new_vaccinations,
		SUM(CONVERT(BIGINT, new_vaccinations)) OVER (PARTITION BY location ORDER BY location, date) as RollingPeopleVaccinated
FROM CovidDV 
WHERE continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS vac_pop_perc
FROM PopvsVac;

-- Using Temp Table to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS PercentPopulationVaccinated
CREATE TABLE PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
INSERT INTO PercentPopulationVaccinated
Select continent, location, date, population, new_vaccinations,
		SUM(CONVERT(BIGINT, new_vaccinations)) OVER (PARTITION BY location ORDER BY location, date) as RollingPeopleVaccinated
FROM CovidDV
WHERE continent IS NOT NULL;

Select *, (RollingPeopleVaccinated/Population)*100 AS vac_pop_perc
From PercentPopulationVaccina

SELECT location, (RollingPeopleVaccinated/Population)*100 AS vac_pop_perc
FROM PercentPopulationVaccinated
GROUP BY location, population, RollingPeopleVaccinated
ORDER BY vac_pop_perc DESC;



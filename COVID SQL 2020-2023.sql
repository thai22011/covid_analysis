/*
Covid 19 Data Exploration
From 2/2020 - 3/2023
Requirements: Microsoft SQL Server 2022, Microsoft SQL Server Management Studio (SSMS)
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

-Credit: Alex the Analyst Code Along Project 1/4
*/


SELECT *
FROM CovidDeaths$
ORDER BY location, date;

--SELECT *
--FROM CovidVaccinations$
--ORDER BY location, date;

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
Select Location, date, Population, total_cases, (total_cases/population)*100 as pop_infected_perc, (total_deaths/total_cases)*100 AS death_perc
FROM CovidDeaths$
ORDER BY pop_infected_perc DESC;

-- Countries with Highest Infection Rate compared to Population
SELECT Location, Population, MAX(total_cases) as highest_cases,  Max((total_cases/population))*100 as pop_infected_perc, MAX((total_deaths/total_cases))*100 AS death_perc
FROM CovidDeaths$
GROUP BY Location, Population
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
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM CovidDeaths$
WHERE continent is not null 
ORDER BY 1,2 DESC;

/* Join the two table together using OUTER JOIN
*/

;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, 
		SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
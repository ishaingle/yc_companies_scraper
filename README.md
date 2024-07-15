# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Web Scraping Task

## Description

A web scraper api to extract data from Y Combinator's publicly listed companies from this url: https://www.ycombinator.com/companies

## Technologies Used and versions

- Ruby on Rails: ruby 3.0.0, rails 7.0.8

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/ishaingle/yc_companies_scraper.git
   cd yc_companies_scraper

2. Install dependencies:
   bundle install

4. Run the server:
   rails server

5. Access url using following params and download csv including company details:
   http://localhost:3000/scrape_and_return_csv.csv?filters[batch]=W12&filters[industry]=B2B&filters[region]=San Francisco&filters[tag]=B2B&filters[company_size]=1-10&filters[is_hiring]=true&filters[nonprofit]=false&filters[black_founded]=true&filters[hispanic_latino_founded]=false&filters[women_founded]=true&n=12

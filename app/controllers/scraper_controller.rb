class ScraperController < ApplicationController
  require 'net/http'
  require 'nokogiri'
  require 'csv'
  require 'selenium-webdriver'

  def scrape_and_return_csv
    n = params[:n].to_i
    filters = params[:filters]
    url = construct_url_with_filters(filters.as_json)

    scraped_data = scrape_ycombinator_companies(n, url)

    respond_to do |format|
      format.csv { send_data scraped_data, filename: "ycombinator_companies.csv", type: 'text/csv' }
    end
  end

  private

  def construct_url_with_filters(filters)
    @filters = filters.map { |k, v| "#{k}=#{v}" }.join('&')
    base_url = 'https://www.ycombinator.com/companies'
    "#{base_url}?#{@filters}"
  end

  def scrape_ycombinator_companies(n, url)
    options = Selenium::WebDriver::Safari::Options.new
    driver = Selenium::WebDriver.for :safari, options: options
    driver.navigate.to url

    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
      wait.until { driver.find_element(css: '.loading-indicator').nil? }
    rescue Selenium::WebDriver::Error::TimeoutError
      # Handle timeout error if loading indicator doesn't disappear
      puts "Loading indicator didn't disappear within timeout"
    end

    wait.until { driver.find_element(css: '.companies') }

    company_names = driver.find_elements(css: 'span._coName_86jzd_453').map(&:text)
    company_locations = driver.find_elements(css: 'span._coLocation_86jzd_469').map(&:text)
    descriptions = driver.find_elements(css: 'span._coDescription_86jzd_478').map(&:text)
    batches = driver.find_elements(css: '.pill').map(&:text)

    # Prepare data in CSV format
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Company Name', 'Location', 'Description', 'Batch']

      # Iterate through the arrays and add rows to CSV
      n.times do |index|
        csv << [company_names[index], company_locations[index], descriptions[index], batches[index]]
      end
    end
    csv_data
  ensure
    driver.quit if driver
  end
end

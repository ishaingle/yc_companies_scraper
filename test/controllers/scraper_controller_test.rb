require "test_helper"

class ScraperControllerTest < ActionDispatch::IntegrationTest
  test "should get scrape" do
    get scraper_scrape_url
    assert_response :success
  end
end

Rails.application.routes.draw do
  get 'scrape_and_return_csv', to: 'scraper#scrape_and_return_csv'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

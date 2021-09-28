Rails.application.routes.draw do
  get "/location", to: "location#search"
end 

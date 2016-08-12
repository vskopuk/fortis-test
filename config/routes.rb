Rails.application.routes.draw do
  get 'phrases', to: 'home#phrases'
  root to: "home#index"
end

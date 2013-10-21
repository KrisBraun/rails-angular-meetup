RailsAngularMeetup::Application.routes.draw do
  root :to => 'app#index'
  get "/active" => "app#index"
  get "/completed" => "app#index"
  scope '/api', defaults: { format: :json }, as: 'api' do
    resources :todos
  end
end

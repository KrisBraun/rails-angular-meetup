RailsAngularMeetup::Application.routes.draw do
  root :to => 'app#index'
  scope '/api', defaults: { format: :json }, as: 'api' do
    resources :todos
  end
end

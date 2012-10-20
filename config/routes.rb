GithubMates::Application.routes.draw do

  root :to => 'home#index'

  match '/mates' => 'home#mates'

  match '/api/mates' => 'api#mates'

end

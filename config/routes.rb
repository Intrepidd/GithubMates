GithubMates::Application.routes.draw do

  root :to => 'home#index'

  match '/mates' => 'home#mates'

end

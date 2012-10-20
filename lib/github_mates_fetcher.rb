class GithubMatesFetcher
  attr_accessor :username
  attr_accessor :repository

  def initialize(username, repository)
    self.username = username
    self.repository = repository
  end

end

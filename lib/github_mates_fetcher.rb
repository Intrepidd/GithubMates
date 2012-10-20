class GithubMatesFetcher
  attr_accessor :username
  attr_accessor :repository

  def initialize(username, repository)
    self.username = username
    self.repository = repository
  end

  def get_commiters
    begin
      commits = Github.repos.commits.all self.username, self.repository
    rescue
      return nil
    end
    commiters = []
    commits.each do |commit|
      commiters << commit['committer']['login'] if commit['committer'] and commit['committer']['login'].present?
    end
    return commiters.uniq
  end

end

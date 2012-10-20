class GithubMatesFetcher
  attr_accessor :username
  attr_accessor :repository

  def self.github
    return @github if !@github.nil?
    @github = Github.new do |c|
      c.oauth_token = 'f5bc8bdbee9555b1c4dc3190119d250195dbfe48'
    end
  end

  # Gets informations about a list of users
  #
  # @param [Array] usernames An array of usernames
  # @return [Array] An array of hashes, containing the informations about each user given by the github API
  def self.get_users(usernames)
    result = []
    usernames.each do |username|
        user = GithubMatesFetcher.github.users.get(:user => username) rescue nil
        if user.present?
          result << user.to_hash
        end
    end
    result
  end

  # Create an instance of GithubMatesFetcher
  #
  # @param [String] username the username
  # @param [String] repository The name of the repository
  def initialize(username, repository)
    self.username = username
    self.repository = repository
  end

  # Gets the committers of this repository
  #
  # @return [Array, Nil] An array of string containing the logins of the commiters, or nil if the user / repo
  # couple does not exist
  def get_committers
    begin
      commits = GithubMatesFetcher.github.repos.commits.all self.username, self.repository
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

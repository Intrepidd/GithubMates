class GithubMatesFetcher
  attr_accessor :username
  attr_accessor :repository

  # Gets informations about a list of users
  #
  # @param [Array] usernames An array of usernames
  # @return [Array] An array of hashes, containing the informations about each user given by the github API
  def self.get_users(usernames)
    result = []
    usernames.each do |username|
        user = Github.users.get(:user => username) rescue nil
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

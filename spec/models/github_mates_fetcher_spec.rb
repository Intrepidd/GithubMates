require 'spec_helper'

describe GithubMatesFetcher do

  it "should construct with a username and a repository" do
    fetcher = GithubMatesFetcher.new 'username', 'repository'
    fetcher.username.should == 'username'
    fetcher.repository.should == 'repository'
  end

end

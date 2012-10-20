require 'spec_helper'

describe GithubMatesFetcher do

  it "should construct with a username and a repository" do
    fetcher = GithubMatesFetcher.new 'username', 'repository'
    fetcher.username.should == 'username'
    fetcher.repository.should == 'repository'
  end

  describe '#commiters' do
    context "Valid repository" do
      fetcher = GithubMatesFetcher.new 'Intrepidd', 'rails-canhaz'
      fetcher.get_commiters.should == ['Intrepidd']
    end

    context "Invalid repository" do
      fetcher = GithubMatesFetcher.new 'Intrepidd', 'does-not-exist'
      fetcher.get_commiters.should == nil
    end

  end

end

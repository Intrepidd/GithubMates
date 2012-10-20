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
      fetcher.get_committers.should == ['Intrepidd']
    end

    context "Invalid repository" do
      fetcher = GithubMatesFetcher.new 'Intrepidd', 'does-not-exist'
      fetcher.get_committers.should == nil
    end

  end

  describe '.get_users' do
    context "One user" do
      users = GithubMatesFetcher.get_users(['Intrepidd'])
      users.size.should == 1
      users.first['login'].should == 'Intrepidd'
    end

    context "Wrong user" do
      users = GithubMatesFetcher.get_users(['this_user_does_not_exist_at_least_i_hope'])
      users.should == []
    end

    context "Get multiple users" do
      users = GithubMatesFetcher.get_users(['Intrepidd', 'fat', 'random_user_non_existing', 'rails'])
      users.size.should == 3
    end
  end

end

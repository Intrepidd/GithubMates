class ApiController < ApplicationController

  def mates

    if !request.get?
      render :json => {:error => 'Bad request'}, :status => 405 and return
    end

    if !params[:user].present? || !params[:repository].present?
      render :json => {:error => 'Invalid parameters'}, :status => 400 and return
    end

    fetcher = GithubMatesFetcher.new(params[:user], params[:repository])
    if fetcher
      committers = fetcher.get_committers
      users = GithubMatesFetcher.get_users(committers) rescue nil
      if users
        render :json => users and return
      end
    end

    render :json => {:error => 'Repository not accessible'}, :status => 404

  end

end

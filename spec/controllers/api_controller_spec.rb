require 'spec_helper'

describe ApiController do

  it "Should refuse POST & PUT requests" do
    post :mates
    response.status.should == 405
    put :mates
    response.status.should == 405
    # I know there are other HTTP requests.
  end

  it "Should return a 400 error when giving wrong params" do
    get :mates
    response.status.should == 400
    get :mates, {:user => 'toto'}
    response.status.should == 400
    get :mates, {:repository => 'toto'}
  end

  it "Should return a 404 error with a rubish repository" do
    get :mates, {:user => 'it', :repository => 'does_not_exists'}
    response.status.should == 404
  end

  it "Should return a 200 request with good parameters" do
    get :mates, {:user => 'Intrepidd', :repository => 'rails-canhaz'}
    response.status.should == 200
    result = JSON.parse(response.body)
    result.size.should == 1
    result.first['login'].should == 'Intrepidd'
  end

end

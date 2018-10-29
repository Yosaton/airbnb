class WelcomeController < ApplicationController
  def index
    @user = User.all
  end
end

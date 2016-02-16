class SessionsController < ApplicationController
  def create
    byebug
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

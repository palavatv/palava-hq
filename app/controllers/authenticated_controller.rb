class AuthenticatedController < ApplicationController
  before_filter :authenticate_confirmed_user!
end

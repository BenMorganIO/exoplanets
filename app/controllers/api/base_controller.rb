module Api
  class BaseController < ApplicationController
    respond_to :json, :xml
  end
end

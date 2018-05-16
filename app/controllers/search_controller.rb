class SearchController < ApplicationController
  skip_authorization_check

  def index
    @result = "#{params[:search_type]}".constantize.search(params[:body][:body]).group_by(&:class) if params[:body]
  end
end

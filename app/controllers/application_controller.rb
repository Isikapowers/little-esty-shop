class ApplicationController < ActionController::Base
  helper_method :name

  def name
    json = GithubService.new
    @repo ||= Repo.new(json.get_all)
  end

  def welcome
  end

end

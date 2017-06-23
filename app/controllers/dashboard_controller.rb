class DashboardController < ApplicationController
  def index
    rally = Rally.new
    @results = rally.get_userstories_by_project
    @projects = {}
    @results.group_by{|h| h[:Project]}.each do |e|
      @project_name = e[0]
      #puts "Project name is: #{@project_name}"
      @projects[@project_name] = e[1]
    end
  end

  def update
    uid = params[:user_story_id]
    rally = Rally.new
    @results = rally.update_artifact_project(uid)
  end
end

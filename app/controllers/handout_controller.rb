class HandoutController < ApplicationController

  require 'pp'

  def index 
    rally = Rally.new
    @results = rally.get_all_sprints
  end

  def show
    @sprint = params[:sprint_num]
    @graph_link = Graph.find(1)

    rally = Rally.new
    @results = rally.get_sprint_details(@sprint)   

    accepted_points = 0
    total_points = 0
    @results.each do |res|
      if (res.ScheduleState.eql? "Accepted") && (res.PlanEstimate != nil)
        accepted_points += res.PlanEstimate
      end
      if res.PlanEstimate != nil
        total_points += res.PlanEstimate
      end
    end
    @percent_completed = ((accepted_points/total_points) * 100).ceil.to_i

    @start_date = Date.parse(@results.first.Iteration.StartDate).strftime("%m/%d/%Y")
    @end_date = Time.parse(@results.first.Iteration.EndDate) - 1.days
    @end_date = @end_date.strftime("%m/%d/%Y")    
    @devs = Employee.where(role_id: 1)
    @tpo = Employee.find_by role_id: 2
    @scrum_master = Employee.find_by role_id: 3
    
    respond_to do |format|
      format.html do
        render 'handout'
      end
      format.pdf do
        render pdf: 'get_sprint',
               viewport_size: '1280x1024',
               template: 'handout/handout.pdf.erb',
               locals: {:results => @results, :sprint => @sprint, :graph_link => @graph_link, :percent_completed => @percent_completed, :start_date => @start_date, :end_date => @end_date, :devs => @devs, :tpo => @tpo, :scrum_master => @scrum_master}
      end
    end
  end

  def graph_link
    graph = Graph.find(1)
    graph.update(link: params[:graphlink])
  end

end

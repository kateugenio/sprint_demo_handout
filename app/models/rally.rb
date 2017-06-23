class Rally
  attr_accessor :sprint

  def initialize(sprint = nil)
    @rally = RallyAPI::RallyRestJson.new(Rails.configuration.rally)
    @query = RallyAPI::RallyQuery.new()
    @sprint = sprint
  end

  def get_all_sprints
    @query.type = "Iteration"
    @query.fetch = "Name,ObjectID"
    @query.project = {"_ref" => Rails.application.secrets.rally_project_url}
    @query.order = "ObjectID Desc"
    @results = @rally.find(@query)
  end

  def get_sprint_details
    @query.type = "HierarchicalRequirement"
    @query.fetch = "Name,Iteration,PlanEstimate,ScheduleState,c_Product,FormattedID,StartDate,EndDate"
    @query.query_string = '(Iteration.Name = "%s")' % [@sprint]
    @query.order = "c_Product Asc"
    @results = @rally.find(@query)
  end

  def get_all_projects
    @query.type = "Project"
    @query.fetch = "Name,Children"
    @query.project = {"_ref" => Rails.application.secrets.rally_project_url}
    @results = @rally.find(@query)
  end

  def get_userstories_by_project
    @defined = "Defined"
    @query.type = "HierarchicalRequirement"
    @query.fetch = "Name,Iteration,PlanEstimate,Project,ScheduleState,Rank,c_Product,FormattedID,StartDate,EndDate,DragAndDropRank"
    #@query.query_string = '((Iteration = null) AND (Project.Name != "%s"))' % [Rails.application.secrets.rally_project]
    @query.query_string = '((Iteration = null) AND (ScheduleState = "%s"))' % [@defined]
    #@query.page_size = 1
    #@query.limit = 10
    @query.order = "Project ASC,Rank ASC"
    @results = @rally.find(@query)
  end

  def update_artifact_project(uid)
    @query.type = "HierarchicalRequirement"
    @query.fetch = "FormattedID,c_Product,Project,Notes,PlanEstimate,Iteration,ScheduleState"
    @query.query_string = '(FormattedID = "%s")' % [uid]
    @results = @rally.find(@query)
    defect = @results.first
    puts "user story is #{defect}"
    updated_defect = @rally.update(:hierarchical_requirement, "FormattedID|" + defect.FormattedID, {"Project" => "/Projects/" + Rails.application.secrets.rally_team_backlog_oid})
  end
end

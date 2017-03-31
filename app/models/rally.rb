class Rally
  attr_accessor :sprint

  def get_all_sprints
    rally = RallyAPI::RallyRestJson.new(Rails.configuration.rally)
    query = RallyAPI::RallyQuery.new()
    query.type = "Iteration"
    query.fetch = "Name,ObjectID"
    query.project = {"_ref" => Rails.application.secrets.rally_project_url}
    query.order = "ObjectID Desc"
    @results = rally.find(query)
  end

  def get_sprint_details(sprint)
    rally = RallyAPI::RallyRestJson.new(Rails.configuration.rally)
    query = RallyAPI::RallyQuery.new()
    query.type = "HierarchicalRequirement"
    query.fetch = "Name,Iteration,PlanEstimate,ScheduleState,c_Product,FormattedID,StartDate,EndDate"
    query.query_string = '(Iteration.Name = "%s")' % [sprint]
    query.order = "c_Product Asc"
    @results = rally.find(query)
  end

end
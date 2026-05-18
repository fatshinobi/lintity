Lintity::Engine.routes.draw do
  get 'entity_list/index'
  # Route for the new EntityReportController index action
  # Allow HTML and PDF formats for the entity report index
  get 'entity_report/index(.:format)', to: 'entity_report#index'
end

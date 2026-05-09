Lintity::Engine.routes.draw do
  get 'entity_list/index'
  # Route for the new EntityReportController index action
  get 'entity_report', to: 'entity_report#index'
end

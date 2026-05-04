require 'ostruct'

module Lintity
  module ApplicationHelper
    def numeric_filter_tag(filter_field, field_info)
      button_tag "#{field_info[:name]}<i class=\"bi bi-funnel-fill #{ 'text-success' if filter_field == field_info[:field] }\"></i>".html_safe, class: 'btn btn-link', data: {'entity-list-field-param'=>field_info[:field], 'action'=>"click->entity-list#numberic_filter"}
    end

    def filters_select_options
      options_from_collection_for_select([OpenStruct.new(id: 'eq', name: '='), OpenStruct.new(id: 'less', name: '<='), OpenStruct.new(id: 'more', name: '>=')], "id", "name")
    end
  end
end

require 'ostruct'

module Lintity
  module ApplicationHelper
    def numeric_filter_tag(filter_field, field_info)
      button_tag "#{field_info[:name]}<i class=\"bi bi-funnel-fill #{'text-success' if filter_field == field_info[:field]}\"></i>".html_safe,
                 class: 'btn btn-link', data: { 'entity-list-field-param' => field_info[:field], 'action' => 'click->entity-list#numberic_filter' }
    end

    def filters_select_options
      options_from_collection_for_select(
        [OpenStruct.new(id: 'eq', name: '='), OpenStruct.new(id: 'less', name: '<='),
         OpenStruct.new(id: 'more', name: '>=')], 'id', 'name'
      )
    end

    # Renders a header with a caption and an optional "New" button.
    # caption - String displayed as the header title.
    # button_path - URL for the button; if nil or blank, the button is omitted.
    def render_entity_list_header(caption, button_path)
      content_tag(:div, class: 'entity-list-header d-flex justify-content-between align-items-center mb-3') do
        concat content_tag(:h2, caption, class: 'mb-0')
        concat link_to('New', button_path, class: 'btn btn-primary') if button_path.present?
      end
    end

    def render_entity_report_header(caption, button_path)
      content_tag(:div, class: 'entity-list-header d-flex justify-content-between align-items-center mb-3') do
        concat content_tag(:h2, caption, class: 'mb-0')
        concat link_to('PDF', button_path, class: 'btn btn-primary') if button_path.present?
      end
    end
  end
end

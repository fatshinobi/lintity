module Lintity
  class EntityListController < ApplicationController
    before_action :init_fields, only: [:index]
    before_action :check_filters, only: [:index]

    def index; end

    private

    def check_filters
      filters = @fields_settings ? @fields_settings.select { |rec| rec[:type] == 'numeric_filter' } : []
      filters.each do |filter_field_info|
        break if check_filter_field(filter_field_info)
      end
    end

    def check_filter_field(filter_field_info)
      filter_name = filter_field_info[:field]
      field_caption = filter_field_info[:name]
      return nil unless params[filter_name]

      @filter_field = filter_name.to_s
      @filter_value = params[filter_name]
      @filter_caption = field_caption

      @filter_sign =
        case params[:filter_option]
        when 'more'
          '>='
        when 'less'
          '<='
        else
          '='
        end
      @filter_field
    end
  end
end

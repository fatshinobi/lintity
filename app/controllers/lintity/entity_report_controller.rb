# frozen_string_literal: true

module Lintity
  class EntityReportController < ApplicationController
    before_action :init_fields, only: [:index]
    # Child controllers inheriting from this controller should set @records
    # to an array of hashes with the structure described in the view.
    def index
      @records ||= []
    end
  end
end

# frozen_string_literal: true

module Tables
  class ColumnsController < ApplicationController
    def index
      @table = Table.find(params[:table_id])
    end
  end
end

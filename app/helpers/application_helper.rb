# frozen_string_literal: true

module ApplicationHelper
  def display_nullable(boolean)
    boolean ? '◯' : '✕'
  end
end

# frozen_string_literal: true

class LanguagesController < ApplicationController
  def search
    @results = Search.new(search_params).search_result
    render 'search/search_page'
  end

  private

  def search_params
    params.permit(:name, :language_type, :designed_by)
  end
end

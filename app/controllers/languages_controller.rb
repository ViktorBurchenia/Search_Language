# frozen_string_literal: true

class LanguagesController < ApplicationController
  def search
    search_result if search_params.present?
    render 'search/search_page'
  end


  private

  def split_negative_positive(arr)
    arr.split(',').partition { |str| (!str.start_with?("-"))}
  end 

  def initialize_neg
    neg_res_type = Language.where("language_type LIKE ?", "%#{@neg_type}%") if params[:language_type].present?
    neg_res_design = Language.where("designed_by LIKE ?", "%#{@neg_design}%") if params[:language_type].present?
    @sun_neg << neg_res_type
    @sum_neg << neg_res_design
    @sum_neg = @sum_neg.flatten.compact
  end 


  def search_result
    return unless search_params

    language_type_params
    designed_by_params
    @results = calculate_result.tally.sort_by { |_,count| -count }.map(&:first)
  end 

  def search_params
    search_params  ||= params.permit(:name, :language_type, :designed_by) 
  end 


  def language_type_params
    return unless search_params[:language_type].present?

    pos_type, neg_type = split_negative_positive(search_params[:language_type])
    
    neg_type = neg_type.each_with_object([]) do |value, arr|
      arr << value.delete_prefix('-')
    end

    @positive_language_type = Language.where("language_type LIKE ?", "%#{pos_type.join(',')}%") if pos_type.present?
    @negative_language_type = Language.where("language_type LIKE ?", "%#{neg_type.join(',')}%") if neg_type.present?
  end 

  def designed_by_params
    return unless search_params[:designed_by].present?

    pos_design,neg_design = split_negative_positive(search_params[:designed_by])

    neg_design = neg_design.each_with_object([]) do |value, arr|
      arr << value.delete_prefix('-')
    end

    @positive_designed_by = Language.where("designed_by LIKE ?", "%#{pos_design.join(',')}%") if pos_design.present?
    @negative_designed_by = Language.where("designed_by LIKE ?", "%#{neg_design.join(',')}%") if neg_design.present?
  end 

  def calculate_result
    results_name = Language.where("name LIKE ?", "%#{search_params[:name]}%") if params[:name].present?

    results = []
    negative_result = []
    results << results_name
    results << @positive_language_type
    results << @positive_designed_by
    results = results.flatten.compact
    negative_result << @negative_language_type << @negative_designed_by
    negative_result = negative_result.flatten.compact
    results - negative_result
  end
end

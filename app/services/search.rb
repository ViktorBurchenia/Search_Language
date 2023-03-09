# frozen_string_literal: true

class Search
  def initialize(search_params)
    @search_params = search_params
    @negative_result = []
    @positive_result = []
  end

  def search_result
    return unless @search_params

    language_type_params
    designed_by_params

    calculate_result.tally.sort_by { |_, count| -count }.map(&:first)
  end

  private

  def split_negative_positive(arr)
    arr.split(',').partition { |str| !str.start_with?('-') }
  end

  def language_type_params
    return if @search_params[:language_type].blank?

    pos_type, neg_type = split_negative_positive(@search_params[:language_type])

    neg_type = neg_type.each_with_object([]) do |value, arr|
      arr << value.delete_prefix('-')
    end

    if pos_type.present? || neg_type.present?
      @positive_result << Language.where('language_type LIKE ?',
                                         "%#{pos_type.join(',')}%")
    end
    @negative_result << Language.where('language_type LIKE ?', "%#{neg_type.join(',')}%") if neg_type.present?
  end

  def designed_by_params
    return if @search_params[:designed_by].blank?

    pos_design, neg_design = split_negative_positive(@search_params[:designed_by])

    neg_design = neg_design.each_with_object([]) do |value, arr|
      arr << value.delete_prefix('-')
    end

    if pos_design.present? || neg_design.present?
      @positive_result << Language.where('designed_by LIKE ?',
                                         "%#{pos_design.join(',')}%")
    end
    @negative_result << Language.where('designed_by LIKE ?', "%#{neg_design.join(',')}%") if neg_design.present?
  end

  def calculate_result
    @search_params[:name] = 'Common Lisp' if @search_params[:name] == 'Lisp Common'
    results_name = Language.where('name LIKE ?', "%#{@search_params[:name]}%") if @search_params[:name].present?

    @positive_result << results_name
    @positive_result = @positive_result.flatten.compact
    @negative_result = @negative_result.flatten.compact

    @positive_result - @negative_result
  end
end

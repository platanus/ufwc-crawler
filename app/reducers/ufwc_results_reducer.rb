class UfwcResultsReducer < Crabfarm::BaseReducer
  has_field :results, field_default: [], field_readonly: false

  def run
    self.results = css("#tablepress-8 tbody tr").map do |row|
      get_match_from_row(row)
    end
  end

  private

  def get_match_from_row(row)
    Match.new({
      index: row.at_css('.column-1').text,
      date: row.at_css('.column-2').text,
      home: row.at_css('.column-4').text,
      away: row.at_css('.column-6').text,
      venue: row.at_css('.column-8').text,
      match_type: row.at_css('.column-9').text,
      raw_score: row.at_css('.column-5').text,
    }).tap do |match|
      match.calculate_scores
      match.calculate_winner
    end
  end

end

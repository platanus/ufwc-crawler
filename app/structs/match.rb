class Match < Crabfarm::BaseStruct
  DRAW = 'DRAW'
  DATE_REGEXP = /\d{2}\/\d{2}\/\d{4}/

  has_integer :index
  has_string :date, matches: DATE_REGEXP
  has_string :home
  has_string :away
  has_string :venue
  has_string :match_type
  has_string :raw_score
  has_integer :home_score, field_readonly: false
  has_integer :away_score, field_readonly: false
  has_integer :winner, field_readonly: false

  def calculate_scores
    field_hash[:home_score] = get_home_score
    field_hash[:away_score] = get_away_score
  end

  def calculate_winner
    field_hash[:winner] = get_winner
  end

  def get_home_score
    raw_score.split('-').first.to_i
  end

  def get_away_score
    raw_score.split('-').last.to_i
  end

  private

  def get_winner
    match_result = MatchResult.new(self)
    match_result.winner || match_result.penalty_winner || DRAW
  end

  class MatchResult
    def initialize(match)
      self.match = match
      self.home = match.home
      self.away = match.away
      self.away_score = match.away_score
      self.home_score = match.home_score
    end

    def winner
      if home_score > away_score
        home
      elsif away_score > home_score
        away
      end
    end

    def penalty_winner
      [home, away].find do |team|
        team.end_with?("*")
      end
    end

    private

    attr_accessor :match, :home, :away, :away_score, :home_score
  end
end

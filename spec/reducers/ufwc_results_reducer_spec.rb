require 'spec_helper'

describe UfwcResultsReducer do
  it 'returns an array of results', reducing: 'results', live: true do
    expect(reducer.results).to be_kind_of(Array)
  end

  subject { reducer.results.first }

  it 'returns a result with index' do
    expect(subject.index).to_not be_nil
  end

  it 'returns a result with date' do
    expect(subject.date).to match(Match::DATE_REGEXP)
  end

  it 'returns a result with home'  do
    expect(subject.home).to_not be_nil
  end

  it 'returns a result with away'  do
    expect(subject.away).to_not be_nil
  end

  it 'returns a result with venue'  do
    expect(subject.venue).to_not be_nil
  end

  it 'returns a result with match_type'  do
    expect(subject.match_type).to_not be_nil
  end
end

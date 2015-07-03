require 'spec_helper'

describe UfwcResults, navigating: 'results' do
  let!(:reducer) { spy_reducer(UfwcResultsReducer) }

  it "should navigate to results page" do
    navigate
    expect(browser.title).to eq('Results | Unofficial Football World Championships')
  end

  it "should navigate the total of times" do
    navigate
    expect(reducer.calls.size).to eq(10)
  end

  it "should get 903 entries" do
    expect(navigate.document[:results].size).to eq(903)
  end
end

require 'spec_helper'

describe UfwcResults do
  it "should navigate to results page", navigating: 'results' do
    navigate
    expect(browser.title).to eq('Results | Unofficial Football World Championships')
  end
end

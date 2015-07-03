class UfwcResults < Crabfarm::BaseNavigator
  def run
    browser.goto 'http://www.ufwc.co.uk/results/'
    reduce_with_defaults
  end
end

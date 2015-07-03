class UfwcResults < Crabfarm::BaseNavigator
  PAGE_SIZE = 100

  def run
    browser.goto 'http://www.ufwc.co.uk/results/'
    browser.select_list(name: 'tablepress-8_length').select(PAGE_SIZE)

    results = total_pages.times.map do |page|
      reduce_with_defaults.results.tap do |results|
        browser.a(id: 'tablepress-8_next').click
      end
    end.flatten

    { results: results }
  end

  private

  def total_entries
    paginator_text = browser.div(id: 'tablepress-8_info').text
    paginator_text.match(/Showing \d+ to \d+ of (\d+)/)[1].to_i
  end

  def total_pages
    (total_entries.to_f / PAGE_SIZE).ceil
  end
end

require 'spec_helper'

def setup_client
  # nothing
end

def check_location(page, location)
  location = Regexp.escape(location) unless location.is_a? Regexp
  page.evaluate_script('window.location.pathname + window.location.search').should =~ %r<\A/#{location}(\z|\?)>
end
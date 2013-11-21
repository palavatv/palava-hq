require_relative 'capybara'

# workaround from https://github.com/thoughtbot/capybara-webkit/issues/494
module Capyabara21Workarounds
  def click_button(link_name)
    begin
      super link_name
    rescue Capybara::Webkit::ClickFailed => e
      links_with_text = "button:contains(\"#{link_name}\")"
      links_with_id = "button[id=\"#{link_name}\"]"
      click_command = "$('#{links_with_text},#{links_with_id}').click()"
      evaluate_script click_command
    end
  end

  def click_link(link_name)
    begin
      super link_name
    rescue Capybara::Webkit::ClickFailed => e
      links_with_text = "a:contains(\"#{link_name}\")"
      links_with_id = "a[id=\"#{link_name}\"]"
      click_command = "$('#{links_with_text},#{links_with_id}').click()"
      evaluate_script click_command
    end
  end
end

RSpec.configure do |config|
  config.send(:include, Capyabara21Workarounds)
end
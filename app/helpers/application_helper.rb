module ApplicationHelper
  def display_errors(record)
    record.errors.full_messages.each{|msg| msg}.join("<br/>").html_safe
  end
end

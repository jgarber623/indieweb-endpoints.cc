# frozen_string_literal: true

require "irb/completion"
require "rainbow"

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_FILE] = ".irb_history"
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:USE_AUTOCOMPLETE] = false
IRB.conf[:USE_PAGER] = false

prompt = "#{Rainbow("IndieWebEndpoints").orange} (#{Rainbow(ENV.fetch("RACK_ENV")).blue}) (%m) %03n:%i"

IRB.conf[:PROMPT][:RODA] = {
  PROMPT_I: "#{prompt}> ",
  PROMPT_N: "#{prompt}> ",
  PROMPT_S: "#{prompt}%l ",
  PROMPT_C: "#{prompt}* ",
  RETURN: "=> %s\n"
}

IRB.conf[:PROMPT_MODE] = :RODA

def clear
  system("clear")
end

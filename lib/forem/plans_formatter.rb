module Forem
  class PlansFormatter
    extend PlanTextFormatting

    def self.format(text)
      clean_and_format text
    end

    def self.blockquote(text)
      text.split("\n").map do |line|
        "> " + line
      end.join("\n")
    end
  end
end

module ActionView
  module Helpers
    class FormBuilder
      def enum_select(name, enum, options = {}, html_options = {})
        select name, enum.map { |k, v| [k.titleize, v] }, options, html_options
      end
    end
  end
end

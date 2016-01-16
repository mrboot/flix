Date::DATE_FORMATS[:default] = "%b %e, %Y"
Date::DATE_FORMATS[:short_ordinal] = lambda { |date| date.strftime("%b #{date.day.ordinalize}, %Y") }

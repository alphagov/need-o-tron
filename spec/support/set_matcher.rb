module SetMatchers
  class SetEqualityMatcher
    include RSpec::Matchers::Pretty

    def initialize(expected)
      @expected = Set.new(expected)
    end

    def matches?(actual)
      @actual = Set.new(actual)
      @missing_items = @expected - @actual
      @extra_items = @actual - @expected
      @expected == @actual
    end

    def failure_message_for_should
      message =  "expected set contained:    #{expected.inspect}\n"
      message += "actual set contained:      #{actual.inspect}\n"
      message += "the missing elements were: #{@missing_items.inspect}\n" unless @missing_items.empty?
      message += "the extra elements were:   #{@extra_items.inspect}\n"   unless @extra_items.empty?
      message
    end

    def failure_message_for_should_not
      message =  "actual set matched expected set unexpectedly. \n"
      message += "actual set contained: #{@actual.inspect}\n"
      message
    end

    def description
      "equal #{_pretty_print(@expected)} (when both actual and expected are cast to Set)"
    end
  end

  def equal_set(expected)
    SetEqualityMatcher.new(expected)
  end
end

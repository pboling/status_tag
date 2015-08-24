module StatusTag
  class Decider

    attr_accessor :ordered_choices

    def initialize(ordered_choices:)
      @ordered_choices = ordered_choices
    end

    def decide(object)
      ordered_choices.detect do |choice|
        if choice.catch_all?
          true
        else
          object.send(choice.name)
        end
      end
    end

  end
end

# SRP:  Provides a method signature that can be splatted to content_tag_for to create labels
#
#       This base class can be used to instantiate a label for anything.
#       Subclasses will address specific needs, like a label for user status, order status, job state, etc.
#       Flexible: not explicitly dependent on bootstrap or any other style framework.
#
# Example:
#
#       text, signature = StatusTag::Presenter.status_tag_signature_for(:span, mtm_profile, "fit_status")
#       content_tag_for(*signature) do
#         text
#       end

module StatusTag
  class Presenter

    # Override constants in subclasses
    ORDERED_CHOICES = [StatusTag::Choice.new]
    CSS_CLASS = [] # A CSS class or classes to assign to all tags generated with the presenter
    DECIDE_ON = :object # or :self, which will send the messages to the presenter class
                        #   (which has an internal reference to object) and would allow more complicated logic that
                        #   pertains to the view, not the model.
    CHOICE_ON = :object # or :self, which will send the messages to the presenter class
                        #   (which has an internal reference to object) and would allow more complicated logic that
                        #   pertains to the view, not the model.

    attr_accessor :object,  # e.g. an instance of the User class
                  :aspect   # e.g. "state", "status" or some other descriptive name for this particular status tag
                            #       Defaults to nil, so by default there is only one StatusTag presenter allowed per object class,
                            #       as the aspect provides a namespace for additional presenters.
    attr_reader :decider, :choice, :options

    def initialize(object:, aspect: nil, options: {})
      @object = object
      @aspect = aspect
      @decider = StatusTag::Decider.new(ordered_choices: self.class.ordered_choices(object, aspect))
      @options = options || {}
    end

    def decide
      @choice = if (self.class)::DECIDE_ON == :object
                  decider.decide(object)
                else
                  decider.decide(self)
                end
    end

    def text
      return "" unless choice
      if choice.text.is_a?(Symbol)
        receiver = (self.class)::CHOICE_ON == :object ? object : self
        receiver.send(choice.text)
      else
        choice.text
      end
    end

    def noop?
      return true unless choice
      choice.noop?
    end

    def css_class
      return nil unless choice
      choice.css_class
    end

    # An alternative to overriding the constant in subclasses is to override this method.
    # If you override, do not change the signature.
    # The params enable the ordered choices to be derived dynamically for your needs, but are not used by default.
    def self.ordered_choices(object, aspect)
      self::ORDERED_CHOICES
    end

    # An alternative to overriding the CSS_CLASS constant in subclasses is to override this method.
    # If you override, do not change the signature.
    # The params enable the ordered choices to be derived dynamically for your needs, but are not used by default.
    def self.css_class(object, aspect)
      self::CSS_CLASS
    end

  end
end

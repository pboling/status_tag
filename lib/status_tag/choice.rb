module StatusTag
  class Choice

    attr_accessor :name,      # the method that will be called on the object to determine if this is the correct choice
                              #   when nil, indicates this choice is the catch-all, naked `else`
                  :css_class, # css_class is for the CSS class that will differentiate each specific label type (color, size, etc)
                  :text,      # text is the what the label says in the view port
                  :noop       # designates a `name` as taking up space, but not rendering a tag, in the ordered set to tumble the results.

    def initialize(name: nil, css_class: "", text: "", noop: false)
      @name = name
      @css_class = css_class
      @text = text
      @noop = !!noop
    end

    def catch_all?
      name.nil?
    end

    def noop?
      noop
    end

  end
end

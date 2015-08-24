require "status_tag/version"
require "status_tag/utils"
require "status_tag/choice"
require "status_tag/decider"
require "status_tag/presenter"
require "status_tag/null_presenter"

module StatusTag

  extend StatusTag::Utils

  def self.status_tag_presenter(object:, aspect: nil)
    # Support for STI and namespaced Objects is accomplished by
    #   first checking for a Presenter definition at the STI class level
    #   and then checking for a definition at the super class (generic) level.
    namespaces = namespaces_from_class(object.class)
    presenter = nil
    namespaces.inject(object.class) do |namespace, memo|
      if aspect.nil?
        # recommend locating class definition at app/presenters/status_tag/<klass>_presenter.rb
        presenter_class = class_from_string("StatusTag::#{memo}Presenter")
        presenter = presenter_class.new(object: object) if presenter_class
      else
        presenter_class = class_from_string("StatusTag::#{memo}Presenters::#{camelize_underscored(aspect.to_s)}Presenter")
        # recommend locating class definition at app/presenters/status_tag/<klass>_presenters/<aspect>_presenter.rb
        presenter = presenter_class.new(object: object, aspect: aspect) if presenter_class
      end
      break if presenter
      last_namespace = memo.rindex("::")
      memo = memo[0..(last_namespace-1)] if last_namespace # level up!
      memo
    end
    presenter = NullPresenter.new(object: object) unless presenter
    presenter
  end

  # Same signature as Rails' `content_tag_for`.
  # However, does not currently support object being multiple records like Rails' `content_tag_for` does
  def self.status_tag_signature_for(tag, object, prefix = false, options = nil)
    presenter = status_tag_presenter(object: object, aspect: prefix)
    presenter.decide
    text = presenter.text
    return text, nil if presenter.noop?
    options ||= {}
    options[:class] = Array(options[:class])
    options[:class].concat(Array(presenter.class.css_class(object, prefix)))
    options[:class] << presenter.css_class if presenter.css_class
    options[:class] = options[:class].join(" ")
    return text, [tag, presenter.object, presenter.aspect, options]
  end

end

# An example of what a Presenter would look like.
module StatusTag
  class NullPresenter < Presenter
    ORDERED_CHOICES = [StatusTag::Choice.new(text: "null presenter")]
  end
end

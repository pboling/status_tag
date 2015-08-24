module StatusTag
  module MtmProfilePresenters
    class FitStatusPresenter < Presenter
      ORDERED_CHOICES = [
          StatusTag::Choice.new(name: "new?", klass: "label-default-important", text: "New"),
          StatusTag::Choice.new(name: "bad_fit?", klass: "label-default-warning", text: "Bad Fit"),
          StatusTag::Choice.new(name: "confirmed?", klass: "label-default-success", text: "Fit Confirmed"),
          StatusTag::Choice.new(name: "pending?", noop: true), # TODO: Why do we not want pending to display?
          StatusTag::Choice.new(name: nil, klass: "label-default-warning", text: "Fit Unknown"),
      ]
      CSS_CLASS = [
          "label",
          "label-default"
      ]
    end
  end
end

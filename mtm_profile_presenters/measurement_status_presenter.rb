module StatusTag
  module MtmProfilePresenters
    class MeasurementStatusPresenter < Presenter
      ORDERED_CHOICES = [
          StatusTag::Choice.new(name: "bad?", klass: "label-default-warning", text: "Bad Measure"),
          StatusTag::Choice.new(name: "good?", klass: "label-default-success", text: "Good Measure"),
          StatusTag::Choice.new(name: "waiting_approval?", klass: "label-default-important", text: "Pending Measure"),
          StatusTag::Choice.new(name: "on_hold?", klass: "label-default-warning", text: "On Hold"),
          StatusTag::Choice.new(name: "not_measured?", klass: "label-default-important", text: "Not Measured"),
          StatusTag::Choice.new(name: nil, klass: "label-default-warning", text: "Measure Unknown"),
      ]
      CSS_CLASS = [
          "label",
          "label-default"
      ]
    end
  end
end

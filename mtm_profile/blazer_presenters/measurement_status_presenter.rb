module StatusTag
  module MtmProfilePresenters
    class MeasurementStatusPresenter < Presenter
      ORDERED_CHOICES = [
          StatusTag::Choice.new(name: "bad?", klass: "label-default-warning", text: "B Bad Measure"),
          StatusTag::Choice.new(name: "good?", klass: "label-default-success", text: "B Good Measure"),
          StatusTag::Choice.new(name: "waiting_approval?", klass: "label-default-important", text: "B Pending Measure"),
          StatusTag::Choice.new(name: "on_hold?", klass: "label-default-warning", text: "B On Hold"),
          StatusTag::Choice.new(name: "not_measured?", klass: "label-default-important", text: "B Not Measured"),
          StatusTag::Choice.new(name: nil, klass: "label-default-warning", text: "B Measure Unknown"),
      ]
      CSS_CLASS = [
          "label",
          "label-default"
      ]
    end
  end
end

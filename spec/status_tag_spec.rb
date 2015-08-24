require "spec_helper"
require "pry"

describe StatusTag do

  it "has a version number" do
    expect(StatusTag::VERSION).not_to be nil
  end

  describe ".status_tag_presenter" do
    let(:aspect) { nil }
    let(:presenter) { StatusTag.status_tag_presenter(object: object, aspect: aspect) }
    context "null case" do
      let(:object) { nil }
      it("returns a StatusTag::Presenter") { expect(presenter).to be_a StatusTag::Presenter }
      it("returns a StatusTag::NullPresenter") { expect(presenter).to be_a StatusTag::NullPresenter }
    end
    context "with non-nil object" do
      context "missing custom presenter" do
        let(:object) { "" }
        it("returns a StatusTag::Presenter") { expect(presenter).to be_a StatusTag::Presenter }
        it("returns a StatusTag::NullPresenter") { expect(presenter).to be_a StatusTag::NullPresenter }
      end
      context "with custom object presenter" do
        class StatusTag::ArrayPresenter < StatusTag::Presenter; end
        let(:object) { [1,2,3] }
        context "without an aspect" do
          it("returns a StatusTag::Presenter") { expect(presenter).to be_a StatusTag::Presenter }
          it("returns a StatusTag::ArrayPresenter") { expect(presenter).to be_a StatusTag::ArrayPresenter }
        end
        context "with an aspect" do
          context "missing customer aspect presenter" do
            let(:object) { [1,2,3] }
            let(:aspect) { "swarthy" }
            it("returns a StatusTag::Presenter") { expect(presenter).to be_a StatusTag::Presenter }
            it("returns a StatusTag::NullPresenter") { expect(presenter).to be_a StatusTag::NullPresenter }
          end
          context "with customer aspect presenter" do
            module StatusTag; module ArrayPresenters; class SwarthyBuglePresenter < StatusTag::Presenter; end; end; end
            let(:object) { [1,2,3] }
            let(:aspect) { "swarthy_bugle" }
            it("returns a StatusTag::Presenter") { expect(presenter).to be_a StatusTag::Presenter }
            it("returns a StatusTag::ArrayPresenters::SwarthyBuglePresenter") { expect(presenter).to be_a StatusTag::ArrayPresenters::SwarthyBuglePresenter }
          end
        end
      end
    end
  end

  describe ".status_tag_signature_for" do
    let(:tag) { :span }
    let(:prefix) { nil }
    let(:options) { nil }
    let(:signature) { StatusTag.status_tag_signature_for(tag, object, prefix, options) }
    context "null case" do
      let(:object) { nil }
      it("returns the text and signature") {
        text, sig = signature
        expect(text).to eq "null presenter"
        expect(sig).to be_a Array
        expect(sig).to eq [:span, nil, nil, {:class=>""}]
      }
    end
    context "with non-nil object" do
      context "missing custom presenter" do
        let(:object) { "" }
        it("returns the text and signature") {
          text, sig = signature
          expect(text).to eq "null presenter"
          expect(sig).to be_a Array
          expect(sig).to eq [:span, "", nil, {:class=>""}]
        }
      end
      context "with custom object presenter" do
        class StatusTag::ArrayPresenter < StatusTag::Presenter; end
        let(:object) { [1,2,3] }
        context "without an aspect" do
          it("returns the text and signature") {
            text, sig = signature
            expect(text).to eq ""
            expect(sig).to be_a Array
            expect(sig).to eq [:span, [1, 2, 3], nil, {:class=>""}]
          }
        end
        context "DECIDE_ON = :self" do
          class MyArray < Array; end
          class StatusTag::MyArrayPresenter < StatusTag::Presenter
            DECIDE_ON = :self
            ORDERED_CHOICES = [
                StatusTag::Choice.new(name: "empty?", text: "pigs fly", klass: "fence"),
                StatusTag::Choice.new(name: "flatten!", text: "a dingo ate", noop: true),
                StatusTag::Choice.new(name: "foo", text: "ants march", klass: "bar"),
                StatusTag::Choice.new(name: nil, text: "COWS MOO", klass: "cheese")
            ]
            def empty?
              object.empty?
            end
            def flatten!
              object.flatten!
            end
            def foo
              object[0] == 1
            end
          end
          context "chooses first" do
            let(:object) { MyArray.new }
            it("returns the text and signature") {
              text, sig = signature
              expect(text).to eq "pigs fly"
              expect(sig).to be_a Array
              expect(sig).to eq [:span, object, nil, {:class=>"fence"}]
            }
          end
          context "chooses second" do
            let(:object) { MyArray.new([[1]]) }
            it("returns the text and signature") {
              text, sig = signature
              expect(text).to eq "a dingo ate"
              expect(sig).to be_nil
            }
          end
          context "chooses third" do
            let(:object) { MyArray.new([1]) }
            it("returns the text and signature") {
              text, sig = signature
              expect(text).to eq "ants march"
              expect(sig).to be_a Array
              expect(sig).to eq [:span, object, nil, {:class=>"bar"}]
            }
          end
        end
        context "with an aspect" do
          context "missing custom aspect presenter" do
            let(:object) { [1,2,3] }
            let(:prefix) { "swarthy" }
            it("returns the text and signature") {
              text, sig = signature
              expect(text).to eq "null presenter"
              expect(sig).to be_a Array
              expect(sig).to eq [:span, [1, 2, 3], nil, {:class=>""}]
            }
          end
          context "with customer aspect presenter" do
            module StatusTag; module ArrayPresenters; class SwarthyBuglePresenter < StatusTag::Presenter; end; end; end
            let(:object) { [1,2,3] }
            let(:prefix) { "swarthy_bugle" }
            it("returns the text and signature") {
              text, sig = signature
              expect(text).to eq ""
              expect(sig).to be_a Array
              expect(sig).to eq [:span, [1, 2, 3], "swarthy_bugle", {:class=>""}]
            }
          end
          context "with ORDERED_CHOICES and CSS_CLASS" do
            module StatusTag; module ArrayPresenters;
              class SwarthyMooglePresenter < StatusTag::Presenter
                ORDERED_CHOICES = [
                    StatusTag::Choice.new(name: "empty?", text: "pigs fly", klass: "fence"),
                    StatusTag::Choice.new(name: "flatten!", text: "a dingo ate", noop: true),
                    StatusTag::Choice.new(name: nil, text: "COWS MOO", klass: "cheese")
                ]
                CSS_CLASS = %w(label label-default)
              end;
            end; end
            context "first choice passes test" do
              let(:object) { [] }
              let(:prefix) { "swarthy_moogle" }
              it("returns the text and signature") {
                text, sig = signature
                expect(text).to eq "pigs fly"
                expect(sig).to be_a Array
                expect(sig).to eq [:span, [], "swarthy_moogle", {:class=>"label label-default fence"}]
              }
            end
            context "noop choice passes test" do
              let(:object) { [[1],[2],[3]] }
              let(:prefix) { "swarthy_moogle" }
              it("returns the text and a nil signature") {
                text, sig = signature
                expect(text).to eq "a dingo ate"
                expect(sig).to be_nil
              }
            end
            context "decides on catch-all choice" do
              let(:object) { [1,2,3] }
              let(:prefix) { "swarthy_moogle" }
              it("returns the text and signature") {
                text, sig = signature
                expect(text).to eq "COWS MOO"
                expect(sig).to be_a Array
                expect(sig).to eq [:span, [1, 2, 3], "swarthy_moogle", {:class => "label label-default cheese"}]
              }
            end
          end
        end
      end
    end
  end

end

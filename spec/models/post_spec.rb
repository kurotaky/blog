require 'rails_helper'

RSpec.describe Post, type: :model do
  subject {
    described_class.new(
      title: "Test Title",
      content: "Lorem ipsum dolor sit amet"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without content" do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it "has a rich text content" do
    expect(subject.content.class == ActionText::RichText).to be true
  end

  it "has a rich text content with body" do
    html_content = <<~HTML
      <div class="trix-content">
        Lorem ipsum dolor sit amet
      </div>
    HTML
    expect(subject.content.body.to_s).to eq(html_content)
  end
end

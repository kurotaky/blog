require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(
      eth_address: "0x123456789abcdef",
      eth_nonce: "123456",
      username: "test_user"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a eth_address" do
    subject.eth_address = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a eth_nonce" do
    subject.eth_nonce = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate eth_address" do
    described_class.create!(
      eth_address: "0x123456789abcdef",
      eth_nonce: "123456",
      username: "test_user"
    )
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate eth_nonce" do
    described_class.create!(
      eth_address: "0xabcdef123456789",
      eth_nonce: "123456",
      username: "another_user"
    )
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate username" do
    described_class.create!(
      eth_address: "0xabcdef123456789",
      eth_nonce: "654321",
      username: "test_user"
    )
    expect(subject).to_not be_valid
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:conversations) }
    it { is_expected.to have_many(:recepient_conversations) }
    it { is_expected.to have_many(:conversation_messages).through(:conversations) }
    it { is_expected.to have_many(:recepient_messages).through(:recepient_conversations).source(:conversation_messages) }
  end
end

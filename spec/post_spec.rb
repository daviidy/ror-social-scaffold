require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    described_class.new(
      content: 'test'
    )
  end

  describe 'Validations' do
    it 'is not valid without valid attributes' do
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:user) }
  end
end

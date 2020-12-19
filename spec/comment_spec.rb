require 'rails_helper'

RSpec.describe Comment, type: :model do
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
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end

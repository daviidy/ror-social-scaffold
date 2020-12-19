require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      name: 'dave',
      email: 'test@test.com'
    )
  end

  describe 'Validations' do
    it 'is not valid without valid attributes' do
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:followers) }
    it { should have_many(:leaders) }
  end
end

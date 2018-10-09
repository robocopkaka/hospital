require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'values are present' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'email uniqueness' do
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'email format' do
    it { should allow_value('kachi@kqchi.com').for(:email) }
    it { should_not allow_value('kachi').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:appointments) }
    it { should have_many(:patients).through(:appointments) }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'validations' do
    it 'is invalid if first name is not present' do
      subject.first_name = ''
      expect(subject.valid?).to be(false)
      expect(subject.errors.full_messages).to eq(["First name can't be blank"])
    end
  end

  describe '#full_name' do
    context 'last_name is present' do
      it 'returns the first and last name' do
        expect(subject.full_name).to eq('Person Dude')
      end
    end

    context 'last_name is not present' do
      it 'returns the first name' do
        subject.last_name = nil
        expect(subject.full_name).to eq('Person')
      end
    end
  end
end

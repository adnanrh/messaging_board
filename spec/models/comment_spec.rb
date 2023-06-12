require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    subject { create(:comment) }

    it 'is invalid if body is not present' do
      subject.body = nil
      expect(subject.valid?).to be(false)
      expect(subject.errors.full_messages).to eq(["Body can't be blank"])
    end

    it 'is invalid if body is greather than 30 characters' do
      subject.body = 'a' * 31
      expect(subject.valid?).to be(false)
      expect(subject.errors.full_messages).to eq(["Body is too long (maximum is 30 characters)"])
    end
  end

  describe '#timestamp' do
    it 'returns the created_at time in the format Y-M-D H:M' do
      Timecop.freeze(DateTime.new(2023, 6, 11, 15, 30, 10)) do
        comment = create(:comment)
        expect(comment.timestamp).to eq('2023-06-11 15:30')
      end
    end
  end
end

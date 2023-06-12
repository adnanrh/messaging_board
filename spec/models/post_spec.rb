require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { create(:post) }

    context 'title' do
      it 'is invalid if not present' do
        subject.title = nil
        expect(subject.valid?).to be(false)
        expect(subject.errors.full_messages).to eq(["Title can't be blank"])
      end

      it 'is invalid if greather than 30 characters' do
        subject.title = 'a' * 31
        expect(subject.valid?).to be(false)
        expect(subject.errors.full_messages).to eq(["Title is too long (maximum is 30 characters)"])
      end
    end

    context 'body' do
      it 'is invalid if not present' do
        subject.body = nil
        expect(subject.valid?).to be(false)
        expect(subject.errors.full_messages).to eq(["Body can't be blank"])
      end

      it 'is invalid if greather than 30 characters' do
        subject.body = 'a' * 251
        expect(subject.valid?).to be(false)
        expect(subject.errors.full_messages).to eq(["Body is too long (maximum is 250 characters)"])
      end
    end
  end

  describe '.by_recent' do
    subject { Post.by_recent }
    let(:oldest_post) { create(:post) }
    let(:old_post) { create(:post) }
    let(:new_post) { create(:post) }

    before do
      Timecop.freeze { new_post }
      Timecop.freeze(1.day.ago) { old_post }
      Timecop.freeze(2.days.ago) { oldest_post }
    end

    it 'returns posts ordered by created_at descending' do
      expect(subject.map(&:id)).to eq([new_post.id, old_post.id, oldest_post.id])
    end
  end

  describe '#timestamp' do
    it 'returns the created_at time in the format Y-M-D H:M' do
      Timecop.freeze(DateTime.new(2023, 6, 11, 15, 30, 10)) do
        post = create(:post)
        expect(post.timestamp).to eq('2023-06-11 15:30')
      end
    end
  end
end

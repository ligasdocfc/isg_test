# spec/interactors/posts/destroy_post_interactor_spec.rb

require 'rails_helper'

module Posts
  RSpec.describe DestroyPostInteractor do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    subject(:interactor) { described_class.call(user:, post:) }

    describe '#call' do
      context 'when comments exist' do
        let!(:comment1) { create(:comment, post:) }
        let!(:comment2) { create(:comment, post:) }

        it 'destroys associated comments and the post within a transaction' do
          expect { interactor }.to change(Comment, :count).by(-2)
          expect(Post.exists?(post.id)).to be_falsey
        end
      end

      context 'when no comments exist' do
        it 'destroys the post within a transaction' do
          expect { interactor }.to change(Comment, :count).by(0)
          expect(Post.exists?(post.id)).to be_falsey
        end
      end
    end
  end
end

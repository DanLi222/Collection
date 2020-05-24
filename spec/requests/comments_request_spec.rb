require 'rails_helper'

describe CommentsController, type: :request do
  before do
    sign_in User.create(email: 'test@example.com', name: 'Test', password: 'password')
  end

  context '#create' do
    it 'belongs to the item given in the path' do
      item = Item.create(name: 'item', category: 'water')
      params = {
          comment: { body: 'Test body' },
      }

      post "/items/#{item.id}/comments", params: params

      expect(Comment.first.item).to eq(item)
    end

    it 'sets user_id as the current_user id' do
      item = Item.create(name: 'item', category: 'water')
      params = {
          comment: { body: 'Test body' },
      }

      post "/items/#{item.id}/comments", params: params

      expect(Comment.first.user_id).to eq(controller.current_user.id)
    end

    it 'sets commenter as the current_user name' do
      item = Item.create(name: 'item', category: 'water')
      params = {
          comment: { body: 'Test body' },
      }

      post "/items/#{item.id}/comments", params: params

      expect(Comment.first.commenter).to eq(controller.current_user.name)
    end

    it 'redirects to given item path' do
      item = Item.create(name: 'item', category: 'water')
      params = {
          comment: { body: 'Test body' },
      }

      post "/items/#{item.id}/comments", params: params

      expect(controller).to redirect_to(item_path(item))
    end
  end

  context '#destroy' do
    it 'deletes the comment given in the path' do
      item = Item.create(name: 'item', category: 'water')
      comment = Comment.create(body: 'Test body', item_id: item.id, user_id: User.first.id)

      delete "/items/#{item.id}/comments/#{comment.id}"

      expect(Comment.count).to eq(0)
    end

    it 'redirects to the item given in the path' do
      item = Item.create(name: 'item', category: 'water')
      comment = Comment.create(body: 'Test body', item_id: item.id, user_id: User.first.id)

      delete "/items/#{item.id}/comments/#{comment.id}"

      expect(controller).to redirect_to(item_path(item))
    end
  end
end

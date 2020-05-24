require 'rails_helper'

describe CommentsController, type: :request do

  context '#index' do
    it 'displays all items' do
      item_1 = Item.create(name: 'item_1', category: 'water')
      item_2 = Item.create(name: 'item_2', category: 'nature')
      item_3 = Item.create(name: 'item_3', category: 'animals')

      items = [item_1, item_2, item_3]
      items.each do |item|
        item.image.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                          filename: 'avatar.jpg',
                          content_type: '/image/gif')
      end

      get items_path

      expect(response.body.include? 'item_1').to eq(true)
      expect(response.body.include? 'item_2').to eq(true)
      expect(response.body.include? 'item_3').to eq(true)
    end

    it 'displays items based on filter' do
      item_1 = Item.create(name: 'item_1', category: 'water')
      item_2 = Item.create(name: 'item_2', category: 'nature')
      item_3 = Item.create(name: 'item_3', category: 'animals')

      items = [item_1, item_2, item_3]
      items.each do |item|
        item.image.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                          filename: 'avatar.jpg',
                          content_type: '/image/gif')
      end

      params = {
          search: 'water'
      }
      get items_path, params: params

      expect(response.body.include? 'item_1').to eq(true)
      expect(response.body.include? 'item_2').to eq(false)
      expect(response.body.include? 'item_3').to eq(false)
    end

    it 'hides carousel when filter present' do
      item_1 = Item.create(name: 'item_1', category: 'water')
      item_2 = Item.create(name: 'item_2', category: 'nature')
      item_3 = Item.create(name: 'item_3', category: 'animals')

      items = [item_1, item_2, item_3]
      items.each do |item|
        item.image.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                          filename: 'avatar.jpg',
                          content_type: '/image/gif')
      end

      params = {
          search: 'water'
      }
      get items_path, params: params

      expect(
          response.body.include?('<div id="myCarousel" class="carousel slide hidden" data-ride="carousel">')
      ).to eq(true)
    end

    it 'displays all items if filter returns empty' do
      item_1 = Item.create(name: 'item_1', category: 'water')
      item_2 = Item.create(name: 'item_2', category: 'nature')
      item_3 = Item.create(name: 'item_3', category: 'animals')

      items = [item_1, item_2, item_3]
      items.each do |item|
        item.image.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                          filename: 'avatar.jpg',
                          content_type: '/image/gif')
      end

      params = {
          search: 'cars'
      }
      get items_path, params: params

      expect(response.body.include? 'item_1').to eq(true)
      expect(response.body.include? 'item_2').to eq(true)
      expect(response.body.include? 'item_3').to eq(true)
    end

    it 'displays a flash notice if filter returns empty' do
      item_1 = Item.create(name: 'item_1', category: 'water')
      item_2 = Item.create(name: 'item_2', category: 'nature')
      item_3 = Item.create(name: 'item_3', category: 'animals')

      items = [item_1, item_2, item_3]
      items.each do |item|
        item.image.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                          filename: 'avatar.jpg',
                          content_type: '/image/gif')
      end

      params = {
          search: 'cars'
      }
      get items_path, params: params

      expect(flash[:notice]).to_not eq(nil)
    end
  end

  context '#show' do
    it 'displays item as per the path' do
      item = Item.create(name: 'item', category: 'water')
      item.image.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                        filename: 'avatar.jpg',
                        content_type: '/image/gif')

      get item_path(item)

      expect(request.path).to eq("/items/#{item.id}")
      expect(response.code).to eq('200')
    end
  end

  context '#create' do
    it 'saves the new item' do
      params = {item: {name: 'item', category: 'water'} }

      post "/items", params: params

      expect(Item.count).to eq(1)
    end

    it 'redirects to the new item' do
      params = {item: {name: 'item', category: 'water'} }

      post "/items", params: params

      expect(controller).to redirect_to item_path(Item.first)
    end

    it 'renders new if save failed' do
      params = {item: {name: ''} }

      post "/items", params: params

      expect(response.code).to eq('200')
    end
  end

  context '#update' do
    it 'updates the given item' do
      item = Item.create(name: 'item', category: 'water')
      params = {item: {name: 'item', category: 'nature'} }

      put "/items/#{item.id}", params: params

      item.reload
      expect(item.category).to eq('nature')
    end

    it 'redirects to the updated item' do
      item = Item.create(name: 'item', category: 'water')
      params = {item: {name: 'item', category: 'nature'} }

      put "/items/#{item.id}", params: params

      expect(controller).to redirect_to item_path(item)
    end

    it 'renders edit if save failed' do
      item = Item.create(name: 'item', category: 'water')
      params = {item: {name: ''} }

      put "/items/#{item.id}", params: params

      expect(response.code).to eq('200')
    end
  end

  context '#destroy' do
    it 'deletes the item given in the path' do
      item = Item.create(name: 'item', category: 'water')

      delete "/items/#{item.id}"

      expect(Item.count).to eq(0)
    end

    it 'redirects to items index' do
      item = Item.create(name: 'item', category: 'water')

      delete "/items/#{item.id}"

      expect(controller).to redirect_to(items_path)
    end
  end
end

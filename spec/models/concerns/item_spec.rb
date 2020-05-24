require 'rails_helper'

describe ItemConcern do
  context 'scopes' do
    it 'can search based on filter' do
      test_item_1 = Item.create(name: 'test_item_1', category:'water')
      Item.create(name: 'test_item_2', category:'nature')

      search_result = Item.search('water')

      expect(search_result.count).to eq(1)
      expect(search_result.first).to eq(test_item_1)
    end
  end
end
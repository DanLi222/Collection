require 'rails_helper'

describe ApplicationHelper do
  context 'when user has avatar' do
    it 'fetches the avatar' do
      user = User.create(email: 'test@example.com', name: 'Test', password: 'password')
      user.avatar.attach(io: File.open(Rails.root.join 'app/assets/images/default_avatar.gif'),
                         filename: 'avatar.jpg',
                         content_type: '/image/gif')

      expect(fetch_avatar(user)).to be_an(ActiveStorage::Attached)
    end

    context 'when user has no avatar' do
      it 'returns the default avatar' do
        user = User.create(email: 'test@example.com', name: 'Test', password: 'password')

        expect(fetch_avatar(user)).to eq('default_avatar.gif')
      end
    end
  end
end

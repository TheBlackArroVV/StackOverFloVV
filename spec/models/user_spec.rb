require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_for_oauth' do
    let!(:user) { create :user }
    let(:oauth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }

    context 'user already have authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'github', uid: '123456')
        expect(User.find_for_oauth(oauth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user exist' do
        let(:oauth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: user.email }) }

        it 'should not create new user' do
          expect { User.find_for_oauth(oauth) }.to_not change(User, :count)
        end

        it 'should create authorization for user' do
          expect { User.find_for_oauth(oauth) }.to change(user.authorizations, :count).by(1)
        end

        it 'create authorization with provider and uid' do
          authorization = User.find_for_oauth(oauth).authorizations.first

          expect(authorization.provider).to eq oauth.provider
          expect(authorization.uid).to eq oauth.uid
        end

        it 'returns user' do
          expect(User.find_for_oauth(oauth)).to eq user
        end
      end

      context 'user do not exist' do
        let(:oauth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: "user@email.com" }) }

        it 'creates new user' do
          expect { User.find_for_oauth(oauth) }.to change(User, :count).by(1)
        end

        it 'returns user' do
          expect(User.find_for_oauth(oauth)).to be_a(User)
        end

        it 'fills email user' do
          expect(User.find_for_oauth(oauth).email).to eq oauth.info.email
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(oauth)
          expect(user.authorizations).to_not be_empty
        end

        it 'create authorization with provider and uid' do
          authorization = User.find_for_oauth(oauth).authorizations.first

          expect(authorization.provider).to eq oauth.provider
          expect(authorization.uid).to eq oauth.uid
        end
      end
    end
  end
end
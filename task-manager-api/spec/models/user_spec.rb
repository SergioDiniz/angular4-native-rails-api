require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:user) { build(:user) }

  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'retun email end created_at' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return("asd123zxcTOKEN")
      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: asd123zxcTOKEN")
    end
  end

  describe '#generate_authetication_token!' do
    it 'generetes a unique ayth token' do
      allow(Devise).to receive(:friendly_token).and_return("asd123zxcTOKEN")
      user.generate_authentication_token!

      expect(user.auth_token).to eq("asd123zxcTOKEN")
    end

    it 'generetes another auth token when the current token is already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('asd123tokenxyz', 'asd123tokenxyz', 'abc321token2')
      existing_user = create(:user)
      user.generate_authentication_token!
      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end

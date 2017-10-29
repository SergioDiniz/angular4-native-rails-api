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
end

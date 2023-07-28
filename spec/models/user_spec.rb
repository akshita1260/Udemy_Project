require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating user' do 
    let(:user12) {build:user}
    it 'verify valid user' do 
      user12.valid? eql?(true)
    end
  end
end

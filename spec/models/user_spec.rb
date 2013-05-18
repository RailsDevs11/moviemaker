require 'spec_helper'
require "cancan/matchers"

describe User do

  context 'Model Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  context 'Associations' do
    it { should have_many(:friends) }
  end

end

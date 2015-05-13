require 'rails_helper'

RSpec.describe Tag, type: :model do

  it 'validates a tag' do
    tag = build(:tag)
    expect(tag).to be_valid
  end

  it 'is not valid when name is blank' do
    tag = build(:tag, name: '')
    expect(tag).to_not be_valid
  end
end

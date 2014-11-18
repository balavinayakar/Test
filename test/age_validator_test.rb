require 'test_helper'

describe AgeValidator do
  before do
    @adult = Adult.new
  end

  it 'validates age' do
    travel_to Date.new(2014,1,2) do
      @adult.birthday = Date.new(1996,1,1)
      @adult.age.must_equal 18
      @adult.valid?.must_equal true

      @adult.birthday = Date.new(1996,1,2)
      @adult.age.must_equal 18
      @adult.valid?.must_equal true

      @adult.birthday = Date.new(1996,1,3)
      @adult.age.must_equal 17
      @adult.valid?.must_equal false
      @adult.errors.full_messages.first.must_equal 'Birthday must be over 18'
    end
  end

  it 'validates presence' do
    travel_to Date.new(2014,1,2) do
      @adult.birthday = nil
      @adult.valid?.must_equal false
      @adult.errors.full_messages.first.must_equal "Birthday can't be blank"
    end
  end

  it 'validates date' do
    travel_to Date.new(2014,1,2) do
      @adult.birthday = 'invalid'
      @adult.valid?.must_equal false
      @adult.errors.full_messages.first.must_equal 'Birthday is not a valid date'
    end
  end

  it 'allows blank' do
    adult = AdultAllowBlank.new

    travel_to Date.new(2014,1,2) do
      adult.birthday = nil
      adult.valid?.must_equal true
    end
  end
end

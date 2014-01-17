require 'spec_helper'

describe Identity do

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password_digest }

end

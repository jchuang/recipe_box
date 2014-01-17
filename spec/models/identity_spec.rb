require 'spec_helper'

describe Identity do

  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :user }

  it { should belong_to :user }

end

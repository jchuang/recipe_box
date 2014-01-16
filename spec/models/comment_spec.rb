require 'spec_helper'

describe Comment do

  it { should validate_presence_of :body }
  it { should validate_presence_of :recipe }
  it { should validate_presence_of :user }

  it { should belong_to :recipe }
  it { should belong_to :user }

end

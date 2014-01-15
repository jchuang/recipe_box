require 'spec_helper'

describe RecipeTag do

  it { should validate_presence_of :recipe }
  it { should validate_presence_of :tag }

  it { should belong_to :recipe }
  it { should belong_to :tag }

end

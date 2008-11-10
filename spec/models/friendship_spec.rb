require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Friendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }
  it { should belong_to(:user, :friend) }
end

require 'spec_helper'

describe Vx::Cacher do
  it 'has a version number' do
    expect(Vx::Cacher::VERSION).not_to be nil
  end

  it "has azure classes" do
    expect(Vx::Cacher::Azure).to be
    expect(Vx::Cacher::Azure::Blob).to be
  end
end

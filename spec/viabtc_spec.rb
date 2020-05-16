# frozen_string_literal: true

RSpec.describe ViaBTC do
  it 'has a version number' do
    expect(ViaBTC::VERSION).not_to be nil
  end

  it 'has semantic versioning' do
    semver = /\A\d+\.\d+\.\d+\Z/
    expect(ViaBTC::VERSION.match(semver)).not_to be_nil
  end
end

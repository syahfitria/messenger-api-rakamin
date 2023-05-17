RSpec::Matchers.define :be_json_type do |expected|
  match do |actual|
    actual.keys == expected.keys &&
    actual.values.map(&:class) == expected.values.map(&:class)
  end

  failure_message do |actual|
    "expected #{actual} to be equal to JSON representation of #{expected}"
  end

  description do
    "be equal to the JSON representation of #{expected}"
  end
end
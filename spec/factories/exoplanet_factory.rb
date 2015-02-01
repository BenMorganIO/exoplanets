FactoryGirl.define do
  factory :exoplanet do
    name "#{%w(Kepler OGLE-TR HD).sample}-#{Random.rand(100..999)}"
    letter [*('a'..'z')].sample
    discovery_method Exoplanet::DISCOVERY_METHODS.sample
  end
end

FactoryBot.define do
  factory :reservation do
    start_date { "2019-02-23" }
    end_date { "2019-02-23" }
    listing { nil }
  end
end

FactoryGirl.define do
  sequence :name do |n|
    "app#{DateTime.now.to_i}#{n}"
  end

  factory :valid_app, class: Application do
  	name { generate(:name) }
  end

  factory :invalid_app, class: Application do
  	name 'Lorem ipsum dolor sit amet'
  end

end
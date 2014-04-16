FactoryGirl.define do
  factory :valid_component, class: Component do
    name 'web'
    command 'bundle exec rails server -p 3000'
  end

  factory :invalid_component, class: Component do
    # TODO
  end
end
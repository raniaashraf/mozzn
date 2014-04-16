FactoryGirl.define do
  factory :valid_datastore, class: Datastore do
    name 'postgresql' 
    role 'master'
  end

  factory :invalid_datastore, class: Datastore do
    # TODO
  end
end
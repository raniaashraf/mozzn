FactoryGirl.define do
  factory :valid_user, class CLI do
    cli = Mozzn::Cli.new
    name = 'rania'
    email = unique_email
    password = '12345678'
    password_confirmation = '12345678'
    @cli.options = {
      name: name,
      email: email ,
      password: password,
      password_confirmation: password_confirmation
    }
    @cli.registration 
  end
end

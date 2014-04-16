FactoryGirl.define do
  factory :valid_user do
    cli = Mozzn::Cli.new
    cli.options = {
      email:'test@mozzn.com',
      password: '12345678'
    } 
    cli.login  
  end
end

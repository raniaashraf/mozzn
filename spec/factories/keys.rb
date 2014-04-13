FactoryGirl.define do
  factory :valid_key, class: Key do
    public 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXwZsqptW/1sxBvT6FAukbGsDKzqoBwwaAj6yUgM1ygdupF3NHhpf3huenu9X09SQTjvGDUjLCn6MgIREumrn3JaIEceqRVI5wtAd2c8S1kwJxZLYqTJT4iifW/ydTocz94FADwrLYWHIjlGLh/FY6xDHhloL0Ymvv+iiEg4cWhdC23zenEUOBS7khnw2FeXxLag4/tcinEYR1+Z3PrhRvfg964Rlf1BdspRwuF26GbiRqgo2M1bj9tBH5PZyL17R06adOpBAh1UzT8X9qSXi9OYE9C2HDIGH3MRpCdpJWU36FWqg8iG/DnFzlxzheRJ78A5R8WdDL2oMFE/BrkM9d'
  end

  factory :invalid_key, class: Key do
    public  'Lorem ipsum dolor sit amet'
  end

end
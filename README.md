#Mozzn
Command Line Interface for mozzn APIs
##Installation

Run the following command from your terminal:

    $ gem install mozzn

##Usage
###Mozzn Commands


Commands:
  - mozzn add_key             
  - mozzn create_app APPNAME  
  - mozzn help COMMAND        
  - mozzn login               
  - mozzn registration        
  - mozzn remove_app APPNAME  
  - mozzn update              

Detailed command usage: 

    $ mozzn add_key



####mozzn add_key

#####Options:
  -k, [--public-key=PUBLIC_KEY]  
  -p, [--key-path=KEY_PATH]      

Add your SSH Public Key

    $ mozzn create_app



####mozzn create_app APPNAME

create a new application

    $ mozzn help



####mozzn help COMMAND

For more infromation about spicific COMMAND

    $ mozzn login



####mozzn login

#####Options:
  -u, [--email=EMAIL]        
  -p, [--password=PASSWORD]  

Login with your mozzn credentials

    $ mozzn registration



####mozzn registration

#####Options:
  -n, [--name=NAME]                                    
  -u, [--email=EMAIL]                                  
  -p, [--password=PASSWORD]                            
  -c, [--password-confirmation=PASSWORD_CONFIRMATION]  

Create an account on mozzn.

    $ mozzn remove_app



####mozzn remove_app APPNAME

Remove spcicfic Application.

    $ mozzn update



####mozzn update

To show if there is an update for the CLI

## Contributing
1. Fork it ( http://github.com/mozzn/mozzn/fork )
2. Create your feature branch ( git checkout -b my-new-feature)
3. Commit your changes ( git commit -am 'Add some feature')
4. Push to the branch ( git push origin my-new-feature)
5. Create new Pull Request

module Mozzn
  module Commands
    class Key < Thor
      desc 'add', 'Add your SSH Public Key directily or add its path'
      method_option :public_key, :aliases => "-k", :desc => "RSA/DSA public key"
      method_option :key_path, :aliases => "-p", :desc => "Path to RSA/DSA public key"
      def add
        token = Mozzn::Config.new.read['token']
        if token.nil?
          raise Thor::Error,"You need to login in order to continue."
        end
        mozzn = Mozzn::Api.new(token)
        if options[:key_path].present?
          key_path = File.expand_path(options[:key_path])
        elsif options[:public_key].present?
          public_key = options[:public_key]
        else
          raise Thor::Error, "Neither a key path or an SSH key were provided. You must use -p or -k options."
        end

        if public_key.nil?
          if File.exist?(key_path)
            File.open(key_path, "rb") do |f|
              public_key = f.read
            end
          else
            raise Thor::Error, "Unable to read #{key_path}. File does not exist or not accessible."
          end
        end

        path = 'keys'
        params = {
          key: {
            public: public_key
          }
        }
        response = mozzn.post(path, params)
        say response['info'], :green
      rescue Mozzn::Disconnected
        say 'Unable to connect to Mozzn check the internet connection!', :red
      rescue Mozzn::UnexpectedOutput
        say 'UnexpectedOutput', :red
      end

      desc 'destroy', 'Delete specific SSH public Key.'
      def destroy
        # TODO
      end

      desc 'list', 'List all your SSH public keys.'
      def list
        token = Mozzn::Config.new.read['token']
        if token.nil?
          raise Thor::Error,"You need to login in order to continue."
        end
        mozzn = Mozzn::Api.new(token)
        path = "keys"
        response = mozzn.get(path, nil)
        say response['keys'].first['name']
        # if response.has_key? ('info')
        #   say response['info'], :yellow
        #   return
        # end
        # table = Terminal::Table.new(headings: ['ID', 'Name']) do |t|
        #   response['keys'].each do |key|
        #     key = key['id']
        #     value = key['name']
        #     t.add_row [key, value]  
        #   end
        # end
        # say "Your SSH keys are:"
        # say table
        # rescue Mozzn::Disconnected
        # say 'Unable to connect to Mozzn. Check your internet connection!', :red
        # rescue Mozzn::UnexpectedOutput
        # say 'UnexpectedOutput', :red
      end
    end
  end
end
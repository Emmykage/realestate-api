class ApplicationController < ActionController::API
    def encode_token(payload)
        JWT.encode(payload, 'secret')
    end

    def decode_token 
        auth_header = request.headers['Authorization']
        if auth_header 
            token = auth_header.split(' ')[1]
            begin
              JWT.decode(token, 'secret', true, algorithm: 'HS256')

            rescue JWT::DecodeError
                nil
            end
            

        end
    end
    
    def authorized_user
        decode_taken = decode_token()

        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end

      
    end

    def authorize
        render json: { message: "you have to log in"} unless 
        authorized_user
          
    end

    def initialize_wallet 
        @wallet ||= Wallet.find_by(user_id: @user.id)
        return unless @wallet.nil?

        @wallet = @user.create_wallet
      
    end
end

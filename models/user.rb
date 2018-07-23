class User < ActiveRecord::Base
    has_secure_password
    # add a method password
    # add another method - authenticate
end
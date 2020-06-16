class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :roles, :locale, :nickname, :first_name, :last_name
end

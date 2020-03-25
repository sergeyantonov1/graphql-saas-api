module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::User::SignUp
  end
end

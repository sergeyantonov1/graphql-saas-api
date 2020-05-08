# frozen_string_literal: true

module Companies
  module CreateCompany
    class PrepareMembershipParams
      include Interactor

      delegate :company, :user, to: :context
      delegate :id, to: :company, prefix: true
      delegate :id, to: :user, prefix: true

      def call
        context.membership_params = membership_params
      end

      private

      def membership_params
        {
          role: membership_owner_role,
          user_id: user_id,
          company_id: company_id
        }
      end

      def membership_owner_role
        :owner
      end
    end
  end
end

class User < ActiveRecord::Base

  state_machine :status, initial: :pending do
    event :activate do
      transition pending: :active
    end
  end

end

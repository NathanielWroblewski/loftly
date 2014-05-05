class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  before_create :generate_identifier

  state_machine :status, initial: :pending do
    event :activate do
      transition pending: :active
    end
  end

  def generate_identifier
    hex = SecureRandom.hex(4)
    User.find_by(slug: id).nil? ? self.slug = hex : generate_identifier
  end

end

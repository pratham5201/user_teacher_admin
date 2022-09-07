class User < ApplicationRecord
  has_many :notices, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :email, presence: true,
                    length: { minimum: 5, maxmimum: 105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  # devise :database_authenticatable, :recoverable, :rememberable,
  #         :validatable, :lockable, :trackable,
  #         :registerable,
  #         :timeoutable, :jwt_authenticatable,
  #         jwt_revocation_strategy: JwtDenylist

  enum role: %i[student teacher admin]

  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    self.role ||= :student
  end
end

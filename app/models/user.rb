class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :cep, presence: true, format: { with: /\A\d{5}-?\d{3}\z/, message: "CEP inválido" }, if: :customer?
  validates :number, presence: true, if: :customer?
  validates :cpf, presence: true, format: { with: /\A\d{3}\.?\d{3}\.?\d{3}-?\d{2}\z/,message: "CPF inválido" }, if: :customer?
  validates :telefone, presence: true, format: { with: /\A(\(?\d{2}\)?\s?)?\d{4,5}-?\d{4}\z/, message: "deve conter apenas números e ter entre 10 e 11 dígitos" }, if: :customer?

  after_create :create_cart

  enum role: { customer: 0, admin: 1 }

  attr_accessor :admin_code

  before_validation :set_admin_by_code

  def set_admin_by_code
    admin_code = (self.admin_code).to_i
    secret_code = Rails.application.credentials.dig(:admin, :admin_code)
    secret_email = Rails.application.credentials.dig(:admin, :admin_email)

    if self.admin_code.present? && (admin_code != secret_code || self.email != secret_email)
      raise
      errors.add(:admin_code, "Código inválido ou email não autorizado para registro como administrador.")
      throw :abort
    else
      self.role = :admin if admin_code == secret_code
    end
  end


  def create_cart
    Cart.create(user: self)
  end
end

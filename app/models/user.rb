class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  serialize :registered_pages, Array  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  
  def registered_pages
    if read_attribute(:registered_pages).blank?
      [] # カラムが空の場合は空の配列を返す
    else
      read_attribute(:registered_pages).split(',').map(&:strip)
    end
  end

  def registered_pages=(pages)
    write_attribute(:registered_pages, pages.join(',')) if pages.is_a?(Array)
  end

end

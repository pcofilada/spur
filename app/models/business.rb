class Business < ApplicationRecord
  validates :name, :image, :website, :facebook_page, :contact_number, :location, :services, presence: true
  validates :description, presence: true, length: { maximum: 140 }

  scope :published, -> { where(published: true) }
end

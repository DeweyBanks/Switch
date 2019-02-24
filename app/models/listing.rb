class Listing < ApplicationRecord
  belongs_to :user
  has_many :devices
  has_one :reservation, dependent: :destroy
  validates_presence_of :reservation
  accepts_nested_attributes_for :reservation
  accepts_nested_attributes_for :devices, reject_if: :all_blank, allow_destroy: true
end

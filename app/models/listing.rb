class Listing < ApplicationRecord
  belongs_to :user
  has_many :devices
  has_one :reservation

  accepts_nested_attributes_for :reservation, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :devices, reject_if: :all_blank, allow_destroy: true
end

class Device < ApplicationRecord
  DEVICE_OPTIONS = ['Light Switch', 'Lock', 'Thermostat']
  validates_inclusion_of :device, :in => DEVICE_OPTIONS
  belongs_to :listing

end

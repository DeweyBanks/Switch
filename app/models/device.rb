class Device < ApplicationRecord
  DEVICE_OPTIONS = ['Light Switch', 'Lock', 'Thermostat']
  validates_inclusion_of :name, :in => DEVICE_OPTIONS
  belongs_to :listing

end

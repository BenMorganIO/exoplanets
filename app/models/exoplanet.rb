class Exoplanet < ActiveRecord::Base
  include Archivable

  DISCOVERY_METHODS = ['Transit', 'Orbital Brightness Modulation',
                       'Transit Timing Variations', 'Radial Velocity',
                       'Imaging']
end

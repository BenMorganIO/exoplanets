class Exoplanet < ActiveRecord::Base
  include Archivable

  DISCOVERY_METHODS = ['Transit', 'Orbital Brightness Modulation',
                       'Transit Timing Variations', 'Radial Velocity',
                       'Imaging']

  def self.transform_column_values(data)
    data = data.map do |datum|
      datum.transform_keys! do |key|
        case key
        when "pl_hostname"
          "name"
        when "pl_letter"
          "letter"
        when "pl_discmethod"
          "discovery_method"
        else
          nil
        end
      end
      datum.except nil
    end
  end
end

module Archivable
  extend ActiveSupport::Concern

  included do
    include HTTParty
    base_uri 'exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI'

    def self.refresh
      data = get '/nph-nstedAPI', query: { table: name.downcase.pluralize }
      eps_array = CSV.parse(data).as_json

      columns = eps_array.shift
      rows    = eps_array

      column_indexes = {}
      columns.each_with_index do |column, index|
        column_indexes[index] = column
      end

      exoplanets_hash = {}
      rows.each_with_index do |row, row_index|
        row_uuid = SecureRandom.uuid
        exoplanet_hash = {}
        row.each_with_index do |data, index|
          exoplanet_hash[column_indexes[index]] = data
        end
        exoplanets_hash[row_uuid] = exoplanet_hash
      end

      true if save_data exoplanets_hash
    end

    def self.save_data(exoplanets_hash)
      ActiveRecord::Base.transaction do
        exoplanets_hash.each do |key, values|
          exoplanet = Exoplanet.find_or_initialize_by name: values["pl_hostname"]
          exoplanet.update name: values["pl_hostname"], letter: values["pl_letter"], discovery_method: values["pl_discmethod"]
        end
      end
    end
  end
end

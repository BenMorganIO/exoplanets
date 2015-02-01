module Archivable
  extend ActiveSupport::Concern

  included do
    include HTTParty
    base_uri 'exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI'

    def self.refresh
      data = get '/nph-nstedAPI', query: { table: name.downcase.pluralize }
      csv = CSV.new(data, headers: true, header_converters: :symbol, converters: :all)
      data_as_hash = transform_column_values csv.to_a.map(&:to_hash).as_json
      save_data data_as_hash
    end

    def self.save_data(data)
      ActiveRecord::Base.transaction do
        data.each do |datum|
          exoplanet = find_or_initialize_by name: datum["name"]
          exoplanet.update name: datum["name"], letter: datum["letter"], discovery_method: datum["discovery_method"]
        end
      end
    end
  end
end

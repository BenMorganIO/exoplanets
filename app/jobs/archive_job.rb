class ArchiveJob < ActiveJob::Base
  queue_as :default

  def perform
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.each do |descendant|
      next unless descendant.included_modules.include? Archivable
      descendant.refresh
    end
  end
end

every 5.minutes do
  puts "Running Archive Job from Cron Job"
  runner 'ArchiveJob.perform'
end

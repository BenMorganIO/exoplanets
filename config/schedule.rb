every 5.minutes do
  puts "Running Archive Job from Cron Job"
  ArchiveJob.perform
end

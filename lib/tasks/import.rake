desc 'Starts users import to Canvas'
task import_users: :environment do
  import_request = User::ImportRequest.create
  ImportJob.perform_later import_request
  CheckJob.new(import_request).enqueue(wait: 1.minute)
end

desc 'Starts accounts import to Canvas'
task import_accounts: :environment do
  import_request = Account::ImportRequest.create
  ImportJob.perform_later import_request
  CheckJob.new(import_request).enqueue(wait: 1.minute)
end

desc 'Starts terms import to Canvas'
task import_terms: :environment do
  import_request = Term::ImportRequest.create
  ImportJob.perform_later import_request
  CheckJob.new(import_request).enqueue(wait: 1.minute)
end

desc 'Starts courses import to Canvas'
task import_courses: :environment do
  import_request = Course::ImportRequest.create
  ImportJob.perform_later import_request
  CheckJob.new(import_request).enqueue(wait: 1.minute)
end

desc 'Starts enrollments import to Canvas'
task import_enrollments: :environment do
  import_request = Enrollment::ImportRequest.create
  ImportJob.perform_later import_request
  CheckJob.new(import_request).enqueue(wait: 1.minute)
end

desc 'Starts import to Canvas'
task import: :environment do
  Rake::Task["import_users"].invoke
  Rake::Task["import_accounts"].invoke
  Rake::Task["import_terms"].invoke
  Rake::Task["import_courses"].invoke
  Rake::Task["import_enrollments"].invoke
end

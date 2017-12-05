class CheckJob < ApplicationJob
  queue_as :default

  def perform(import_request)
    CheckJob.new(import_request).enqueue(wait: 1.minute) if !import_request.finished?
  end
end

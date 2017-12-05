class ImportJob < ApplicationJob
  queue_as :default

  def perform(import_request)
    begin
      import_request.import
    rescue Exception => e
      ImporterLogger.logger.error "#{e.message}\n  #{e.backtrace.join("\n  ")}"
    end
  end
end

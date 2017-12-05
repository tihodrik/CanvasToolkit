class ImportRequest::Base < ActiveRecord::Base
  self.table_name = 'import_requests'

  scope :ordered, -> { order(:created_at => :desc) }

  state_machine :initial => :scheduled do
    event :run do
      transition :scheduled => :running
    end

    event :increment_succeeded_counter do
      transition :running => :sent, :if => lambda { |import_request|
        ImportRequest::Base.increment_counter(:succeeded_count, import_request.id)
        return import_request.sent?
      }
    end

    event :increment_failed_counter do
      transition :running => :sent, :if => lambda { |import_request|
        ImportRequest::Base.increment_counter(:failed_count, import_request.id)
        return import_request.sent?
      }
    end

    event :stop do
      transition :running => :failed
    end

    event :success do
      transition :sent => :succeeded
    end

    event :failure do
      transition :sent => :failed
    end

    event :error do
      transition :sent => :unknown_answer
    end

  end

  def sent?
    self.reload
    (self.succeeded_count + self.failed_count) >= self.total_count
  end

  def finished?
    if self.state != "sent"
      return true
    end

    id = ImportRequest::Base.find(self.id).import_id
    request = "curl -k -H 'Authorization: Bearer #{Settings.canvas[:token]}' \
              '#{Settings.canvas[:route]}/api/v1/accounts/#{Settings.canvas[:account_id]}/sis_imports/#{id}'"
    response = JSON.parse(%x(#{request}))

    if response['progress'] == 100
      if response['workflow_state'].include? "imported"
        self.success!
      elsif response['workflow_state'].include? "failed"
        self.failure!
      else
        self.error!
      end

      if response.include?("processing_warnings")
        m = ''
        response['processing_warnings'].each do |file, warning|
          m << file << ": " << warning << "\n"
        end

        e = Exception.new(m)
        log_error(e)
      end

      return true
    end

    return false
  end

  def import
    begin
      self.run!
      process
    rescue => e
      self.stop
      log_error(e)
    end
  end

  def import_async
    ImportJob.perform_later(self.id)
  end

protected
  def process
    raise NotImplementedError
  end

  def log_error(exception)
    if exception.backtrace != nil
      message = "#{exception.message}\n  #{exception.backtrace.join("\n  ")}"
    else
      message = "#{exception.message}\n"
    end
    self.update_attribute(:exception, message)
    ImporterLogger.logger.error message
  end
end

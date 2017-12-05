class Importer::Base
  attr_accessor :import_request

  def initialize(import_request)
    self.import_request = import_request
  end

  def run
    entry = entries
    self.import_request.update_attribute(:total_count, 1)
    begin
      process(entry)
      ImporterLogger.logger.info "Sent the following entry: #{entry}"
      self.import_request.increment_succeeded_counter
    rescue Exception => e
      ImporterLogger.logger.error "Could not send the following entry: #{entry}\n #{e.backtrace.join("\n  ")}"
      self.import_request.increment_failed_counter
    end
  end

protected
  def entries
    raise NotImplementedError
  end

  def process(entry)
    objects = entry.split('/').last.split('_').first
    request = "curl -k -F attachment=@'#{entry}' -H 'Authorization: Bearer #{Settings.canvas[:token]}' \
                      -F clear_sis_stickiness=true -F override_sis_stickiness=true \
                      -F diffing_data_set_identifier=#{objects} \
                      '#{Settings.canvas[:route]}/api/v1/accounts/#{Settings.canvas[:account_id]}/sis_imports.json?import_type=instructure_csv'"
    id = JSON.parse(%x(#{request}))['id']
    ImportRequest::Base.find(import_request.id).update(import_id: id)
  end
end

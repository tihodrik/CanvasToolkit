module ImporterLogger
  def self.logger
    @@logger ||= Logger.new("#{Rails.root}/log/imports.log")
  end
end

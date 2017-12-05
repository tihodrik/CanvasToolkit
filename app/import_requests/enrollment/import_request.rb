class Enrollment::ImportRequest < ImportRequest::Base
  protected
  def process
    Enrollment::Importer.new(self).run
  end
end

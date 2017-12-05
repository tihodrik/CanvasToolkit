class Course::ImportRequest < ImportRequest::Base
  protected
  def process
    Course::Importer.new(self).run
  end
end

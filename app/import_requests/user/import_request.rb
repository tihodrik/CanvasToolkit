class User::ImportRequest < ImportRequest::Base
  protected
  def process
    User::Importer.new(self).run
  end
end

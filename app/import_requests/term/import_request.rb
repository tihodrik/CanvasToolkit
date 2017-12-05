class Term::ImportRequest < ImportRequest::Base
  protected
  def process
    Term::Importer.new(self).run
  end
end

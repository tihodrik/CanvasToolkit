class Account::ImportRequest < ImportRequest::Base

  #Нужно ставить задачу проверки ответа Canvas'а: загрузился ли файл в canvas или нет, с какими ошибками?
  # state_machine do
  #   after_transition any => :finished, :do => :remove_outdated_professors
  # end

  protected
  def process
    Account::Importer.new(self).run
  end
end

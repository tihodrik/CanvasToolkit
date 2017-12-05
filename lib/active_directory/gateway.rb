module ActiveDirectory::Gateway
  def self.get_students
    ActiveDirectory::Base.setup(Settings.students[:active_directory][:connection_settings])

    students = Array.new
    students.push(ActiveDirectory::User.find(:all, :in => 'ou=Students'))
    students.push(ActiveDirectory::User.find(:all, :in => 'ou=Graduate Students'))
    students.flatten!
  end
end

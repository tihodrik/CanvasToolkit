class User::Importer < Importer::Base
  # Not working cause Canvas can't diff more than 1 file of the same type in one import
  # def entries
  #   file = Helper.generate_zip("users") do
  #     csv_files = Array.new
  #     csv_files << User::Professor.entries
  #     csv_files << User::Student.entries
  #     csv_files
  #   end
  #   return file
  # end

  def entries
    file = Helper.generate_csv("users") do
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['users']

      students = User::Student.entries
      professors = User::Professor.entries

      csv_string = CSV.generate do |csv|
        csv << header
        CSV.foreach(professors, headers: true) {|row| csv << row.values_at(*header) }
        CSV.foreach(students, headers: true) {|row| csv << row.values_at(*header) }
      end

      File.delete(students)
      File.delete(professors)
      
      csv_string
    end
    return file
  end
end

require "#{Rails.root}/app/importers/user/professor"
require "#{Rails.root}/app/importers/user/student"

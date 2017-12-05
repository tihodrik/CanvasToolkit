module User::Student
  def self.entries
    file = Helper.generate_csv("students") do
      students = ActiveDirectory::Gateway.get_students
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['users']

      csv_string = CSV.generate do |csv|
        csv << header

        students.each do |student|
          csv << [  student[:samaccountname].downcase,
                    "#{student[:samaccountname].downcase}@edu.tversu.net",
                    student[:givenname],
                    student[:sn],
                    User::Helper.full_name(student),
                    User::Helper.short_name(student),
                    User::Helper.full_name(student),
                    "#{student[:samaccountname].downcase}@edu.tversu.ru",
                    "active"
                  ]
        end
      end

      csv_string
    end
    return file
  end

end

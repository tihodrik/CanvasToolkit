module User::Professor
  def self.entries
    file = Helper.generate_csv("professors") do
      professors = Helper.load('professors')
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['users']

      csv_string = CSV.generate do |csv|
        csv << header

        professors.each do |professor|
          csv << [  professor[:login],
                    "#{professor[:login]}@tversu.net",
                    professor[:first_name],
                    professor[:last_name],
                    professor[:full_name],
                    professor[:short_name],
                    professor[:full_name],
                    "#{professor[:login]}@tversu.ru",
                    'active'
                  ]
        end
      end
      csv_string
    end
    return file
  end

end

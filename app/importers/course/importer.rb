class Course::Importer < Importer::Base
  def entries
    file = Helper.generate_csv("courses") do
      courses = Helper.load('courses')
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['courses']

      csv_string = CSV.generate do |csv|
        csv << header

        courses.each do |course|
          csv << [  course[:course_id],
                    course[:name],
                    "#{course[:name]} (#{course[:cipher]}. #{course[:academic_program]})",
                    course[:account_id],
                    course[:term_id],
                    'active'
                  ]
        end
      end

      csv_string
    end
    return file
  end

end

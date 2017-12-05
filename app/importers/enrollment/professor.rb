module Enrollment::Professor
  def self.entries
    file = Helper.generate_csv("professors") do
      enrollments = Helper.load('enrollments')
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['enrollments']

      csv_string = CSV.generate do |csv|
        csv << header

        enrollments.each do |enrollment|
          csv << [  enrollment[:course_id],
                    enrollment[:user_id],
                    'teacher',
                    'active'
                  ]
        end
      end

      csv_string
    end
    return file
  end

end

module Enrollment::Student
  def self.entries
    file = Helper.generate_csv("students") do
      courses = Helper.load('courses')
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['enrollments']
      db = Mmis::Gateway.new
      db.connect

      csv_string = CSV.generate do |csv|
        csv << header

        courses.each do |course|
          course[:course_num].each do |num|

            students = db.get_enrolled_students(course[:year],course[:cipher],course[:academic_program],num)
            if (!students.empty?)
              students.each do |student|
                csv << [  course[:course_id],
                          student[:login],
                          'student',
                          'active'
                        ]
              end
            end
          end

        end
      end

      csv_string
    end
    return file
  end

end

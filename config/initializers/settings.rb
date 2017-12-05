Settings = Rails.application.config.x

students_settings = YAML.load_file(Rails.root.join('config/students.yml'))[Rails.env].deep_symbolize_keys
students_settings.each { |key, value| Settings.students.send("#{key}=", value) }

canvas_settings = YAML.load_file(Rails.root.join('config/canvas.yml'))[Rails.env].deep_symbolize_keys
canvas_settings.each { |key, value| Settings.canvas.send("#{key}=", value) }

mmis_settings = YAML.load_file(Rails.root.join('config/mmis.yml'))[Rails.env].symbolize_keys
mmis_settings.each { |key, value| Settings.mmis.send("#{key}=", value) }

courses_settings = YAML.load_file(Rails.root.join('config/courses.yml')).symbolize_keys
courses_settings.each { |key, value| Settings.courses.send("#{key}=", value) }

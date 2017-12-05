class Term::Importer < Importer::Base
  def entries
    file = Helper.generate_csv("terms") do
      terms =  Helper.load('terms')
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['terms']

      csv_string = CSV.generate do |csv|
        csv << header

        terms.each do |term|
          csv << [  term[:term_id],
                    term[:name],
                    term[:status],
                    term[:start_date]
                  ]
        end
      end

      csv_string
    end
    return file
  end

end

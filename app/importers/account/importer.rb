class Account::Importer < Importer::Base
  def entries
    file = Helper.generate_csv("accounts") do
      accounts = Helper.load('accounts')
      header = YAML.load_file(Rails.root.join('lib/headers/list.yml'))['accounts']

      csv_string = CSV.generate do |csv|
        csv << header

        accounts.each do |account|
          csv << [  account[:account_id],
                    '',
                    account[:name],
                    'active'
                  ]
        end
      end

      csv_string
    end
    return file
  end

end

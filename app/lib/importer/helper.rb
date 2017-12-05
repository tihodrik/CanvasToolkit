module Importer::Helper
  def self.delete_courses
    while true do
      request = "curl -k -H 'Authorization: Bearer #{Settings.canvas[:token]}' \
                        '#{Settings.canvas[:route]}/api/v1/accounts/#{Settings.canvas[:account_id]}/courses'"
      response = JSON.parse(%x(#{request}))
      if response != nil && response.empty? != true
        response.each do |course|
          Kernel.system "curl -k -H 'Authorization: Bearer #{Settings.canvas[:token]}' \
                            -X 'DELETE' \
                            -d 'event=delete' \
                            '#{Settings.canvas[:route]}/api/v1/courses/#{course["id"]}'"
        end
      else break
      end
    end
  end

end

module Helper
  def self.generate_csv(objects)
    require 'csv'

    Dir.chdir("#{Rails.root}/tmp")
    Dir.mkdir('import') if not Dir.exist?('import')
    Dir.chdir("#{Dir.pwd}/import")

    file = "#{Dir.pwd}/#{objects}_#{DateTime.now.strftime("%Y%m%d%H%M%S%L")}.csv"

    csv_string = yield if block_given?

    File.open(file, "w") do |f|
      f.write(csv_string)
    end
    return "#{Dir.pwd}/#{Dir.glob("#{objects}*.csv").sort!.last}"
  end

  def self.generate_zip(objects)
    require 'zip'
    
    Dir.chdir("#{Rails.root}/tmp")
    Dir.mkdir('import') if not Dir.exist?('import')
    Dir.chdir("#{Dir.pwd}/import")

    file = "#{Dir.pwd}/#{objects}_#{DateTime.now.strftime("%Y%m%d%H%M%S%L")}.zip"

    csv_files = yield if block_given?

    Zip::File.open(file, Zip::File::CREATE) do |zfile|
      csv_files.each do |csv_file|
        zfile.add("#{csv_file.split('/').last.split('_').first}.csv", csv_file)
      end
    end

    return "#{Dir.pwd}/#{Dir.glob("#{objects}*.zip").sort!.last}"
  end

  def self.remove_tmp_files
    Dir.chdir("#{Rails.root}/tmp/import")
    Dir.glob('*').each do |file|
      File.delete(file)
    end
    Dir.delete("#{Rails.root}/tmp/import") if Dir.glob('*').empty?
  end

  def self.load(objects)
    request = "curl -X 'GET' '#{Settings.courses[:route]}/#{objects}.json'"
    response = JSON.parse(%x(#{request}))["#{objects}"]
    response.each do |element|
      element.symbolize_keys!
    end
    response
  end
end

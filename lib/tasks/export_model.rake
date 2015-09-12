task export_all_models: :environment do
  base = "(app/models/|lib/)"
  files = Dir.glob("app/models/**/*.rb")
  files.each do |file|
    @model = (file.gsub(/^#{base}([\w_\/\\]+)\.rb/, '\2')).camelize.constantize
    file = "db/seed/development/#{@model.table_name}.csv"
    STDERR.print "#{@model}\n"
    FasterCSV.open(File.join(Rails.root, file), "w") do |csv|
      csv << @model.column_names
      @model.all.each do |object|
        csv << @model.column_names.map {|c| object.send(c) }
      end
    end
  end
end

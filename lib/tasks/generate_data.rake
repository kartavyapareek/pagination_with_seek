require 'faker'
require 'activerecord-import'

namespace :generate_employee_data do
  desc "Generate Sample Data "
  task with_import_method: :environment do
    # Create 10 million records in batches of 10,0000
    id_number = Employee.last&.identification_number || 0
    (1..100000).each do |i|
      records = []
      # Generate 10,000 records in each batch
      10000.times do
        id_number += 1
        records << Employee.new(
          full_name: Faker::Name.name,
          identification_number: id_number
        )
      end
      # Use activerecord-import to create the records in bulk
      Employee.import records
      puts "Batch #{i} complete"
    end
  end

  task with_create_method: :environment do
    # Create 1000 records
    id_number = Employee.last&.identification_number || 0
    1000.times do
      id_number += 1
      Employee.create(
        full_name: Faker::Name.name,
        identification_number: id_number
      )
    end
  end
end

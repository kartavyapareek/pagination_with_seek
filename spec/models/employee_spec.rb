# spec/models/employee_spec.rb

require 'rails_helper'

RSpec.describe Employee, :type => :model do
  it "is valid with valid attributes" do
    employee = Employee.new(identification_number: 123, full_name: 'Test Name')
    expect(employee).to be_valid
  end
  it "is not valid without a identification_number" do
    employee = Employee.new(full_name: 'Test Name')
    expect(employee).not_to be_valid
  end
  it "is valid without a full_name"  do
    employee = Employee.new(identification_number: 123)
    expect(employee).to be_valid
  end
end
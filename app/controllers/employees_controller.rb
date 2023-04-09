class EmployeesController < ApplicationController
  def index
    limit = params[:limit] || 100
    prev_page_id = params[:prev_page_id] || 0
    next_page_id = params[:next_page_id] || 0

    if params[:page_number].present?
      skip_objs = (limit * params[:page_number].to_i) - 1
      next_page_id = Employee.select(:identification_number)
                             .order(created_at: :desc)
                             .offset(skip_objs)
                             .limit(1)
                             .last
                             .identification_number
    end

    employees = if next_page_id.to_i > 0
                  Employee.order(created_at: :desc).where('identification_number < ?', next_page_id.to_i).limit(limit)
                elsif prev_page_id.to_i > 0
                  Employee.where('identification_number > ?', prev_page_id.to_i).limit(limit)&.sort{ |x,y| y.created_at <=> x.created_at }
                else
                  Employee.order(created_at: :desc).limit(limit)
                end

    
    respond_to do |format|
      format.json { render json: response_json(employees, prev_page_id, next_page_id) }
    end
  end
end

def response_json(results, prev_page_id, next_page_id)
  response_json = {
      data: results,
      cursor: {
        prev_page_id: prev_page_id(results, prev_page_id, next_page_id),
        next_page_id: next_page_id(results, prev_page_id, next_page_id)
      }
    }
end

def prev_page_id(results, prev_page_id, next_page_id)
  first_identification_number = results&.first&.identification_number
  first_identification_number == Employee.select(:identification_number).last.identification_number ? nil : first_identification_number
end

def next_page_id(results, prev_page_id, next_page_id)
  last_identification_number = results&.last&.identification_number
  last_identification_number == Employee.select(:identification_number).first.identification_number ? nil : last_identification_number
end


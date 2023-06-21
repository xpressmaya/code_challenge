class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :request_number, null: false
      t.integer :sequence_number, null: false
      t.string :request_type, null: false
      t.string :request_action, null: false
      t.string :response_due_date_time, null: false
      t.string :primary_service_area_code, null: false
      t.string :additional_service_area_code, null: false
      t.string :well_known_text, null: false
      

      t.timestamps
    end
  end
end

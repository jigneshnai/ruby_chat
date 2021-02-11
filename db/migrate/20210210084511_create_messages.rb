class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
    	t.text    :msg
    	t.integer :user_id
    	t.string  :msgtype
      t.timestamps
    end
  end
end

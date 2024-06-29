# $ rails g migration AddStatusToComments status

class AddStatusToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :status, :string
  end
end

# rails db:migrate
# -- add_column(:comments, :status, :string)
#    -> 0.0007s
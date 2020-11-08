class AddIconToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :icon, :string
    change_column_default :members, :icon, "https://www.flaticon.com/premium-icon/icons/svg/2989/2989915.svg"
  end
end

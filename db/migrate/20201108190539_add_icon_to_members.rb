class AddIconToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :icon, :string
    change_column_default :members, :icon, "https://www.flaticon.com/svg/static/icons/svg/1077/1077114.svg"
  end
end

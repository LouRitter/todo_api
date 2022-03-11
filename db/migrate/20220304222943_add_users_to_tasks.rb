class AddUsersToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :user, index: true

  end
end

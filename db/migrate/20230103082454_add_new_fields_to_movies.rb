class AddNewFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :director, :string, default: "Manoj Solanki"
    add_column :movies, :duration, :string, default: "1 Year"
    add_column :movies, :image_file_name, :string, default: "placeholder.png" 
  end
end

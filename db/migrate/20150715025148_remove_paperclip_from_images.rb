class RemovePaperclipFromImages < ActiveRecord::Migration
  def change
    # remove_column :images, :img_updated_at, :datetime
    # remove_column :images, :img_file_name, :string
    # remove_column :images, :img_content_type, :string
    # remove_column :images, :img_file_size, :integer
    add_column :images, :photo, :string, default: "http://i.livescience.com/images/i/000/048/146/original/concert-crowd-100817-02.jpg"
  end
end

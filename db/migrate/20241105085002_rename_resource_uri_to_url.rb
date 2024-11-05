class RenameResourceUriToUrl < ActiveRecord::Migration[7.2]
  def change
    rename_column :resources, :uri, :url
  end
end

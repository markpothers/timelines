class AddWebsiteUrlToEmployers < ActiveRecord::Migration[5.2]
  def change
    add_column :employers, :website_url, :string
  end
end

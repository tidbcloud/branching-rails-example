#  bin/rails generate migration add_index_to_article title:uniq
class AddIndexToArticle < ActiveRecord::Migration[7.0]
  def change
    add_index :articles, :title, unique: true
  end
end
class Category < ActiveRecord::Base
  unloadable
  
  set_table_name "kb_categories"
  
  validates_presence_of :title
  
  belongs_to :project
  has_many :articles
  
  acts_as_nested_set :order => 'title'

end


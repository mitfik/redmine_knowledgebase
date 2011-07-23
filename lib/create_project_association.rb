class Project < ActiveRecord::Base
    STATUS_ACTIVE     = 1
    has_many :categories
    has_many :articles, :through => :categories
end

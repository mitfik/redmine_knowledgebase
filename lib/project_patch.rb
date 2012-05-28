module KnowladgeBase
  module ProjectPath
    def self.included(base)
      base.class_eval do
        unloadable
        has_many :categories
        has_many :articles, :through => :categories
      end
    end
  end
end

Dispatcher.to_prepare do
  require_dependency 'project'
  Project.send(:include, KnowladgeBase::ProjectPath)
end

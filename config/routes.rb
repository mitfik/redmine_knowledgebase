ActionController::Routing::Routes.draw do |map|
   map.resources :articles, :path_prefix=> '/projects/:project_id', :conditions => {:method=>[:get, :post] }
   map.connect ':id/kb', :controller=>'knowledgebase', :action=>'index'

   # articles links
   map.connect ':project_id/articles', :controller=>'articles', :action=>'index'
   map.connect 'articles/new', :controller=>'articles', :action=>'new'
   map.connect 'articles/create', :controller=>'articles', :action=>'create'
   map.connect 'articles/comment', :controller=>'articles', :action=>'comment'
   map.connect 'articles/preview', :controller=>'articles', :action=>'preview'
   map.connect 'articles/:article_id/rate/:rating', :controller=>'articles', :action=>'rate'
   map.connect 'articles/:id', :controller=>'articles', :action=>'show'


   # categories links
   map.resources :categories, :path_prefix=> '/projects/:project_id', :conditions => {:method=>[:get, :post]}
   map.connect 'categories/new', :controller=>'categories', :action=>'new'
   map.connect 'categories/create', :controller=>'categories', :action=>'create'
   map.connect 'categories/:id', :controller=>'categories', :action=>'show'
end

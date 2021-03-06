require 'redmine'
require 'project_patch'
require 'acts_as_viewed'
require 'acts_as_rated'
require 'acts_as_taggable'
require 'macros'

Redmine::Plugin.register :redmine_knowledgebase do
  name        'Knowledgebase'
  author      'Alex Bevilacqua'
  description 'A plugin for Redmine that adds knowledgebase functionality'
  url         'http://alexbevi.com/projects/redmine-kb'
  author_url  'http://blog.alexbevi.com'
  version     '0.3.2-devel'

  requires_redmine :version_or_higher => '1.0.0'

  settings :default => {
    'knowledgebase_anonymous_access' => "1",
    'knowledgebase_sort_category_tree' => "1",
    'knowledgebase_show_category_totals' => "1",
    'knowledgebase_summary_limit' => "5",
    'display_newest' => true,
    'display_recent' => true,
    'display_popular' => true,
    'display_rated' => true,
    'knowladgebase_title' => "Knowledgebase"
  }, :partial => 'settings/knowledgebase_settings'

    project_module :knowledgebase do
        permission :view_articles, {
          :knowledgebase => :index,
          :articles      => [:show, :tagged, :index],
          :categories    => [:index, :show]
        }
        permission :view_top_rated_articles, {
          :knowledgebase => :index
        }
        permission :view_newest_articles, {
          :knowledgebase => :index
        }
        permission :view_recently_updated_articles, {
          :knowledgebase => :index
        }
        permission :view_most_popular_articles, {
          :knowledgebase => :index
        }
        permission :comment_and_rate_articles, {
          :knowledgebase => :index,
          :articles      => [:show, :tagged, :rate, :comment, :add_comment, :index],
          :categories    => [:index, :show]
        }
        permission :create_articles, {
          :knowledgebase => :index,
          :articles      => [:show, :tagged, :new, :create, :add_attachment, :preview, :index],
          :categories    => [:index, :show]
        }
        permission :edit_articles, {
          :knowledgebase => :index,
          :articles      => [:show, :tagged, :edit, :update, :add_attachment, :preview, :index],
          :categories    => [:index, :show]
        }
        permission :manage_articles, {
          :knowledgebase => :index,
          :articles      => [:show, :new, :create, :edit, :update, :destroy, :add_attachment, 
                             :preview, :comment, :add_comment, :destroy_comment, :tagged, :index],
          :categories    => [:index, :show]
        }
        permission :manage_articles_comments, {
          :knowledgebase => :index,
          :articles      => [:show, :comment, :add_comment, :destroy_comment, :index],
          :categories    => [:index, :show]
        }
        permission :create_article_categories, {
          :knowledgebase => :index,
          :categories    => [:index, :show, :new, :create]
        }
        permission :manage_article_categories, {
          :knowledgebase => :index,
          :categories    => [:index, :show, :new, :create, :edit, :update, :delete]
        }
      end

     menu :project_menu, :knowledgebase, {:controller=>'knowledgebase', :action=>'index'}, :caption=>'Knowledgebase', :before=>:boards, :params=>:project_id

  Redmine::Search.available_search_types << 'articles'
end

class CategoriesController < KnowledgebaseController
  unloadable

  before_filter :find_project, :authorize

  def find_project
    if !params[:project_id].nil?
        @project=Project.find(params[:project_id])
    elsif !params[:category_id].nil?
        @project=Category.find(params[:category_id]).project
    elsif !params[:parent_id].nil?
        @project=Category.find(params[:parent_id]).project
    elsif !params[:id].nil?
        @project=Category.find(params[:id]).project
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.find(:all)
  end

  def new
    @category = Category.new
    @parent_id = params[:parent_id]
    @categories=@project.categories.find(:all, :conditions=>["parent_id Is Null"])
  end

  def create
    @category = Category.new(params[:category])
    @category.project_id=@project.id

    if @category.save
      # Test if the new category is a root category, and if more categories exist.
      # We check for a value > 1 because if this is the first entry, the category
      # count would be 1 (since the create operation already succeeded)
      if !params[:root_category] and @project.categories.count > 1
        @category.move_to_child_of(Category.find(params[:parent_id]))
      end

      flash[:notice] = "Created Category: " + @category.title
      redirect_to({ :action => 'show', :id => @category.id })
    else
      render(:action => 'new')
    end
  end

  def edit
    @category = Category.find(params[:id])
    @categories=@project.categories.find(:all, :conditions=>["parent_id Is Null"])
  end

  def delete
    @category = Category.find(params[:id])
    if @category.articles.size == 0
      project_identifier=@category.project.identifier
      @category.destroy
      flash[:notice] = "Category deleted"
      redirect_to({ :controller=>'knowledgebase', :action => 'index', :id=>project_identifier})
    else
      @articles = @category.articles.find(:all)
      flash[:error] = "Category is assigned to articles and could not be deleted."
      render(:action => 'show')
    end
  end

  def update
    @category = Category.find(params[:id])
    if !params[:root_category]
      @category.move_to_child_of(Category.find(params[:parent_id]))
    end
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category Updated"
      redirect_to({ :action => 'show', :id => @category.id })
    else
      render(:action => 'edit')
    end
  end

end


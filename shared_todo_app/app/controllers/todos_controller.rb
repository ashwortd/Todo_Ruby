class TodosController < ApplicationController
  def index
  @todo_items = Todo.all
  #render :index, :layout => true
  end
  def delete
  @todo_last = Todo.last
  @todo_last.delete
  @todo_last.save
  end
  def add
   todo = Todo.create(:todo_item => params[:todo_text])
   if !todo.valid?
        flash[:error] = todo.errors.full_messages.join("<br>").html_safe
   end
   redirect_to :action => 'index'
  end
  def complete
    params[:todos_checkbox].each do |check|
       todo_id = check
       t = Todo.find_by_id(todo_id)
      if t.completed == true
        t.update_attribute(:completed, false)
      else
        t.update_attribute(:completed, true)
      end
     end
    redirect_to :action => 'index'
end
private
def todo_params
	params.require(:todo_item).permit(:completed)
	end
end
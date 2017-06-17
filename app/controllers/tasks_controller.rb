class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks 変数に Task を「全件」取得して、ページングを追加する
    # 今回必要な対応は
    # 「全件(Task.all)」の部分を、「ログインユーザー(current_user.tasks)」に修正する必要がある
    @tasks = current_user.tasks.page(params[:page])
  end

 def show
  set_task
 end
 
 def new
   @task = current_user.tasks.build
 end

def create
  @task = current_user.tasks.build(task_params)

  if @task.save
    flash[:success] = 'Taskが正常に投稿されました'
    redirect_to @task
  else
    flash.now[:danger] = 'Taskが投稿されませんでした'
    render :new
  end
end
 
 def edit
   set_task
 end
 
 def update
  set_task
   
   if @task.update(task_params)
    flash[:success] = 'Taskは正常に更新されました'
    redirect_to @task
   else
    flash.now[:danger] = 'Taskは更新されませんでした'
    render :edit
  end
 end

  def destroy
   set_task
   @task.destroy
   
   flash[:success] = 'Taskは正常に削除されました'
   redirect_to tasks_url
 end
 
 private
 
 def set_task
  @task = Task.find(params[:id])
 end
 
 def task_params
  params.require(:task).permit(:content, :status)
 end

 def login(email, password)
   @user = User.find_by(email: email)
   if @user && @user.authenticate(password)
     #ﾛｸﾞｲﾝ成功
     session[:user_id] = @user.id
     return true
   else
     #ﾛｸﾞｲﾝ失敗
     return false
   end
  end
  
  def correct_user 
    @tasklist = current_user.tasks.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_path
    end
  end
end



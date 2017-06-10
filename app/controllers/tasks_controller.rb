class TasksController < ApplicationController

 def index
   @tasks = Task.all
 end

 def show
   @tasks = Task.find(params[:id])
 end
 
 def new
   @task = Task.new
 end
 

 def edit
   @task = Task.find(params[:id])
 end
 
 def update
 end
 
 
 def destroy
 end


end


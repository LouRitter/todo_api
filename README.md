# README
ruby version 2.4.2
rails version 5.0.3

todo api requirements:

* Create a new account
* Login to my account
* Create, update, and delete a task
* A task should have a title, a check to see if i’ve completed it and I want to be able to add notes to it
* See a list of all of my tasks, as well as filter by whether or not a task has been completed
* I should not be able to see tasks of other users, just my own tasks
* See the details (title, etc.) for a particular task
* Retrieve a list of my completed tasks
* Retrieve a list of my uncompleted tasks

Api Routes: 

users:
post /users 
post /auth/log_in 

tasks:
get /tasks  
get /completed_tasks
get /uncompleted_tasks
post /tasks 

get /tasks/:id 
put /tasks/:id 
delete tasks/:id 

models 

Task
  title: string
  completed: bool
  notes: text
  belongs_to user
User
  username: string 
  password_digest: encrypted string
  has_many task


# Set Up:
bundle install
rails db:migrate

 
# Running Tests:

bundle exec rspec

# Start Server:

rails s 


### For most routes you will need to use the authorization token returned from the '/auth/login' response. In postman, you can find it under the Authorization tab, or you can add it to the headers manually. 

# Create User
post /users
{"email":"test@example.com", "password":"password", "password_confirmation":"password"}

# Authentication 
post /auth/login
{"email":"test@example.com", "password":"password"}

# Get Users Tasks
  ## All Tasks
  get /tasks
  
  ## Uncompleted Tasks
  get  /uncompleted_tasks

  ## Completed Tasks
  get /completed_tasks

# Create/Read/Update/Delete Task
post /tasks
get /tasks/:id
puts /tasks/:id
delete /tasks/:id






require 'rails_helper'
require 'capybara/rails'


feature 'Manage Tasks' do
  scenario 'User can add a task' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    expect(page).to have_content "Work List"
    expect(page).to have_content "+ Add Task"
    first(".add-task").click_on "+ Add Task"
    expect(page).to have_content "Description"
    expect(page).to have_content "Due Date"
    fill_in "task[description]", with: ""
    click_on "Create Task"
    within('.notice_error') do
      expect(page).to have_content "Your task could not be created"
    end
    fill_in "task[description]", with: "enjoy studying and learning"

    due_date = 4.days.from_now
    select due_date.strftime("%Y"), :from => "task_due_date_1i"
    select due_date.strftime("%m"), :from => "task[due_date(2i)]"
    select due_date.strftime("%d"), :from => "task[due_date(3i)]"
    click_on "Create Task"

    expect(page).to have_content "enjoy studying and learning"
    within('.notice_successful') do
      expect(page).to have_content "Task was created successfully!"
    end
    expect(page).to have_content "4 days"
  end
end
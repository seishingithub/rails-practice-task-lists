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

    # next to each task name
    expect(page).to have_content "Work List"
    expect(page).to have_content "+ Add Task"
    first(".add-task").click_on "+ Add Task"
    expect(page).to have_content "Description"
    # date field (w/ year / month / day dropdowns)
    expect(page).to have_content "Due Date"
    fill_in "task[description]", with: "enjoy studying and learning"
    click_on "Create Task"
    expect(page).to have_content "enjoy studying and learning"
    expect(page).to have_content "Task was created successfully!"
    # each task should have the due date represented in relative time
  end
end